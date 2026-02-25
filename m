Return-Path: <stable+bounces-218756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHl+FCFVnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16918FEF4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2153C31FABDE
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB8F26F476;
	Wed, 25 Feb 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eN6525V9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A8F1E2834;
	Wed, 25 Feb 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983626; cv=none; b=HTynijSIYXQmjw3iegmbsSPDII1l+v4fVqJ0aw8jCG7B6p0mJoVhOPpWMrHFb41kMMnSnpnPrwSy8Z4n2wvjBK8nNfW1yyOPH/6soWAlsvfk0zPlyibnemyBLrRKZT0P8H6if2A9P9225dZUoKegDXM6Xpkq6DB9zXgo4SPO4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983626; c=relaxed/simple;
	bh=G5VrcSSO5dhpp67hPO7KW+yGgGxxvKFxN/8xndC4SMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIieKRmZ2/W4+GICFLeTv5ipzVjDcmzTLSrQuFcO4mYU6Fwl92vmZg9zbHke4va7NL3EmmRJwZn67zfQk0rIHcx0K27I1AEoo4/6UVLLGvzvl0hCxMTgoIRVpzxCcTmt97NAiox9o7QuA4lkuNSSaR+0cXnTuwIrn4UC/Gdfluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eN6525V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF3BC116D0;
	Wed, 25 Feb 2026 01:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983626;
	bh=G5VrcSSO5dhpp67hPO7KW+yGgGxxvKFxN/8xndC4SMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eN6525V9rTxTm+YbSCsBUy+mdFUmX+57G1VZb/B01JkMZLOoqHhTEqcr4Q9hJTGeT
	 BI4PiYQRVFhH63gHQSpiPRrv6g08Dd1d6CQdEBNoFrnpYzSpVkYLRY2zPspm+Rk0zV
	 Tc5PusxWDWe60e05H0KvjlFS2SZsXXV6V2BaqzK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 717/781] ASoC: codecs: aw88261: Fix erroneous bitmask logic in Awinic init
Date: Tue, 24 Feb 2026 17:23:46 -0800
Message-ID: <20260225012417.326547019@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218756-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,orange.com:email]
X-Rspamd-Queue-Id: 9F16918FEF4
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>

[ Upstream commit b82fa9b0c26eeb2fde6017f7de2c3c544484efef ]

The aw88261_dev_reg_update() function sets the Awinic registers in a
rather nonuniform way:
  - most registers get directly overwritten from the firmware blob
  - but a handful of them need more delicate logic to preserve
    some bits from their current value, according to a register-
    specific mask
For the latter, the logic is basically
       NEW = (OLD & MASK) | (VAL & ~MASK)
However, the ~MASK value is hand-computed, and in the specific case
of the SYSCTRL register, in a buggy way.
This patch restores the proper ~MASK value.

Fixes: 028a2ae25691 ("ASoC: codecs: Add aw88261 amplifier driver")
Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Link: https://patch.msgid.link/20260211-aw88261-fwname-v1-1-e24e833a019d@fairphone.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/aw88261.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index 8f37bfb974ae4..96b1a85c26aa7 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -423,9 +423,10 @@ static int aw88261_dev_reg_update(struct aw88261 *aw88261,
 			if (ret)
 				break;
 
+			/* keep all three bits from current hw status */
 			read_val &= (~AW88261_AMPPD_MASK) | (~AW88261_PWDN_MASK) |
 								(~AW88261_HMUTE_MASK);
-			reg_val &= (AW88261_AMPPD_MASK | AW88261_PWDN_MASK | AW88261_HMUTE_MASK);
+			reg_val &= (AW88261_AMPPD_MASK & AW88261_PWDN_MASK & AW88261_HMUTE_MASK);
 			reg_val |= read_val;
 
 			/* enable uls hmute */
-- 
2.51.0




