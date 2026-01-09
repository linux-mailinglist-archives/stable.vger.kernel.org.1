Return-Path: <stable+bounces-206830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0D6D09614
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6009A30E115D
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA635A921;
	Fri,  9 Jan 2026 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEXlb9Bv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C961946C8;
	Fri,  9 Jan 2026 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767960320; cv=none; b=eDY9ar5r3evU8GuwYxaPoTNhz5sx9ksFRV0ZrHy+rIf0j2hrl3M9h1fFkKTQ3skyUDrUFrCwJ/ddJ7hv8jzQBzgmGxH2cY/HSN7rKsvmSUDrn5jMO8eKPV2dilkAi1xBP8gN0sQc5hD4Qb1IHgKOPpOFyL4wZEfLcN047k09w18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767960320; c=relaxed/simple;
	bh=I9bkMIaKOhdP072fWbDlZhF1KvaaV4VzKTbZaKMI/dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hce/rNT+NYUnq40M/5q4z9XVlzYm7d0rTmhXuuXRkoqsfSwSfyuthC9fCNS9sPTLLTnyEMXkjsOekQJsrsjwlcsrV/sqg1HNZHsy+T064pNP+52AdunypJPCgpsfL8OTRHFDT7vY1M1rN3377SePaDVuqUa2vehkRfDuTA/QHIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEXlb9Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8276C4CEF1;
	Fri,  9 Jan 2026 12:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767960320;
	bh=I9bkMIaKOhdP072fWbDlZhF1KvaaV4VzKTbZaKMI/dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEXlb9Bvk3CfjgTAWBdt4D8ULaiPmxmQcSg53jV3wnVRBJ3qT+F8dq1iSqJBrRUKy
	 jdIO9i0kcnLk8oKNNXpdVMF1vtE9ZgKRZ2lV2VaXZC4ElxMdLVzh567UGg5rcitMBV
	 UxFmFITmwVoDb+WlTHyWTftxg2Zbw47XAzlc6HlI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 363/737] MIPS: Fix a reference leak bug in ip22_check_gio()
Date: Fri,  9 Jan 2026 12:38:22 +0100
Message-ID: <20260109112147.651454166@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit 680ad315caaa2860df411cb378bf3614d96c7648 ]

If gio_device_register fails, gio_dev_put() is required to
drop the gio_dev device reference.

Fixes: e84de0c61905 ("MIPS: GIO bus support for SGI IP22/28")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/sgi-ip22/ip22-gio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index 81c9f0a8880b..7026b464b02e 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -373,7 +373,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		gio_dev->resource.flags = IORESOURCE_MEM;
 		gio_dev->irq = irq;
 		dev_set_name(&gio_dev->dev, "%d", slotno);
-		gio_device_register(gio_dev);
+		if (gio_device_register(gio_dev))
+			gio_dev_put(gio_dev);
 	} else
 		printk(KERN_INFO "GIO: slot %d : Empty\n", slotno);
 }
-- 
2.51.0




