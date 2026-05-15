Return-Path: <stable+bounces-248564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK7mISpNB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:43:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 281AE553CCF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEC63024A0B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566713E929C;
	Fri, 15 May 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B1dmyhUk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C513E7BAE;
	Fri, 15 May 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862054; cv=none; b=lx7pL6fkIYy6HmKMmLK5j2gSISHe4PaLPLDB61DI3a69vB8ZkYtQ6aASmi41M2BAZPBiSXCKaADdwcOdcc/1QFAfBl+ev7y17r4tlli5gOoDp7ztptBPYhQ5Oay4AJwpfZ2vGgP39cGCSVzUoyvl+zrz3TWFaIC+376/P/mNEZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862054; c=relaxed/simple;
	bh=9JRcI4gXvTVRV/RXlmo/g+EnGdbIrHeiHSfwI+JJ9wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdAseJFzttR1a/q7lBs15R/VGxhHw8lZ3Af07r9jkvVNo5upixvxjjekeS12aaRNSl06yIvH3G94N02Ra36tL2uMVTnI64BQaIku7ZYnpMSbVhfEFHb9UNfsusaoT7bXQMRNIbQ0TdSXd80QhbTrquxG3ItpK9AATHxzS+3M8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B1dmyhUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DC3C2BCB3;
	Fri, 15 May 2026 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862054;
	bh=9JRcI4gXvTVRV/RXlmo/g+EnGdbIrHeiHSfwI+JJ9wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B1dmyhUk/0i1kG89maP5n70xqa4yeKOfInvBzcTTp8hpTiwceYveDoKeniDQbTC/5
	 OCD98fCsAtjepRQ22k9kSPndzD3wC1u794jEK+G+GGrq+ccfev75r1p34axjhpiGO+
	 AOlkTEohZtSgiobIakbPO69IKvzOzzI26ijHJ+Lc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 090/188] spi: orion: fix clock imbalance on registration failure
Date: Fri, 15 May 2026 17:48:27 +0200
Message-ID: <20260515154659.279294664@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 281AE553CCF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248564-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux.org.uk:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 443cde0dc59c5d154156ac9f27a7dadef8ebc0c2 upstream.

Make sure that the controller is not runtime suspended before disabling
clocks on probe failure.

Also restore the autosuspend setting.

Fixes: 5c6786945b4e ("spi: spi-orion: add runtime PM support")
Cc: stable@vger.kernel.org	# 3.17
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260421130211.1537628-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-orion.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -774,6 +774,7 @@ static int orion_spi_probe(struct platfo
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	status = orion_spi_reset(spi);
@@ -785,10 +786,15 @@ static int orion_spi_probe(struct platfo
 	if (status < 0)
 		goto out_rel_pm;
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return status;
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 out_rel_axi_clk:
 	clk_disable_unprepare(spi->axi_clk);
 out:



