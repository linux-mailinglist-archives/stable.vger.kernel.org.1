Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAC47B875C
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbjJDSE1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243774AbjJDSE1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA20A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1049AC433C7;
        Wed,  4 Oct 2023 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442661;
        bh=J7VIHOsunbwY00r2324pZt9jom+COaMKOQY7D1kiHuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLfR0USlFRMermd85V7mCf4kBoSZXeeRBw5eFtBLGpaOQmC561uAtmI+JX8TbJsYF
         xz2KQXLXuXgjYBXxe7louT79kEKke0YhakzR0eOSfHnQyvSzNF4GbZuhFF4LvYsgXF
         1KZD/s9kDgi/ca8axRFJaVnphjK8nmnCXhYUC+YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hsin-Wei Hung <hsinweih@uci.edu>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 036/183] bpf: Avoid deadlock when using queue and stack maps from NMI
Date:   Wed,  4 Oct 2023 19:54:27 +0200
Message-ID: <20231004175205.455250575@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit a34a9f1a19afe9c60ca0ea61dfeee63a1c2baac8 ]

Sysbot discovered that the queue and stack maps can deadlock if they are
being used from a BPF program that can be called from NMI context (such as
one that is attached to a perf HW counter event). To fix this, add an
in_nmi() check and use raw_spin_trylock() in NMI context, erroring out if
grabbing the lock fails.

Fixes: f1a2e44a3aec ("bpf: add queue and stack maps")
Reported-by: Hsin-Wei Hung <hsinweih@uci.edu>
Tested-by: Hsin-Wei Hung <hsinweih@uci.edu>
Co-developed-by: Hsin-Wei Hung <hsinweih@uci.edu>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/20230911132815.717240-1-toke@redhat.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/queue_stack_maps.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f9c734aaa9902..ef95b796a0fa3 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -103,7 +103,12 @@ static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -133,7 +138,12 @@ static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -198,7 +208,12 @@ static int queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	}
 
 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
-- 
2.40.1



