Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42147797D23
	for <lists+stable@lfdr.de>; Thu,  7 Sep 2023 22:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjIGUHC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 7 Sep 2023 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjIGUHB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 7 Sep 2023 16:07:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027B1703
        for <stable@vger.kernel.org>; Thu,  7 Sep 2023 13:06:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2CFC433C8;
        Thu,  7 Sep 2023 20:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694117217;
        bh=aGFaMLfkMRJ7SCt/qgEcOhVxcqWwkhD5fl+QOo8pX6c=;
        h=From:To:Cc:Subject:Date:From;
        b=NSGK9GxC99lb1fCm53abw/ugjAiGfUzVkgh1H2gDxlNt59XI78LhIHaDts6yjizWu
         VGk9/Am1Ord7HyFB5wpYtcqRpppOsJW59vSSVParAycMlvB7HBqAC4/LKSYdQ8idB9
         ekGo4vkbEdpc7pKu+9iThNHHbtqYrMsXqjTsq3Q60ohI+1N2wf33jWruTtst4uUgR/
         H9VaABqW6ZzpDcNP1nXV+I5K/V+bdiCGRY1dm8rFPygescQKSEtoRFOjpI/VCEWVpX
         KhznkaLOOyYFewVvScU2h4irERiAV5iveb2rZyXAF9D6s4wMEkssqiFNd7ke8FhouQ
         FhhLCNZrgLJyQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     stable@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Djalal Harouni <tixxdz@gmail.com>
Subject: [PATCH bpf 1/2] bpf: Add override check to kprobe multi link attach
Date:   Thu,  7 Sep 2023 22:06:51 +0200
Message-ID: <20230907200652.926951-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.41.0
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

Currently the multi_kprobe link attach does not check error
injection list for programs with bpf_override_return helper
and allows them to attach anywhere. Adding the missing check.

Cc: stable@vger.kernel.org
Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/bpf_trace.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a7264b2c17ad..c1c1af63ced2 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2853,6 +2853,17 @@ static int get_modules_for_addrs(struct module ***mods, unsigned long *addrs, u3
 	return arr.mods_cnt;
 }
 
+static int addrs_check_error_injection_list(unsigned long *addrs, u32 cnt)
+{
+	u32 i;
+
+	for (i = 0; i < cnt; i++) {
+		if (!within_error_injection_list(addrs[i]))
+			return -EINVAL;
+	}
+	return 0;
+}
+
 int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
 {
 	struct bpf_kprobe_multi_link *link = NULL;
@@ -2930,6 +2941,11 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 			goto error;
 	}
 
+	if (prog->kprobe_override && addrs_check_error_injection_list(addrs, cnt)) {
+		err = -EINVAL;
+		goto error;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link) {
 		err = -ENOMEM;
-- 
2.41.0

