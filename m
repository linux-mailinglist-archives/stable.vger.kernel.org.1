Return-Path: <stable+bounces-232271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNLhNcn+y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9318C36DD4C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EFE030A2A6F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F4423A9D;
	Tue, 31 Mar 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XpEDqOom"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F281423A62;
	Tue, 31 Mar 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976318; cv=none; b=FPn9A8WLZ3rSGXUjZRWS7ISlA+Oaxx75KC4iYYBAVT1gp1oq7GJVtoKvequyLj/V9KWMOiVh+eNDe9IPbxyR+3jWJcWMGJs2gWxZbcUcC5c9ioXhMmUuJrVc0gJpr2gR+dI0Q5AXQuGb9R2KWxJCdxN58jgswrn2LzzPN21lPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976318; c=relaxed/simple;
	bh=B4WZ2tJX7KcliOeM7Cwg/WJrMzXbvR0mEfBhxAYZS5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0syP0ReKXz1y5OhZUHJwpG90RefFVOPymc1e6jiJPkWxAtiDvTgJIXAPBGnc8sgvXr8hutSo3HdTViTItLr/b92fZq1CCPKBjJYjKgvJDuwg/eWydLk5FJGvs8HVNAuQs+M6rauGLdISgOT0mQUZW/J1Np15iRNPMbKwKrR3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XpEDqOom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F320BC19423;
	Tue, 31 Mar 2026 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976318;
	bh=B4WZ2tJX7KcliOeM7Cwg/WJrMzXbvR0mEfBhxAYZS5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpEDqOomTRun1RsnJJSkQCOHcSqLZHdWIyYod0oow80DouyFq2AYIPwv6k+k8tJDU
	 4NgTVXsAUkYQiIK3VE8YsKoq1OQy5ZglmpW6VjLWuhKbSdhv02oe7YC4cFU3fxLKEr
	 P+p12uD23XYW6Sw86pqdj/R/UYhuECZ21r8KiQmk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 046/309] ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()
Date: Tue, 31 Mar 2026 18:19:09 +0200
Message-ID: <20260331161755.180484014@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232271-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9318C36DD4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 54a86cf48eaa6d1ab5130d756b718775e81e1748 ]

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_easrc_iec958_put_bits() unconditionally returns
0, causing ALSA to not generate any change events. This is detected by
mixer-test with large numbers of messages in the form:

    No event generated for Context 3 IEC958 CS5
    Context 3 IEC958 CS5.0 orig 5224 read 5225, is_volatile 0

Add a suitable check.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20260205-asoc-fsl-easrc-fix-events-v1-1-39d4c766918b@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_easrc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index ec49da2d1ebb2..d86f01fbecd4a 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -52,10 +52,13 @@ static int fsl_easrc_iec958_put_bits(struct snd_kcontrol *kcontrol,
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
 	unsigned int regval = ucontrol->value.integer.value[0];
+	int ret;
+
+	ret = (easrc_priv->bps_iec958[mc->regbase] != regval);
 
 	easrc_priv->bps_iec958[mc->regbase] = regval;
 
-	return 0;
+	return ret;
 }
 
 static int fsl_easrc_iec958_get_bits(struct snd_kcontrol *kcontrol,
-- 
2.51.0




