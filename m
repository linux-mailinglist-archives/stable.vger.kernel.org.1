Return-Path: <stable+bounces-164769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B55B12595
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 22:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F461C22EFD
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 20:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF73925A32E;
	Fri, 25 Jul 2025 20:33:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.blochl.de (mail.blochl.de [151.80.40.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055A423F421;
	Fri, 25 Jul 2025 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.40.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475632; cv=none; b=MRviHI7k4t6gDzHHJCeUdw762ST0ca1AjT/IqWdk5IwaU27AJiClHLjTtqegHuLJAhjZy1K/ZRXYAsa7Smn8JJw+wpdZ1R/43mCPxbbBUvtr+q8dpUVIBYawkUfZmSd6g3SZRNSZREN3sjimTxoKefNgitTbJJufyzlqSsPmhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475632; c=relaxed/simple;
	bh=Um8nTzh656Pi7VP5BcSWXmH++wVExc/uJZ0Tx3+/PtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kDEDGjqjPEZ6ERgzaNXGFDVEL+vyail0zsMEq2jJXomio3Pdlxj/JCrkrp7CDoTsvcATthF/4eeDp9bDMiiUPoExCgFnYyaf0wjttVj3FxllzaNB7z6S0wi0kREQjt0Yr1kvcK+iqQ+5YfCOTl3Nak9N8BYb9sc8RoXnb1Yee8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de; spf=pass smtp.mailfrom=blochl.de; arc=none smtp.client-ip=151.80.40.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blochl.de
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.blochl.de 154C644664AD
Authentication-Results: mail.blochl.de; dmarc=none (p=none dis=none) header.from=blochl.de
Authentication-Results: mail.blochl.de; spf=fail smtp.mailfrom=blochl.de
Received: from WorkKnecht.fritz.box (ppp-93-104-0-143.dynamic.mnet-online.de [93.104.0.143])
	by smtp.blochl.de (Postfix) with ESMTPSA id 154C644664AD;
	Fri, 25 Jul 2025 20:33:36 +0000 (UTC)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.2 at 472b552e6fe8
Date: Fri, 25 Jul 2025 22:33:31 +0200
From: Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, 
	Anton Nadezhdin <anton.nadezhdin@intel.com>, markus.bloechl@ipetronik.com
Subject: [PATCH] ice/ptp: fix crosstimestamp reporting
Message-ID: <20250725-ice_crosstimestamp_reporting-v1-1-3d0473bb7b57@blochl.de>
X-B4-Tracking: v=1; b=H4sIAELpg2gC/x3MQQqFIBAA0KvErBPKyqKrxCfMpppFKjPyCaK7J
 y3f5t0gyIQCY3ED45+Egs+oywLcYf2OitZs0JXuqr42ihzOjoNIohMl2TPOjDFwIr+rxejGWN0
 a1w6Qi8i40fX10+95Xh9SEVhuAAAA
X-Change-ID: 20250716-ice_crosstimestamp_reporting-b6236a246c48
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (smtp.blochl.de [0.0.0.0]); Fri, 25 Jul 2025 20:33:36 +0000 (UTC)

From: Anton Nadezhdin <anton.nadezhdin@intel.com>

commit a5a441ae283d upstream.

Set use_nsecs=true as timestamp is reported in ns. Lack of this result
in smaller timestamp error window which cause error during phc2sys
execution on E825 NICs:
phc2sys[1768.256]: ioctl PTP_SYS_OFFSET_PRECISE: Invalid argument

This problem was introduced in the cited commit which omitted setting
use_nsecs to true when converting the ice driver to use
convert_base_to_cs().

Testing hints (ethX is PF netdev):
phc2sys -s ethX -c CLOCK_REALTIME  -O 37 -m
phc2sys[1769.256]: CLOCK_REALTIME phc offset -5 s0 freq      -0 delay    0

Fixes: d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Markus Blöchl <markus@blochl.de>
---
Hi Greg,

please consider this backport for linux-6.12.y

It fixes a regression from the series around
d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")
which affected multiple drivers and occasionally
caused phc2sys to fail on ioctl(fd, PTP_SYS_OFFSET_PRECISE, ...).

This was the initial fix for ice but apparently tagging it
for stable was forgotten during submission.

The hunk was moved around slightly in the upstream commit 
92456e795ac6 ("ice: Add unified ice_capture_crosststamp")
from ice_ptp_get_syncdevicetime() into another helper function
ice_capture_crosststamp() so its indentation and context have changed.
I adapted it to apply cleanly.
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7c6f81beaee4602050b4cf366441a2584507d949..369c968a0117d0f7012241fd3e2c0a45a059bfa4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2226,6 +2226,7 @@ ice_ptp_get_syncdevicetime(ktime_t *device,
 			hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
 			system->cycles = hh_ts;
 			system->cs_id = CSID_X86_ART;
+			system->use_nsecs = true;
 			/* Read Device source clock time */
 			hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
 			hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));

---
base-commit: d90ecb2b1308b3e362ec4c21ff7cf0a051b445df
change-id: 20250716-ice_crosstimestamp_reporting-b6236a246c48

Best regards,
-- 
Markus Blöchl <markus@blochl.de>


-- 

