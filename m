Return-Path: <stable+bounces-228314-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K5IGnNOwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228314-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85E2F4A03
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB48D3180DE1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695083B0ADB;
	Mon, 23 Mar 2026 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NyUMc5PX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CADA3ACEFE;
	Mon, 23 Mar 2026 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274780; cv=none; b=I6XYBjfZuVpWdwN9EB1/Z2BfEaq1UooMGCEHyHMucvLJ9QnxRYZ9vRtzSejS1TQvQ9z7U3mtf24Ig20mTu4lLx917gbkE2POj02ttltR3CqlorXrOrKeOPh0rvMHTtbB1ohP5UAjKDBxsBg37i4F88jMrCec6aS+lDLb0GrGzc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274780; c=relaxed/simple;
	bh=DbFnt+cqXJUfKaOup4Za2s2rrJ7budjCM+N6dqubImM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpO0JwLbFg1xZ8uj1qy4yZOjGIhl/oRALJFmz7O3UKVUQ5357ALul+5+fjLUEFEN9z5383QKToumA2t/+UTwH1twTAhdUI9IX1KpI1P2V2WldQbZjvB2oKX3PIa0P/zRm4RnEVQOKduAZNmsK5CoebJYl3mIKQlQ+Ae5mOAOtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NyUMc5PX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659B6C4CEF7;
	Mon, 23 Mar 2026 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274779;
	bh=DbFnt+cqXJUfKaOup4Za2s2rrJ7budjCM+N6dqubImM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NyUMc5PXuS3aVJh7MaLIVzX41pNYd3rwKEOzm4XzdSmkYvykfWgxw0HdbhYfY9FJ1
	 w7npkqlwj//IH9aAwqluIdeF9BNQV1EURWowN5oHGYmRqNYyzMf5l9IENnw+jjyVXt
	 ZYh2NJhd4ryAX3vHoRD545Ju4qwdetsiB8munzt8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Herve Codina <herve.codina@bootlin.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 106/212] soc: fsl: cpm1: qmc: Fix error check for devm_ioremap_resource() in qmc_qe_init_resources()
Date: Mon, 23 Mar 2026 14:45:27 +0100
Message-ID: <20260323134507.132866507@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228314-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DC85E2F4A03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 3f4e403304186d79fddace860360540fc3af97f9 ]

Fix wrong variable used for error checking after devm_ioremap_resource()
call. The function checks qmc->scc_pram instead of qmc->dpram, which
could lead to incorrect error handling.

Fixes: eb680d563089 ("soc: fsl: cpm1: qmc: Add support for QUICC Engine (QE) implementation")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Acked-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/20260209015904.871269-1-nichen@iscas.ac.cn
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/fsl/qe/qmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qmc.c b/drivers/soc/fsl/qe/qmc.c
index da5ea6d356184..6db5ab05c2c1c 100644
--- a/drivers/soc/fsl/qe/qmc.c
+++ b/drivers/soc/fsl/qe/qmc.c
@@ -1799,8 +1799,8 @@ static int qmc_qe_init_resources(struct qmc *qmc, struct platform_device *pdev)
 		return -EINVAL;
 	qmc->dpram_offset = res->start - qe_muram_dma(qe_muram_addr(0));
 	qmc->dpram = devm_ioremap_resource(qmc->dev, res);
-	if (IS_ERR(qmc->scc_pram))
-		return PTR_ERR(qmc->scc_pram);
+	if (IS_ERR(qmc->dpram))
+		return PTR_ERR(qmc->dpram);
 
 	return 0;
 }
-- 
2.51.0




