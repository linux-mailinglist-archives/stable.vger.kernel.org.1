Return-Path: <stable+bounces-198530-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53627CA09D6
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AD6031A40F9
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB4F3191CF;
	Wed,  3 Dec 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WDg5tgub"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA83191AF;
	Wed,  3 Dec 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776850; cv=none; b=MlRIRZu94I3K0ms+aSeWFx5A8B9fnBHZK0a7fSj3AEA2UkRBBjFEnqu5X5itefrkB5S/LHWhvTNKLmTrEE/a5bbMCwGCODKz33VHgWq5KbKaAoJTrQHDW75Pb9Az2N4FeEkdGQx6pLUwje5WKupiYXx5htzLPRzdN5ubn5CLXy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776850; c=relaxed/simple;
	bh=8klkRzoYz7QFet1vfuOsz2Cp8RqGWpko9uHHfM8wOHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H12FfYDYJanINv477MRWe6oMAhoAFH9nMApgzHUcsOTc5bRTuquyGitmVjb+gHS8oNfqvkhV6cRQNMPj40k4ay16XsnQz0JGJYdZtOIDyitXgb4yj1gNiAUA2eJ+cat0czI7zh7/JYtaiHDlUugkIGpM5ljZGkZnrTIKfqhoPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WDg5tgub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B941C4CEF5;
	Wed,  3 Dec 2025 15:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776850;
	bh=8klkRzoYz7QFet1vfuOsz2Cp8RqGWpko9uHHfM8wOHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDg5tgubNpcSzHNWrP8Ddqz6EaNDEba8D/F0eNKUbQFyJW6cb6YwnJawYX6kykFGS
	 SaEiZybXv7XyaWZz60AA1c8rau5t4MxI1Nc5ip43AU8BJH7iOELnzNux7CJInndGLx
	 I7m+7udQ6iEjPCh6LpZtNSdkTiUQe3u6scO5UYOU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tianchu Chen <flynnnchen@tencent.com>,
	stable <stable@kernel.org>
Subject: [PATCH 5.10 282/300] usb: storage: sddr55: Reject out-of-bound new_pba
Date: Wed,  3 Dec 2025 16:28:06 +0100
Message-ID: <20251203152411.073103147@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tianchu Chen <flynnnchen@tencent.com>

commit b59d4fda7e7d0aff1043a7f742487cb829f5aac1 upstream.

Discovered by Atuin - Automated Vulnerability Discovery Engine.

new_pba comes from the status packet returned after each write.
A bogus device could report values beyond the block count derived
from info->capacity, letting the driver walk off the end of
pba_to_lba[] and corrupt heap memory.

Reject PBAs that exceed the computed block count and fail the
transfer so we avoid touching out-of-range mapping entries.

Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/B2DC73A3EE1E3A1D+202511161322001664687@tencent.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/sddr55.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -469,6 +469,12 @@ static int sddr55_write_data(struct us_d
 		new_pba = (status[3] + (status[4] << 8) + (status[5] << 16))
 						  >> info->blockshift;
 
+		/* check if device-reported new_pba is out of range */
+		if (new_pba >= (info->capacity >> (info->blockshift + info->pageshift))) {
+			result = USB_STOR_TRANSPORT_FAILED;
+			goto leave;
+		}
+
 		/* check status for error */
 		if (status[0] == 0xff && status[1] == 0x4) {
 			info->pba_to_lba[new_pba] = BAD_BLOCK;



