Return-Path: <stable+bounces-265580-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YN+FE7GLMWoMmQUAu9opvQ
	(envelope-from <stable+bounces-265580-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:45:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D30D2693718
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:45:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=S7pJyP8v;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265580-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265580-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 51D87303C52C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C73C276B;
	Tue, 16 Jun 2026 17:45:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A103CFF4B;
	Tue, 16 Jun 2026 17:45:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631916; cv=none; b=MShNhR3AFCfogmC2ta0f2ZRJfN3WgYi170kXARRLid8fmi8QxhuVegdYdKGcob05FNb3qnwrInUPhUY/QUoi2ieqAq/+/a6QFJWDbhJa+x3WjQLvXTRim1sbOwTVixAfI9CjTjrs/w9kyQcg6J2NU178e9yRofWv+sb7r3gurJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631916; c=relaxed/simple;
	bh=GWGCEBHUe3NcmDkQzGMBB41lBcYO6RHjdnuIYHc/nW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQzqY2VfslZb1ImEJfeltZEJ6vXVmjJZWztzLGUW2iPVAUPGNTt3gtrB4wXfOgQ9Z2taLWuqVBsBWL0/0TvqZdPhU/aisj1Co/P2Bg0BA0berNHn0BYE659kBz4ANv0p2SuWgPdTrQxLHxoOfy6rmlZA+GZP82+LOqqNm0L9YLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S7pJyP8v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79EA41F000E9;
	Tue, 16 Jun 2026 17:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631915;
	bh=UlUVFghqoMCmuc8eaIl+8m1NWLTSqccXfCB54yeVCiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7pJyP8viv7AuCMzpZWouOYIiqJa1C7xCCHtOr5bHpdjifZKssEp3hQVxaPYV+duD
	 wLPHqCsO959jewe1k5Dl9uSfkPZTxmQy+kLmMULjJDzsTVtsWHC4SzNsTDrT0wAJQw
	 tzV6+ue1SVioTYAi3RRnliOJQ5ZBLn3TVFUgxv4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jisheng Zhang <jszhang@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH 6.1 312/522] mmc: sdhci: add signal voltage switch in sdhci_resume_host
Date: Tue, 16 Jun 2026 20:27:39 +0530
Message-ID: <20260616145140.471230474@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265580-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:jszhang@kernel.org,m:adrian.hunter@intel.com,m:ulfh@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D30D2693718

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3823,6 +3823,7 @@ int sdhci_resume_host(struct sdhci_host
 		host->pwr = 0;
 		host->clock = 0;
 		host->reinit_uhs = true;
+		mmc->ops->start_signal_voltage_switch(mmc, &mmc->ios);
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
 		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));



