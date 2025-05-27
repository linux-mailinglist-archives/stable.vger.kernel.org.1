Return-Path: <stable+bounces-147144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEBAC5657
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81DA1BA7285
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CC024C07D;
	Tue, 27 May 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fuUHy0dB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9311E89C;
	Tue, 27 May 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366426; cv=none; b=GAuQ8iVutRsBQB627idJdTzZij5wFUY4DSIFnCmTlOEe3Gfn1QQ3Cju1Ga30mshtsdRGOTC4Xqv7idQ5DZEL+prNbwNxA3bCdJekiWd3ebET52dir382FYl7a1pv/9DTBsbApkqapLJguq7InCCX2Axl/3zjVEzjD2VYpsjBmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366426; c=relaxed/simple;
	bh=N2UcNqZ8OwfhJz+HKZvxI8wDRRU41MNOuQm8Xi5VE/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLvJmTwlpCyC6E+7S0eP1Wx2ABQ4QNnhK/4PHhTJvkolkDxkxLY/f+r6lyen9YCIbmbL45D3JIQH4C+TC+7TQppejxlbnEZAfi4lUrOAmnUJs6xCuYe/sX0IFAHnbgPLj8yDhtqw83TasQc7byIFevHROrWLNeC0F1j8VMVQmnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fuUHy0dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C439CC4CEE9;
	Tue, 27 May 2025 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366426;
	bh=N2UcNqZ8OwfhJz+HKZvxI8wDRRU41MNOuQm8Xi5VE/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuUHy0dB8G2jm13KCbOdFUjBKjPfn0DB9xewi3duzeTSpLtDXZEQf3e575HdvolFS
	 6oFmEo7dOar7MRTAQwhetdNT7gnLEyJOLKBP0BBVUL2pOTgQBNi4hBMxNOzftqH4pL
	 Avlp4OjtrvK+rCCLwhvln3+yAnxpYBwV+o2UsfY0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 064/783] mailbox: pcc: Use acpi_os_ioremap() instead of ioremap()
Date: Tue, 27 May 2025 18:17:41 +0200
Message-ID: <20250527162515.730892607@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit d181acea5b864e91f38f5771b8961215ce5017ae ]

The Platform Communication Channel (PCC) mailbox driver currently uses
ioremap() to map channel shared memory regions. However it is preferred
to use acpi_os_ioremap(), which is mapping function specific to EFI/ACPI
defined memory regions. It ensures that the correct memory attributes
are applied when mapping ACPI-provided regions.

While at it, also add checks for handling any errors with the mapping.

Acked-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Huisong Li <lihuisong@huawei.com>
Tested-by: Adam Young <admiyo@os.amperecomputing.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index f8215a8f656a4..49254d99a8ad6 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -419,8 +419,12 @@ int pcc_mbox_ioremap(struct mbox_chan *chan)
 		return -1;
 	pchan_info = chan->con_priv;
 	pcc_mbox_chan = &pchan_info->chan;
-	pcc_mbox_chan->shmem = ioremap(pcc_mbox_chan->shmem_base_addr,
-				       pcc_mbox_chan->shmem_size);
+
+	pcc_mbox_chan->shmem = acpi_os_ioremap(pcc_mbox_chan->shmem_base_addr,
+					       pcc_mbox_chan->shmem_size);
+	if (!pcc_mbox_chan->shmem)
+		return -ENXIO;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pcc_mbox_ioremap);
-- 
2.39.5




