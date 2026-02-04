Return-Path: <stable+bounces-213959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI9RLjhsg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-213959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:56:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B18E9A1B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2790D3075A1A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B48423A7A;
	Wed,  4 Feb 2026 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvuVkUd5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE42BE03C;
	Wed,  4 Feb 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218084; cv=none; b=PvfveiMFtXKiz83Rjyn9vD32F4RUNO7RFaosehRRKg8nnuqB9lusCREdtnXErHzEeqs1TNM7mMT7QP/xNw/aet6Q2vA07PwW3BLvGMESeMY441KVAD9XHHZHk29iN70nZs0bCBdSZZvBsTvpWK1OZ8Cg1EAIp9yLC8Y+/zrGt/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218084; c=relaxed/simple;
	bh=6VVkx79EGP2l6ap6Iyu6uV4RE4s9RSVr5VvW6/l6tsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aN09HJjMx7dDcpqFgUkQo2wRc3QRqeiTDGvQOfDTRQopg1AfP+n3+zvpZ6GUGkRDFj1GAZsLnRXgV4bBS336B726//GAOVSGqYFqBFnPkFW3utQlju8naqr1JX6appG11nqLAqZRlSy2R/sjWIQ+2jtmeqUMTSMX5TQXzHL7D6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vvuVkUd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359D9C4CEF7;
	Wed,  4 Feb 2026 15:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218084;
	bh=6VVkx79EGP2l6ap6Iyu6uV4RE4s9RSVr5VvW6/l6tsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vvuVkUd5ZjPUoA4/R6lhyzuWPK3YSKZMLHOboaQ/Ll7zmWhLdPpPPdCEE7wlX2dia
	 9r467WsBf+b63XotipK3G9JKIZdejjs11n1EA3jXYZudzW0DnvVdXTTKy60awN++jG
	 o1ooHGTKLp5BRdrDSWoAMLmv3KBsBNQx0o14YwUE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 208/280] ASoC: fsl: imx-card: Do not force slot width to sample width
Date: Wed,  4 Feb 2026 15:39:42 +0100
Message-ID: <20260204143917.085879412@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213959-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: D2B18E9A1B
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@gmail.com>

commit 9210f5ff6318163835d9e42ee68006be4da0f531 upstream.

imx-card currently sets the slot width to the physical sample width
for I2S links. This breaks controllers that use fixed-width slots
(e.g. 32-bit FIFO words), causing the unused bits in the slot to
contain undefined data when playing 16-bit streams.

Do not override the slot width in the machine driver and let the CPU
DAI select an appropriate default instead. This matches the behavior
of simple-audio-card and avoids embedding controller-specific policy
in the machine driver.

On an i.MX8MP-based board using SAI as the I2S master with 32-bit slots,
playing 16-bit audio resulted in spurious frequencies and an incorrect
SAI data waveform, as the slot width was forced to 16 bits. After this
change, audio artifacts are eliminated and the 16-bit samples correctly
occupy the first half of the 32-bit slot, with the remaining bits padded
with zeroes.

Cc: stable@vger.kernel.org
Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Link: https://patch.msgid.link/20260118205030.1532696-1-festevam@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/imx-card.c |    1 -
 1 file changed, 1 deletion(-)

--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -314,7 +314,6 @@ static int imx_aif_hw_params(struct snd_
 			      SND_SOC_DAIFMT_PDM;
 		} else {
 			slots = 2;
-			slot_width = params_physical_width(params);
 			fmt = (rtd->dai_link->dai_fmt & ~SND_SOC_DAIFMT_FORMAT_MASK) |
 			      SND_SOC_DAIFMT_I2S;
 		}



