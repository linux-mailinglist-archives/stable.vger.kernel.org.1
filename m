Return-Path: <stable+bounces-30410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D4889071
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6951F2D155
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616B723060A;
	Sun, 24 Mar 2024 23:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5xxeUJm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14914C580;
	Sun, 24 Mar 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322227; cv=none; b=u88eilGeSAK4Ubq2oPTvVaLf8j27lGKC4BMfaeTR8FgQJ9sLvFmBCkLeo65JWTneaOIpGsSgWfMkGx8BqYGG8Q5HeKx5+4ruH8QpDUaWhmbYKnHN2yGmwFynP2uj6gXOIlNN1BH4LcTvfuYtm2TYjlATYkLycP8199d/4WjGsq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322227; c=relaxed/simple;
	bh=Z/mlgY4VXogCly0KBDlMulkMi09u0VClrfmIPZj5Bik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CruhT9MBhyRzWIVkOOLeofPnDD7XkhUfQ46C8N7WSrKFpZSsurE6BIVvouqQXgr7mKX63mbw68QthCe7i0Ruq0I9fv7nuFln7+IeSwHNw7Rk0Gta28glvpyByx1A+GzyHcFmu/fkwnd7HfKEO2LClS4Lt2mBtJc64QLmtG/4bL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5xxeUJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B82C43390;
	Sun, 24 Mar 2024 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322226;
	bh=Z/mlgY4VXogCly0KBDlMulkMi09u0VClrfmIPZj5Bik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T5xxeUJm5DKlcXUdGbt2QSJt2JqKjAZPJ3PoHvPi9KlHAlE4aaDN9ZxsHDomyUnfa
	 CPiC2jOAYAyRDP5vpB4FjpeukOFjGqjF2Vjz5Ht2+dJC2OYVU9wI918KdGcZFae4fm
	 Lo06HOoRzn8VCQZMNv9nAHs8GOJweruDG+G6B8PmCS/mbE0hS5InBOjAQAiUWrVXcA
	 WcDXzdMbQUm4jRx2If176ymMfgtbfPcgh1JCoP8eMCYNNAV17ZfiZeWoQqZ7h2D5Wd
	 Wv1FWVntR7XKy9EBye6Nz277UKZC3Gk1GnyUBX7TVejnxa6iATA7SLuVbtYcGee1xS
	 NBa21CgpfPiyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?J=C3=B6rg=20Wedekind?= <joerg@wedekind.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 307/451] PCI: Mark 3ware-9650SE Root Port Extended Tags as broken
Date: Sun, 24 Mar 2024 19:09:43 -0400
Message-ID: <20240324231207.1351418-308-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jörg Wedekind <joerg@wedekind.de>

[ Upstream commit baf67aefbe7d7deafa59ca49612d163f8889934c ]

Per PCIe r6.1, sec 2.2.6.2 and 7.5.3.4, a Requester may not use 8-bit Tags
unless its Extended Tag Field Enable is set, but all Receivers/Completers
must handle 8-bit Tags correctly regardless of their Extended Tag Field
Enable.

Some devices do not handle 8-bit Tags as Completers, so add a quirk for
them.  If we find such a device, we disable Extended Tags for the entire
hierarchy to make peer-to-peer DMA possible.

The 3ware 9650SE seems to have issues with handling 8-bit tags. Mark it as
broken.

This fixes PCI Parity Errors like :

  3w-9xxx: scsi0: ERROR: (0x06:0x000C): PCI Parity Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000D): PCI Abort: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x000E): Controller Queue Error: clearing.
  3w-9xxx: scsi0: ERROR: (0x06:0x0010): Microcontroller Error: clearing.

Link: https://lore.kernel.org/r/20240219132811.8351-1-joerg@wedekind.de
Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=202425
Signed-off-by: Jörg Wedekind <joerg@wedekind.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 51d634fbdfb8e..c175b70a984c6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5415,6 +5415,7 @@ static void quirk_no_ext_tags(struct pci_dev *pdev)
 
 	pci_walk_bus(bridge->bus, pci_configure_extended_tags, NULL);
 }
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_3WARE, 0x1004, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0132, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0140, quirk_no_ext_tags);
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, 0x0141, quirk_no_ext_tags);
-- 
2.43.0


