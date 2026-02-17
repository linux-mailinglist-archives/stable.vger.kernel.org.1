Return-Path: <stable+bounces-216913-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MHICijSlGmfIAIAu9opvQ
	(envelope-from <stable+bounces-216913-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:40:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C092150050
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D78653032F4A
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268E8377556;
	Tue, 17 Feb 2026 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s25QssMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8DE36F431;
	Tue, 17 Feb 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360783; cv=none; b=Ncm/oX6fweEX0hU/l9gNd1VUznJ7hzvkdn8tlVTfDwGTSq4/+JUtE7pFH5UEKtIEu6SsE43DnCIhh/MoJfCBJC2Zff/cFGTTsXLVe0c0+Z9hMk9N7KddVS3iBrGyjwRYiC+TFm7rJKF+Dtlfn304et3wqvJsZZI9TjSiCOxl0m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360783; c=relaxed/simple;
	bh=ncWwLSugdcTYnmAQTtyqQw2fwywBWqth0+TACQFuEFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFjWdQQjNzmKTeGJjIxoLtNXRl8Yat9aC54y3VhNpOZ8CfLcWtGYLZmSFWTGDxTXgrV0bYUSyvgV9hzMetSRpf0MyfGHWYTQe2XukJVn65PBNibnDJfWR18ePD/l6QuF5YjSeQyRBXP00RTxNT+0aVAT82sc2XhcxgXK+nOHJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s25QssMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D34AC4CEF7;
	Tue, 17 Feb 2026 20:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771360783;
	bh=ncWwLSugdcTYnmAQTtyqQw2fwywBWqth0+TACQFuEFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s25QssMvHUCkA71lhJ4ismsQ1/82vikSe/0RSv3RGT0W2E4XKU9MPCvDWCDIPLBdy
	 9zLJnFBxFmsO1a6kN04fQsSRohBR82aBF2kRMxnsWSb3lcGzRsPN/dFYsMDzqyl6u/
	 /GGWtoY9l9qJirzG7hb6fbjjKapc2qmfy2vHu5a8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tagir Garaev <tgaraev653@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 14/39] ASoC: Intel: sof_es8336: Add DMI quirk for Huawei BOD-WXX9
Date: Tue, 17 Feb 2026 21:30:36 +0100
Message-ID: <20260217200004.774916892@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200004.221651386@linuxfoundation.org>
References: <20260217200004.221651386@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216913-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7C092150050
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tagir Garaev <tgaraev653@gmail.com>

[ Upstream commit 6b641122d31f9d33e7d60047ee0586d1659f3f54 ]

Add DMI entry for Huawei Matebook D (BOD-WXX9) with HEADPHONE_GPIO
and DMIC quirks.

This device has ES8336 codec with:
- GPIO 16 (headphone-enable) for headphone amplifier control
- GPIO 17 (speakers-enable) for speaker amplifier control
- GPIO 269 for jack detection IRQ
- 2-channel DMIC

Hardware investigation shows that both GPIO 16 and 17 are required
for proper audio routing, as headphones and speakers share the same
physical output (HPOL/HPOR) and are separated only via amplifier
enable signals.

RFC: Seeking advice on GPIO control issue:

GPIO values change in driver (gpiod_get_value() shows logical value
changes) but not physically (debugfs gpio shows no change). The same
gpiod_set_value_cansleep() calls work correctly in probe context with
msleep(), but fail when called from DAPM event callbacks.

Context information from diagnostics:
- in_atomic=0, in_interrupt=0, irqs_disabled=0
- Process context: pipewire
- GPIO 17 (speakers): changes in driver, no physical change
- GPIO 16 (headphone): changes in driver, no physical change

In Windows, audio switching works without visible GPIO changes,
suggesting possible ACPI/firmware involvement.

Any suggestions on how to properly control these GPIOs from DAPM
events would be appreciated.

Signed-off-by: Tagir Garaev <tgaraev653@gmail.com>
Link: https://patch.msgid.link/20260201121728.16597-1-tgaraev653@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_es8336.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index c9d9381c76796..02b74ab62ff58 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -332,6 +332,15 @@ static int sof_es8336_quirk_cb(const struct dmi_system_id *id)
  * if the topology file is modified as well.
  */
 static const struct dmi_system_id sof_es8336_quirk_table[] = {
+	{
+		.callback = sof_es8336_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BOD-WXX9"),
+		},
+		.driver_data = (void *)(SOF_ES8336_HEADPHONE_GPIO |
+					SOF_ES8336_ENABLE_DMIC)
+	},
 	{
 		.callback = sof_es8336_quirk_cb,
 		.matches = {
-- 
2.51.0




