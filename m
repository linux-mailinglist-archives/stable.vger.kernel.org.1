Return-Path: <stable+bounces-178759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79ACB47FF4
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B73A200B63
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6714521ADAE;
	Sun,  7 Sep 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Su1v0bYe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F104315A;
	Sun,  7 Sep 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277868; cv=none; b=jn2xnjHba8iU9W+y+UFsJ2bIejR3X9Kyg8sl9e554rDIaeWhTTUebi0ac9vmv32wwBx6dig0AsyCesj8PUQXBY1B8BQ3LkOijUcfUvRvdnUGx3mrki+BLqf5TiZTWg2lzvaUEZmSWnm1JXZql/K7cTttp9jHi4hXG8YUUYpp/2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277868; c=relaxed/simple;
	bh=a6pCsLg4SRKde7Eb0ZCHxzl+Y+p0auxDONoM+psttE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpZMPGNIUuWIPl4R47vX2rDaM8+UcFV76tSkZ3krvFCh+NkVOGeVkqehiaazg6pTE8kJd8WhdNRcSnSaLyyp9Uh94w3QN7O3IzHgLeKtX+j/Gnp4/yc47NW8IZ/SkMj3UjXYLZGfhJrvJ0DqBPiwZptD6jt/jlNDCRarhg8tx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Su1v0bYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EBBC4CEF0;
	Sun,  7 Sep 2025 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277867;
	bh=a6pCsLg4SRKde7Eb0ZCHxzl+Y+p0auxDONoM+psttE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Su1v0bYekBvspg2Z/bt6Zpxj1MOnzGe+ENWGj+5AwQhmUbWj19J3TxxycihBdavkc
	 QG1s3BgMJ657ObyJ5iUAI7lZ3rbAe232mF7pLZUx74QfOy9g6JNWBkuYsbdoxCQ/rh
	 V+z5vmQrdXb1oHwXNG8y6ewGA0IdifYQru/Qjv/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gergo Koteles <soyer@irl.hu>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.16 147/183] ALSA: hda: tas2781: reorder tas2563 calibration variables
Date: Sun,  7 Sep 2025 21:59:34 +0200
Message-ID: <20250907195619.303266430@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
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

From: Gergo Koteles <soyer@irl.hu>

commit d5f8458e34a331e5b228de142145e62ac5bfda34 upstream.

The tasdev_load_calibrated_data() function expects the calibration data
values in the cali_data buffer as R0, R0Low, InvR0, Power, TLim which
is not the same as what tas2563_save_calibration() writes to the buffer.

Reorder the EFI variables in the tas2563_save_calibration() function
to put the values in the buffer in the correct order.

Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gergo Koteles <soyer@irl.hu>
Link: https://patch.msgid.link/20250829160450.66623-2-soyer@irl.hu
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/tas2781_hda_i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -282,7 +282,7 @@ static int tas2563_save_calibration(stru
 {
 	efi_guid_t efi_guid = tasdev_fct_efi_guid[LENOVO];
 	char *vars[TASDEV_CALIB_N] = {
-		"R0_%d", "InvR0_%d", "R0_Low_%d", "Power_%d", "TLim_%d"
+		"R0_%d", "R0_Low_%d", "InvR0_%d", "Power_%d", "TLim_%d"
 	};
 	efi_char16_t efi_name[TAS2563_CAL_VAR_NAME_MAX];
 	unsigned long max_size = TAS2563_CAL_DATA_SIZE;



