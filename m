Return-Path: <stable+bounces-255858-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KDbJ5ymGGp+lwgAu9opvQ
	(envelope-from <stable+bounces-255858-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FB95F8F45
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 920F8309A9F1
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC23254B1F;
	Thu, 28 May 2026 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QI57o2eO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ED12E7379;
	Thu, 28 May 2026 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000074; cv=none; b=DcEd1FyBSIgysld4LqHtt1LpdxDFFkumGOQ215kkWuBFtSFHCgwb3iFJBHztfeQkryQV4Od+W4AlOUv6LBTHqL6hq4NkiMTVHE7MlFxlhfGuXbsoDVVeX1VPT+UCLBiM/sCsnJbMp1qs+ZFN5xoce9xk/OZFAydZaeMcQPCzhow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000074; c=relaxed/simple;
	bh=nTA6CN6BIeucD596JuQ5RiXYkwLtEaZpXYo17IC83AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6i1tSWYcHc9xAKrM53Qt7H5O9TAGaEcQ+QfvJPbql1NDHVPIzxa+lma/9fq7b53UnaJsMsx636C4DrsWFoVIlMq87BLyi6r6j46EIks/iLrnlkvfz8sK3CDALBLN4FPuVKi1rD3dMxHGB75iyNN/bo6rZrhnxLZZXUHfHo9OwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QI57o2eO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C141F000E9;
	Thu, 28 May 2026 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000073;
	bh=r4IudickBmuSnZTe2/HASr4F1KiJAdYs3sfX2qENMeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QI57o2eOotHhBVPSH5APk5zZeewp8V2ifd8aEl8NMUQtjU0VvAfN11xHb6OKUE7zr
	 xG09ke9KC0kCD6zGdEElwNlmDJqKDv3kjjPjR8vPfnGMVRSWU1vI9WxF71w0kmSbYY
	 8jj/bKnx7ugYZw9LB7Em375wdP14vcUjxSM/cdsk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 293/377] ASoC: codecs: fs210x: fix possible buffer overflow
Date: Thu, 28 May 2026 21:48:51 +0200
Message-ID: <20260528194646.830598830@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255858-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[linuxfoundation.org:server fail,tor.lore.kernel.org:server fail,msgid.link:server fail,al2klimov.de:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[al2klimov.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 45FB95F8F45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander A. Klimov <grandmaster@al2klimov.de>

[ Upstream commit 0d435a7ebcd4e97e47673c1ab6fb27f973a053ec ]

In fs210x_effect_scene_info(), a string was copied like this:

    strscpy(DST, SRC, strlen(SRC) + 1);

A buffer overflow would happen if strlen(SRC) >= sizeof(DST).
Actually, strscpy() must be used this way:

    strscpy(DST, SRC, sizeof(DST));
    strscpy(DST, SRC); // defaults to sizeof(DST)

Fixes: 756117701779 ("ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Link: https://patch.msgid.link/20260513190852.196723-2-grandmaster@al2klimov.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/fs210x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/fs210x.c b/sound/soc/codecs/fs210x.c
index e2f85714972d5..e2207c53c50d5 100644
--- a/sound/soc/codecs/fs210x.c
+++ b/sound/soc/codecs/fs210x.c
@@ -968,7 +968,7 @@ static int fs210x_effect_scene_info(struct snd_kcontrol *kcontrol,
 	if (scene->name)
 		name = scene->name;
 
-	strscpy(uinfo->value.enumerated.name, name, strlen(name) + 1);
+	strscpy(uinfo->value.enumerated.name, name);
 
 	return 0;
 }
-- 
2.53.0




