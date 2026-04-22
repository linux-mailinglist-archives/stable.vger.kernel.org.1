Return-Path: <stable+bounces-240358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDG6DPDy6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:10:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7D1448492
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B257B308E757
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8443F382288;
	Wed, 22 Apr 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KawzW3nL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE166273D77
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873914; cv=none; b=fXmsJyEOA/Wlo6OSdxAjavHl2zH8fqwzcKF4sbNknXGJRWNC1tcDpS2RsnkogM75A0ccZjZGxGdWr35SGPFb4j9JTvnK758YvsOp23JUTk1JGbyQsbmu6AXV/3SV4zYK0xcFAS4iBsblCnpdDKuztU0RyKhYQrb1jUN3CWUYyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873914; c=relaxed/simple;
	bh=uAlx4dafLjCbZtYgu8t26fX22aBqr60jfKSmcDl60po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLTqDNmA11T3biQ0IQGwFTtP4j1v8mVBzp+NmHfkx3YR32wyYWnfYcl6w88IpFwbz0AAZMzdtAv2qBCx8p3JCKDAZQXUfS67f3qDCFA8pFZ04CF6Vnx5egSh2GvUIclnZPoKeR2u4vf0Ce76POMNGn85uXw47qRYTqHK2Fhxp5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KawzW3nL; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479810de04bso1986483b6e.1
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776873910; x=1777478710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiAHFmpgwZ9sP0RdkP+eyou4duGN1gqLDfVLn5KxFRw=;
        b=KawzW3nL/CcWmH+3MiPX5GWsbupvUNuArV8VZV1oCztlL0b8bB3mH/mJJfIEJkAvvv
         staPB2FJLdHNjlOxAIbcfT2uPvdCAXb+Ge+9mrgHUV1hJo/lBiCvHQAs6KYZ1Q4Rl++R
         bJ8fa7M3R6T+e6eMFlDXXFC3pZrWonGLg8Xe9DrDrfpj55CQ8bo4dlaStqtKvWMoMLQQ
         x3oQv2/juQXq7ch/RWvzhbMfNX15ztY/n7TSnPPn/HB697441i5xoFAQQ897hNL8FfiI
         gBiIfwYNf2Judc2/R++nzck7KQ3US71k8uuQOdDMDT6UEdFtPJJgjIIT9nUh7qXJnucC
         FYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873910; x=1777478710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiAHFmpgwZ9sP0RdkP+eyou4duGN1gqLDfVLn5KxFRw=;
        b=AmbZBlTtr1AC82muIOmUraPbYOyR1fomwDvmsTLU32sJsUmjHJTWuxaNlfkpeoJYeo
         Cce9hHEFYtyorqPboGc1jbAQXyKLrhM/Q0hPOqZHRseaCpj9+5aS+B42XVlRI2L7SfRc
         j/cNx7S1iHVeH06D4dCIlWEjb5nV0rLrDhXWReB8/J4INBB65MNpclZPsUMSWfP7wIhE
         TWBL5TvCFKLMsPepsOA55QA3GXNZYnhjiKDfn3cW5NFoaXV3Uo/uYwLqSXAvKR3voDeb
         RvZwpbKDb+RvXUM5rhcNGtcAvMv5fnUC/3yT//TNc64w4hIYPb20g1YCHK2XRvrCbcoA
         OrXg==
X-Forwarded-Encrypted: i=1; AFNElJ/5EE8M8wNx8K0lNIMTwT6QmHWCf1F+zK+SlDJFnCLfXLc6X5qpQllaVQSrDI8D2ZnciKHbg84=@vger.kernel.org
X-Gm-Message-State: AOJu0YxViygLySRISPlzTS8tmm8FH1R0ru2ZyI9Bqzo42jyqxApfLc/z
	iGrg5LdvKgGW514qe3Jn/xpGyrymh8V188dE0Ha4LtSn9taP8969Crhd
X-Gm-Gg: AeBDiet1gbaIstHApp9LtAfcGMtEIoWijtOhG1uKhTFVLUXq1P9fiusm+BqtYMRkn4c
	rn43McnTqTCk5miUjdejhUqfbcj/vcYZzJXgZvbrgr5/uCZEmMObaxMua67QviHr/4bpIZGhDtq
	0iIIRYewcIDYKmgYVzfrMc6TGWitiKYMkZC5poXH5jl1e3U1v32n9NBkNpu/vsW6ERGYjRwxcpu
	HZU1xmKaa3JSLXUu5XtPQ9nlXGosLe2Pt+YO3rZCx3MsmiJX7DMOMpUzb/iU2jkPbGoXYlXtU2S
	QpsUp6tfsEu9pmDi/LlqXniYciYD3rRBrm1OWugFw2e26EaXYAFiRui7P1L7hcN0mHmtqZsPnQt
	I+/mNS87HnnRnzKFm8KG+xQkWGkUCEydAUQ/829b1HN3C34MlyMVQYFtftF7pMW9rSAHK6qxLoZ
	tWZse6jnx63YxSF6wPn5Me7AcxJSxoU/FfCIeYV38ldrytmPgxsQQHcFlAEZPxG3ANje6VtJmQe
	o0fGyOKsZsql8NUflR6BekPtP5xFnahvzSxNq4n9g==
X-Received: by 2002:a05:6808:2515:b0:467:4939:9656 with SMTP id 5614622812f47-4799cae4b0amr12727562b6e.37.1776873910445;
        Wed, 22 Apr 2026 09:05:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm136370786d6.7.2026.04.22.09.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:05:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Michael Bommarito <michael.bommarito@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net 4/6] net/ncsi: validate OEM response payloads before parsing
Date: Wed, 22 Apr 2026 12:03:40 -0400
Message-ID: <20260422160342.1975093-5-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240358-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB7D1448492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reject truncated OEM responses before reading the manufacturer ID,
vendor-specific subheaders, or vendor MAC address payloads.

The OEM response dispatcher reads rsp->mfr_id without verifying that the
skb contains the manufacturer field and checksum. The Mellanox,
Broadcom, and Intel handlers then read their command-specific headers
without checking that the payload is large enough for those fields. The
shared GMA helper finally copies a MAC address from a
manufacturer-specific offset without validating that the payload reaches
that offset.

Validate the advertised payload before each of those reads so malformed
or truncated BMC responses are rejected before the parser touches data
past the end of the skb.

Fixes: fb4ee67529ff ("net/ncsi: Add NCSI OEM command support")
Fixes: cb10c7c0dfd9 ("net/ncsi: Add NCSI Broadcom OEM command")
Fixes: 16e8c4ca21a2 ("net/ncsi: Add NCSI Mellanox OEM command")
Fixes: 205b95fe658d ("net/ncsi: add get MAC address command to get Intel i210 MAC address")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ncsi/ncsi-rsp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
index cbddb2012f90..94354dca23ea 100644
--- a/net/ncsi/ncsi-rsp.c
+++ b/net/ncsi/ncsi-rsp.c
@@ -656,6 +656,7 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	struct net_device *ndev = ndp->ndev.dev;
 	struct ncsi_rsp_oem_pkt *rsp;
 	u32 mac_addr_off = 0;
+	unsigned int payload;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
@@ -668,6 +669,11 @@ static int ncsi_rsp_handler_oem_gma(struct ncsi_request *nr, int mfr_id)
 	else if (mfr_id == NCSI_OEM_MFR_INTEL_ID)
 		mac_addr_off = INTEL_MAC_ADDR_OFFSET;
 
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->mfr_id) + mac_addr_off + ETH_ALEN +
+		      sizeof(__be32))
+		return -EINVAL;
+
 	saddr->ss_family = ndev->type;
 	memcpy(saddr->__data, &rsp->data[mac_addr_off], ETH_ALEN);
 	if (mfr_id == NCSI_OEM_MFR_BCM_ID || mfr_id == NCSI_OEM_MFR_INTEL_ID)
@@ -686,9 +692,14 @@ static int ncsi_rsp_handler_oem_mlx(struct ncsi_request *nr)
 {
 	struct ncsi_rsp_oem_mlx_pkt *mlx;
 	struct ncsi_rsp_oem_pkt *rsp;
+	unsigned int payload;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->mfr_id) + sizeof(*mlx) + sizeof(__be32))
+		return -EINVAL;
+
 	mlx = (struct ncsi_rsp_oem_mlx_pkt *)(rsp->data);
 
 	if (mlx->cmd == NCSI_OEM_MLX_CMD_GMA &&
@@ -702,9 +713,14 @@ static int ncsi_rsp_handler_oem_bcm(struct ncsi_request *nr)
 {
 	struct ncsi_rsp_oem_bcm_pkt *bcm;
 	struct ncsi_rsp_oem_pkt *rsp;
+	unsigned int payload;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->mfr_id) + sizeof(*bcm) + sizeof(__be32))
+		return -EINVAL;
+
 	bcm = (struct ncsi_rsp_oem_bcm_pkt *)(rsp->data);
 
 	if (bcm->type == NCSI_OEM_BCM_CMD_GMA)
@@ -717,9 +733,14 @@ static int ncsi_rsp_handler_oem_intel(struct ncsi_request *nr)
 {
 	struct ncsi_rsp_oem_intel_pkt *intel;
 	struct ncsi_rsp_oem_pkt *rsp;
+	unsigned int payload;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->mfr_id) + sizeof(*intel) + sizeof(__be32))
+		return -EINVAL;
+
 	intel = (struct ncsi_rsp_oem_intel_pkt *)(rsp->data);
 
 	if (intel->cmd == NCSI_OEM_INTEL_CMD_GMA)
@@ -742,10 +763,15 @@ static int ncsi_rsp_handler_oem(struct ncsi_request *nr)
 {
 	struct ncsi_rsp_oem_handler *nrh = NULL;
 	struct ncsi_rsp_oem_pkt *rsp;
+	unsigned int payload;
 	unsigned int mfr_id, i;
 
 	/* Get the response header */
 	rsp = (struct ncsi_rsp_oem_pkt *)skb_network_header(nr->rsp);
+	payload = ncsi_rsp_payload(nr->rsp);
+	if (payload < sizeof(rsp->mfr_id) + sizeof(__be32))
+		return -EINVAL;
+
 	mfr_id = ntohl(rsp->mfr_id);
 
 	/* Check for manufacturer id and Find the handler */
-- 
2.53.0


