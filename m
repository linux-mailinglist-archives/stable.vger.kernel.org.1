Return-Path: <stable+bounces-218261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDGpJGVSnmm6UgQAu9opvQ
	(envelope-from <stable+bounces-218261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF918F355
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B1363184FB6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652B243376;
	Wed, 25 Feb 2026 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sr1MQz3r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE651FE45D;
	Wed, 25 Feb 2026 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983060; cv=none; b=fFpIUVwcrMgUySJ+avAuoj92VdxGzsfJMbNaa7ob3B3JOUfFGOeQQBN7o1AzLu9nZiu19MRJWTbE4G5ywjTL4pVVw950vX8qQaOimvrd1V7CIaNWr4MQ7bzY+ZmIAVQeqVCaL3F0/antQSz/aI72S8aNEHLDfPypOuIYKMgPBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983060; c=relaxed/simple;
	bh=gGWOeW+z2jhZADuQRbHFrHpL+bLTUdeR8azPzaRdJpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fu628TJWt0tBZUMdCgKFRnjJW97O3HV8nRWoFuLZVmn7ejYiLVNGg2N9zV1yW6ZOZ6g+3t7/LsuX8p+JpIdDD7h5evXvP7ApgVEUSqlsppxRgp02Nhb69E33OW0aTQlrOJmNe0qFt9YfEuevfOfvyrfW+mSiqzVMCl5KBrm/F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sr1MQz3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC92C116D0;
	Wed, 25 Feb 2026 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983059;
	bh=gGWOeW+z2jhZADuQRbHFrHpL+bLTUdeR8azPzaRdJpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sr1MQz3rOqDhO20nRnNfitVFWiGBvfYkt3aQKeInBINvvrZUx4xIVzkxK3FcXuUWv
	 806jOBwzLFFAXARG+XMwetBl2YMfOUXEknCWnClXgwx7N+Mqq7r7XMS1k4MPW0i8nA
	 Pa6EF2sjL5v9o3c5OfF7iT6GrLDcTS/YIVHVH//I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 224/781] ASoC: SDCA: Allow sample width wild cards in set_usage()
Date: Tue, 24 Feb 2026 17:15:33 -0800
Message-ID: <20260225012405.205318764@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218261-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,cirrus.com:email]
X-Rspamd-Queue-Id: 23DF918F355
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 87783532d34050e2bff6749a4fe9860e624a0540 ]

The SDCA spec allows the sample rate and width to be wild cards, but the
current implementation of set_usage() only checked for a wild card of
the sample rate.

Fixes: 4ed357f72a0e ("ASoC: SDCA: Add hw_params() helper function")
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20251216142204.183958-1-simont@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_asoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_asoc.c b/sound/soc/sdca/sdca_asoc.c
index 2d328bbb95b94..498aba9df5d9b 100644
--- a/sound/soc/sdca/sdca_asoc.c
+++ b/sound/soc/sdca/sdca_asoc.c
@@ -1478,7 +1478,7 @@ static int set_usage(struct device *dev, struct regmap *regmap,
 		unsigned int rate = sdca_range(range, SDCA_USAGE_SAMPLE_RATE, i);
 		unsigned int width = sdca_range(range, SDCA_USAGE_SAMPLE_WIDTH, i);
 
-		if ((!rate || rate == target_rate) && width == target_width) {
+		if ((!rate || rate == target_rate) && (!width || width == target_width)) {
 			unsigned int usage = sdca_range(range, SDCA_USAGE_NUMBER, i);
 			unsigned int reg = SDW_SDCA_CTL(function->desc->adr,
 							entity->id, sel, 0);
-- 
2.51.0




