Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633A6F16C4
	for <lists+stable@lfdr.de>; Fri, 28 Apr 2023 13:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240007AbjD1LaT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 28 Apr 2023 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345755AbjD1LaS (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 28 Apr 2023 07:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18F5BBB
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 04:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE9A6430A
        for <stable@vger.kernel.org>; Fri, 28 Apr 2023 11:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B36C433EF;
        Fri, 28 Apr 2023 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682681416;
        bh=xEMkT6Tabd/L9qxuWvznCQ5OGW/tqFFPCT1QzWODMz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byLp8JeqORW3Q2w65T7I8tyIGne0oKfy35i2erDU8F0eQsu0PIjYr/SdtEedJjbKV
         4NW3qVosMQZMXiJrTozuf5wIul6RCxbr2fJjZHS6Uiiuhn107lCN0Z9fz9SS4AgUyk
         npX3WjYrvKb7pZybMhVhJPL7wXJ3MYXu18pgU7mY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH 5.15 10/13] selftests: mptcp: join: fix "invalid address, ADD_ADDR timeout"
Date:   Fri, 28 Apr 2023 13:28:14 +0200
Message-Id: <20230428112039.531220050@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230428112039.133978540@linuxfoundation.org>
References: <20230428112039.133978540@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthieu Baerts <matthieu.baerts@tessares.net>

The "Fixes" commit mentioned below adds new MIBs counters to track some
particular cases that have been fixed by its parent commit 150d1e06c4f1
("mptcp: fix race in incoming ADD_ADDR option processing").

Unfortunately, one of the new MIB counter (AddAddrDrop) shares the same
prefix as an older one (AddAddr). This breaks one selftest because it
was doing a grep on "AddAddr" and it now gets 2 counters instead of 1.

This issue has been fixed upstream in a commit that was part of the same
set but not backported to v5.15, see commit 6ef84b1517e0 ("selftests:
mptcp: more robust signal race test"). It has not been backported
because it was fixing multiple things, some where for >v5.15.

This patch then simply extracts the only bit needed for v5.15. Now the
test passes when validating the last stable v5.15 kernel.

Fixes: f25ae162f4b3 ("mptcp: add mibs counter for ignored incoming options")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -732,7 +732,7 @@ chk_add_nr()
 	local dump_stats
 
 	printf "%-39s %s" " " "add"
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtAddAddr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$add_nr" ]; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"


