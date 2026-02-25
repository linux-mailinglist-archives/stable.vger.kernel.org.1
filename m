Return-Path: <stable+bounces-219504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGfFKQihnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:13:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B4F1931B5
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E74F03103F86
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F53081D7;
	Wed, 25 Feb 2026 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ix6u58ts"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F42BDC03;
	Wed, 25 Feb 2026 06:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002759; cv=none; b=inJFZNMK3AYSP+R2wIn1BfXUfFMoY2XlZxKiDL2IcZHqWxvd0oIuOaNiFg9hSaNIlQNxXiQKpi6f37N/E+dR9V00b9Ic1GVtJoG9fpoatpLiSOGLvrfS5cjkrJtdGYUMlR8EZrNWwrpAY7zKbUYcLhkD1r/rMmZ0NvldT44+AQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002759; c=relaxed/simple;
	bh=VmKxZkVvqnLaH7N2JS9KHDhjAfPn8jYYERBjquNoBT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LR//t61mLdBmpP4ET2YT5OGHERESucTX5u1ayStSqg2Xd72X/Wt2iAn9mThJ5c2zfjWCdfipg+zu6wlL9Uxz71QaYeH4OjA1ZSG3C6ns3Nvo3oFYcumk1EKbykQw5QT9I6UbD2ojfS7xRhfNcec/bhvVR8qHX+Mb6jW+HFIJc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ix6u58ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C1C116D0;
	Wed, 25 Feb 2026 06:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002759;
	bh=VmKxZkVvqnLaH7N2JS9KHDhjAfPn8jYYERBjquNoBT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ix6u58tsRyKDEQB7ooe6spTI+TavSpFDJTuctJN8g8t1O5BdLIYPr7odQaFiPMFk3
	 Dd6bN4QmJcFHauIj9gBie6UBPv8Jxq6/QSDCI5ATxRfA0mberdk3zADyAQhv3lN5RD
	 i2pOCRojB5c5K6/qxviS45dcCk+AZsnSibesn0Cs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 588/641] ASoC: codecs: aw88261: Fix erroneous bitmask logic in Awinic init
Date: Tue, 24 Feb 2026 17:25:14 -0800
Message-ID: <20260225012402.758190705@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-219504-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 00B4F1931B5
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index de11ae8dd9d9f..124c0a58d08bd 100644
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




