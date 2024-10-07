Return-Path: <stable+bounces-81412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DB993431
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3224B1C23279
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836051DD55B;
	Mon,  7 Oct 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dR/jGFMZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD91DD558
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320213; cv=none; b=Nb7YHn8ylpOH59FPYMoOAPXiTZUuokmi1hG4UKJ+myIJ19x0L5Mnn1NEh7lGVHr3R8AbHa/4bRr5Vdp6402JeirotJTFNmh2xxhoxAsqjHQfMF/kWfxnBbGcX6wYhzs0z98ySiwJnlv8YC3M8YYNiTpcnARDihn+Wh1/oQdmVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320213; c=relaxed/simple;
	bh=PZsg9hVhWEnrf0BOl29Tf4hzEXEg1RVZWbFG+JM+UKs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nD3EzoGCNW/vkVW5M/CHdGy6xmaUrvOf8WyiXEgZxgEQPEBZ7ufUoltsNUq9jVqnRvKahGRw5a3YFx2G7yM+QQYRzeEswSyPuOVKB4NABDJ+pd9IspKXhV7CHltyDlrKd9WNSSp7Pzp+WkKdqvtwhWY0YJpyMfZkZ0Kykn5mruk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dR/jGFMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A847CC4CEC6;
	Mon,  7 Oct 2024 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728320213;
	bh=PZsg9hVhWEnrf0BOl29Tf4hzEXEg1RVZWbFG+JM+UKs=;
	h=Subject:To:Cc:From:Date:From;
	b=dR/jGFMZiki98aIizfSPYZ71Hg39GULbOXEbpzi1AY9HFB+gkLcMEgnU29+mwGLJP
	 8TlXV035GgehNmT61I5NGM9RxGP0nt12VdcqPlJjqP/M2sl3X7kDkSzACaHeK4uxHr
	 KE7+JEe7Ek1z7SVM9Y5n555UuWxEzk/nthNuvZmg=
Subject: FAILED: patch "[PATCH] r8169: add tally counter fields added with RTL8125" failed to apply to 5.10-stable tree
To: hkallweit1@gmail.com,horms@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:56:36 +0200
Message-ID: <2024100736-chlorine-elusive-e80f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ced8e8b8f40accfcce4a2bbd8b150aa76d5eff9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100736-chlorine-elusive-e80f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


