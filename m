Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08E477ABA0
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjHMVX5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjHMVX4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A931701
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97F3F628BF
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672B6C433B6;
        Sun, 13 Aug 2023 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691961836;
        bh=ov/3zRzxfELGr/vF7C1FtfHn8OqGoMxxGePjtFzJtzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2KxW8JKIFX0vU7UcJ+HzQBeO6KIAa+moAiU/ZxEn46OQsjBfbqXC7g+RxNJ+Li8B
         JqLOYHmtGnduMBZQV90KSWhzyD7PQdx0Ics4rnjkcSvrrhadHCMxorCHhnKZ3w+Y8u
         qujjbDUkP+yz/n6qQsWrOPRh/uM28f/TGFtkEuxA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrea Claudi <aclaudi@redhat.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 017/206] selftests: mptcp: join: fix implicit EP test
Date:   Sun, 13 Aug 2023 23:16:27 +0200
Message-ID: <20230813211725.467839534@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrea Claudi <aclaudi@redhat.com>

commit c8c101ae390a3e817369e94a6f12a1ddea420702 upstream.

mptcp_join 'implicit EP' test currently fails when using ip mptcp:

  $ ./mptcp_join.sh -iI
  <snip>
  001 implicit EP    creation[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
  Error: too many addresses or duplicate one: -22.
                     ID change is prevented[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
                     modif is allowed[fail] expected '10.0.2.2 10.0.2.2 id 1 signal' found '10.0.2.2 id 1 signal '

This happens because of two reasons:
- iproute v6.3.0 does not support the implicit flag, fixed with
  iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
  flag")
- pm_nl_check_endpoint wrongly expects the ip address to be repeated two
  times in iproute output, and does not account for a final whitespace
  in it.

This fixes the issue trimming the whitespace in the output string and
removing the double address in the expected string.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Link: https://lore.kernel.org/r/20230803-upstream-net-20230803-misc-fixes-6-5-v1-2-6671b1ab11cc@tessares.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -767,10 +767,11 @@ pm_nl_check_endpoint()
 	fi
 
 	if [ $ip_mptcp -eq 1 ]; then
+		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
+		line="${line% }"
 		# the dump order is: address id flags port dev
-		expected_line="$addr"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		[ -n "$addr" ] && expected_line="$addr"
 		expected_line="$expected_line $id"
 		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
 		[ -n "$dev" ] && expected_line="$expected_line $dev"


