Return-Path: <stable+bounces-92445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0819C5426
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DABB36FEC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA42144BB;
	Tue, 12 Nov 2024 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iR6u2DA/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBD2144B3;
	Tue, 12 Nov 2024 10:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407681; cv=none; b=cFZ4Tj3lQlTji4MProWk12l8ldqgyY4MxnR3dQJgbxEtCTBQIwD3xbnLS3pP4WY4T+X02iJelHjYusB/UMYWozPbVtyTtw/LuzwY7W8d0A6fpwRrhwlsSgiVRiX8JhBNfXN2uxTY8U6MAbrqFcOI9LMsEXK8kl3/SuqSSS/Fo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407681; c=relaxed/simple;
	bh=4CgQHFSO7PILVa7WI277YHzBBnKSDybjHCWMep9iAOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxUA4DrCqDVABLUkE9nu0TaLyAd6wRw7DkZwaGxJCo55oIYVjALXXwrg7Id9/jXv2xapvxu6m0ZT+WLz/8cyWsus7hhNj5rPrmrT00SIvMYUPyvydg/zes1DgaHPGdkSCaWPgIbNvQsbZUlP3g8ohRw3u4hZhGp3lsA9HoES1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iR6u2DA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23902C4CED4;
	Tue, 12 Nov 2024 10:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731407681;
	bh=4CgQHFSO7PILVa7WI277YHzBBnKSDybjHCWMep9iAOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iR6u2DA/mwKHlhWOGYVEdGOtVWLsAGT63mrtmf0EMNVpaDrvZ5POiEs1YQ7ZqKvIx
	 RMnWQBHmVOU65aKHxt/6IrTUgf9BZcorxcJlU7AQPD9CDgoFWpL5j74KljVYELkD9i
	 yf4xmoj5Jn9aEApo04g77ZvtLVTfE+CjQE4T8l6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jaros=C5=82aw=20Janik?= <jaroslaw.janik@gmail.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.6 050/119] Revert "ALSA: hda/conexant: Mute speakers at suspend / shutdown"
Date: Tue, 12 Nov 2024 11:20:58 +0100
Message-ID: <20241112101850.629945198@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101848.708153352@linuxfoundation.org>
References: <20241112101848.708153352@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jarosław Janik <jaroslaw.janik@gmail.com>

commit c9363bbb0f68dd1ddb8be7bbfe958cdfcd38d851 upstream.

Commit 4f61c8fe3520 ("ALSA: hda/conexant: Mute speakers at suspend /
shutdown") mutes speakers on system shutdown or whenever HDA controller
is suspended by PM; this however interacts badly with Thinkpad's ACPI
firmware behavior which uses beeps to signal various events (enter/leave
suspend or hibernation, AC power connect/disconnect, low battery, etc.);
now those beeps are either muted altogether (for suspend/hibernate/
shutdown related events) or work more or less randomly (eg. AC
plug/unplug is only audible when you are playing music at the moment,
because HDA device is likely in suspend mode otherwise).

Since the original bug report mentioned in 4f61c8fe3520 complained about
Lenovo's Thinkpad laptop - revert this commit altogether.

Fixes: 4f61c8fe3520 ("ALSA: hda/conexant: Mute speakers at suspend / shutdown")
Signed-off-by: Jarosław Janik <jaroslaw.janik@gmail.com>
Link: https://patch.msgid.link/20241030171813.18941-2-jaroslaw.janik@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_conexant.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -205,8 +205,6 @@ static void cx_auto_shutdown(struct hda_
 {
 	struct conexant_spec *spec = codec->spec;
 
-	snd_hda_gen_shutup_speakers(codec);
-
 	/* Turn the problematic codec into D3 to avoid spurious noises
 	   from the internal speaker during (and after) reboot */
 	cx_auto_turn_eapd(codec, spec->num_eapds, spec->eapds, false);



