Return-Path: <stable+bounces-58183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF09297F5
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 14:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 170CC282180
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8B338FA8;
	Sun,  7 Jul 2024 12:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwA0rndF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BC037143;
	Sun,  7 Jul 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720356957; cv=none; b=cqahdpxMbl7WmBn2sWXy7MlbPI0bP4D3J8m9nWxfrbkkkgpzxfAHWsx2OhVv7Tv/nZ6J4jIs/O9H9o+IimGVV7zWSDtI0O1lWvAEgFiqeZHvSgiT0HEoPncAia9PjoaoDGUL3HgRxVcRcRqIwlO0AKJq9sjx1dqcd76nhnxZdT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720356957; c=relaxed/simple;
	bh=yq9fdn79P/7uXLeqkaqvokXNESEJw6LEGZiE5haj0rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H4M4StYh3Ur3BXQUjTXVlvFC3QXNSbjXkmFC6e+F6ItCBKzQ8m+KzSpq99U5uyZ4RFKzwhYuShfr5StXN8l351xIFtwUOHyX5YOM0+Tk2AqddgGqzfqrlfBQO9nyLSYNZsBSoaG7frYmskeyrEfnhKPa6RslqbDMMmlQToJ20l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwA0rndF; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720356956; x=1751892956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yq9fdn79P/7uXLeqkaqvokXNESEJw6LEGZiE5haj0rk=;
  b=hwA0rndFL9qfbsFDksMiZ9cLIUW95MBJqaXu6vX5rTz03hrpYBwfeg4a
   bR75vWbo8a6nM32+foCXYXIWbfa7BZLiosw2ARKNDEyLgrekVt+pGDwab
   gglGxl4mO16WJUdZmYseF1ZAav2Zv52wqTCJwugugmlV2ofo7HAaR5qZc
   nXnsLlx5gqk6LSoP1voXioI2h5xYtmjGG1r6ETwQKPPV1Wc78gBGnmObp
   HfWfA0ENt7xmq5cezs0tCtGOv3t10dX40w0l5lSM4B6RtUrJlYX23Bflb
   DNA4ZdUzZUyn03N8Q6vyplsZBptDFYGHuUkqNRqW+N3KOd9pVUo+J3pi5
   Q==;
X-CSE-ConnectionGUID: /VNgHnndTAGdutYeo+UIEg==
X-CSE-MsgGUID: Kgn66ITeTSe7hECb71koOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="17673469"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="17673469"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:55:55 -0700
X-CSE-ConnectionGUID: xPp/wiFMS6+0YZ9L/LZb1w==
X-CSE-MsgGUID: rdCxZ3vISw62k2inJpqk0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="47029673"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:55:55 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id E556420738C7;
	Sun,  7 Jul 2024 05:55:50 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v2 3/3] igc: Fix qbv tx latency by setting gtxoffset
Date: Sun,  7 Jul 2024 08:53:18 -0400
Message-Id: <20240707125318.3425097-4-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
References: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A large tx latency issue was discovered during testing when only QBV was
enabled. The issue occurs because gtxoffset was not set when QBV is
active, it was only set when launch time is active.

The patch "igc: Correct the launchtime offset" only sets gtxoffset when
the launchtime_enable field is set by the user. Enabling launchtime_enable
ultimately sets the register IGC_TXQCTL_QUEUE_MODE_LAUNCHT (referred to as
LaunchT in the SW user manual).

Section 7.5.2.6 of the IGC i225/6 SW User Manual Rev 1.2.4 states:
"The latency between transmission scheduling (launch time) and the
time the packet is transmitted to the network is listed in Table 7-61."

However, the patch misinterprets the phrase "launch time" in that section
by assuming it specifically refers to the LaunchT register, whereas it
actually denotes the generic term for when a packet is released from the
internal buffer to the MAC transmit logic.

This launch time, as per that section, also implicitly refers to the QBV
gate open time, where a packet waits in the buffer for the QBV gate to
open. Therefore, latency applies whenever QBV is in use. TSN features such
as QBU and QAV reuse QBV, making the latency universal to TSN features.

Discussed with i226 HW owner (Shalev, Avi) and we were in agreement that
the term "launch time" used in Section 7.5.2.6 is not clear and can be
easily misinterpreted. Avi will update this section to:
"When TQAVCTRL.TRANSMIT_MODE = TSN, the latency between transmission
scheduling and the time the packet is transmitted to the network is listed
in Table 7-61."

Fix this issue by using igc_tsn_is_tx_mode_in_tsn() as a condition to
write to gtxoffset, aligning with the newly updated SW User Manual.

Tested:
1. Enrol taprio on talker board
   base-time 0
   cycle-time 1000000
   flags 0x2
   index 0 cmd S gatemask 0x1 interval1
   index 0 cmd S gatemask 0x1 interval2

   Note:
   interval1 = interval for a 64 bytes packet to go through
   interval2 = cycle-time - interval1

2. Take tcpdump on listener board

3. Use udp tai app on talker to send packets to listener

4. Check the timestamp on listener via wireshark

Test Result:
100 Mbps: 113 ~193 ns
1000 Mbps: 52 ~ 84 ns
2500 Mbps: 95 ~ 223 ns

Note that the test result is similar to the patch "igc: Correct the
launchtime offset".

Fixes: 790835fcc0cb ("igc: Correct the launchtime offset")
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 9fafe275f30f..efe13a9350ca 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -61,7 +61,7 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u16 txoffset;
 
-	if (!is_any_launchtime(adapter))
+	if (!igc_tsn_is_tx_mode_in_tsn(adapter))
 		return;
 
 	switch (adapter->link_speed) {
-- 
2.25.1


