Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214547B8A81
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbjJDSgO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbjJDSgM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D9A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527DFC433CA;
        Wed,  4 Oct 2023 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444568;
        bh=Y7+vlHR17M3KExVDkgCU/WLIRViTftk9J2NuCkeh4Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q2yfEB6GKNGWa0MWoXh4Bam74nqpzt2qg4J3gjnHVJC0Q1vUt/R4qs8NTPaeNzQzv
         XZsJANyA98fnY+RTvOSS50MOSUkVKlke4yL77dn4Pn0ZJiicnFI4cRxRmvyShnT0N8
         SDbpLJsDL0Hdn0a9GnJM8pH5GkwdGWxP2DgRgLqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH 6.5 296/321] bpf: Add override check to kprobe multi link attach
Date:   Wed,  4 Oct 2023 19:57:21 +0200
Message-ID: <20231004175243.006816219@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit 41bc46c12a8053a1b3279a379bd6b5e87b045b85 upstream.

Currently the multi_kprobe link attach does not check error
injection list for programs with bpf_override_return helper
and allows them to attach anywhere. Adding the missing check.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20230907200652.926951-1-jolsa@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/bpf_trace.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2772,6 +2772,17 @@ static int get_modules_for_addrs(struct
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
@@ -2849,6 +2860,11 @@ int bpf_kprobe_multi_link_attach(const u
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


