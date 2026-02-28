Return-Path: <stable+bounces-220414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ASWInw5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6B1C65A3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCDF034BC90B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3623B0948;
	Sat, 28 Feb 2026 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOmZZ+XD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0093B0940;
	Sat, 28 Feb 2026 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300305; cv=none; b=rFOgC2Ew7iBSZXOWlulSnQY4kKkvYHFczO1rOwss2eGycYbgDNG7YiaapAM8zSHcOJnO6/TPbN4eWxUbIX1mMVe3wjJyPWOpPNpxDAw8s13fxcZzsmS/H0BdSOsMU5gyghhjR7jFSjIpXI0aEJrmK880Vdhu7xWxxKIM+9TdGv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300305; c=relaxed/simple;
	bh=ATjiF+y6xyZCncjOO7dsiQtE8pP3E5WtbNbJ8vK1yTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJ1QuchWN0m9iewHPpDUYePSbbw2uEl4+o07tN7Wa4OCKkY3FW/M3utuyLL6rO5rPy2ikCmEm+pNxojtvLE3+ZuFLj33Pd5CzZhsCodDSIP27yqC+aFfxmoMB794z+tJNHieTPMkdf+lopBgYTZoREa5GPnoVThHORU1FRNpxRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOmZZ+XD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75D8C19423;
	Sat, 28 Feb 2026 17:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300305;
	bh=ATjiF+y6xyZCncjOO7dsiQtE8pP3E5WtbNbJ8vK1yTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOmZZ+XDlEQ8EVD/PP6MjGk5sr0v5J3HYxoKMnJLLQfcAopBunu0PqLJC0aAWPIdK
	 gyLiwJgcMvv+hh06ymSy882q09BScq2zyDcDCepiTRJOBciWR1sAGj2xsXuVFzKPKk
	 f9pP4rrHyHEgRbK31gub75g1O50UCInneOG9ui++jROO8FuBt6HUQ3fYwgj1o8JG8L
	 eZKCNdBAhIE1wKFxBNzCi3GUEpuXss3j8rRNroX0uYig85oePKkr7gVBdnxzNi1wKr
	 9NyyS8j/F8V1efDfJq9zMk+u5y6Vz7+hUxbAri4liADQYIjSJw8WaBIYhkFax6w00L
	 xykXCbU4mr1GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 335/844] PCI: Add ACS quirk for Qualcomm Hamoa & Glymur
Date: Sat, 28 Feb 2026 12:24:08 -0500
Message-ID: <20260228173244.1509663-336-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220414-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CBF6B1C65A3
X-Rspamd-Action: no action

From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

[ Upstream commit 44d2f70b1fd72c339c72983fcffa181beae3e113 ]

The Qualcomm Hamoa & Glymur Root Ports don't advertise an ACS capability,
but they do provide ACS-like features to disable peer transactions and
validate bus numbers in requests.

Add an ACS quirk for Hamoa & Glymur.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://patch.msgid.link/20260109-acs_quirk-v1-1-82adf95a89ae@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 538ad85cf7c30..4463a2da0441f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5117,6 +5117,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_QCOM, 0x0401, pci_quirk_qcom_rp_acs },
 	/* QCOM SA8775P root port */
 	{ PCI_VENDOR_ID_QCOM, 0x0115, pci_quirk_qcom_rp_acs },
+	/* QCOM Hamoa root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0111, pci_quirk_qcom_rp_acs },
+	/* QCOM Glymur root port */
+	{ PCI_VENDOR_ID_QCOM, 0x0120, pci_quirk_qcom_rp_acs },
 	/* HXT SD4800 root ports. The ACS design is same as QCOM QDF2xxx */
 	{ PCI_VENDOR_ID_HXT, 0x0401, pci_quirk_qcom_rp_acs },
 	/* Intel PCH root ports */
-- 
2.51.0


