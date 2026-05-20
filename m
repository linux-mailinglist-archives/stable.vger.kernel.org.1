Return-Path: <stable+bounces-251631-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KZHNNj2DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251631-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:00:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 988445951AE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B033308A79E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73172369D67;
	Wed, 20 May 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fUb5t+5z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186C28DC4;
	Wed, 20 May 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298485; cv=none; b=jM83/A0avhXoj6vdxnvZisOjr6BFnQ9G+uPUq+K7gIzjfkc6dC3L8qnUflhCvbagn4i6s3Opci+KY9lhoGcKY6042SDdGEd20uMC95wiHqvVU0BKcucmfenBOA6bGBEY4po3n9tYDIy43qvm8ZLrsv3ul2U4dYkc4rWCpBbI0Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298485; c=relaxed/simple;
	bh=HMgqyjFWDYquMCJYHq2pa+HR6hEpCQ3i0WqcoRlBbL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBv8hBdOhy7fWsy0SCj9APUU7hf2tFFQqAZWFH1QZCRDoV5UGpQOqepuofn5fE6Rbbx1qAvwBTPC6H/Dmsokvhc/uPei0TIo9LUfoHBhBby7BDgdV1/p6ZOTObBq6FmyeDeAorH3/lLsIQpEA9+YBcKv32eFuDdYk6v5NprD1UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fUb5t+5z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61D61F000E9;
	Wed, 20 May 2026 17:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298484;
	bh=IL/e0A4d4mDFFT0f6iitANJzYtY4zTX9bjAhwi3mm4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUb5t+5zk2z/k+klAYp5+Ddn2ub4NbQq43cLs6OMFPUfxp0a72Vc56t/38NIPaFlA
	 7670C8h4MnQL0ix9XNtBzpKSagtkq6p9HQBFhsruolTJ2re3GeXaI1Ji54Zo6OK7k0
	 w5RqgK6HrDRiLTbAL5tOso64d72sdIX4YwhM+N+Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sumit Gupta <sumitg@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 427/957] soc/tegra: cbb: Set ERD on resume for err interrupt
Date: Wed, 20 May 2026 18:15:10 +0200
Message-ID: <20260520162143.782221632@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251631-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 988445951AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit b6ff71c5d1d4ad858ddf6f39394d169c96689596 ]

Set the Error Response Disable (ERD) bit to mask SError responses
and use interrupt-based error reporting. When the ERD bit is set,
inband error responses to the initiator via SError are suppressed,
and fabric errors are reported via an interrupt instead.

The register is set during boot but the info is lost during system
suspend and needs to be set again on resume.

Fixes: fc2f151d2314 ("soc/tegra: cbb: Add driver for Tegra234 CBB 2.0")
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/tegra/cbb/tegra234-cbb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/tegra/cbb/tegra234-cbb.c b/drivers/soc/tegra/cbb/tegra234-cbb.c
index a9adbcecd47cc..518733a066588 100644
--- a/drivers/soc/tegra/cbb/tegra234-cbb.c
+++ b/drivers/soc/tegra/cbb/tegra234-cbb.c
@@ -1586,6 +1586,10 @@ static int __maybe_unused tegra234_cbb_resume_noirq(struct device *dev)
 {
 	struct tegra234_cbb *cbb = dev_get_drvdata(dev);
 
+	/* set ERD bit to mask SError and generate interrupt to report error */
+	if (cbb->fabric->off_mask_erd)
+		tegra234_cbb_mask_serror(cbb);
+
 	tegra234_cbb_error_enable(&cbb->base);
 
 	dev_dbg(dev, "%s resumed\n", cbb->fabric->fab_list[cbb->fabric->fab_id].name);
-- 
2.53.0




