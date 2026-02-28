Return-Path: <stable+bounces-220339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBxOIM00o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8691C5EF5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 880CE30C9977
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76E8359A82;
	Sat, 28 Feb 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETiRpB33"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ABC359A78;
	Sat, 28 Feb 2026 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300238; cv=none; b=oukA/FaMH+luBNwA1ND2E6jYHqLC4mHQRJ2Hl5Yp8ZMY9CqHjp7MVtmZTHizUN2HYxjvoyB17hxqii1wwnTs2PlGCh4OikuMtjnIIgxMm8wCobunzyvMDw1oPHZixbMtLK1Td/PjeyTURs77H1a8p82orLXG4HBzKtqzLnma36E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300238; c=relaxed/simple;
	bh=5aKzeXcYaYo4MCLQ1Ws0WHCxrUeX6gnyX7HcxQxb8KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm96ciCUdgvUIkg9W5ZBWmhv9DrDf3GXqBA/Pj3pjFk1M+uLFFrJUNEJGnyqjipWctetTpU7l9jo2y0nQvJhxNL160fptKP8zaDsHITKBtqde71ubc26hkFrhjp/0U4prFSd1sEe6TgAZIbXg4jbfI3ZMP6Ya0a3O9oWpUtJi60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETiRpB33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB47AC19424;
	Sat, 28 Feb 2026 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300238;
	bh=5aKzeXcYaYo4MCLQ1Ws0WHCxrUeX6gnyX7HcxQxb8KA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ETiRpB33UY4ZskLNZ4SXjSsPuR/b7iX+bfi9UrpcaMNTLPyBzksKaKV5z/zEhuEvV
	 QmFsRmUDwRuFzasBQX2I6cTyvCcITtcgRWlG0Tk8obohOUDeiFYnNRls+upxhSpOar
	 1uvRm4+61/5p9ktodqjJdJNWgbumgDDJJokbqF8jsK/FF85ZdUv16GSupELyBXcBQV
	 Zf9iPxyvyy7IrieB9PJJ/Cn5FKGdNwgl6fipX0ZpaerbkO8mL4WLkdJB79P7yQtphm
	 5GO1YI2U3FTh9uFBgWNfkId5ShzVKy+8mNeohNPxOxR4KtmvVoR2WZrzhmeAH6LwcN
	 acKR47ytYelBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 261/844] PCI: cadence: Avoid signed 64-bit truncation and invalid sort
Date: Sat, 28 Feb 2026 12:22:54 -0500
Message-ID: <20260228173244.1509663-262-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220339-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: EE8691C5EF5
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit 0297dce758a021ccf2c0f4e164d5403ef722961c ]

The cdns_pcie_host_dma_ranges_cmp() element comparison function used by
list_sort() is of type list_cmp_func_t, so it returns a 32-bit int.

cdns_pcie_host_dma_ranges_cmp() computes a resource_size_t difference that
may be a 64-bit value, and truncating that difference to a 32-bit return
value may change the sign and result in an invalid sort order.

Avoid the truncation and invalid sort order by returning -1, 0, or 1.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20251209223756.2321578-1-irogers@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../controller/cadence/pcie-cadence-host-common.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-host-common.c b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
index 15415d7f35ee9..2b0211870f02a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host-common.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host-common.c
@@ -173,11 +173,21 @@ int cdns_pcie_host_dma_ranges_cmp(void *priv, const struct list_head *a,
 				  const struct list_head *b)
 {
 	struct resource_entry *entry1, *entry2;
+	u64 size1, size2;
 
 	entry1 = container_of(a, struct resource_entry, node);
 	entry2 = container_of(b, struct resource_entry, node);
 
-	return resource_size(entry2->res) - resource_size(entry1->res);
+	size1 = resource_size(entry1->res);
+	size2 = resource_size(entry2->res);
+
+	if (size1 > size2)
+		return -1;
+
+	if (size1 < size2)
+		return 1;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(cdns_pcie_host_dma_ranges_cmp);
 
-- 
2.51.0


