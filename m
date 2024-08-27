Return-Path: <stable+bounces-70302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C261F96030C
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 09:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D881280BF5
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01057154439;
	Tue, 27 Aug 2024 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HN3Ft3iF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3141145B10
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743724; cv=none; b=ZE+DCmdY1JI7NON4rax2frqi3QgT/QA8D4RwM8xuHLHriy5SsCJIOHYraUncB2L57cCaELkiSfC4Ky4LGYLhRSd54YceMlcfOCQXw7ZEMUecd5BYSKwOgzFYoUagxyrHXlTu8Pr7iYUr0lOOyqKgcW3DgxK2lPzBKp/Z/2G2P6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743724; c=relaxed/simple;
	bh=CqUCaJOVvT8rRgyjq5M2tsRiDE1LraeJ0P5Rs4HIfQU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=V5YLDEgzEkcAl+zEuEUAhtd4K7oJORyeeN741fRqJXb2nTikz0jzLrmHoFPsgUtA/9rVkkbFUVMbOapj76aDtLUt6kTammxme3L9s1fmJ0NvVyecYQEJHicOjIdTU/eMYDhZXpoSwMt8rJkUfHNn8hl3EhkLSeEpZxpqLYHqSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HN3Ft3iF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DEDC8B7A0;
	Tue, 27 Aug 2024 07:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724743724;
	bh=CqUCaJOVvT8rRgyjq5M2tsRiDE1LraeJ0P5Rs4HIfQU=;
	h=Subject:To:Cc:From:Date:From;
	b=HN3Ft3iFUS/MaWty2dnr87bKSceXtUoj7QiVfJ85zZSmVx/ixRegex1uSktNXlcvd
	 vrqGUSiwTJSuHye4+sazmA5CU4iY0yMw5852y5HHkZPcmpbOHSLfcJvSQTRd3qkhBA
	 Pjd3wu8/Erj9tW6XOkr3ZGbRcNKaqXqG5LxfliKI=
Subject: FAILED: patch "[PATCH] igc: Fix qbv tx latency by setting gtxoffset" failed to apply to 6.1-stable tree
To: faizal.abdul.rahim@linux.intel.com,anthony.l.nguyen@intel.com,horms@kernel.org,morx.bar.gabay@intel.com,vinicius.gomes@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Aug 2024 09:28:41 +0200
Message-ID: <2024082740-citadel-facelift-bc00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6c3fc0b1c3d073bd6fc3bf43dbd0e64240537464
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024082740-citadel-facelift-bc00@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6c3fc0b1c3d0 ("igc: Fix qbv tx latency by setting gtxoffset")
790835fcc0cb ("igc: Correct the launchtime offset")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6c3fc0b1c3d073bd6fc3bf43dbd0e64240537464 Mon Sep 17 00:00:00 2001
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Date: Sun, 7 Jul 2024 08:53:18 -0400
Subject: [PATCH] igc: Fix qbv tx latency by setting gtxoffset

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
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index ada751430517..d68fa7f3d5f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -61,7 +61,7 @@ void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter)
 	struct igc_hw *hw = &adapter->hw;
 	u16 txoffset;
 
-	if (!is_any_launchtime(adapter))
+	if (!igc_tsn_is_tx_mode_in_tsn(adapter))
 		return;
 
 	switch (adapter->link_speed) {


