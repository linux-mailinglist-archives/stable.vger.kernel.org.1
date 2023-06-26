Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518C73EA2D
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjFZSoL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjFZSoK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7830ED
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628BC60E8D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DEDC433C8;
        Mon, 26 Jun 2023 18:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687805048;
        bh=P3h2hjZrHdqdljlQE0cOsJ4YhJ0VXF462+NZJyCH0XE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OKKqj1/U72RYuxZl4O/uESrUfp8JDsEtxZiT0iJOc5GjHRWmz6qsWdqNAU22te7W6
         8VFIi3QQzdpFcNFEvjWXBQM8eQEjyeMSkE55ixpp0skJUTMega+cXO3GjTw7TiNiX0
         UEDiOPrthSgXq51o2WcU0E5TBZPOUOTUu6kvg9KE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 05/81] selftests: mptcp: lib: skip if missing symbol
Date:   Mon, 26 Jun 2023 20:11:47 +0200
Message-ID: <20230626180744.674168952@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180744.453069285@linuxfoundation.org>
References: <20230626180744.453069285@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 673004821ab98c6645bd21af56a290854e88f533 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

New functions are now available to easily detect if a certain feature is
missing by looking at kallsyms.

These new helpers are going to be used in the following commits. In
order to ease the backport of such future patches, it would be good if
this patch is backported up to the introduction of MPTCP selftests,
hence the Fixes tag below: this type of check was supposed to be done
from the beginning.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/config       |    1 
 tools/testing/selftests/net/mptcp/mptcp_lib.sh |   38 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,41 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}


