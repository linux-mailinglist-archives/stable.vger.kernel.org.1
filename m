Return-Path: <stable+bounces-242425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGAfJBCn9GngDAIAu9opvQ
	(envelope-from <stable+bounces-242425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:13:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 111584AC967
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B4FD301586B
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC417386C30;
	Fri,  1 May 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf6LnEWA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CF2248B4
	for <stable@vger.kernel.org>; Fri,  1 May 2026 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641227; cv=none; b=TlzElY8PbApZOERFqArb2BR8SIlzZZvzhhinzqVF0O/PKt9lWsT9CMp3r6hAI2mv74PWv5nlmr19IcXXlqUu3n6ciQyhXCVzj9BqN2J7RQDDh8sBfPKjaTj6Gx2LhkfjVCNXd6PBStDvH1xv6xuRKdn5OSTQzr/2feYlo2Vbtw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641227; c=relaxed/simple;
	bh=BQHAAtXMp9JwNQOsg/qpBmseiH6npvTAPx94EKaZqQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8n/87/iLqfvg7mRdvc984JK6ifau264PA3KaZcrT7VL7hBcRVSfpQ2PMSv/NShNpDTyeSjeJ+rmsqAFWwju1s7EjzJVZdwtel9b5yjHomFstJkcIPpVF4Pq4P4A3fjhxTd/5Nat1zHqNufGQg26qRxM6SK2Fd/9wEo2d4YpZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf6LnEWA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBE7C2BCB4;
	Fri,  1 May 2026 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777641227;
	bh=BQHAAtXMp9JwNQOsg/qpBmseiH6npvTAPx94EKaZqQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jf6LnEWAcEBq6GmBja1XdQtdxFDprLvoHFTYuKvOcicNYsCVNIDQJ+rct2eQXTHsg
	 pfTRmXHvGuuoo+nIbnOuPg7DysbypA2kyJNy8PKvq4rH+VR632W0eV48XwyBWkU699
	 iMXd4oFKOCof13zJRwRABC4nP/rEq8zJvv4HJBBSybYGQamPGPGw/Z9T0i1naPIcDo
	 +wOOBlUqNt7dT28UBhXmYqPV1Yg1XN41OTgSKB9lp7HNSmm67kcRQHlpn2NmRGvEpr
	 X8aqPFB5TgFCYZzDihSIF8QDp9A5HnXbGhGLDLyDb0QgQ27MW14wNYZKv6lKcKEYEt
	 8wA27v6GM+0cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Hodges <git@danielhodges.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete
Date: Fri,  1 May 2026 09:13:44 -0400
Message-ID: <20260501131344.3233285-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050137-lesser-shaping-0e62@gregkh>
References: <2026050137-lesser-shaping-0e62@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 111584AC967
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242425-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]

From: Daniel Hodges <git@danielhodges.dev>

[ Upstream commit 36bfc3642b19a98f1302aed4437c331df9b481f0 ]

pci_epf_mhi_edma_read() and pci_epf_mhi_edma_write() start DMA
operations and wait for completion with a timeout.

On successful completion, they previously returned the remaining
timeout, which callers may treat as an error.  In particular,
mhi_ep_ring_add_element(), which calls pci_epf_mhi_edma_write() via
mhi_cntrl->write_sync(), interprets any non-zero return value as
failure.

Return 0 on success instead of the remaining timeout to prevent
mhi_ep_ring_add_element() from treating successful completion as an
error.

Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
[mani: changed commit log as per https://lore.kernel.org/linux-pci/20260227191510.GA3904799@bhelgaas]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260206200529.10784-1-git@danielhodges.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 87154992ea11b..e5a7d1735649a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -331,6 +331,8 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
 		dev_err(dev, "DMA transfer timeout\n");
 		dmaengine_terminate_sync(chan);
 		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
 	}
 
 err_unmap:
@@ -402,6 +404,8 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
 		dev_err(dev, "DMA transfer timeout\n");
 		dmaengine_terminate_sync(chan);
 		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
 	}
 
 err_unmap:
-- 
2.53.0


