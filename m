Return-Path: <stable+bounces-126498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CAA700F3
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3555219A4285
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC926B2CA;
	Tue, 25 Mar 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATg8ov8W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE726E165;
	Tue, 25 Mar 2025 12:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906337; cv=none; b=Kvo2v0N9KSdkDRSPL9PFTKNEgBPAjEzir5SSWwdSL+Nte/W6VVw5uQwhxWcpFXqGlvaS80MqTBq1RsR0UzLv8K5848br5gDB3DUa0G6bW+V5e0eyetGs98tuvQPDEwbDbcNm1WaAH0roxO/2HfDHdnkClAiq91sYoxQgiTwdAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906337; c=relaxed/simple;
	bh=KQkgLtMRTUX0mGs/dleT3uvUi0Pegjavu01fJqOWaT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teZXC4O2KwumNptYXK7tF6ovWN1EAWkywoBaLYcHArIMuPymtEoeGv4qoKaq+15YU95KKezhgTKU8rTWWT7610y02mL3hkRd7BPATPTj2XHAN5Ob5DQCtDmBgShr3B9sa20jBphrZ125BrhakYucpJO+3mCqIw2bmgAaaOSuXSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ATg8ov8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E9DC4CEED;
	Tue, 25 Mar 2025 12:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906336;
	bh=KQkgLtMRTUX0mGs/dleT3uvUi0Pegjavu01fJqOWaT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATg8ov8WMAIPAcqhU6AyH9rcAZBv+/9nJXdMnIQfKvUZ4qjjgPchWnWeTLsSg7dWQ
	 ay/fhPcP9IR7OPePG/jge4BYKYSI/6U0x3LBduSZSoezs2kTqv5Inlo9rCU9Ddnroa
	 6hLOquWu08faLcqYfGzqD1gx3GHDRQds55UBNnF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	E Shattow <e@freeshell.de>,
	Hal Feng <hal.feng@starfivetech.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 6.12 062/116] riscv: dts: starfive: Fix a typo in StarFive JH7110 pin function definitions
Date: Tue, 25 Mar 2025 08:22:29 -0400
Message-ID: <20250325122150.794503965@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: E Shattow <e@freeshell.de>

commit 1b133129ad6b28186214259af3bd5fc651a85509 upstream.

Fix a typo in StarFive JH7110 pin function definitions for GPOUT_SYS_SDIO1_DATA4

Fixes: e22f09e598d12 ("riscv: dts: starfive: Add StarFive JH7110 pin function definitions")
Signed-off-by: E Shattow <e@freeshell.de>
Acked-by: Hal Feng <hal.feng@starfivetech.com>
CC: stable@vger.kernel.org
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/boot/dts/starfive/jh7110-pinfunc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
+++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
@@ -89,7 +89,7 @@
 #define GPOUT_SYS_SDIO1_DATA1			59
 #define GPOUT_SYS_SDIO1_DATA2			60
 #define GPOUT_SYS_SDIO1_DATA3			61
-#define GPOUT_SYS_SDIO1_DATA4			63
+#define GPOUT_SYS_SDIO1_DATA4			62
 #define GPOUT_SYS_SDIO1_DATA5			63
 #define GPOUT_SYS_SDIO1_DATA6			64
 #define GPOUT_SYS_SDIO1_DATA7			65



