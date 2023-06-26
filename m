Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18B73E7A7
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFZSRT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFZSRS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:17:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3196099
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3F0360F21
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0CBC433C0;
        Mon, 26 Jun 2023 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803436;
        bh=peZxvpC/DAIyjlihyv7g7K4qyrZCuaizTnVtlOwxl2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQ2KuF+4yie9tw1P1Hq6X8Dg+L54MSxwFkzPaRbCDRxENHszOg8c2PuI+RuyxWpv8
         DHmwukJ82A9VV/TpBmKQjK9qwL1ukxES6d8eu1pfdBbyyv/dPIitgyBtqj19D8SY5r
         xIOWIHkQVbeImMTHtq1uEqCyYEKCdlj26quOLw5s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.3 032/199] selftests: mptcp: userspace pm: skip if not supported
Date:   Mon, 26 Jun 2023 20:08:58 +0200
Message-ID: <20230626180807.032042607@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

commit f90adb033891d418c5dafef34a9aa49f3c860991 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the MPTCP Userspace PM introduced by commit 4638de5aefe5
("mptcp: handle local addrs announced by userspace PMs").

We can skip all these tests if the feature is not supported simply by
looking for the MPTCP pm_type's sysctl knob.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 259a834fadda ("selftests: mptcp: functional tests for the userspace PM type")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,6 +5,11 @@
 
 mptcp_lib_check_mptcp
 
+if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	echo "userspace pm tests are not supported by the kernel: SKIP"
+	exit ${KSFT_SKIP}
+fi
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"


