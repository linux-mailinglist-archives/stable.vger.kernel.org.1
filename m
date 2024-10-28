Return-Path: <stable+bounces-89005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2329B2D9F
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 11:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0309281826
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEB51DE4DB;
	Mon, 28 Oct 2024 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSI2u8U0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B81DE4D2;
	Mon, 28 Oct 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112711; cv=none; b=dQxthd1/8bwQ3Rhokj+Hmxk7ClBoeWXTr1K0P2CtY8Q/3slkz6s04eKRWAQEKbvMjJoChWwCSMtxolCJpP03SgsLPgICA8iP6Fi9GqWleILmGjXwlTHKDwAylpOChxXTxjaFbl2smowZQbP0IJq3QC5zgQtDtnXK4a8Zyx9wki0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112711; c=relaxed/simple;
	bh=+eeFzBLeWQ/yCXaN53gII6lkCRzdT0pvSPCz8xFZY1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ARkUFYYCyASdkgNN3wMd4IBnOEEOXFYoi8G/6cWaebRWJ2FdPcFS8pKrQCNMcn/cXvC0ryZVEmLs7G/GE5oMqLSOmZ2fPaW+JIavUON+ayRilitpE03m8gs+MlnUcwYpGNgqzKmcPawyVPTIBAWAqI149NtpbSYMp44vgfjZMPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSI2u8U0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9F8C4CEE8;
	Mon, 28 Oct 2024 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730112710;
	bh=+eeFzBLeWQ/yCXaN53gII6lkCRzdT0pvSPCz8xFZY1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSI2u8U05vpMmOmdBzrOsdLqLj0UcrIkNlEbZfrpfiIiB+IErHo51wE3UZ8kDy9zX
	 doP5tKpoES6yHHC2o2B4Mn/H8j+bJWFtnvIiyDLG81UOcO9dRKNbtLrR0ATSzJPOIR
	 QOzfTi3OLFjD9kL3GbKcTsa3d0KOXirnXquGzK5H30UJ4ZV4QNfisGAUdICVOIsNZo
	 pafWFHkHkehUMPoLzyhfvQNmZpTi/mrn+nYcyfvCNG+H72JJnZVwbQ4ekMLAnEDl4f
	 YuioWBA9HfoQHciB5drBjPkj1JTyUeo4TVAnToL2nO/F/PQnywFMu229TXQ80W+KYr
	 XkMbHd7C76MpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	siddharth.manthan@gmail.com,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	mjg59@srcf.ucam.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 23/32] platform/x86: dell-wmi: Ignore suspend notifications
Date: Mon, 28 Oct 2024 06:50:05 -0400
Message-ID: <20241028105050.3559169-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028105050.3559169-1-sashal@kernel.org>
References: <20241028105050.3559169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit a7990957fa53326fe9b47f0349373ed99bb69aaa ]

Some machines like the Dell G15 5155 emit WMI events when
suspending/resuming. Ignore those WMI events.

Tested-by: siddharth.manthan@gmail.com
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Acked-by: Pali Rohár <pali@kernel.org>
Link: https://lore.kernel.org/r/20241014220529.397390-1-W_Armin@gmx.de
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/dell/dell-wmi-base.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platform/x86/dell/dell-wmi-base.c
index 502783a7adb11..24fd7ffadda95 100644
--- a/drivers/platform/x86/dell/dell-wmi-base.c
+++ b/drivers/platform/x86/dell/dell-wmi-base.c
@@ -264,6 +264,15 @@ static const struct key_entry dell_wmi_keymap_type_0010[] = {
 	/*Speaker Mute*/
 	{ KE_KEY, 0x109, { KEY_MUTE} },
 
+	/* S2Idle screen off */
+	{ KE_IGNORE, 0x120, { KEY_RESERVED }},
+
+	/* Leaving S4 or S2Idle suspend */
+	{ KE_IGNORE, 0x130, { KEY_RESERVED }},
+
+	/* Entering S2Idle suspend */
+	{ KE_IGNORE, 0x140, { KEY_RESERVED }},
+
 	/* Mic mute */
 	{ KE_KEY, 0x150, { KEY_MICMUTE } },
 
-- 
2.43.0


