Return-Path: <stable+bounces-77203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB25A985A18
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 292EAB21E4B
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F231B2EEA;
	Wed, 25 Sep 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmvVDaYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD611B2EDD;
	Wed, 25 Sep 2024 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264503; cv=none; b=cLFmqzuin+8rPAqpkp/JWlSEdtY+Yz9KedYhnmqbj6g0OEbkYtF4RVukkhMlgQ2N1ySOHihSgHTz+N5UVb3CAlRWsxyJ1AGEiqEKUYYWw0NkAxC5Z4LzM8yy+2qwvwKkv3trF8/o5WH7f7C+VOjPby01S105+Z0dlUBVKePNjvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264503; c=relaxed/simple;
	bh=4kStu5cFgDRLN5FvWQV8v4gaCJQ4kcCDjuaA2FKp+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnT8yDd0EjKo9PYnxSs1M97wjM+MHvP5h/FIfJAAfo1sQxAMQejytCMVMgt1RADBzANhAff9lbQjM0toM2YaSmdjDfM46cwrSV3mueycrW3ddUe4OqgoFI0x7O1hIeRXQkV19P1UX3r/BnmwoAUBKjhlWWmfVR5kYDPrDyKy6Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmvVDaYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF92C4CEC7;
	Wed, 25 Sep 2024 11:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264503;
	bh=4kStu5cFgDRLN5FvWQV8v4gaCJQ4kcCDjuaA2FKp+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmvVDaYCuy6h6wTsvloRV3b2GzkmvRPI+A4sVlaaKFRQQoOOTl8yhmDwVSoq/FGmS
	 6ub/95ykxvr+yuNkKMnoJLpu9KQDYjV7ehsaKb4ZVV08qc30Um2euW5alrAJvxKprF
	 VyGO0z+XWAe5FLcDxaKfTRtUDbnZDiAR6EtPVZPXbx/KWmpf0EYPuldGBEalnFXkZU
	 jnLSSPWNv2xKwrBD1P3wUJp6i2zKid3XUOuz2lzWWMYJeGU+d505ZvFwDBm9D52xaG
	 aCL0y7ONCuleMt4+lDv0H7elinyvIPVV1sl8KsNOOh+l8DsR+1cJ3T+xDQGgbEKv3v
	 rmg/6fbE9hgmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 105/244] ALSA: asihpi: Fix potential OOB array access
Date: Wed, 25 Sep 2024 07:25:26 -0400
Message-ID: <20240925113641.1297102-105-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7b986c7430a6bb68d523dac7bfc74cbd5b44ef96 ]

ASIHPI driver stores some values in the static array upon a response
from the driver, and its index depends on the firmware.  We shouldn't
trust it blindly.

This patch adds a sanity check of the array index to fit in the array
size.

Link: https://patch.msgid.link/20240808091454.30846-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/asihpi/hpimsgx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpimsgx.c b/sound/pci/asihpi/hpimsgx.c
index d0caef2994818..b68e6bfbbfbab 100644
--- a/sound/pci/asihpi/hpimsgx.c
+++ b/sound/pci/asihpi/hpimsgx.c
@@ -708,7 +708,7 @@ static u16 HPIMSGX__init(struct hpi_message *phm,
 		phr->error = HPI_ERROR_PROCESSING_MESSAGE;
 		return phr->error;
 	}
-	if (hr.error == 0) {
+	if (hr.error == 0 && hr.u.s.adapter_index < HPI_MAX_ADAPTERS) {
 		/* the adapter was created successfully
 		   save the mapping for future use */
 		hpi_entry_points[hr.u.s.adapter_index] = entry_point_func;
-- 
2.43.0


