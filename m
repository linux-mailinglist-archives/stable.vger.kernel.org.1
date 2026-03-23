Return-Path: <stable+bounces-229118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIpzErZZwWnbSQQAu9opvQ
	(envelope-from <stable+bounces-229118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A902F61DA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA7B325ACA2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C42773FF;
	Mon, 23 Mar 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1xdM0VbN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D422765C4;
	Mon, 23 Mar 2026 15:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278116; cv=none; b=bUFs8I6vl4cgWyvGWkP3qTG2o2kheqHFqtDk32QZoxgO/SGq8HHrVGXFAqsXRTxXcJkiNY4rJtS9qFm3I0anqQZjSz3PF2/AsSsv7+3cHPTxzD2rnPzQ3nDb+4OyVlAryBFGhcFgv8sh2eeQuGAR20C1eKuoVLGJSbYsFpMxGe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278116; c=relaxed/simple;
	bh=i+m3V8HkE7WEGHeA++11uJIdvT3iGlnxp7Hc5FWXct0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dj8gUCU+NDr8z7HrhKQwnCxW95pMuGrJyrmFtCkeWZrqjQFFbpV9vbR8zgAKJyuJZ56cEe7Q96j3mDvvomrR9NkQKb9///x+Zh7QR0ZwhglvG1/ghWJJP4ONvBV6khIreD3B/lEFj+MNhxqHzeoZfFZni6HCX9o1O4c/ycgFqTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1xdM0VbN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78BCC4CEF7;
	Mon, 23 Mar 2026 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278116;
	bh=i+m3V8HkE7WEGHeA++11uJIdvT3iGlnxp7Hc5FWXct0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1xdM0VbN6yyOImH2rmyn64G8aff4yBimxmZdy6RXnM25sodIifMWxhkqw2LEhHPpr
	 ZMOFlWUokId9NVDkgaEboqgWfflaG/9yfgpx0YvdPvyhRAw3NuixXKZ+Fi76px2bUo
	 aC5xTvEjeAZv2x/ANpgnLdElUdMUgaYCMJo41s/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 206/567] ASoC: cs42l43: Report insert for exotic peripherals
Date: Mon, 23 Mar 2026 14:42:06 +0100
Message-ID: <20260323134538.937180706@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229118-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B5A902F61DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 6510e1324bcdc8caf21f6d17efe27604c48f0d64 ]

For some exotic peripherals the type detect can return a reserved value
of 0x4. This will currently return an error and not report anything to
user-space, update this to report the insert normally.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260223093616.3800350-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l43-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index f58d55d77693f..ba60acc4b2f09 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -699,6 +699,7 @@ static int cs42l43_run_type_detect(struct cs42l43_codec *priv)
 	switch (type & CS42L43_HSDET_TYPE_STS_MASK) {
 	case 0x0: // CTIA
 	case 0x1: // OMTP
+	case 0x4:
 		return cs42l43_run_load_detect(priv, true);
 	case 0x2: // 3-pole
 		return cs42l43_run_load_detect(priv, false);
-- 
2.51.0




