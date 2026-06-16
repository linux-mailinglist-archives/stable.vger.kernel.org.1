Return-Path: <stable+bounces-265160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jPPEGvGEMWrzlQUAu9opvQ
	(envelope-from <stable+bounces-265160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9561692F28
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:16:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=qdf10Bqy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265160-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265160-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92CF93043F83
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9CC466B70;
	Tue, 16 Jun 2026 17:09:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299CD38F930;
	Tue, 16 Jun 2026 17:09:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629779; cv=none; b=OUqALq9ZlgbBJ9n3fAOsrGMv6PnwodHXXrhpv9MnJ7J0ct8VA415oT7XL72Iu/1qLDaw+p5Mtx4SQCP4zf43LfEyBMuGL34ApXM9XzJEAAitsn7GemjFgBtN1CuYj+bVqRCnwye7OBCZSs7iG9J/80l5pxoJr/7DhC31u1Eun/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629779; c=relaxed/simple;
	bh=19pQW1riDshR2mx5hmU0+urpcP/mjY3VAGWR+6WFG0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIPrPA/GUyYwimzYR1oaDq3jr7vMKNOgj2rcfMbl0z2N6IZ/EVqpxQzfD0wvjvj80KTNps5caiwm0jREzzfurLN6YYH99O0a3g61oA8hL3idBApa7qOoEve2mQTJV/ZK2Vfm01mXH1+O7q3jmCC0u99FQzVi8QlNrImN2OLGknY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdf10Bqy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA221F000E9;
	Tue, 16 Jun 2026 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629777;
	bh=WYLFbQtaNSghKGLLkxDLcBC8OzC6AYX1f8qrJtu5314=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qdf10BqyQ9b8vdyTU3Xh16Afab1KOx2doQFqsF5SOdPnoTcwOL26d9T4sOlw+yk/J
	 Nvp/bWUdm6S49EQ1oHcaw3xSMzVSPR/JuyWirMlBObwZQtuBQLHbl5ZZ4zmyHT98ME
	 f3wpussezwfG1JhKQEZu8nYivE1XG25g59u+rVHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jisheng Zhang <jszhang@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH 6.6 351/452] mmc: sdhci: add signal voltage switch in sdhci_resume_host
Date: Tue, 16 Jun 2026 20:29:38 +0530
Message-ID: <20260616145135.636840559@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jszhang@kernel.org,m:adrian.hunter@intel.com,m:ulfh@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B9561692F28

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jisheng Zhang <jszhang@kernel.org>

commit f595e8e77a51eee35e331f69321766593a845ef2 upstream.

I met one suspend/resume issue with sdr104 capable sdio wifi card (with
"keep-power-in-suspend" set in DT property):
After resuming from suspend to ram, the sdio wifi card stops working.
Further debug shows that although ios shows the sdio card is at sdr104
mode, the voltage is still at 3V3. This is due to missing the calling
of ->start_signal_voltage_switch() in sdhci_resume_host().

Fix this issue by adding ->start_signal_voltage_switch() in
sdhci_resume_host(). This also matches what we do for
sdhci_runtime_resume_host().

Then the question is: why this issue hasn't reported and fixed for so
long time. IMHO, several reasons: Some host controllers just kick off
the runtime resume for system resume, so they benefit from the well
supported runtime pm code; Some platforms just use the old sdio wifi
card which doesn't need signal voltage switch at all, the default
voltage is 3v3 after resuming.

Fixes: 6308d2905bd3 ("mmc: sdhci: add quirk for keeping card power during suspend")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3800,6 +3800,7 @@ int sdhci_resume_host(struct sdhci_host
 		host->pwr = 0;
 		host->clock = 0;
 		host->reinit_uhs = true;
+		mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
 		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));



