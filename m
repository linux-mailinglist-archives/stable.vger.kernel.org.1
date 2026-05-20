Return-Path: <stable+bounces-252780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFtTE3b+DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDA5968B6
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E77AA318A19C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01CA3F8706;
	Wed, 20 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+voqkI5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE2A3F9280;
	Wed, 20 May 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301571; cv=none; b=g+ganP7jmVCmeQYkXr2Fdhz0Na92AryI7imZk86Saxh8oKKj3OTqXzadv/qnFlPJf+iGnb6Acif9PZZp5z8ZCWruEckCGxdWqnSivwoF7D9+r3ceANChv1MQ5Ch1gq+/l9KE670Lf+Tdr+PAxtC2ccVLQfKGNsynXxOl+uP0WNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301571; c=relaxed/simple;
	bh=GCCdDnfaGrQyAWyzo5CF+LBm69Tm3jOPqQewUhU5/j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irutejR85YBu/hOcniFdL3V2E7fs4F+J+IXxI+/dMUB9/G5rROxtXjNOye/DX2+6GfvpPiWM4Rxws7Bslh3OVa5VffaTGD1CgwKkC0sDP+BgcXYHmKpRk+2JhilgL/4J1ums/TjnnmfsuaB/9c1g0kyzgpQz+QkJjOk2GB3BNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+voqkI5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D895D1F000E9;
	Wed, 20 May 2026 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301570;
	bh=kdcv3DUhizeNmzlXjfZ9mspN/8eoBXzGjZ3XqniQMcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W+voqkI5vAE/uv/P0zCpH2v9QwqOC9rC11VbMpdFYohLl0EKOYZ/LEMaAMLH9TL3n
	 kkjz7UtRUmxUAGSjGCK9jgIrlvWfF2DLwMIvd2syqEMCc8gWJunFhAnOLZfmwLfXi0
	 R1LJmsRpTBZIEkOayCsZ4xXpUjlfaEuWS2wiffmw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Christian A. Ehrhardt" <christian.ehrhardt@codasip.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20 ?= <u.kleine-koenig@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 568/666] ASoC: codecs: ab8500: Fix casting of private data
Date: Wed, 20 May 2026 18:22:59 +0200
Message-ID: <20260520162123.577981095@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252780-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,codasip.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DBCDA5968B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 04b5e1d5a6530..32d9cdbc8c310 100644
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




