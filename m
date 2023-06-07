Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94548726C35
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFGUb3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjFGUb2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFC10DE
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D4A0644FF
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93948C433EF;
        Wed,  7 Jun 2023 20:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169886;
        bh=p3WJ7x9/NlbwO4sWMj75fLaKz2XEnuRmSvEzdOTEgrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwTskRhXlY9pS88BQqhwXps8iPuUULzfxttj8ojgx/4H6XxfsNKPcOv104D3qPywn
         kRMJ++ujXaq/7WCDSmxvtlxT1xrNYwmtsvyECNCg7LQ5yWbZFbRWIiN9aTBY05MgRJ
         56jurUM5T4+jVt/TPBJwVdUpGkCMqu4Yd+xyCFGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.3 251/286] selftests: mptcp: join: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 22:15:50 +0200
Message-ID: <20230607200931.498806206@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 715c78a82e00f848f99ef76e6f6b89216ccba268 upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: b08fbf241064 ("selftests: add test-cases for MPTCP MP_JOIN")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -6,6 +6,8 @@
 # address all other issues detected by shellcheck.
 #shellcheck disable=SC2086
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 ret=0
 sin=""
 sinfail=""
@@ -132,6 +134,8 @@ cleanup_partial()
 
 check_tools()
 {
+	mptcp_lib_check_mptcp
+
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip


