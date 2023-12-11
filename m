Return-Path: <stable+bounces-5495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9992980CE11
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEF9BB217DF
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2875487B3;
	Mon, 11 Dec 2023 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDjdil+9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ibuq7a5A"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC683247;
	Mon, 11 Dec 2023 06:16:09 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702304168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppjU+31LnK9VxtavD2GvL4JVjKrjbiZoU7R+ROKBQw0=;
	b=hDjdil+9JU5/ytG0e6pkeyZEi9edP1ZWxu1wXzWH9ftXHULdjTHR1m6Pidh/DpgHOJYozI
	XhD5eCdVGfxOBwp5i25Vvxwn+ipA0o2iZpmzoKMuDTtBdWZr/bdKalDhIRgo39NV6DCNWk
	oCdvQR4T06kV0c8sEJnSmaRiiN8Pq4Rdro2hV3WDV4IP1SXNIXAp+RLXJZ7dl+hMU1T3LS
	+yVnBMcUdWUrFNwsneDvxu9wkG9fdvJYPkmcl13RMSIqKFIDtAuXU84mTO5hfCpzUCkcId
	eJLJRXkgv94QnTJJQdLce7L+H+N0r6hlJHcC6IhDwDfVyMdp+8x+cBUlXJPx8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702304168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ppjU+31LnK9VxtavD2GvL4JVjKrjbiZoU7R+ROKBQw0=;
	b=ibuq7a5Az7Pjp0C516ChSpwDNo8VYpdGUiMuwu2e4BF0j1aNiiNTNq3aHUS31bE6P+aI6D
	IgAuM+cNwzYVydDA==
To: stable@vger.kernel.org
Cc: jiajie.ho@starfivetech.com,
	palmer@rivosinc.com,
	conor.dooley@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v6.1] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Date: Mon, 11 Dec 2023 15:15:55 +0100
Message-Id: <20231211141555.89648-1-namcao@linutronix.de>
In-Reply-To: <20231211145750.7bc2d378@namcao>
References: <20231211145750.7bc2d378@namcao>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jia Jie Ho <jiajie.ho@starfivetech.com>

[ Upstream commit 78a03b9f8e6b317f7c65738a3fc60e1e85106a64 ]

Selects ARM_AMBA platform support for StarFive SoCs required by spi and
crypto dma engine.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
[ resolve conflict due to removal of "select SIFIVE_PLIC" ]
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/Kconfig.socs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 69774bb362d6..29d78eefc889 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -23,6 +23,7 @@ config SOC_STARFIVE
 	select PINCTRL
 	select RESET_CONTROLLER
 	select SIFIVE_PLIC
+	select ARM_AMBA
 	help
 	  This enables support for StarFive SoC platform hardware.
=20
--=20
2.39.2


