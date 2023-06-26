Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB073E8C3
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjFZS31 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjFZS3J (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:29:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D973C19BA
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7641060F51
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF89C433C0;
        Mon, 26 Jun 2023 18:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804112;
        bh=zfZESOLOkYLtdIRgj5FHS4SjZcmF4oaUzPNdHYIHPW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2nGB3Phl2f7Kp+MD58JQbu5zjr216laZAapGlWClt2hFqUqyuO0VhwQv+g6p76ED
         SiUxZQqLoxVH+iBmf2aEIkLd5vWJHVD9m8ZM1PTIeQOXCgMMSpQaWOL9sUHxlSaP9/
         BhkyAeDTiiIovG7tjR2J4N3O1or0y0A+ZzQNzIuI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 018/170] selftests: mptcp: connect: skip disconnect tests if not supported
Date:   Mon, 26 Jun 2023 20:09:47 +0200
Message-ID: <20230626180801.380024137@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
References: <20230626180800.476539630@linuxfoundation.org>
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

commit 4ad39a42da2e9770c8e4c37fe632ed8898419129 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the full support of disconnections from the userspace
introduced by commit b29fcfb54cd7 ("mptcp: full disconnect
implementation").

It is possible to look for "mptcp_pm_data_reset" in kallsyms because a
preparation patch added it to ease the introduction of the mentioned
feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -782,6 +782,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
+		echo "INFO: Full disconnect not supported: SKIP"
+		return
+	fi
+
 	cat $cin $cin $cin > "$cin".disconnect
 
 	# force do_transfer to cope with the multiple tranmissions


