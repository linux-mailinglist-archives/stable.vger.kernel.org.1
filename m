Return-Path: <stable+bounces-140426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 574C1AAA895
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBB41884971
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41C83507F9;
	Mon,  5 May 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UROhahhr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C7F3507F1;
	Mon,  5 May 2025 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484829; cv=none; b=trY0rT34iMTh5F5vyTS8N8g3O9j9fL9I3QiUoaHsLDidSfM2klHvTmp2qleFFyAjY3B3/hzUwIVpcZiDZ1gcRuZJslope2WJubBjRFMu0QmLdE+VLV2JhgOOfkNnw1MqK9EBEffw4p//83Djv0g15lLIp69RvGDUkcA29WteDLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484829; c=relaxed/simple;
	bh=/UCsCVFjAKQ5ixedxcZzXmKFJNG1lbkF0KEuXoj11jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WBq0G27NfuQwgbXGqFin5g7sSQNaLE4pAG5ZiadyR07iSZFe+3tsqcbHntttQS4TAuBhulkIlOonCNqeofY4hCWvgO/BhFC1NOrDDEiVl/aGIW3edtPqIjgenLuZ+LflwEdkZyIZnW5rPtJls/eD6QlYXlgGjqV6+JNuqfq5X5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UROhahhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A39C4CEEF;
	Mon,  5 May 2025 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484829;
	bh=/UCsCVFjAKQ5ixedxcZzXmKFJNG1lbkF0KEuXoj11jk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UROhahhrIoEZtUXpWmjy+n6GFvMGhIF/oHRwHo9lbJAL2eJvGJkupfSALPmbNITfZ
	 GgkXoH9zZNpCchzvdHo6p2U/QcSWnTfOR9gEl9KBy3/MpsWX8o6zQq98scsGUfH9GC
	 ROa/mpSvXj2amUtzRuf+stnYrokkxa5SIkUbjYckNeSp9D016T+QkPJ3zmUTFq1acJ
	 DCpEYYeFQ/jsIxpgS1NEkEhsgJ9fMcDZpJpqFZgywlUQHuQcamNL8YTfOSYvE/cO5N
	 BIu+V9Dwzt5i8lx+yKgoGAe02mc3m+6yAt6aQeCLL7d8iZx6Yh83UT0Thlk4DK6Zea
	 BFP689ZlpzvWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans-Frieder Vogt <hfdevel@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	fujita.tomonori@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 035/486] net: tn40xx: add pci-id of the aqr105-based Tehuti TN4010 cards
Date: Mon,  5 May 2025 18:31:51 -0400
Message-Id: <20250505223922.2682012-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Hans-Frieder Vogt <hfdevel@gmx.net>

[ Upstream commit 53377b5c2952097527b01ce2f1d9a9332f042f70 ]

Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
of the tn40xx driver on these cards. Here, I chose the detailed definition
with the subvendor ID similar to the QT2025 cards with the PCI-ID
TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
the AQ2104 is currently not supported.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250322-tn9510-v3a-v7-7-672a9a3d8628@gmx.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/tehuti/tn40.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/tehuti/tn40.c b/drivers/net/ethernet/tehuti/tn40.c
index 259bdac24cf21..a6965258441c4 100644
--- a/drivers/net/ethernet/tehuti/tn40.c
+++ b/drivers/net/ethernet/tehuti/tn40.c
@@ -1832,6 +1832,10 @@ static const struct pci_device_id tn40_id_table[] = {
 			 PCI_VENDOR_ID_ASUSTEK, 0x8709) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, 0x4022,
 			 PCI_VENDOR_ID_EDIMAX, 0x8103) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, PCI_DEVICE_ID_TEHUTI_TN9510,
+			 PCI_VENDOR_ID_TEHUTI, 0x3015) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_TEHUTI, PCI_DEVICE_ID_TEHUTI_TN9510,
+			 PCI_VENDOR_ID_EDIMAX, 0x8102) },
 	{ }
 };
 
-- 
2.39.5


