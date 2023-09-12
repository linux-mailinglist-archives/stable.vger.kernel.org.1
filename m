Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54B979B27B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbjIKV20 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239975AbjIKOdA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:33:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEBCCF0
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:32:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0347EC433C9;
        Mon, 11 Sep 2023 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442775;
        bh=eTWDtdV045aeH4SEdzKlZQbZxabyqWLxbgxPx6ouJy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rza3FLo5xWw3zfIF2fmzpKa9FRZJKqwMGA8qesNgy17gs0dZjZyhMl6JcQejbwgTu
         IZehNpYyvtgiYwoxvwKz7VrfH0rG/O28R6obJSk0fzRLRfFsYhe0aT4XFIUoKZ1oiF
         2gjvhpurTq74Bkggn1zwJyBCWaxXjIn6PjsK6tXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Quentin Monnet <quentin@isovalent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 143/737] bpftool: Define a local bpf_perf_link to fix accessing its fields
Date:   Mon, 11 Sep 2023 15:40:02 +0200
Message-ID: <20230911134654.492544973@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Lobakin <alobakin@pm.me>

[ Upstream commit 67a43462ee2405c94e985a747bdcb8e3a0d66203 ]

When building bpftool with !CONFIG_PERF_EVENTS:

skeleton/pid_iter.bpf.c:47:14: error: incomplete definition of type 'struct bpf_perf_link'
        perf_link = container_of(link, struct bpf_perf_link, link);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:74:22: note: expanded from macro 'container_of'
                ((type *)(__mptr - offsetof(type, member)));    \
                                   ^~~~~~~~~~~~~~~~~~~~~~
tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_helpers.h:68:60: note: expanded from macro 'offsetof'
 #define offsetof(TYPE, MEMBER)  ((unsigned long)&((TYPE *)0)->MEMBER)
                                                  ~~~~~~~~~~~^
skeleton/pid_iter.bpf.c:44:9: note: forward declaration of 'struct bpf_perf_link'
        struct bpf_perf_link *perf_link;
               ^

&bpf_perf_link is being defined and used only under the ifdef.
Define struct bpf_perf_link___local with the `preserve_access_index`
attribute inside the pid_iter BPF prog to allow compiling on any
configs. CO-RE will substitute it with the real struct bpf_perf_link
accesses later on.
container_of() uses offsetof(), which does the necessary CO-RE
relocation if the field is specified with `preserve_access_index` - as
is the case for struct bpf_perf_link___local.

Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230707095425.168126-3-quentin@isovalent.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index e2af8e5fb29ec..3a4c4f7d83d86 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -15,6 +15,11 @@ enum bpf_obj_type {
 	BPF_OBJ_BTF,
 };
 
+struct bpf_perf_link___local {
+	struct bpf_link link;
+	struct file *perf_file;
+} __attribute__((preserve_access_index));
+
 struct perf_event___local {
 	u64 bpf_cookie;
 } __attribute__((preserve_access_index));
@@ -45,10 +50,10 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 /* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
 static __u64 get_bpf_cookie(struct bpf_link *link)
 {
+	struct bpf_perf_link___local *perf_link;
 	struct perf_event___local *event;
-	struct bpf_perf_link *perf_link;
 
-	perf_link = container_of(link, struct bpf_perf_link, link);
+	perf_link = container_of(link, struct bpf_perf_link___local, link);
 	event = BPF_CORE_READ(perf_link, perf_file, private_data);
 	return BPF_CORE_READ(event, bpf_cookie);
 }
-- 
2.40.1



