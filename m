Return-Path: <stable+bounces-146723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48973AC5492
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3480B7AFEB7
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 16:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A9727FD5A;
	Tue, 27 May 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m9iy9ATj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352727FD4C;
	Tue, 27 May 2025 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365109; cv=none; b=lUrKV6rmsND5VZzCRxlRgwAkRopLckDK2GtGWL7MwdB9LF40sVlFus3VsIvLtr1wzsqgNz8es27eXqQKbs8sxaa72xjQDHtDo+uYFUiYzKOukgqawrcTgrordPN2x4RS0BW/4XqaUuZvLsPtk34oR8fxHmvvUMCaSNzUhG1vfTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365109; c=relaxed/simple;
	bh=bICkCR6EX/EJIhK89eR0XcDt1ibyA/enczi3a81UxXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eVVHqAgXrPA21OdI9nPF998NHdMkYRLtrQSasBb7ONqQnP2GYl5T+FBW9lVnQe2TTarpPjiqNm3DhQza3lFEX+CNizpsX9la4TVWYDeuCscAIBB4KHLHj8Ptx+jEAq3b843zmVpD8DjzuqINYpAuCEe18wDSDwiRCB7w3fpsyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m9iy9ATj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76B1C4CEE9;
	Tue, 27 May 2025 16:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365109;
	bh=bICkCR6EX/EJIhK89eR0XcDt1ibyA/enczi3a81UxXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9iy9ATjG0l+mYkHLxFbdFAROjJtBrv/IVOBZq68Vf4+of/oEd0U5DLDYOuBgVv4E
	 ab6ItJU3H+wuiC8FrG+eiewyHHJICYg697P5sO0+JnQDs89ZtncpIzKVFPdKPOnwZD
	 kD29Ji9vizdS5+9t/OP17lvGJlbWiCrdsCaEfWE4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stanimir Varbanov <svarbanov@suse.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Ivan T. Ivanov" <iivanov@suse.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 269/626] PCI: brcmstb: Add a softdep to MIP MSI-X driver
Date: Tue, 27 May 2025 18:22:42 +0200
Message-ID: <20250527162455.951635231@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanimir Varbanov <svarbanov@suse.de>

[ Upstream commit 2294059118c550464dd8906286324d90c33b152b ]

Then the brcmstb PCIe driver and MIP MSI-X interrupt controller
drivers are built as modules there could be a race in probing.

To avoid this, add a softdep to MIP driver to guarantee that
MIP driver will be load first.

Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Ivan T. Ivanov <iivanov@suse.de>
Link: https://lore.kernel.org/r/20250224083559.47645-5-svarbanov@suse.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-brcmstb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 32ffb0c14c3ca..81f085cebf627 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1947,3 +1947,4 @@ module_platform_driver(brcm_pcie_driver);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
 MODULE_AUTHOR("Broadcom");
+MODULE_SOFTDEP("pre: irq_bcm2712_mip");
-- 
2.39.5




