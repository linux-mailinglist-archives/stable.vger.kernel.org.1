Return-Path: <stable+bounces-239458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBnjKftX5mlQvAEAu9opvQ
	(envelope-from <stable+bounces-239458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:44:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FFE42FF05
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E27B3456DE8
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832C533858B;
	Mon, 20 Apr 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/ZT/Lbb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D8B2E093A;
	Mon, 20 Apr 2026 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700305; cv=none; b=pEgGdwV8F7odI44P/tQ7rDnxvkolBmoO7NQwnmJUbQjVRAm1Y/GszNBPOFaEvsmplOjKvEcPm0eQAEV1LZ4zRwRdIorEhACGgJu/++jVeYoKvE+ce68+j1QwK70Fp0+5MxHj6a8tb6jmb4YvBNI7ZcYMkfWKFT1QfQ6oZIuJKco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700305; c=relaxed/simple;
	bh=zWEqOrKGh7O9L+tHcG5AffAVPxrnXIV5wsWrTVo72Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2P5OwNFVAOX2FFGEhaQByJbBO21EkMWvAPr45JtM9tDTaZvP1jvw+8UUXuYnqBlAobILHerJPIz833sIqqAiKENg3W2MkrzocGJvWIDKu2u1YMcR+6GnhGmyqdbKf/xVsgt1IFAXOwnoYO00s+cFQ7/9G9uyhDrjqNf1MJoGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M/ZT/Lbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95495C19425;
	Mon, 20 Apr 2026 15:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700304;
	bh=zWEqOrKGh7O9L+tHcG5AffAVPxrnXIV5wsWrTVo72Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M/ZT/Lbbs/txX/fEd8RiguuxVBSHDzdxiy65+dYXog9PW3aVV8Cf5ttAUrr74fZi7
	 5FVLlW5+57J4f3gjYSGwETnzzh/55v/uCrgzsQwKGewKTWxrDyhZw2ZOYD2Bwbrgv0
	 xGcRQnc1DTudAbRnTSUKbAS+3LIQibY5bUugM6GI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 121/220] ASoC: SDCA: Fix overwritten var within for loop
Date: Mon, 20 Apr 2026 17:41:02 +0200
Message-ID: <20260420153938.385911849@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239458-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,cirrus.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 40FFE42FF05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit 23e0cbe55736de222ed975863cf06baf29bee5fe ]

mask variable should not be overwritten within the for loop or it will
skip certain bits. Change to using BIT() macro.

Fixes: b9ab3b618241 ("ASoC: SDCA: Add some initial IRQ handlers")
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20260408093835.2881486-2-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sdca/sdca_interrupts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sdca/sdca_interrupts.c b/sound/soc/sdca/sdca_interrupts.c
index be269f204d623..4739fabb75f23 100644
--- a/sound/soc/sdca/sdca_interrupts.c
+++ b/sound/soc/sdca/sdca_interrupts.c
@@ -117,9 +117,7 @@ static irqreturn_t function_status_handler(int irq, void *data)
 
 	status = val;
 	for_each_set_bit(mask, &status, BITS_PER_BYTE) {
-		mask = 1 << mask;
-
-		switch (mask) {
+		switch (BIT(mask)) {
 		case SDCA_CTL_ENTITY_0_FUNCTION_NEEDS_INITIALIZATION:
 			//FIXME: Add init writes
 			break;
-- 
2.53.0




