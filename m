Return-Path: <stable+bounces-56310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81291EDB5
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB98283CA8
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C912EBD6;
	Tue,  2 Jul 2024 04:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkuWZ/S5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7322B12E1C6;
	Tue,  2 Jul 2024 04:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893521; cv=none; b=tfJU/MFBXA5uXOXXXshZVhbLq7q6teUb0zqtGorpyIPmqpZERxfTAnsl+QIdKCni7iKIEbNA5rZ08V/jTujQ4me3+KR8eBWNqKN0fWUd8eQLf0LkPPQbIumDef18Z21rumocNG2v/D6rrXIQO/ogkcwcxAOY5oLWw2PCFyhcJo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893521; c=relaxed/simple;
	bh=6DF+Tg08u2ZMCkSK6BU/n5CzYxotLfqWDSV6lDu1oZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNzzNpRYTc2Bq+csKuFY5ELiwp6V2rJ+0h73EalCQ0YAgO90199oSTDJtDjJOe+dztYIpFUksZbfbCjLjABO8g5UaQQ97ebLnFy/auxk0rZk7qpFyMzQwk1/t2K9wkKxhlg3PsiRlKtCRJ0GRk5twLzCEvFiG9Em0MFD5UCxreA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkuWZ/S5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719893519; x=1751429519;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6DF+Tg08u2ZMCkSK6BU/n5CzYxotLfqWDSV6lDu1oZo=;
  b=YkuWZ/S5mGDmunJNAvcSzwr/H/n7/WkF1sLagFukJIjAfIz6IWhl3Y4T
   EWxKXVsLIQGDxqToqdEhz5k1QO6ebgYZe4+aSYSXhYe2458/kwqGHBDHd
   R+CHI4aqoEF9AJA7+gwc2XHF1sFppyRLtE1c+lwxdlPp3jN2wYdpWJ/t2
   qOxUr+hebeObfBU352b2GNzbcCijoOwjQKRpm8OYOQZmFZuGcJuDSgIVO
   W4Hde8wUuyeH/cpZfPnU2ozSCYhlJYKJaiWief01WRZM4b/g/Um7HA5sj
   jzIevg1PIS6w9r4UmClnJM1uDLvGYcJP4U3mF3v8XWIa6xZZoL+XBgc45
   Q==;
X-CSE-ConnectionGUID: C33KhS79Qtq3Ros4VQvn+A==
X-CSE-MsgGUID: M+xKdIvXQs+EoxBE4uRTsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="20916516"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20916516"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:59 -0700
X-CSE-ConnectionGUID: 013kFb9YRG6E1dNdSTzwNw==
X-CSE-MsgGUID: EMJIRaMTTNijTvRFkaUmcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="50959324"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:59 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 7B6C1201A797;
	Mon,  1 Jul 2024 21:11:56 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v1 4/4] igc: Fix qbv tx latency by setting gtxoffset
Date: Tue,  2 Jul 2024 00:09:26 -0400
Message-Id: <20240702040926.3327530-5-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
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
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 26dbe3442ad1..e95502fc844b 100644
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


