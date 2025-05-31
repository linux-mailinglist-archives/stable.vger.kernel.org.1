Return-Path: <stable+bounces-148351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D24AAC9AB4
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 13:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A04B4A262A
	for <lists+stable@lfdr.de>; Sat, 31 May 2025 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDF923BCE7;
	Sat, 31 May 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="coKGkj2E"
X-Original-To: stable@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7523A563;
	Sat, 31 May 2025 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748691560; cv=none; b=HycAevO7XXXDik+le+PdZ9cmj46GI3z38a/XbcXBs/LMSnfwjpOnIFjZC7IHACF3Rd0AXStZIQytzfcZXiBXGOzgPsHkOP6aMZdmLQSkR85KTOeYaX2nnsYOZ2ORFqWm6QyLS5qbXfPVwgqGvPXT477rSU7zRSSvhdi35zW2z6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748691560; c=relaxed/simple;
	bh=erN5D2e7bDlphwtOAn+dkHFnD3yn45/VsLbboj6zrxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKoGeiuOT9/Ay44rg+Ef498uHhUaCXlydPqbXZp4FJNQjeNZP3A0ZBUz8DFVyKF/6v07EOiqEwv/hl6ezU0UE77xAAzAVOd/oq/BcJoIL1WD6ph2z2glYmRD+0ZYHHth54IMNjK/WTAB9JU0CIvVlqI89Eot25Rucz2KZGPaZmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=coKGkj2E; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id C383D25DDA;
	Sat, 31 May 2025 13:39:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d_qvBswCBNzt; Sat, 31 May 2025 13:39:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1748691550; bh=erN5D2e7bDlphwtOAn+dkHFnD3yn45/VsLbboj6zrxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=coKGkj2EGAeXZzXzQthnKgSaBjMzg9y7BE4++nvKXRygjTM46d95x+NEpCDSJybNP
	 eXFrIcFlVCD4d8rOBjWZDgpZRfGW4DK64ixxiszauNvfwklr2cQ120uEFh0QtcIt25
	 EjyKZ9IbZRZ1wJHZ4GXhU4ezg6OkHWn9pmlg0W4nIciDWm81fGhQeGJhkK8kimt4mU
	 HxaU/jUvl9aQkCCHZ/MhdsV8ojzcvDC+v8dN8KxzVzN9aG798humwNhAX1x+iyQ/B4
	 Q2oKPP9OiOWVJjpT1OZi1ObEhZokJ0VvbrHUtQgjT627Q6FOuMWSzVXd5W4VzChK4u
	 SByg+BrwAaiVg==
From: Yao Zi <ziyao@disroot.org>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] platform/loongarch: laptop: Get brightness setting from EC on probe
Date: Sat, 31 May 2025 11:38:50 +0000
Message-ID: <20250531113851.21426-2-ziyao@disroot.org>
In-Reply-To: <20250531113851.21426-1-ziyao@disroot.org>
References: <20250531113851.21426-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously 1 is unconditionally taken as current brightness value. This
causes problems since it's required to restore brightness settings on
resumption, and a value that doesn't match EC's state before suspension
will cause surprising changes of screen brightness.

Let's get brightness from EC and take it as the current brightness on
probe of the laptop driver to avoid the surprising behavior. Tested on
TongFang L860-T2 3A5000 laptop.

Cc: stable@vger.kernel.org
Fixes: 6246ed09111f ("LoongArch: Add ACPI-based generic laptop driver")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/platform/loongarch/loongson-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/loongarch/loongson-laptop.c b/drivers/platform/loongarch/loongson-laptop.c
index 99203584949d..828bd62e3596 100644
--- a/drivers/platform/loongarch/loongson-laptop.c
+++ b/drivers/platform/loongarch/loongson-laptop.c
@@ -392,7 +392,7 @@ static int laptop_backlight_register(void)
 	if (!acpi_evalf(hotkey_handle, &status, "ECLL", "d"))
 		return -EIO;
 
-	props.brightness = 1;
+	props.brightness = ec_get_brightness();
 	props.max_brightness = status;
 	props.type = BACKLIGHT_PLATFORM;
 
-- 
2.49.0


