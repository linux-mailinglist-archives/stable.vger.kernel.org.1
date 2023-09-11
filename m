Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B259B79AD90
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377476AbjIKW0e (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbjIKPH3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:07:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916FFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:07:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55856C433C8;
        Mon, 11 Sep 2023 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444844;
        bh=wYyLacA63f/iih+pcWwtKBX5+7RDE0YbDXORsy6sBCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixcQZ9oCQV8K8wLcw5GZ9ZTh6NQwgcNFr5NEMC0H5l0fNonA/MPICbluQ1S/23TLL
         2woRFz5zYjQj26PORxPf6XShdbzIyyRsQsKZCk87JMCR20+97HOBSRWfcmzsQtHxtW
         PimQoG8C/A7A0rNvACTLgzTuX/6dzSRZw60Rryhs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrii Nakryiko <andrii@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Quentin Monnet <quentin@isovalent.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 137/600] bpftool: use a local copy of perf_event to fix accessing :: Bpf_cookie
Date:   Mon, 11 Sep 2023 15:42:50 +0200
Message-ID: <20230911134637.654648928@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Lobakin <alobakin@pm.me>

[ Upstream commit 4cbeeb0dc02f8ac7b975b2ab0080ace53d43d62a ]

When CONFIG_PERF_EVENTS is not set, struct perf_event remains empty.
However, the structure is being used by bpftool indirectly via BTF.
This leads to:

skeleton/pid_iter.bpf.c:49:30: error: no member named 'bpf_cookie' in 'struct perf_event'
        return BPF_CORE_READ(event, bpf_cookie);
               ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~

...

skeleton/pid_iter.bpf.c:49:9: error: returning 'void' from a function with incompatible result type '__u64' (aka 'unsigned long long')
        return BPF_CORE_READ(event, bpf_cookie);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tools and samples can't use any CONFIG_ definitions, so the fields
used there should always be present.
Define struct perf_event___local with the `preserve_access_index`
attribute inside the pid_iter BPF prog to allow compiling on any
configs. CO-RE will substitute it with the real struct perf_event
accesses later on.

Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230707095425.168126-2-quentin@isovalent.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index eb05ea53afb12..e2af8e5fb29ec 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -15,6 +15,10 @@ enum bpf_obj_type {
 	BPF_OBJ_BTF,
 };
 
+struct perf_event___local {
+	u64 bpf_cookie;
+} __attribute__((preserve_access_index));
+
 extern const void bpf_link_fops __ksym;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
@@ -41,8 +45,8 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 /* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
 static __u64 get_bpf_cookie(struct bpf_link *link)
 {
+	struct perf_event___local *event;
 	struct bpf_perf_link *perf_link;
-	struct perf_event *event;
 
 	perf_link = container_of(link, struct bpf_perf_link, link);
 	event = BPF_CORE_READ(perf_link, perf_file, private_data);
-- 
2.40.1



