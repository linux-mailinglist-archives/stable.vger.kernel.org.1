Return-Path: <stable+bounces-220304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFGLLXowo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8561C5912
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6ACA309D451
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4F38D012;
	Sat, 28 Feb 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+j7nzrj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94938D009;
	Sat, 28 Feb 2026 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300207; cv=none; b=R/jPc4JgB9m9BaZTNF2gdo5+iVGMTCZPam8g0RkuMbE6SYKZZBSQB8VL4hjX6Zq6zAQHW7iaFe/PBbVJcRM8XmoTjytiO5R8m++/wzij5/W8Y6DgYxNW/L2+uEv5sNEOwDTG6CHrE/wYdC438+0RoN/W6NF6v7i8bNS0W/bKkh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300207; c=relaxed/simple;
	bh=HrE32cZx8Wn5/h1pkvX3+n4NaaYqY4QP3DhxJjCs4u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLzph1+eguryzMHw5fy2Jtc9FnwYQEk52fqLIkfah6XV7HjLF9jLBkzwR31e1e/GhzpXt7Oz1XHO0rgN+WfYFZpXtAvL66AKXN1FbbiHrIrzCjGmT2xFShTn93YMkw0BrHb56frap0r/tqootcx2nbZH7yvOeBzr8ccfjaeKRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+j7nzrj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0588DC2BC9E;
	Sat, 28 Feb 2026 17:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300207;
	bh=HrE32cZx8Wn5/h1pkvX3+n4NaaYqY4QP3DhxJjCs4u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N+j7nzrjMrJ7litxdXDLWSkLJTAzXJmyb2aDOQOAGhlkpgJVBsR6t1iQcH1YtkmEu
	 XerC3hpLzfOolJacsDS/KfIizKpOC0KAhdB89wi+PGCDqaWYIcRdWmKeccU9UEDaq4
	 XFRQMvpZ/hoLWEFJIMM+7QM3TIhtky1Y+HJJ0HNdAE6GfDkGthkifzFG5GD21Xobs6
	 xBuwToZm1WltVGm3DEo7kZVs+RgjUvLod83KnWZ6wyDyo8G1s8EF70gfFR8oFu+IP3
	 K+3WxTggC4AprJ/Ad9zK3uihLS3teaocnMSbeN5jpdMG6bIv2MTxhQJBwuGxSg2eCY
	 jBJ5sZvl627Ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 226/844] ASoC: codecs: max98390: Check return value of devm_gpiod_get_optional() in max98390_i2c_probe()
Date: Sat, 28 Feb 2026 12:22:19 -0500
Message-ID: <20260228173244.1509663-227-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220304-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 8C8561C5912
X-Rspamd-Action: no action

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit a1d14d8364eac2611fe1391c73ff0e5b26064f0e ]

The devm_gpiod_get_optional() function may return an error pointer
(ERR_PTR) in case of a genuine failure during GPIO acquisition,
not just NULL which indicates the legitimate absence of an optional
GPIO.

Add an IS_ERR() check after the function call to catch such errors and
propagate them to the probe function, ensuring the driver fails to load
safely rather than proceeding with an invalid pointer.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20260130091904.3426149-1-nichen@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/max98390.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index 3dd4dd94bc371..ff58805e97d17 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -1067,6 +1067,9 @@ static int max98390_i2c_probe(struct i2c_client *i2c)
 
 	reset_gpio = devm_gpiod_get_optional(&i2c->dev,
 					     "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(&i2c->dev, PTR_ERR(reset_gpio),
+				     "Failed to get reset gpio\n");
 
 	/* Power on device */
 	if (reset_gpio) {
-- 
2.51.0


