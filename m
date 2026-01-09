Return-Path: <stable+bounces-206544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2B4D09080
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 12:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 762C33009D52
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4FB358D22;
	Fri,  9 Jan 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DXLXycT9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AC633C511;
	Fri,  9 Jan 2026 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767959508; cv=none; b=aGzCmPo1wgoT5lDWJ21JdeehiLSs8Hr2esPe96JD6fN6LsO9iqZ+Jz2CSzYFRHywX4UkWaMPU8kL0maYbkvOqOUrQ7s3zADGf2Sa2VB0ztN4oFj2dbBRFQdJMZJpVF5fUf1ftaFXx9iAjxjDzn0qEroqnrrq057T3KRFlQ8vsfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767959508; c=relaxed/simple;
	bh=l/vAl3eKjxP5y0GOiS4ymcCKHpGAVOwZYmP+svZaMQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGYo9CnGsz7N96xwAwLIFhBG4o/gBIkX7trVlfF8TXoHQ2vjah8Y4jCZz/RNZ6gLe4baVSMre5Rr2v2s0r8oQSLZN4q3JhUG3PHMRL8uQkBcRqcqZkFjMubv50ANT2rBJBsnTrsOn7xduaS9UqhARarFNQD+1SXGKqvS+jv+VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DXLXycT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23AEC4CEF1;
	Fri,  9 Jan 2026 11:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767959508;
	bh=l/vAl3eKjxP5y0GOiS4ymcCKHpGAVOwZYmP+svZaMQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DXLXycT9ufQlWWYYQNe7BN8ldM93i6fZUK7SzR/GfVt8wrbPHI9gqE5oT2KoSe2yU
	 jSfEyHqj3Gs4pQkaxZXE9uYgSuWp0WmQRdbH0ZxAePXfTTTCzLw0w6FTvE+T86EHsu
	 b39XGO9MEwZoD7qBo/SepZ+JwbWuzy5BpRwNXGks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ston Jia <ston.jia@outlook.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 034/737] platform/x86: huawei-wmi: add keys for HONOR models
Date: Fri,  9 Jan 2026 12:32:53 +0100
Message-ID: <20260109112135.279959446@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112133.973195406@linuxfoundation.org>
References: <20260109112133.973195406@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Jia Ston <ston.jia@outlook.com>

[ Upstream commit 5c72329716d0858621021193330594d5d26bf44d ]

HONOR MagicBook X16/X14 models produced in 2025 cannot use the Print
Screen and YOYO keys properly, with the system reporting them as
unknown key presses (codes: 0x028b and 0x028e).

To resolve this, a key_entry is added for both the HONOR Print Screen
key and the HONOR YOYO key, ensuring they function correctly on these
models.

Signed-off-by: Ston Jia <ston.jia@outlook.com>
Link: https://patch.msgid.link/20251029051804.220111-1-ston.jia@outlook.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/huawei-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 0ef1c46b617b6..29ef391d33052 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -81,6 +81,10 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_KEY,    0x289, { KEY_WLAN } },
 	// Huawei |M| key
 	{ KE_KEY,    0x28a, { KEY_CONFIG } },
+	// HONOR YOYO key
+	{ KE_KEY,    0x28b, { KEY_NOTIFICATION_CENTER } },
+	// HONOR print screen
+	{ KE_KEY,    0x28e, { KEY_PRINT } },
 	// Keyboard backlit
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
-- 
2.51.0




