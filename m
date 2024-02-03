Return-Path: <stable+bounces-18287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F04848221
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870671C229A6
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6EFBEE;
	Sat,  3 Feb 2024 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fc/Cc4Gh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73D247A61;
	Sat,  3 Feb 2024 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933687; cv=none; b=MgPB73aNY/elw5AKNx7zfz1k4YCMhN4LU6z5fmYwUA5ZwytezU+H1ko/z3S7jMSqlRWCAFqdUCDJX1rRKpIqsmmnLb/OIOlqb7NGtKyMxsKLDCD5RN3GZ3EiulEg7S3Sd/eO67g03DSAc7mu+JdFhd9J/Orq+Y52Kv3qt6kBFeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933687; c=relaxed/simple;
	bh=xQrE30GfsfMn2fDWo11Cpi7qNZHXyhX1qBJSzRFSRH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbz1WeDbEIMd54caVAIKyWEp/PGx74hhQltI572rs56BKrYEdV2jzClC9rmIhj1axWyCc9XH63dUVPO/wJ/qn7Nl2//8Sk/pgVekzcf8N1l4ywxQ55clka868WBGWbWbpWBitmKHp8AmpNZV3MdOEJN6VGdPZhjneTxO68euV8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fc/Cc4Gh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FF5C433F1;
	Sat,  3 Feb 2024 04:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933687;
	bh=xQrE30GfsfMn2fDWo11Cpi7qNZHXyhX1qBJSzRFSRH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fc/Cc4GhIELYhbB9d+XRozvaxu61M2OV6/I/AfycKjHF3cfbevnoQDU9E8Hk2sAPl
	 1eTpcoyYSyHporKj8vwbuqTdj3DJ2S+CyA535bz1tesbBTol98ZFNP9+BNTCnEoPci
	 olJWfs/D5819iQtT42IG6nx4CO0C7I0v5hJEHkSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Trey Harrison <harrisondigitalmedia@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Naama Meir <naamax.meir@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 282/322] e1000e: correct maximum frequency adjustment values
Date: Fri,  2 Feb 2024 20:06:19 -0800
Message-ID: <20240203035408.202137002@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
References: <20240203035359.041730947@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacob Keller <jacob.e.keller@intel.com>

[ Upstream commit f1f6a6b1830a8f1dc92ee26fae76333f446b0663 ]

The e1000e driver supports hardware with a variety of different clock
speeds, and thus a variety of different increment values used for
programming its PTP hardware clock.

The values currently programmed in e1000e_ptp_init are incorrect. In
particular, only two maximum adjustments are used: 24000000 - 1, and
600000000 - 1. These were originally intended to be used with the 96 MHz
clock and the 25 MHz clock.

Both of these values are actually slightly too high. For the 96 MHz clock,
the actual maximum value that can safely be programmed is 23,999,938. For
the 25 MHz clock, the maximum value is 599,999,904.

Worse, several devices use a 24 MHz clock or a 38.4 MHz clock. These parts
are incorrectly assigned one of either the 24million or 600million values.
For the 24 MHz clock, this is not a significant issue: its current
increment value can support an adjustment up to 7billion in the positive
direction. However, the 38.4 KHz clock uses an increment value which can
only support up to 230,769,157 before it starts overflowing.

To understand where these values come from, consider that frequency
adjustments have the form of:

new_incval = base_incval + (base_incval * adjustment) / (unit of adjustment)

The maximum adjustment is reported in terms of parts per billion:
new_incval = base_incval + (base_incval * adjustment) / 1 billion

The largest possible adjustment is thus given by the following:
max_incval = base_incval + (base_incval * max_adj) / 1 billion

Re-arranging to solve for max_adj:
max_adj = (max_incval - base_incval) * 1 billion / base_incval

We also need to ensure that negative adjustments cannot underflow. This can
be achieved simply by ensuring max_adj is always less than 1 billion.

Introduce new macros in e1000.h codifying the maximum adjustment in PPB for
each frequency given its associated increment values. Also clarify where
these values come from by commenting about the above equations.

Replace the switch statement in e1000e_ptp_init with one which mirrors the
increment value switch statement from e1000e_get_base_timinica. For each
device, assign the appropriate maximum adjustment based on its frequency.
Some parts can have one of two frequency modes as determined by
E1000_TSYNCRXCTL_SYSCFI.

Since the new flow directly matches the assignments in
e1000e_get_base_timinca, and uses well defined macro names, it is much
easier to verify that the resulting maximum adjustments are correct. It
also avoids difficult to parse construction such as the "hw->mac.type <
e1000_phc_lpt", and the use of fallthrough which was especially confusing
when combined with a conditional block.

Note that I believe the current increment value configuration used for
24MHz clocks is sub-par, as it leaves at least 3 extra bits available in
the INCVALUE register. However, fixing that requires more careful review of
the clock rate and associated values.

Reported-by: Trey Harrison <harrisondigitalmedia@gmail.com>
Fixes: 68fe1d5da548 ("e1000e: Add Support for 38.4MHZ frequency")
Fixes: d89777bf0e42 ("e1000e: add support for IEEE-1588 PTP")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/e1000e/e1000.h | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/ptp.c   | 22 +++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index a187582d2299..ba9c19e6994c 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -360,23 +360,43 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
  * As a result, a shift of INCVALUE_SHIFT_n is used to fit a value of
  * INCVALUE_n into the TIMINCA register allowing 32+8+(24-INCVALUE_SHIFT_n)
  * bits to count nanoseconds leaving the rest for fractional nonseconds.
+ *
+ * Any given INCVALUE also has an associated maximum adjustment value. This
+ * maximum adjustment value is the largest increase (or decrease) which can be
+ * safely applied without overflowing the INCVALUE. Since INCVALUE has
+ * a maximum range of 24 bits, its largest value is 0xFFFFFF.
+ *
+ * To understand where the maximum value comes from, consider the following
+ * equation:
+ *
+ *   new_incval = base_incval + (base_incval * adjustment) / 1billion
+ *
+ * To avoid overflow that means:
+ *   max_incval = base_incval + (base_incval * max_adj) / billion
+ *
+ * Re-arranging:
+ *   max_adj = floor(((max_incval - base_incval) * 1billion) / 1billion)
  */
 #define INCVALUE_96MHZ		125
 #define INCVALUE_SHIFT_96MHZ	17
 #define INCPERIOD_SHIFT_96MHZ	2
 #define INCPERIOD_96MHZ		(12 >> INCPERIOD_SHIFT_96MHZ)
+#define MAX_PPB_96MHZ		23999900 /* 23,999,900 ppb */
 
 #define INCVALUE_25MHZ		40
 #define INCVALUE_SHIFT_25MHZ	18
 #define INCPERIOD_25MHZ		1
+#define MAX_PPB_25MHZ		599999900 /* 599,999,900 ppb */
 
 #define INCVALUE_24MHZ		125
 #define INCVALUE_SHIFT_24MHZ	14
 #define INCPERIOD_24MHZ		3
+#define MAX_PPB_24MHZ		999999999 /* 999,999,999 ppb */
 
 #define INCVALUE_38400KHZ	26
 #define INCVALUE_SHIFT_38400KHZ	19
 #define INCPERIOD_38400KHZ	1
+#define MAX_PPB_38400KHZ	230769100 /* 230,769,100 ppb */
 
 /* Another drawback of scaling the incvalue by a large factor is the
  * 64-bit SYSTIM register overflows more quickly.  This is dealt with
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 02d871bc112a..bbcfd529399b 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -280,8 +280,17 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		adapter->ptp_clock_info.max_adj = MAX_PPB_96MHZ;
+		break;
 	case e1000_pch_lpt:
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
+			adapter->ptp_clock_info.max_adj = MAX_PPB_96MHZ;
+		else
+			adapter->ptp_clock_info.max_adj = MAX_PPB_25MHZ;
+		break;
 	case e1000_pch_spt:
+		adapter->ptp_clock_info.max_adj = MAX_PPB_24MHZ;
+		break;
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
@@ -289,15 +298,14 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
 	case e1000_pch_nvp:
-		if ((hw->mac.type < e1000_pch_lpt) ||
-		    (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)) {
-			adapter->ptp_clock_info.max_adj = 24000000 - 1;
-			break;
-		}
-		fallthrough;
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
+			adapter->ptp_clock_info.max_adj = MAX_PPB_24MHZ;
+		else
+			adapter->ptp_clock_info.max_adj = MAX_PPB_38400KHZ;
+		break;
 	case e1000_82574:
 	case e1000_82583:
-		adapter->ptp_clock_info.max_adj = 600000000 - 1;
+		adapter->ptp_clock_info.max_adj = MAX_PPB_25MHZ;
 		break;
 	default:
 		break;
-- 
2.43.0




