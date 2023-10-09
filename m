Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5665A7BDF60
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376982AbjJIN3Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377228AbjJIN3O (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:29:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037B199
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:29:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E2FC433C8;
        Mon,  9 Oct 2023 13:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858153;
        bh=uBNWeWdI+Ue97Kim5X7h3r0TeNDUrXGDEG7ikQ4niBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmOkJRQAfEXA7BUqV/nATgkMUv0kcMLJCU7io9PFfzEVr+PJxZjiTvG/dR4d7ssHC
         1ukWwFTg6q40OFEKu32jwCbHskZaWz5HKVB/5+9vPrVg9+VpnKG1Jm5Rei/QeSiki0
         GPBJq72tCD0/7T9x7XdxcVSBr7I+EmwWFGxVh0dY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hsin-Wei Hung <hsinweih@uci.edu>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 015/131] bpf: Avoid deadlock when using queue and stack maps from NMI
Date:   Mon,  9 Oct 2023 15:00:55 +0200
Message-ID: <20231009130116.787112206@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index f697647ceb547..26ba7cb01136c 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -118,7 +118,12 @@ static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
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
@@ -148,7 +153,12 @@ static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
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
@@ -213,7 +223,12 @@ static int queue_stack_map_push_elem(struct bpf_map *map, void *value,
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



