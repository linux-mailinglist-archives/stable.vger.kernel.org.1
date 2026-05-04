Return-Path: <stable+bounces-243726-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFPQKras+GkixwIAu9opvQ
	(envelope-from <stable+bounces-243726-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD5E4BF715
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21CC430305A3
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F6D3DE454;
	Mon,  4 May 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyhsOUaY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A53D3334;
	Mon,  4 May 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904619; cv=none; b=iFiwyjIgWVfIMzbFWSxzTNOvbFXo7SBPBVCbR3DtitCAJ579h1WPMF8LFbMgSNAA7qbDu75sgy2c+BuGwwCf1PytkBdUN+yqgv8wj3xxSKHL//myeiU7cjzE/hx6JCuNGI/3K3hRMj+c9PMKduSc5HajXxETZjNS81SKa0zs8iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904619; c=relaxed/simple;
	bh=hcHsWSaa6jVW26wYf/mkku0uSj/G0uAkfEnhVRNkd4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYdbD9aOJom7iu6xwvo6+LuAAmg+n7AvytATRaQo92PJo/J0/pumeDkImVOamyVHL+JZTDtxg/YGe5Nt7wwXl4FLZMQ3pPFlznwUXKgQWosd1Y3mf65tcx3SGJG74oogcKdlM9K7od/p7oC0kSn2vnriBYk8OOZQsgc2DJKctek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyhsOUaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7037FC2BCB8;
	Mon,  4 May 2026 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904619;
	bh=hcHsWSaa6jVW26wYf/mkku0uSj/G0uAkfEnhVRNkd4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyhsOUaYzlNFLlxN9N3wc+Xp65efOyXFxuedAkrgX3/sd9GArq7Oc70tQ4SqXCNN+
	 8zKGWz2tBwZSgWCV6i7vjgir+oZo72eMdfhQG5BVwbsbx21ZEWFtGjqUVknFsPf9k9
	 NUMNclXpUCWyRsNrYWhi3thvoXxpWLlINNwGDjgM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 6.12 110/215] pwm: imx-tpm: Count the number of enabled channels in probe
Date: Mon,  4 May 2026 15:52:09 +0200
Message-ID: <20260504135134.168299772@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5AD5E4BF715
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243726-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[i.mx:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nxp.com:email,msgid.link:url]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>

commit 3962c24f2d14e8a7f8a23f56b7ce320523947342 upstream.

On a soft reset TPM PWM IP may preserve its internal state from previous
runtime, therefore on a subsequent OS boot and driver probe
"enable_count" value and TPM PWM IP internal channels "enabled" states
may get unaligned. In consequence on a suspend/resume cycle the call "if
(--tpm->enable_count == 0)" may lead to "enable_count" overflow the
system being blocked from entering suspend due to:

   if (tpm->enable_count > 0)
       return -EBUSY;

Fix the problem by counting the enabled channels in probe function.

Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
Fixes: 738a1cfec2ed ("pwm: Add i.MX TPM PWM driver support")
Link: https://patch.msgid.link/20260311123309.348904-1-viorel.suman@oss.nxp.com
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pwm/pwm-imx-tpm.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -352,7 +352,7 @@ static int pwm_imx_tpm_probe(struct plat
 	struct clk *clk;
 	void __iomem *base;
 	int ret;
-	unsigned int npwm;
+	unsigned int i, npwm;
 	u32 val;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
@@ -382,6 +382,13 @@ static int pwm_imx_tpm_probe(struct plat
 
 	mutex_init(&tpm->lock);
 
+	/* count the enabled channels */
+	for (i = 0; i < npwm; ++i) {
+		val = readl(base + PWM_IMX_TPM_CnSC(i));
+		if (FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val))
+			++tpm->enable_count;
+	}
+
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");



