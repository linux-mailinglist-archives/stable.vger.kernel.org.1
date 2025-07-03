Return-Path: <stable+bounces-160068-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF64AF7C28
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5A66E496F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268C7EEBA;
	Thu,  3 Jul 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hewYhM+r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D808F2DE6F1;
	Thu,  3 Jul 2025 15:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556266; cv=none; b=IgRvnV7sFvBiGo9QVHI16iPMPKKYu5wQoR5eNpzL1yGIJ09X/PrG1Ihz6MajAzrCCHWyyB1fJDKnAmwqFsF6xKQt6TClrTcWnOZiGygcxWkti6DqlzyKdnl86lt2CscM8tRUJg9YWeOTPu9nyxD+atDoH2jIFoa43a32TGqFnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556266; c=relaxed/simple;
	bh=K84xhwxNX1nXPEqpCGCPE9JBRtfvuPTT+My+JN6IGoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sb6v2BCYVp0ytxChppmu2ByBef/3yImIipWzsr5mxjOFDLqcMkhvpVNkZzcblsyCsgzPFecmw6Pql3vhxhklAGRyHpPaJv37SN4T0aNPoaR8Li5MVpMRZjlowrtjdG4OcGU17Tatv9yuKDK7tJ7SUZDSJqZ/mgu6u/Y6YhvQhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hewYhM+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7A2C4CEE3;
	Thu,  3 Jul 2025 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556266;
	bh=K84xhwxNX1nXPEqpCGCPE9JBRtfvuPTT+My+JN6IGoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hewYhM+raJ6dgBQimwAEFFw4W7J2za91C7Ffshrh35bCU/UtHXCnuUL1Squ86gfP2
	 2spEjSdhcoruUw0s6522ifR4cnat0mZzJsCL7cFxi3zfYw/20ZLGW6R5nb/eV2lVhN
	 PDmPSAs4RkFBy6VZTuzo+yQYcyFY9rVEthZBxP9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Iusico Maxim <iusico.maxim@libero.it>,
	Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.1 097/132] HID: lenovo: Restrict F7/9/11 mode to compact keyboards only
Date: Thu,  3 Jul 2025 16:43:06 +0200
Message-ID: <20250703143943.208184911@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Iusico Maxim <iusico.maxim@libero.it>

commit 9327e3ee5b077c4ab4495a09b67624f670ed88b6 upstream.

Commit 2f2bd7cbd1d1 ("hid: lenovo: Resend all settings on reset_resume
for compact keyboards") introduced a regression for ThinkPad TrackPoint
Keyboard II by removing the conditional check for enabling F7/9/11 mode
needed for compact keyboards only. As a result, the non-compact
keyboards can no longer toggle Fn-lock via Fn+Esc, although it can be
controlled via sysfs knob that directly sends raw commands.

This patch restores the previous conditional check without any
additions.

Cc: stable@vger.kernel.org
Fixes: 2f2bd7cbd1d1 ("hid: lenovo: Resend all settings on reset_resume for compact keyboards")
Signed-off-by: Iusico Maxim <iusico.maxim@libero.it>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-lenovo.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -529,11 +529,14 @@ static void lenovo_features_set_cptkbd(s
 
 	/*
 	 * Tell the keyboard a driver understands it, and turn F7, F9, F11 into
-	 * regular keys
+	 * regular keys (Compact only)
 	 */
-	ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
-	if (ret)
-		hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
+	if (hdev->product == USB_DEVICE_ID_LENOVO_CUSBKBD ||
+	    hdev->product == USB_DEVICE_ID_LENOVO_CBTKBD) {
+		ret = lenovo_send_cmd_cptkbd(hdev, 0x01, 0x03);
+		if (ret)
+			hid_warn(hdev, "Failed to switch F7/9/11 mode: %d\n", ret);
+	}
 
 	/* Switch middle button to native mode */
 	ret = lenovo_send_cmd_cptkbd(hdev, 0x09, 0x01);



