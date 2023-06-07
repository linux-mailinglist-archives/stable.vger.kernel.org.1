Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA033726C37
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjFGUbe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjFGUbe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCBB184
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACFFB644E4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFABCC433D2;
        Wed,  7 Jun 2023 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169892;
        bh=nWqr5TWz5JpUsaCsCSSpZgS2+HkE4DbKk2xbE2P+Tas=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xW0Htk2SUomWdIZ18ERrk57cOJ9uHIwQnDgmtba10CmqQlPSESOPtbnhbA8DmajF1
         UllBuvToWozBqk8l9IGhSbW4LmwNRYURDUzzFk8Xqfkn9Je7i9JpwAYOOJnA/HCgt0
         29RMkHDu6ykliBVFE47KCkMw2vjrfgn3A5iKjgOw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 6.3 253/286] selftests: mptcp: diag: skip if MPTCP is not supported
Date:   Wed,  7 Jun 2023 22:15:52 +0200
Message-ID: <20230607200931.573156245@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

commit 46565acdd29facbf418a11e4a3791b3c8967308d upstream.

Selftests are supposed to run on any kernels, including the old ones not
supporting MPTCP.

A new check is then added to make sure MPTCP is supported. If not, the
test stops and is marked as "skipped".

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: df62f2ec3df6 ("selftests/mptcp: add diag interface tests")
Cc: stable@vger.kernel.org
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/diag.sh |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,6 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+. "$(dirname "${0}")/mptcp_lib.sh"
+
 sec=$(date +%s)
 rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
 ns="ns1-$rndh"
@@ -31,6 +33,8 @@ cleanup()
 	ip netns del $ns
 }
 
+mptcp_lib_check_mptcp
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"


