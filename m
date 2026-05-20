Return-Path: <stable+bounces-250064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLH+J9jiDWpF4gUAu9opvQ
	(envelope-from <stable+bounces-250064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9945921C7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 294D33095FB6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1733F20EE;
	Wed, 20 May 2026 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4WlWWgd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA13EFFD6;
	Wed, 20 May 2026 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294452; cv=none; b=X2OJd1OdtmVC7tzZLRbs8pIhvDqK7iLzRSzJPYLew6uRt71w9zcPPk+wm8ZbjrN7UH+WJfyBdATA9qpQz+2hUky3TErZKbVTv6swe6BFIyvFrYjPnU9BiacdLMam+NxTPF+SgJiRW1kSScUid0cDxR6VCG5io3oDcyiHZLWd58M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294452; c=relaxed/simple;
	bh=B0rDuuVVDmWlKF+EidnSFucnOCCpYbmAvxH3P9VYKNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prRYMmBU+L3E+2PSxtgiC0f2En42zwqnxyZviVg69JsW0bOLiH73z2uQiMNfSWLdUnECYy+3g4G54em3iU6Qm/YtSPIEpRBAB8e8a8XIggXNIN3TmkiBHSlY0377gp+NEe9NHPtFsNxCeGMErTikdWX4ew/mETXV7WU8m71KNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4WlWWgd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DB51F00893;
	Wed, 20 May 2026 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294450;
	bh=QXDttnUwp87QN0nDRunJZqafZuvAEkFEb3vU3b8pVIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n4WlWWgdqwyszP6SFCaTc7vnLwbM+dILyzLskH9d0/KcE0LdzmDyLLuzXTm88K936
	 O8uXMfeWC8cDikxM5m1mwfNsM/mDil9RzU97UIdwTSx1EA/Ctrrr7hD7Q6aNpOip71
	 OwbMBG0mdx6AMPU0ISHxp0+VYJvPXYFUKXSGCpaI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0045/1146] irqchip/irq-pic32-evic: Address warning related to wrong printf() formatter
Date: Wed, 20 May 2026 18:04:55 +0200
Message-ID: <20260520162149.399779864@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250064-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 4E9945921C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 86be659415b0ddefebc3120e309091aa215a9064 ]

This driver is currently only build on 32 bit MIPS systems. When building
it on x86_64, the following warning occurs:

    drivers/irqchip/irq-pic32-evic.c: In function ‘pic32_ext_irq_of_init’:
    ./include/linux/kern_levels.h:5:25: error: format ‘%d’ expects argument of type
     ‘int’, but argument 2 has type ‘long unsigned int’ [-Werror=format=]

Update the printf() formatter in preparation for allowing this driver to
be compiled on all architectures.

Fixes: aaa8666ada780 ("IRQCHIP: irq-pic32-evic: Add support for PIC32 interrupt controller")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260222-irqchip-pic32-v1-1-37f50d1f14af@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-pic32-evic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index e85c3e3007018..325b97a0287f6 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -196,7 +196,7 @@ static void __init pic32_ext_irq_of_init(struct irq_domain *domain)
 
 	of_property_for_each_u32(node, pname, hwirq) {
 		if (i >= ARRAY_SIZE(priv->ext_irqs)) {
-			pr_warn("More than %d external irq, skip rest\n",
+			pr_warn("More than %zu external irq, skip rest\n",
 				ARRAY_SIZE(priv->ext_irqs));
 			break;
 		}
-- 
2.53.0




