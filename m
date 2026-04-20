Return-Path: <stable+bounces-238986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDSPM68x5ml6tAEAu9opvQ
	(envelope-from <stable+bounces-238986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849F42C86A
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EE2F3147012
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E146B3F7A87;
	Mon, 20 Apr 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2vh2uiV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9AF3BED24;
	Mon, 20 Apr 2026 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691560; cv=none; b=gQlUeIeFd5eahYj7nNn3fXY1ayMXPqJVAeGup+h02vPhrDGjFuQqFPU9SizkexsGRre1LcKN+7V4RRoXPGhcWlYrPx2ud3ZL9Pc3lsMIAuiMrvSf8NsoTH0VvJBF2gEcLElE7vRlL2CPbTdd2SLKOXUDPfnTzik4A0EMMJb5xqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691560; c=relaxed/simple;
	bh=xv3QTtSJvR/60/XVdwibFmhoUfk1Y6yxT4HK64DBMvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF8Pd/Pjdr5qOxCoDSIIswKLqTwtUIlvJ0wmRKOIAW8lNhrb3eVwaHK/K2JdB45dGygLHMZhccGLTaumlQOtPn3ngSjB4WL+ZQ+OhNIJ34ZNVNaG3Bm+SWops3JpKf5PwG8AHGSiNZaHdmE0Wg/Ke17CSjBOHutSNxtTmTbtexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2vh2uiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D52C19425;
	Mon, 20 Apr 2026 13:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691560;
	bh=xv3QTtSJvR/60/XVdwibFmhoUfk1Y6yxT4HK64DBMvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b2vh2uiVFG4zQ/dU8JmvHdEnM18skQqYsnpbZm5FL5PQeoEWdKGECii3bGngm6DRq
	 ijC2CTEUI5+Y7j/fJG59VZ1Mn2yS/6qGhL3LE10WLtaYrP4UEvYo97e3BRWN5+eLOR
	 7VJhQJ3/w3VK9CiMC/B31J54RBW/WTQyldGBYv6SUQWIbXYQS7YT7/YJV9sF/VBqPD
	 rT+TS0lGWgnHm+SgUmCNQl1AV2bY/bLQNwLlyp6UYYB8iEyiIm/57s56NpGWeTu2AA
	 6Ph64aHdTbDd/JR8ohZVWotQNBok1GUreFzzSi2Ndx5E7t7bQYRnpX0gOJsBsQDtk6
	 8I74jALSFJKIg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	yung-chuan.liao@linux.intel.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ASoC: SDCA: Fix overwritten var within for loop
Date: Mon, 20 Apr 2026 09:18:14 -0400
Message-ID: <20260420132314.1023554-100-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_URIBL_FAIL(0.00)[cirrus.com:query timed out];
	TAGGED_FROM(0.00)[bounces-238986-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[opensource.cirrus.com,kernel.org,gmail.com,perex.cz,suse.com,linux.dev,linux.intel.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RSPAMD_EMAILBL_FAIL(0.00)[ckeepax.opensource.cirrus.com:server fail,mstrozek.opensource.cirrus.com:server fail];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus.com:email]
X-Rspamd-Queue-Id: 8849F42C86A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/soc/sdca/sdca_interrupts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sdca/sdca_interrupts.c b/sound/soc/sdca/sdca_interrupts.c
index f83413587da5a..4189efdfe2747 100644
--- a/sound/soc/sdca/sdca_interrupts.c
+++ b/sound/soc/sdca/sdca_interrupts.c
@@ -104,9 +104,7 @@ static irqreturn_t function_status_handler(int irq, void *data)
 
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


