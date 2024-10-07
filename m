Return-Path: <stable+bounces-81413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0282F993432
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B395D283979
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971DF1DD861;
	Mon,  7 Oct 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="phxrqBiE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D7F1DD55C
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320221; cv=none; b=i7hzQ3pZ3OPMfdZnWHXysDV0YhxFobCs21R+pVXDqqZEj+fumhMMVP/IfjZyzNg9TxAe3sNQmghItJDVHR09vqJek8BJeCMr+Hqt5fA/vZ6MsH3DXRQ+y2/rMVrmefVOb6zR/S1rCgaaMpYHneju3VH2gtjJeXfEbCrCXDChgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320221; c=relaxed/simple;
	bh=KEGNSGh850MYZMS86a36wB9p7aKRunigUvynTy1HtxQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u6TUKBMpKs0oRTK8EhM5Ae+XPfOunTdShIq74eWmTynHdAJ/ZLm+yYFJ8ggVtudAHWhWN3kw9GP5Ic/sWKxzzoL2eKmbKGbaw3C+vCjPiDdADKuZuYAIZU43RZT9yvtpYei1+Ax1vc7N6h5i1BbUByuc/1AG3BLxnKnFlSbLUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=phxrqBiE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EB0C4CEC6;
	Mon,  7 Oct 2024 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320220;
	bh=KEGNSGh850MYZMS86a36wB9p7aKRunigUvynTy1HtxQ=;
	h=Subject:To:Cc:From:Date:From;
	b=phxrqBiESKwOEQc+9ejC72z10xtpxaN01qt68RneDimgYEyV6Bi3T3lXUIL+u+Xmd
	 1Bk/NcRIJ0CPaRHplPWIs1xC2r69SZab7uZ25qRY/3b/2MML5/PGMw5qNH8PsQURBD
	 HSJ4hkABnQzqfJ3KR1O8rzN/jwLtdBgTHzBBinWY=
Subject: FAILED: patch "[PATCH] r8169: add tally counter fields added with RTL8125" failed to apply to 5.4-stable tree
To: hkallweit1@gmail.com,horms@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:56:37 +0200
Message-ID: <2024100736-poise-woozy-3dc7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x ced8e8b8f40accfcce4a2bbd8b150aa76d5eff9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100736-poise-woozy-3dc7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

ced8e8b8f40a ("r8169: add tally counter fields added with RTL8125")
8df9439389a4 ("r8169: Fix spelling mistake: "tx_underun" -> "tx_underrun"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ced8e8b8f40accfcce4a2bbd8b150aa76d5eff9a Mon Sep 17 00:00:00 2001
From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 17 Sep 2024 23:04:46 +0200
Subject: [PATCH] r8169: add tally counter fields added with RTL8125

RTL8125 added fields to the tally counter, what may result in the chip
dma'ing these new fields to unallocated memory. Therefore make sure
that the allocated memory area is big enough to hold all of the
tally counter values, even if we use only parts of it.

Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/741d26a9-2b2b-485d-91d9-ecb302e345b5@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 45ac8befba29..3ddba7aa4914 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -579,6 +579,33 @@ struct rtl8169_counters {
 	__le32	rx_multicast;
 	__le16	tx_aborted;
 	__le16	tx_underrun;
+	/* new since RTL8125 */
+	__le64 tx_octets;
+	__le64 rx_octets;
+	__le64 rx_multicast64;
+	__le64 tx_unicast64;
+	__le64 tx_broadcast64;
+	__le64 tx_multicast64;
+	__le32 tx_pause_on;
+	__le32 tx_pause_off;
+	__le32 tx_pause_all;
+	__le32 tx_deferred;
+	__le32 tx_late_collision;
+	__le32 tx_all_collision;
+	__le32 tx_aborted32;
+	__le32 align_errors32;
+	__le32 rx_frame_too_long;
+	__le32 rx_runt;
+	__le32 rx_pause_on;
+	__le32 rx_pause_off;
+	__le32 rx_pause_all;
+	__le32 rx_unknown_opcode;
+	__le32 rx_mac_error;
+	__le32 tx_underrun32;
+	__le32 rx_mac_missed;
+	__le32 rx_tcam_dropped;
+	__le32 tdu;
+	__le32 rdu;
 };
 
 struct rtl8169_tc_offsets {


