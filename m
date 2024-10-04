Return-Path: <stable+bounces-80838-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C35B990BAE
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E60D1C21B59
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475831E32CA;
	Fri,  4 Oct 2024 18:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msKaWP64"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C951D9677;
	Fri,  4 Oct 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066020; cv=none; b=pUR+5pDYlkbNYWSk7TFPsdbG9hVfmwzDOatR2JuI/VxkN62bXN6UN2dD3JIm4D0v/I/73inN5Da9IxnagoWpmfTqxZ01uzz5CwI53Z4JnKpQPCTeLHyn2gusthzOD4e52HDmotqb9WK2SZxVN1ezi4/NMbRaL08Vw2r+JrB6glc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066020; c=relaxed/simple;
	bh=1sspyqVTgvIpKwxU5N9E0sOh0QrLdF27x0qAoEIqpa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPQem9yy3UHOJ8Ey/uuhdARgUQg2hX169bpgK4aMJisaMhAMEnIF3xMwx7TYGASAJ7yZ3wutW4wLnpuFVsyvcmGYQqcSI3PgimTAmDLrd55OfXq8DoNblPY0nwXQgngKeUr3Ap3JPoi0aqGYArLjS1O0xD9lq6d5B2bj6W5rU3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msKaWP64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3C8C4CECE;
	Fri,  4 Oct 2024 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066019;
	bh=1sspyqVTgvIpKwxU5N9E0sOh0QrLdF27x0qAoEIqpa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msKaWP64hwLfEFaz5qUMugU8qjgGpIkt3eFKCOGkhdI35SZW8lvnD8dp32ThuB4Dg
	 3uQu1UgNydmjdg7xuM2uGNaGADe538wTJf0gVcaYiq86Zf6do0X0Bo8Rn9skvlfT46
	 iEdjvpxBccYwSyTcS4r3XUhQXZgegyN8iHaSZZlMoDcrzu/XQ53PB2bm/6bbhDlh8k
	 qNNOqwmsq67heKA8mTAZP/gZqTlWLONHkGJd5SmuVoeTzB+L9axNTynfrjUW1i7/Iy
	 WAWjafZH4iaXZQaT03FRWlUflnj3OqIisutiQhUQPaFjmrse0QRoBz0194q1NtyOoE
	 LWN3knYxqvxnw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	Yuli Wang <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 58/76] LoongArch: Fix memleak in pci_acpi_scan_root()
Date: Fri,  4 Oct 2024 14:17:15 -0400
Message-ID: <20241004181828.3669209-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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


