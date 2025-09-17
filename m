Return-Path: <stable+bounces-179981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1AEB7E348
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A81B26A85
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957DB1F09A5;
	Wed, 17 Sep 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wvPLHNKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E6D337EB9;
	Wed, 17 Sep 2025 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758113005; cv=none; b=JA/Wh6rc+BFBVBhR7e5w2Dl4iZGo069LdStnC+jLHlsiaQvbSHVSjf20zV59Nd9TbJQlSq5uSdJJyrhY8SyMUJ2EtfiIeTZC0kXNyT57WgLN0C2/gRpA0p6kDBi1SZsR259GTBjxPdrv3OJv3rf5tNG4WqQTZlMZW5x9hXqpsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758113005; c=relaxed/simple;
	bh=670QNZkS7lygJmBv3ENOXGEETYeSgkHOYsWTol1toew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alsaIo2o5LXcvKJRNOTElGRnjyKdHHaZZ70+csdtvDHaSOrGkY94Hn8TYcqUUchTf7Elk0fucMU86wNmHI830RCN80fMP4xv4JZWF9A9+VPa9b+vQ104JW5KewDzmi6BhLZXsHYG7IkpiUOjU12s9DXlDmaBfnWOmEJFRxABmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wvPLHNKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65A7C4CEF0;
	Wed, 17 Sep 2025 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758113005;
	bh=670QNZkS7lygJmBv3ENOXGEETYeSgkHOYsWTol1toew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wvPLHNKVjAW+dzWQhXU8HV/MQIDXzIK4Hxx0RENs6d/YOzOP/qoRGqQBFtsPZMhcR
	 JNZ+l0WvBWht1kWhKmXH+2yGDicNCRXQStHqe3hb9V0uC1oN62/hL3trJiiFbeVpDG
	 KD8y82NX2uZ8iCOSmtAOyUA8FcnfsPfb+vNcBT3k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kohei Enju <enjuk@amazon.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH 6.16 141/189] igb: fix link test skipping when interface is admin down
Date: Wed, 17 Sep 2025 14:34:11 +0200
Message-ID: <20250917123355.308991667@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kohei Enju <enjuk@amazon.com>

[ Upstream commit d709f178abca22a4d3642513df29afe4323a594b ]

The igb driver incorrectly skips the link test when the network
interface is admin down (if_running == false), causing the test to
always report PASS regardless of the actual physical link state.

This behavior is inconsistent with other drivers (e.g. i40e, ice, ixgbe,
etc.) which correctly test the physical link state regardless of admin
state.
Remove the if_running check to ensure link test always reflects the
physical link state.

Fixes: 8d420a1b3ea6 ("igb: correct link test not being run when link is down")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index ca6ccbc139548..6412c84e2d17d 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -2081,11 +2081,8 @@ static void igb_diag_test(struct net_device *netdev,
 	} else {
 		dev_info(&adapter->pdev->dev, "online testing starting\n");
 
-		/* PHY is powered down when interface is down */
-		if (if_running && igb_link_test(adapter, &data[TEST_LINK]))
+		if (igb_link_test(adapter, &data[TEST_LINK]))
 			eth_test->flags |= ETH_TEST_FL_FAILED;
-		else
-			data[TEST_LINK] = 0;
 
 		/* Online tests aren't run; pass by default */
 		data[TEST_REG] = 0;
-- 
2.51.0




