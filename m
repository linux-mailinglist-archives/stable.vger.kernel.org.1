Return-Path: <stable+bounces-255430-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKoRBvCiGGrJlggAu9opvQ
	(envelope-from <stable+bounces-255430-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C68B5F8507
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C30031CDDEB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093F344DAC;
	Thu, 28 May 2026 20:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZ8HVJYK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32C318EE1;
	Thu, 28 May 2026 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998888; cv=none; b=MRi9EjljuPEocucJqQ3eYkT7ART0xseEMfroPn/NsnMWjQ0NOlBSUuH7lr5AQwNRCDXI2O0y6G0gmTKIkTdu4IcZBGwNGZl+YRJpaD7FepsOy2netMjGkauaUcvUpq3qG76Rz8vQzk+GWmIM+gGf0/9uRwhWHCtI6osnNeUC9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998888; c=relaxed/simple;
	bh=bDgw7o3FYqqOenEAO0XdpZfUnHciOclck4f1hMS2lxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAE34oJmyFbl82dpdyHx9j9x7QJpE6f1cPVAU78uFpWAhT9EnOawywFVq18QYU5YnwuAYpDVV5d7VD05L/sbEr8kKgDgaCZ6TElxNjFjNB4DALpz+f1lUy3ksYVUvHekCiP96eCXYQHFyclHhAYMVDzdfnVPtpwfs4QPRigB60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZ8HVJYK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5325D1F000E9;
	Thu, 28 May 2026 20:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998886;
	bh=D7a1DdEO5Eagx2FNTZZZTCLa8o2mU5cc69epNlMb/dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eZ8HVJYKAHJqlSHkvxePQB/if5Y2nuSnFdIJ5D7N19/ePG7W4nArczMhLN3PhqcfQ
	 X4iNNHlSa6fL8hAc1S3rNNlu3hElDZ6N/Flq36dAIXtrER7R7ISdnfbzdNBGrtajme
	 +68ymsulY22M+Hoqa6JFhpUBzcyR9+1vxAjgPElc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 333/461] ASoC: codecs: fs210x: fix possible buffer overflow
Date: Thu, 28 May 2026 21:47:42 +0200
Message-ID: <20260528194656.991676532@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255430-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,al2klimov.de:email]
X-Rspamd-Queue-Id: 9C68B5F8507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index e6195b71adadc..eda716f817b58 100644
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




