Return-Path: <stable+bounces-180862-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC562B8EA00
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 02:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F131898C58
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 00:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0140472606;
	Mon, 22 Sep 2025 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSeuK8nr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296D3C33
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758501716; cv=none; b=PuBYLpA7bT/L4Dq8WuaZiaXp+lrWCBNn6P58ergZ2zvTcWAlG0UJhDMJc5Q8aH1+t1R/xf/xmliHYDRol+Bpwg6EEnOReZ/qA86V6TBDNDjwya+LHBAqHuAWNmZpsc1zoshjBU7QsxWoctWQOEmLkzGLp1M2KlnMmVZmeceawW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758501716; c=relaxed/simple;
	bh=gbzJjwRxduYiuBB85DDR4H9EATKd/Y8KyqCSNoKB5Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBr5TTU5UlZuIS0zE8KL+kVmvYkPFW70C+XWsKEals/hMuW6uJoW9ir5AnwlkY1CwO6U5Q0eDZIOx60AagaGNNuLqZ6KMg4Qr0xislog+EVQ+CNHlSlhJ5Ry+113yDvwzT8esSwSCtiFgs2NoQmd1/MoKL7zDRAhkcc6ON8I5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSeuK8nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EDAC4CEF7;
	Mon, 22 Sep 2025 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758501716;
	bh=gbzJjwRxduYiuBB85DDR4H9EATKd/Y8KyqCSNoKB5Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LSeuK8nr8Xmu3j59LAVawHd9rDrJ5DAZgM/rzr/5YMQdw9orECv/0xr2g//QTgOgE
	 SZGHMHdDgFgztBXiTXk+a+ll1xk1ryDcGkygXIEXZp9QiB8lb4ePDlCHlBxoAKsvFd
	 jcZ+/l0SZ2I6FRkQTBLpAAjyWay5eKguWPDah8yDap2E972lC78ZXeQVEKju9Bb9Hj
	 v7aHuipLRsnhjYlPIZcdF4rw2UMvPSyda9XYLIeCi7QSo7ACe3dcLtaYM7wOH0L75C
	 M+Z34yjb8i4ZKdllPwKwKP5JDstFqgJe6S17NbmOCubCumgAdxpfmOliI8q4qYG+JA
	 RyPJhvyma0viw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
	Rahul Chandra <rahul@chandra.net>,
	stable@kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16.y 2/2] platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk
Date: Sun, 21 Sep 2025 20:41:53 -0400
Message-ID: <20250922004153.3106044-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922004153.3106044-1-sashal@kernel.org>
References: <2025092125-thigh-immerse-6abd@gregkh>
 <20250922004153.3106044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Antheas Kapenekakis <lkml@antheas.dev>

[ Upstream commit 225d1ee0f5ba3218d1814d36564fdb5f37b50474 ]

It turns out that the dual screen models use 0x5E for attaching and
detaching the keyboard instead of 0x5F. So, re-add the codes by
reverting commit cf3940ac737d ("platform/x86: asus-wmi: Remove extra
keys from ignore_key_wlan quirk"). For our future reference, add a
comment next to 0x5E indicating that it is used for that purpose.

Fixes: cf3940ac737d ("platform/x86: asus-wmi: Remove extra keys from ignore_key_wlan quirk")
Reported-by: Rahul Chandra <rahul@chandra.net>
Closes: https://lore.kernel.org/all/10020-68c90c80-d-4ac6c580@106290038/
Cc: stable@kernel.org
Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
Link: https://patch.msgid.link/20250916072818.196462-1-lkml@antheas.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 6928bb6ae0f3c..ce177c3799414 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -670,6 +670,8 @@ static void asus_nb_wmi_key_filter(struct asus_wmi_driver *asus_wmi, int *code,
 		if (atkbd_reports_vol_keys)
 			*code = ASUS_WMI_KEY_IGNORE;
 		break;
+	case 0x5D: /* Wireless console Toggle */
+	case 0x5E: /* Wireless console Enable / Keyboard Attach, Detach */
 	case 0x5F: /* Wireless console Disable / Special Key */
 		if (quirks->key_wlan_event)
 			*code = quirks->key_wlan_event;
-- 
2.51.0


