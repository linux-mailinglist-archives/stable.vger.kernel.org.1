Return-Path: <stable+bounces-80908-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B31990C9B
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2C21C2289D
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA141FAC23;
	Fri,  4 Oct 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifi+TRLB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9696821D2CF;
	Fri,  4 Oct 2024 18:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066221; cv=none; b=SptBCr6ODZv0eFNHaRpYe5EJin6qoLHTPY35yXx0yFy+Xj1+7lVmshFQC1P9SfZ+t93A9vseJR5U3+Q+waxsPbrGcSehcnNn7Ku2EoaoSZrZCPDCwqKZ+L7dhoSKMvk+DssWw7qKFeMMvsszOnl3YdTCC2/jPEZF/iUyvjYbehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066221; c=relaxed/simple;
	bh=1sspyqVTgvIpKwxU5N9E0sOh0QrLdF27x0qAoEIqpa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL+51AlC8vCACkbiqZnm0mAsdANvUtJ0u4BQ6yzKuGtjymgNEBgqfLzTk5cGq+svBiNoRIVz4OHoYS6b0V+knXHXRC8oN8eOZUVKujVnfkgY3rzz2ezKD5rL6jAW4z4hSph6mz9G3QcnsnQPE39phpoLePI9u/hqFBktEIJk5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifi+TRLB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A49C4CECD;
	Fri,  4 Oct 2024 18:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066221;
	bh=1sspyqVTgvIpKwxU5N9E0sOh0QrLdF27x0qAoEIqpa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ifi+TRLBBDoW+wtgORBcnEcTCABhzhKoHkb9H+3HJ++QzWcwhPz5sWhKYe0OiVrhD
	 /tkI5ofFRceoeHhBdnn2OhcyyFD/AT7c5lFza4xZHBDLuiufyQvclW9NWvFcpI+9pu
	 k0+xMqae+YOAS6Us+NEGswhLCOK2l027U/5+cMziHfXmWeD5s1mtL4cwNwMDjwTEPi
	 WWqSWn2TO9Y57uNLWkUOmeba6amQPDLt5CzB82Zt8EPqMHibA0vwgBHHK2EsQTIFHk
	 pDZUU774pmU0LllI6H8tIFnevJtD2HUZoMdxMR9o0ttOHfp/oxOmL0DDy9YEtIsGfI
	 x1ReU6dUQBIhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	Yuli Wang <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.10 52/70] LoongArch: Fix memleak in pci_acpi_scan_root()
Date: Fri,  4 Oct 2024 14:20:50 -0400
Message-ID: <20241004182200.3670903-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit 5016c3a31a6d74eaf2fdfdec673eae8fcf90379e ]

Add kfree(root_ops) in this case to avoid memleak of root_ops,
leaks when pci_find_bus() != 0.

Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/pci/acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index 365f7de771cbb..1da4dc46df43e 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -225,6 +225,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (bus) {
 		memcpy(bus->sysdata, info->cfg, sizeof(struct pci_config_window));
 		kfree(info);
+		kfree(root_ops);
 	} else {
 		struct pci_bus *child;
 
-- 
2.43.0


