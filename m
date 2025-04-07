Return-Path: <stable+bounces-128751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACFBA7EBA4
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9C9117DF95
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2561727932E;
	Mon,  7 Apr 2025 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ecIUR+v0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C3279325;
	Mon,  7 Apr 2025 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049864; cv=none; b=UBwWuvvPEJotpysyRT54QxhzztJ5+TXxNUq3zkC5SHFtLO3lj2F6wtqu6ROrFtGR4nZ80YnLpS8HeZgL1jdErmg1V+kzjGrkBTvvR3jzwAqUQtmb4n477LU0ILzXXKwJZ0ypkrcvcwDMhlN/+1D4/53Jpjp9kz3XdRECrm+4QK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049864; c=relaxed/simple;
	bh=EeNyzSPVB15bkTHwbGNE4TC98r6iZP9QZnHs4daBLNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mk8JGCZB9UVcByURKX9QX8DnxyGTa5MbnpC91Zql8Zz/05TVw3f82TJ6GwTnWmE88UeAg2iOW3/87SK5ApaNGCgyYtNAXK/eIiW0VjZePUoJPLLdXVOmnDkraaFhsY1odX9US9CC2DwAkBg2n1mczZc9KGMdK4b56EHVbc1+Jis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ecIUR+v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5267EC4CEE9;
	Mon,  7 Apr 2025 18:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049864;
	bh=EeNyzSPVB15bkTHwbGNE4TC98r6iZP9QZnHs4daBLNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ecIUR+v0p0NBCmn+A6pHP5pOIFQkj3WTiF1ktxwqebQF+XhbsDZuPZ+BCGGjJ/kzX
	 /TfSpxHHlTUOIF8JHXS0SGPx7ZMyKJ0oTnwJcmJQt9oE034LVhzwnSwsJm4ir4brvV
	 TKvR/saHyPA1HBglTviG2vx4kQRlI2C87wXVB7+upNrD6mAwjEBNhVAonB/TycIn4l
	 KDYBvjW9F+D9jBLZnjpgoP9UNuOmZD3vwLxhEZmCOb8Rntxc0wny5vbm+LbguNmDhr
	 oaTm02pGn/mnmSJZBNwHw6qTJrFPsHPRWwfQq8od/nAv0PqiLOO9A3yyA4Nrr9UDPk
	 S9ymA4UNK07CA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	ntb@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 3/6] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date: Mon,  7 Apr 2025 14:17:31 -0400
Message-Id: <20250407181734.3184450-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181734.3184450-1-sashal@kernel.org>
References: <20250407181734.3184450-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
Content-Transfer-Encoding: 8bit

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit bf8a7ce7e4c7267a6f5f2b2023cfc459b330b25e ]

Add NTB support for new generation of processor.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78d..63ceed89b62ef 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1318,6 +1318,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.39.5


