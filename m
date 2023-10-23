Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8287E7D3398
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbjJWLcH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjJWLcG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:32:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B29AC1
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:32:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFCBC433C7;
        Mon, 23 Oct 2023 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060724;
        bh=yzXcIDP9vmlrvAP6T3U563NR4BO1FeDux+1ydWh5LUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwEqshRysUbZkunqkIZoYKElIvlClmQFzkJ4xntbKMPG3aSMroeSjto1AYAHda0Ec
         QkcKRgAyFWZA9rrmZysQLAhuuBW3Sry1qYXjQyHrO+e95XRS6OxjfEbQNv8TkmJCOu
         e2B7PpCOAgLSyLI4CJpQRB+amM3SwK6+/x/WuWCk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephen Rothwell <sfr@canb.auug.org.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.4 044/123] Documentation: sysctl: align cells in second content column
Date:   Mon, 23 Oct 2023 12:56:42 +0200
Message-ID: <20231023104819.200165516@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104817.691299567@linuxfoundation.org>
References: <20231023104817.691299567@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bagas Sanjaya <bagasdotme@gmail.com>

commit 1faa34672f8a17a3e155e74bde9648564e9480d6 upstream.

Stephen Rothwell reported htmldocs warning when merging net-next tree:

Documentation/admin-guide/sysctl/net.rst:37: WARNING: Malformed table.
Text in column margin in table line 4.

========= =================== = ========== ==================
Directory Content               Directory  Content
========= =================== = ========== ==================
802       E802 protocol         mptcp     Multipath TCP
appletalk Appletalk protocol    netfilter Network Filter
ax25      AX25                  netrom     NET/ROM
bridge    Bridging              rose      X.25 PLP layer
core      General parameter     tipc      TIPC
ethernet  Ethernet protocol     unix      Unix domain sockets
ipv4      IP version 4          x25       X.25 protocol
ipv6      IP version 6
========= =================== = ========== ==================

The warning above is caused by cells in second "Content" column of
/proc/sys/net subdirectory table which are in column margin.

Align these cells against the column header to fix the warning.

Link: https://lore.kernel.org/linux-next/20220823134905.57ed08d5@canb.auug.org.au/
Fixes: 1202cdd665315c ("Remove DECnet support from kernel")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20220824035804.204322-1-bagasdotme@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/sysctl/net.rst |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -31,18 +31,18 @@ see only some of them, depending on your
 
 Table : Subdirectories in /proc/sys/net
 
- ========= =================== = ========== ==================
+ ========= =================== = ========== ===================
  Directory Content               Directory  Content
- ========= =================== = ========== ==================
- 802       E802 protocol         mptcp     Multipath TCP
- appletalk Appletalk protocol    netfilter Network Filter
+ ========= =================== = ========== ===================
+ 802       E802 protocol         mptcp      Multipath TCP
+ appletalk Appletalk protocol    netfilter  Network Filter
  ax25      AX25                  netrom     NET/ROM
- bridge    Bridging              rose      X.25 PLP layer
- core      General parameter     tipc      TIPC
- ethernet  Ethernet protocol     unix      Unix domain sockets
- ipv4      IP version 4          x25       X.25 protocol
+ bridge    Bridging              rose       X.25 PLP layer
+ core      General parameter     tipc       TIPC
+ ethernet  Ethernet protocol     unix       Unix domain sockets
+ ipv4      IP version 4          x25        X.25 protocol
  ipv6      IP version 6
- ========= =================== = ========== ==================
+ ========= =================== = ========== ===================
 
 1. /proc/sys/net/core - Network core options
 ============================================


