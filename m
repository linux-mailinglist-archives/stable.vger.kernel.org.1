Return-Path: <stable+bounces-257746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEs3Jk4eG2q4/QgAu9opvQ
	(envelope-from <stable+bounces-257746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB560FC27
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7BAE0301B1EC
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0563998B1;
	Sat, 30 May 2026 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVrkbFXh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98233F5A0;
	Sat, 30 May 2026 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162033; cv=none; b=gHWyF296r2s0GQ5Ses7S87V6O67KWeL4y83iaqoRhDCWh8p3cUoi61dyIHgwbQvpjSkb80k3/oqDrXYYu4pmElfncnJMtU86mfwmO50McgHF6j/jiRCraZx+yrcQViwb5P2i8lBc8GJd+RTWbgRPmqn5c9ntq3dF4NPb1trQIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162033; c=relaxed/simple;
	bh=tw6UqWt1hOaWhYsyxsn+eReiJrfLNKW31AKVFrAEacM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRRPon0i8xrWo+8pzkomdZFgblhSHyRtHWUIJZMssA5c/iNiE2g96oToOUEPn16Sh2ciDQrY1akfeoVNCfh1QaW1PeWcmh5fimTO9wQ7PkEeoJRnUKJiZDln1MTrv/6INMUdGLDTsldjKeFUKgks81XqoWI2kNsxYj8EIZkAUsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVrkbFXh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22A41F00893;
	Sat, 30 May 2026 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162032;
	bh=ptLKMppvneIZmY8SY22xbZHOKkKiepvlyH11y+vizcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fVrkbFXhbNGhOvuH2v3o5v8vK+lFyzGWA+51WM6Kbb0KxnSkQAmCLZU4xlajMHHH9
	 O1OWMqLMB+ir3f/uV5RijpkwRCJlz9zuy1hS//BtNrj/c63nXYQ5dQkPyRCMV9hh8t
	 4sWGrEtEG+1ka8i1zCOO4W4+D1MG/VgGd3uhsixc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20 ?= <u.kleine-koenig@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 761/969] ASoC: codecs: ab8500: Fix casting of private data
Date: Sat, 30 May 2026 18:04:45 +0200
Message-ID: <20260530160321.582463116@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257746-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,baylibre.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,codasip.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 9DBB560FC27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian A. Ehrhardt <christian.ehrhardt@codasip.com>

[ Upstream commit a201aef1a88b675e9eb8487e27d14e2eef3cef80 ]

ab8500_filter_controls[i].private_value is initialized using

	.private_value = (unsigned long)&(struct filter_control)
		{.count = xcount, .min = xmin, .max = xmax}

thus it's a pointer to a struct filter_control casted to unsigned long.

So to get back that pointer .private_data must be cast back, not its
address.

Fixes: 679d7abdc754 ("ASoC: codecs: Add AB8500 codec-driver")
Signed-off-by: Christian A. Ehrhardt <christian.ehrhardt@codasip.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20260428192255.2294705-2-u.kleine-koenig@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index 68342917419e4..42e448978c4a0 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -2496,13 +2496,13 @@ static int ab8500_codec_probe(struct snd_soc_component *component)
 		return status;
 	}
 	fc = (struct filter_control *)
-		&ab8500_filter_controls[AB8500_FILTER_ANC_FIR].private_value;
+		ab8500_filter_controls[AB8500_FILTER_ANC_FIR].private_value;
 	drvdata->anc_fir_values = (long *)fc->value;
 	fc = (struct filter_control *)
-		&ab8500_filter_controls[AB8500_FILTER_ANC_IIR].private_value;
+		ab8500_filter_controls[AB8500_FILTER_ANC_IIR].private_value;
 	drvdata->anc_iir_values = (long *)fc->value;
 	fc = (struct filter_control *)
-		&ab8500_filter_controls[AB8500_FILTER_SID_FIR].private_value;
+		ab8500_filter_controls[AB8500_FILTER_SID_FIR].private_value;
 	drvdata->sid_fir_values = (long *)fc->value;
 
 	snd_soc_dapm_disable_pin(dapm, "ANC Configure Input");
-- 
2.53.0




