Return-Path: <stable+bounces-218472-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBaiLOJRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218472-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C7318F10C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B52306160D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384E248F54;
	Wed, 25 Feb 2026 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q8xO0k4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8723D18B0A;
	Wed, 25 Feb 2026 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983299; cv=none; b=ZyUkHhehdztEeU9ouWs8OlG+gCQfvUPj1e+IpsbLxSmIFIkB3HwXvARHERKJNJcdYxBFJ9eJXumIsbwrpTcnbsuyB83ndBHNMFq8QGC7nJ5bnVFx7h2wyX5C3DlWs0l2Eep59Hd46IOlQvBtGcpctjCCNVz8TIWbnhVmjyyGcck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983299; c=relaxed/simple;
	bh=T5m36JC01yavXbIpDg+8LHdPXPUNPd1SSmWTDFPlGaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dgdxn/EV/ijGxIal8lSVq/SdpWe8w2GxN5KAOI8tJ5aBwOqGmpKVTEmBS+DnDGwlGEjKRY/GlFO0i6YVe/LL7LIhl3+oc9aXiyxK7PXsBjYwtde2UPHJnpaJ+LYTqN0QO/4wc0wlyOBzewKCZqQu+IItECEqk6JLSA/9FYb9SEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q8xO0k4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481E9C116D0;
	Wed, 25 Feb 2026 01:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983299;
	bh=T5m36JC01yavXbIpDg+8LHdPXPUNPd1SSmWTDFPlGaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q8xO0k4hboBxgeri5TpiLr6miIhzJtAeGSsx496GYKR4GW4wXfMg+TgsknKoaOI2S
	 1hC1RI7aroirTo9RPov5iubaxnI1F25oDZwc/Dnm2uY+SmPE1HaA5oelJ4e4+W9wgB
	 yDd3JO4UOS12cyld5dvH8ueuygVCkUdV+/YRtSic=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 432/781] octeon_ep: disable per ring interrupts
Date: Tue, 24 Feb 2026 17:19:01 -0800
Message-ID: <20260225012410.295603295@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218472-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Queue-Id: 34C7318F10C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vimlesh Kumar <vimleshk@marvell.com>

[ Upstream commit 73e6ffa37cebee152c07c5f2b8bc70fd2899ea6e ]

Disable the MSI-X per ring interrupt for every PF ring when PF
netdev goes down.

Fixes: 1f2c2d0cee023 ("octeon_ep: add hardware configuration APIs")
Signed-off-by: Sathesh Edara <sedara@marvell.com>
Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
Link: https://patch.msgid.link/20260206111510.1045092-2-vimleshk@marvell.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/marvell/octeon_ep/octep_cn9k_pf.c | 18 +++++++++++++++---
 .../ethernet/marvell/octeon_ep/octep_cnxk_pf.c | 18 +++++++++++++++---
 .../marvell/octeon_ep/octep_regs_cn9k_pf.h     |  1 +
 .../marvell/octeon_ep/octep_regs_cnxk_pf.h     |  1 +
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
index b5805969404fa..f0bcb5f3c1474 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cn9k_pf.c
@@ -696,14 +696,26 @@ static void octep_enable_interrupts_cn93_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cn93_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
-		intr_mask |= (0x1ULL << (srn + i));
+	for (i = 0; i < num_rings; i++) {
+		intr_mask |= BIT_ULL(srn + i);
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= ~CN93_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CN93_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CN93_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= ~CN93_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CN93_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CN93_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CN93_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
index 5de0b5ecbc5fd..07e00887c6940 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_cnxk_pf.c
@@ -720,14 +720,26 @@ static void octep_enable_interrupts_cnxk_pf(struct octep_device *oct)
 /* Disable all interrupts */
 static void octep_disable_interrupts_cnxk_pf(struct octep_device *oct)
 {
-	u64 intr_mask = 0ULL;
+	u64 reg_val, intr_mask = 0ULL;
 	int srn, num_rings, i;
 
 	srn = CFG_GET_PORTS_PF_SRN(oct->conf);
 	num_rings = CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf);
 
-	for (i = 0; i < num_rings; i++)
-		intr_mask |= (0x1ULL << (srn + i));
+	for (i = 0; i < num_rings; i++) {
+		intr_mask |= BIT_ULL(srn + i);
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_IN_INT_LEVELS(srn + i));
+		reg_val &= ~CNXK_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_IN_INT_LEVELS(srn + i), reg_val);
+
+		reg_val = octep_read_csr64(oct,
+					   CNXK_SDP_R_OUT_INT_LEVELS(srn + i));
+		reg_val &= ~CNXK_INT_ENA_BIT;
+		octep_write_csr64(oct,
+				  CNXK_SDP_R_OUT_INT_LEVELS(srn + i), reg_val);
+	}
 
 	octep_write_csr64(oct, CNXK_SDP_EPF_IRERR_RINT_ENA_W1C, intr_mask);
 	octep_write_csr64(oct, CNXK_SDP_EPF_ORERR_RINT_ENA_W1C, intr_mask);
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
index ca473502d7a02..95f1dfff90cce 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cn9k_pf.h
@@ -386,5 +386,6 @@
 #define CN93_PEM_BAR4_INDEX            7
 #define CN93_PEM_BAR4_INDEX_SIZE       0x400000ULL
 #define CN93_PEM_BAR4_INDEX_OFFSET     (CN93_PEM_BAR4_INDEX * CN93_PEM_BAR4_INDEX_SIZE)
+#define CN93_INT_ENA_BIT	BIT_ULL(62)
 
 #endif /* _OCTEP_REGS_CN9K_PF_H_ */
diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
index e637d7c8224d4..4d172a552f80c 100644
--- a/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
+++ b/drivers/net/ethernet/marvell/octeon_ep/octep_regs_cnxk_pf.h
@@ -412,5 +412,6 @@
 #define CNXK_PEM_BAR4_INDEX		7
 #define CNXK_PEM_BAR4_INDEX_SIZE	0x400000ULL
 #define CNXK_PEM_BAR4_INDEX_OFFSET	(CNXK_PEM_BAR4_INDEX * CNXK_PEM_BAR4_INDEX_SIZE)
+#define CNXK_INT_ENA_BIT	BIT_ULL(62)
 
 #endif /* _OCTEP_REGS_CNXK_PF_H_ */
-- 
2.51.0




