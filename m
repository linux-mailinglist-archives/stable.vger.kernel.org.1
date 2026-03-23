Return-Path: <stable+bounces-228845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA44FMhWwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:05:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5182F5C20
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F2CE30711F1
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B08F2741A0;
	Mon, 23 Mar 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gFyYgNzr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36D23EAB2;
	Mon, 23 Mar 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277287; cv=none; b=r3ldC1sK5sVlDlR4h8kvTiOEdba1WwaNl7JW7OBtcirp1s8u+GWUhfxSJAmd1XVq7hP6OPLlvKauuE8EdOBafhEHDX7aztJbKE29dYnmSPxC0FQq2SCMsHjfgfc43v5rD6Jsav5ZShN2fXPOvS33yZCHJyZxGzB5SDk6vAq21+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277287; c=relaxed/simple;
	bh=h9CDDMmAcG2W0i1KkPP8AlECMiQE2OEarqPggBFWDyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=riwPUs9Lk/K544QFNi9tB7UQ6YNjgcKDNt7cKB8WWkQyrxZcP7mA4Fkia1K17bCopqKmm0C/Cff6aoOOpUtWdpUlCe2JRuBHkD7Cn/RCg8bu8a3dMp1ba9enhx8pfYXhl+xpkWitL+mL9qtVRp0tc4IRrtrhn8rYgOkT3Mh4e+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gFyYgNzr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3259C4CEF7;
	Mon, 23 Mar 2026 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277287;
	bh=h9CDDMmAcG2W0i1KkPP8AlECMiQE2OEarqPggBFWDyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFyYgNzrsfaU13KcTchBXjnmJsW/qMfAE//QJAaqjq/jSdWCKkhDtCZ00jySvwnqu
	 parst0rePKwyrv5izX1LYLSUSf4Fkmf7KJZOZAsXmGsV2TIR1DhFHoAoDsocuPZzxb
	 ohxx4L+fFgmW9AfRSAUMwI9e1HA+TLLa8YYExydM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Olivier Sobrie <olivier@sobrie.be>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.12 340/460] mtd: rawnand: pl353: make sure optimal timings are applied
Date: Mon, 23 Mar 2026 14:45:36 +0100
Message-ID: <20260323134534.889205629@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228845-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4A5182F5C20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Olivier Sobrie <olivier@sobrie.be>

commit b9465b04de4b90228de03db9a1e0d56b00814366 upstream.

Timings of the nand are adjusted by pl35x_nfc_setup_interface() but
actually applied by the pl35x_nand_select_target() function.
If there is only one nand chip, the pl35x_nand_select_target() will only
apply the timings once since the test at its beginning will always be true
after the first call to this function. As a result, the hardware will
keep using the default timings set at boot to detect the nand chip, not
the optimal ones.

With this patch, we program directly the new timings when
pl35x_nfc_setup_interface() is called.

Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -862,6 +862,9 @@ static int pl35x_nfc_setup_interface(str
 			  PL35X_SMC_NAND_TAR_CYCLES(tmgs.t_ar) |
 			  PL35X_SMC_NAND_TRR_CYCLES(tmgs.t_rr);
 
+	writel(plnand->timings, nfc->conf_regs + PL35X_SMC_CYCLES);
+	pl35x_smc_update_regs(nfc);
+
 	return 0;
 }
 



