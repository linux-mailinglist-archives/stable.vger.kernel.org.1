Return-Path: <stable+bounces-201750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0ABCC3B60
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 15:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DD63079281
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197434FF41;
	Tue, 16 Dec 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fUZ2yX88"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35734F49E;
	Tue, 16 Dec 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885665; cv=none; b=ptIZyrRlJZQH3PXKu1/PdHRolbK6lJ9OygCdzvGfpFHHVJz2HEym3p6EZUCpglR5YsBGOgk8BDYgLjudOdeZKrQ4BkyA1Gk94oc0EBwV1EOCaJ2RvoBd9WHehOkPSLjrt+wW8QPXbkv5M0pw/HsH3x/+7WtbLZmuIk7Qh9ZiDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885665; c=relaxed/simple;
	bh=/uJHLEZvK3a5p3fdtai5ekxwF9p3iFa8GZv2Ug9s8ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9WR499zttwcUlmjX9hm8ITljEPpC9kdEcHvtBt8p/jWaheCgXh3yuXMfe3pzh0ziBUpiDoUem1lBzcPpGvJYIPngDyJn+HTPGkyrtFqwxNuHtUe6gvWiVBOT0nQx+h0mnS4NomNFufkQbuLd9n+jiV3XrxDAjZ3wv8UFERdtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fUZ2yX88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B78C4CEF1;
	Tue, 16 Dec 2025 11:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765885665;
	bh=/uJHLEZvK3a5p3fdtai5ekxwF9p3iFa8GZv2Ug9s8ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUZ2yX88R2tEc3YAVfkjZbIOFYJemdfS4SkOB0v55lJ+i3DXi/88EpoKXRzVNyAbK
	 Czw7lEEWbimCFd9XvDvY3K+GGjwecyBEQ7H2n3nJgAtYotHlXX9RvLazBquawsVyv/
	 zlbIShBunsCmwzdKMjwNcFnNFxv2VhjqtXtwnQeo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jihed Chaibi <jihed.chaibi.dev@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 174/507] ARM: dts: omap3: n900: Correct obsolete TWL4030 power compatible
Date: Tue, 16 Dec 2025 12:10:15 +0100
Message-ID: <20251216111351.821583898@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111345.522190956@linuxfoundation.org>
References: <20251216111345.522190956@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

[ Upstream commit 3862123e9b56663c7a3e4a308e6e65bffe44f646 ]

The "ti,twl4030-power-n900" compatible string is obsolete and is not
supported by any in-kernel driver. Currently, the kernel falls back to
the second entry, "ti,twl4030-power-idle-osc-off", to bind a driver to
this node.

Make this fallback explicit by removing the obsolete board-specific
compatible. This preserves the existing functionality while making the
DTS compliant with the new, stricter 'ti,twl.yaml' binding.

Fixes: daebabd578647 ("mfd: twl4030-power: Fix PM idle pin configuration to not conflict with regulators")
Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Link: https://lore.kernel.org/r/20250914192516.164629-4-jihed.chaibi.dev@gmail.com
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ti/omap/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index c50ca572d1b9b..7db73d9bed9e4 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -508,7 +508,7 @@ twl_audio: audio {
 	};
 
 	twl_power: power {
-		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
+		compatible = "ti,twl4030-power-idle-osc-off";
 		ti,use_poweroff;
 	};
 };
-- 
2.51.0




