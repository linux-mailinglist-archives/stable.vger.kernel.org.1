Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766C78AA2A
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjH1KTR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjH1KSy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:18:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAED10A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59B0263782
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63310C433C7;
        Mon, 28 Aug 2023 10:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217927;
        bh=0qdXS/2+uunYFP0nFn0pEPwcULkNODkZY4x+FwdcY7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyGV8LBHFz3Dqikwv3/KJ/v5apUWp7F9nYJnJN8xHWMZonOYUeXfEs13LyMmfRV+1
         uHXBN2dVFZOCPM98saDArzjQX5nrJlpsIXuahnLtLavIfytXmRQ0IfbB0t0zzTSTEw
         eRIkSqg92rgOaXGuP6O7lN1rRA6cNz7bRHz4w9pc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH 6.4 032/129] ice: fix receive buffer size miscalculation
Date:   Mon, 28 Aug 2023 12:11:51 +0200
Message-ID: <20230828101158.453955409@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

[ Upstream commit 10083aef784031fa9f06c19a1b182e6fad5338d9 ]

The driver is misconfiguring the hardware for some values of MTU such that
it could use multiple descriptors to receive a packet when it could have
simply used one.

Change the driver to use a round-up instead of the result of a shift, as
the shift can truncate the lower bits of the size, and result in the
problem noted above. It also aligns this driver with similar code in i40e.

The insidiousness of this problem is that everything works with the wrong
size, it's just not working as well as it could, as some MTU sizes end up
using two or more descriptors, and there is no way to tell that is
happening without looking at ice_trace or a bus analyzer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 619cb07a40691..25e09ab708ca1 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -393,7 +393,8 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Receive Packet Data Buffer Size.
 	 * The Packet Data Buffer Size is defined in 128 byte units.
 	 */
-	rlan_ctx.dbuf = ring->rx_buf_len >> ICE_RLAN_CTX_DBUF_S;
+	rlan_ctx.dbuf = DIV_ROUND_UP(ring->rx_buf_len,
+				     BIT_ULL(ICE_RLAN_CTX_DBUF_S));
 
 	/* use 32 byte descriptors */
 	rlan_ctx.dsize = 1;
-- 
2.40.1



