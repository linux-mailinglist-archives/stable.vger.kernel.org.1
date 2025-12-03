Return-Path: <stable+bounces-199517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ED8CA0E3D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB7232A95CC
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A835A94B;
	Wed,  3 Dec 2025 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M3IxpqMC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D717735A940;
	Wed,  3 Dec 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780060; cv=none; b=V8I2OPiwuciqDTx7SqUXEzooFcthHPHs0lcWnYrUSHpniQefPpiiNEj/6JFvSZva6oR0NxByulIyB01tx1Wy+BmenL+NafqXrD8BHj3yAJTKxKh80eEnaHUJ//Rke9Jnxd72GVgRxr531iyto8TTOI4J8fFYfZhfutKQ88TMHdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780060; c=relaxed/simple;
	bh=fss6q06xY/fteH91S10K8WtvyKpiuuYec7KruOb1qvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8pEq5DMYI4pC4uZZw0GiJERCTJbCXeKrwZDpTUhUXA4MddeP6Cz6EHCoZ2lF6BD6j+OeiGRYb3C7Ev16Xmtg9jd1MB7ZG/DS0BnQiUf46km0Rw3b8OjiugMI9vPhbpdTSdpCxBKEFVnGYuG6hfaVLnjopkCU3dzbURan1W1/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M3IxpqMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4022C4CEF5;
	Wed,  3 Dec 2025 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780060;
	bh=fss6q06xY/fteH91S10K8WtvyKpiuuYec7KruOb1qvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3IxpqMC+qGsWfPiSgI/9iXhz9jDzhBSrjc1seLGoLFJ6huGoEvKTa0qNvLM7F8K0
	 fyE9+tAvc6WWxQT5MepAEzxDF/HL7UjKUFm4kcaimxDmQy/ZKP9+yxIfjMSQZSeA1i
	 ZW8/0ZQrZ1Ra8szhqEQn26bSzNHMWk3CGRWUIgrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.1 443/568] LoongArch: Dont panic if no valid cache info for PCI
Date: Wed,  3 Dec 2025 16:27:25 +0100
Message-ID: <20251203152456.923637505@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit a6b533adfc05ba15360631e019d3e18275080275 upstream.

If there is no valid cache info detected (may happen in virtual machine)
for pci_dfl_cache_line_size, kernel shouldn't panic. Because in the PCI
core it will be evaluated to (L1_CACHE_BYTES >> 2).

Cc: <stable@vger.kernel.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/pci/pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/loongarch/pci/pci.c
+++ b/arch/loongarch/pci/pci.c
@@ -51,11 +51,11 @@ static int __init pcibios_init(void)
 	 */
 	lsize = cpu_last_level_cache_line_size();
 
-	BUG_ON(!lsize);
+	if (lsize) {
+		pci_dfl_cache_line_size = lsize >> 2;
 
-	pci_dfl_cache_line_size = lsize >> 2;
-
-	pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+		pr_debug("PCI: pci_cache_line_size set to %d bytes\n", lsize);
+	}
 
 	return 0;
 }



