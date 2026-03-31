Return-Path: <stable+bounces-232202-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCKZOEQFzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232202-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:32:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0235036EE78
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F4E316EBCD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB90421EE4;
	Tue, 31 Mar 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yKgVm96Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6369629DB8F;
	Tue, 31 Mar 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976140; cv=none; b=FkIZ+tHsn9bC918TKDR+/sqt3lO6Wlk/lk2mDHCS0QbkYCZDIQODH3aO+0LHkC2h7EgbZONvctzxymLmI+dJ4kNH1H8RhpzuM7gAZPu0gAeE4siGxj25YWd62lt0uT6kn/bqdi3ijfUcjKvjqQUMJAWvF56fE4Rwab1poqbbpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976140; c=relaxed/simple;
	bh=169vhHp8n1YyA7GjULFAd1ka0a2mjaPEUGrXQNqAcXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FcZ9ifmqyQCB0xXjMrorRBffXwMjM8k651usIb4PvEEDP8YLHhSm9Dg/5bappPdUEfTc1o9gMKtlTUiOGMUl66M96gIJ7qoEiOsfM33dcCPqy5vVgIlR5q6X0SZ12gujLGyaResxA352ibKkRLPl4PcXH5xz0TGLd3l9QGwPIds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yKgVm96Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6532C19423;
	Tue, 31 Mar 2026 16:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976140;
	bh=169vhHp8n1YyA7GjULFAd1ka0a2mjaPEUGrXQNqAcXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yKgVm96QUHZ0pkDPAhFDb/ys/ZiWY7yWNGgaUQizkslaW/AKbZk8/2wazLBG6v+tX
	 VIR+TtGRhJraiFUkY0rNpMPWb5AsCnU+CRM22w5/Aoqmj2EU4krTQp25GJADsElaLB
	 sHQnSqp6JKN2aoxJgFsH099MT7Ockc3LDlCszzg0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 223/244] ASoC: ak4458: Convert to RUNTIME_PM_OPS() & co
Date: Tue, 31 Mar 2026 18:22:53 +0200
Message-ID: <20260331161750.004563495@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232202-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,suse.de:email,cirrus.com:email]
X-Rspamd-Queue-Id: 0235036EE78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 9f9c8e9064ea8ceb13540a283f08550c097bb673 upstream.

Use the newer RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() macros
instead of SET_RUNTIME_PM_OPS() and SET_SYSTEM_SLEEP_PM_OPS() together
with pm_ptr(), which allows us dropping ugly __maybe_unused attributes
and CONFIG_PM ifdefs.

This optimizes slightly when CONFIG_PM is disabled, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20250317095603.20073-4-tiwai@suse.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/ak4458.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/sound/soc/codecs/ak4458.c
+++ b/sound/soc/codecs/ak4458.c
@@ -639,8 +639,7 @@ static void ak4458_reset(struct ak4458_p
 	}
 }
 
-#ifdef CONFIG_PM
-static int __maybe_unused ak4458_runtime_suspend(struct device *dev)
+static int ak4458_runtime_suspend(struct device *dev)
 {
 	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
 
@@ -656,7 +655,7 @@ static int __maybe_unused ak4458_runtime
 	return 0;
 }
 
-static int __maybe_unused ak4458_runtime_resume(struct device *dev)
+static int ak4458_runtime_resume(struct device *dev)
 {
 	struct ak4458_priv *ak4458 = dev_get_drvdata(dev);
 	int ret;
@@ -686,7 +685,6 @@ err:
 	regulator_bulk_disable(ARRAY_SIZE(ak4458->supplies), ak4458->supplies);
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 static const struct snd_soc_component_driver soc_codec_dev_ak4458 = {
 	.controls		= ak4458_snd_controls,
@@ -735,9 +733,8 @@ static const struct ak4458_drvdata ak449
 };
 
 static const struct dev_pm_ops ak4458_pm = {
-	SET_RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(ak4458_runtime_suspend, ak4458_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static int ak4458_i2c_probe(struct i2c_client *i2c)
@@ -809,7 +806,7 @@ MODULE_DEVICE_TABLE(of, ak4458_of_match)
 static struct i2c_driver ak4458_i2c_driver = {
 	.driver = {
 		.name = "ak4458",
-		.pm = &ak4458_pm,
+		.pm = pm_ptr(&ak4458_pm),
 		.of_match_table = ak4458_of_match,
 		},
 	.probe = ak4458_i2c_probe,



