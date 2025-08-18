Return-Path: <stable+bounces-171347-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6C5B2A95C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC781BA1FBA
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB4332A3D8;
	Mon, 18 Aug 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EWsewurm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF454223337;
	Mon, 18 Aug 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755525618; cv=none; b=gsgCT8StUURyNCP4sXe947+8GxocI3P/f1XgVLkYl1CVwF1Azp0lzxpC692coyPOQz4YTwvS+XFHg7OdZmWPAdriiKqanePA7XBR5w1h+1lZ9+LQLEsRKHsf1RghAsUykMIfxQoY09aUwCrqX89AtiItonDLZPMCCS+SMucVC1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755525618; c=relaxed/simple;
	bh=OV82ttCaOUVeJ538w5Xzr3j3QmefR1tt5Y5Ql7BCJ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbEkfO4kHRjHX/TbedwCvN8LNsLVlLvzAzO8q6aiz0UG58rOS+vPOMJtz+l6Mclpwsj6pTzTkkTpxgZ3CpMbEJYEWKY00n1vs/HTj0bBOKT8aOvOgEnULjswBezvecsgeuIJwSK/563/rDqrIdcxK1FvUw9gonMJ4Zr6SRi3dn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EWsewurm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F01BC4CEEB;
	Mon, 18 Aug 2025 14:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755525617;
	bh=OV82ttCaOUVeJ538w5Xzr3j3QmefR1tt5Y5Ql7BCJ0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EWsewurmEQz7/ql1wVjeihthsyQ9vSRjHSjKO95WUK5WTPIS91UicVwmXUUB5LwwK
	 SaXCf8wgOidjbXMIuh3cjmTdJumT20Dq7GRyl/jogqdp3H/V/oRqJ2XiOJQfSMdvdU
	 8SjFA6drqg9Yu/NHAHEeDV4m6KPYw+fgYsv6nlQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 317/570] powerpc: floppy: Add missing checks after DMA map
Date: Mon, 18 Aug 2025 14:45:04 +0200
Message-ID: <20250818124518.075135683@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit cf183c1730f2634245da35e9b5d53381b787d112 ]

The DMA map functions can fail and should be tested for errors.

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250620075602.12575-1-fourier.thomas@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/floppy.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/floppy.h b/arch/powerpc/include/asm/floppy.h
index f8ce178b43b7..34abf8bea2cc 100644
--- a/arch/powerpc/include/asm/floppy.h
+++ b/arch/powerpc/include/asm/floppy.h
@@ -144,9 +144,12 @@ static int hard_dma_setup(char *addr, unsigned long size, int mode, int io)
 		bus_addr = 0;
 	}
 
-	if (!bus_addr)	/* need to map it */
+	if (!bus_addr) {	/* need to map it */
 		bus_addr = dma_map_single(&isa_bridge_pcidev->dev, addr, size,
 					  dir);
+		if (dma_mapping_error(&isa_bridge_pcidev->dev, bus_addr))
+			return -ENOMEM;
+	}
 
 	/* remember this one as prev */
 	prev_addr = addr;
-- 
2.39.5




