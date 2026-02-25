Return-Path: <stable+bounces-218273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF87AGVRnmmbUgQAu9opvQ
	(envelope-from <stable+bounces-218273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:33:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B6118EFD5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D6DF3097555
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3077F251793;
	Wed, 25 Feb 2026 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBzW7Uok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E3A1D5ABA;
	Wed, 25 Feb 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983073; cv=none; b=DVQJgq5ANrPkk67Y/tN8TtDWu7My4oeeTFtiG9fOt3oaKsBKCcXBFJLb9jyDfKMKyqk5jg7S/3D1o1GDG6qbpLtIYsN55K/SBmBdHnAdeqJZ67O+qUFNAx3D7WoFl6QzQM1HHLbWthzpEU0UtMVfE1PoZQg8GSaWJ/POlmnb5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983073; c=relaxed/simple;
	bh=7myCAk+HLaMcVNdM8GHqX+4R/g1r2YVfr2yuKPJs+JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsD1VvU84NIUs0P9rEKuAzeIv1nkdrV0zaSYJhY1CUY/BJ2MAXS0zV5ZeCSeZp+Soq0DV40izNXcNJ8ZJDqs/QmsaRNXnIQ7GdukbMAmQcz/aDXwq4w9e07SYIAl8nfLPRD3B7WRfJ7leRK/5Q1EuuEZIOezwCapKxKr8H9xtK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBzW7Uok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8711C116D0;
	Wed, 25 Feb 2026 01:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983072;
	bh=7myCAk+HLaMcVNdM8GHqX+4R/g1r2YVfr2yuKPJs+JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mBzW7UokuBybNkow9t6ba/2W1HUGEBD8NwPbz9ivjwhBs3d5hZW3KWGSq7rVECOwI
	 cN3H4aUuBvdns1Rc1BjePn/JJj83G/nRvIYY6T/XQA0jWbR/pJQtGVaAkjTM7gUhhb
	 1eIm418IQ7vvhZyVlMw0TrFMcwGWUQA6Nk3IW/Ro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 235/781] ASoC: nau8821: Cancel pending work before suspend
Date: Tue, 24 Feb 2026 17:15:44 -0800
Message-ID: <20260225012405.473910363@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218273-lists,stable=lfdr.de];
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
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D4B6118EFD5
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 7786b10688ac0ebeaff655923cbb2c7d34a98995 ]

A jack detection work that is unscheduled or in progress while executing
the suspend handler could trigger a race condition.

Ensure state consistency by cancelling any pending work or wait for its
execution to complete before processing the suspend.  Since driver
(re)enables both insert and eject interrupts on resume, there is no risk
to miss the related jack events.  Therefore, flush_delayed_work() is not
required here.

Fixes: aab1ad11d69f ("ASoC: nau8821: new driver")
Fixes: ee70bacef1c6 ("ASoC: nau8821: Avoid unnecessary blocking in IRQ handler")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://patch.msgid.link/20251231-nau8821-cleanup-v1-3-6b0b76cbbb64@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/nau8821.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/nau8821.c b/sound/soc/codecs/nau8821.c
index 2e2714b475012..58d2d5e77c8f4 100644
--- a/sound/soc/codecs/nau8821.c
+++ b/sound/soc/codecs/nau8821.c
@@ -1605,6 +1605,10 @@ static int __maybe_unused nau8821_suspend(struct snd_soc_component *component)
 
 	if (nau8821->irq)
 		disable_irq(nau8821->irq);
+
+	if (nau8821->jdet_active)
+		cancel_delayed_work_sync(&nau8821->jdet_work);
+
 	snd_soc_dapm_force_bias_level(nau8821->dapm, SND_SOC_BIAS_OFF);
 	/* Power down codec power; don't support button wakeup */
 	snd_soc_dapm_disable_pin(nau8821->dapm, "MICBIAS");
-- 
2.51.0




