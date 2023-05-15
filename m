Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789837039A9
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbjEORoy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244514AbjEORog (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F01715615
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06B362E3F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2613C433EF;
        Mon, 15 May 2023 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172528;
        bh=uIrlw0eurPgLSZGUiyHhwEST69r6Evsb5jPhLbr3OAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f0a+csk9X6+MV2HLGejFEhbPsIh9hpaqK6VVfILAaPPS+Acqrnv0Lxb17tzABPqJS
         OUvwVd15660K5cpRQ7X03hxx1yQ6WuYarSblDwqMK4bOev8Ks6ik5Nm2Aq3/IgELHC
         ihM49XuIcmYvJ4qNyD06tamE+5s1GkH6BR+CVr2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Joe Damato <jdamato@fastly.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 5.10 182/381] ixgbe: Allow flow hash to be set via ethtool
Date:   Mon, 15 May 2023 18:27:13 +0200
Message-Id: <20230515161745.048138716@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Joe Damato <jdamato@fastly.com>

[ Upstream commit 4f3ed1293feb9502dc254b05802faf1ad3317ac6 ]

ixgbe currently returns `EINVAL` whenever the flowhash it set by ethtool
because the ethtool code in the kernel passes a non-zero value for hfunc
that ixgbe should allow.

When ethtool is called with `ETHTOOL_SRXFHINDIR`,
`ethtool_set_rxfh_indir` will call ixgbe's set_rxfh function
with `ETH_RSS_HASH_NO_CHANGE`. This value should be accepted.

When ethtool is called with `ETHTOOL_SRSSH`, `ethtool_set_rxfh` will
call ixgbe's set_rxfh function with `rxfh.hfunc`, which appears to be
hardcoded in ixgbe to always be `ETH_RSS_HASH_TOP`. This value should
also be accepted.

Before this patch:

$ sudo ethtool -L eth1 combined 10
$ sudo ethtool -X eth1 default
Cannot set RX flow hash configuration: Invalid argument

After this patch:

$ sudo ethtool -L eth1 combined 10
$ sudo ethtool -X eth1 default
$ sudo ethtool -x eth1
RX flow hash indirection table for eth1 with 10 RX ring(s):
    0:      0     1     2     3     4     5     6     7
    8:      8     9     0     1     2     3     4     5
   16:      6     7     8     9     0     1     2     3
   24:      4     5     6     7     8     9     0     1
   ...

Fixes: 1c7cf0784e4d ("ixgbe: support for ethtool set_rxfh")
Signed-off-by: Joe Damato <jdamato@fastly.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 55983904b6df1..472ea068ea7b0 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3107,8 +3107,8 @@ static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
 	int i;
 	u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
 
-	if (hfunc)
-		return -EINVAL;
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+		return -EOPNOTSUPP;
 
 	/* Fill out the redirection table */
 	if (indir) {
-- 
2.39.2



