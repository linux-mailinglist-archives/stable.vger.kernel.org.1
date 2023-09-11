Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9077079BC0D
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbjIKWUY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbjIKNyX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:54:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1126AFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:54:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58449C433C8;
        Mon, 11 Sep 2023 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440455;
        bh=hEz8FR8mLBKaotlYJZj91tMBEikZtjpGrxopvT0jebg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jELarS+w6C5X+2Nl0KkAVXnzcEFGOCkdOlTeiA0NuRZKo529AvihIuwOcSFvN7qwi
         Zt39tfHNZmlVJPI6eXe+SWNGLvugd3A30agz7ZsaRx9wDKTrXEbGC+AmiOxKNMTdco
         67Tg0VutedI28OuR+BDJq95B1qb4k3uOF/jJ+jNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 067/739] bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in pid_iter.bpf.c
Date:   Mon, 11 Sep 2023 15:37:46 +0200
Message-ID: <20230911134652.977435700@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quentin Monnet <quentin@isovalent.com>

[ Upstream commit 44ba7b30e84fb40da2295e85a6d209e199fdc977 ]

In order to allow the BPF program in bpftool's pid_iter.bpf.c to compile
correctly on hosts where vmlinux.h does not define
BPF_LINK_TYPE_PERF_EVENT (running kernel versions lower than 5.15, for
example), define and use a local copy of the enum value. This requires
LLVM 12 or newer to build the BPF program.

Fixes: cbdaf71f7e65 ("bpftool: Add bpf_cookie to link output")
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20230707095425.168126-4-quentin@isovalent.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 3a4c4f7d83d86..26004f0c5a6ae 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -24,6 +24,10 @@ struct perf_event___local {
 	u64 bpf_cookie;
 } __attribute__((preserve_access_index));
 
+enum bpf_link_type___local {
+	BPF_LINK_TYPE_PERF_EVENT___local = 7,
+};
+
 extern const void bpf_link_fops __ksym;
 extern const void bpf_map_fops __ksym;
 extern const void bpf_prog_fops __ksym;
@@ -93,10 +97,13 @@ int iter(struct bpf_iter__task_file *ctx)
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
 
-	if (obj_type == BPF_OBJ_LINK) {
+	if (obj_type == BPF_OBJ_LINK &&
+	    bpf_core_enum_value_exists(enum bpf_link_type___local,
+				       BPF_LINK_TYPE_PERF_EVENT___local)) {
 		struct bpf_link *link = (struct bpf_link *) file->private_data;
 
-		if (BPF_CORE_READ(link, type) == BPF_LINK_TYPE_PERF_EVENT) {
+		if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
+						      BPF_LINK_TYPE_PERF_EVENT___local)) {
 			e.has_bpf_cookie = true;
 			e.bpf_cookie = get_bpf_cookie(link);
 		}
-- 
2.40.1



