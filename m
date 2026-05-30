Return-Path: <stable+bounces-258275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKRBKtImG2qf/ggAu9opvQ
	(envelope-from <stable+bounces-258275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:05:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9B610F29
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C10D63081A98
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F13349CCF;
	Sat, 30 May 2026 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYxn42Bk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0C03AEB5C;
	Sat, 30 May 2026 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163803; cv=none; b=MuRv2Ix3Wad11DODLf0jXB2Zs3n8KT1iLzchCeZbrdVeq9fCAGHTfYuBW2hgEQd9q894CuYvcPalHX3mQMS7LvDHa2F2tuUZZbXNCRTMcTI/ENtHz3X1vbE9VTHoCWE2FSJ0pmciGTNxRpyZBqNcc1ZluRE5Y8UwZ/aXPSKToZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163803; c=relaxed/simple;
	bh=vdXD4nuqPjTDTT9HBBUZURPueE4q+5ZJDVRr3gx60AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxogrN/RRV19CXfxk46hz7x7WqWsBZF96yVSk7RwA3FWhxJ1PowlHrRgb8DzgnDKCyigrn4n+TA4moe3ZA31Wf66A2cInwDM2CWQGzZXJCiGM68TbXemNyCUhacF9sPbpKJ/VnsF5qrm+C4fbqM5gGAaVyYsik7iII6f11TZa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYxn42Bk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14811F00893;
	Sat, 30 May 2026 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163801;
	bh=PDZlJZLQ4Axl2xP27eHBk5Eql+GZsZTtnquVhFzZCzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hYxn42Bk5yqSWL7lYsZduNFmkgWHYmwp1+G3+lLp7NiHbqx51W8n3SIUg/mTrl0VR
	 oHFY9fxHijhCKmWYNILfvbbvVC685Olpp4BqKI0ZUzJLtG5Hur1+Nbr3o5muVgeYUz
	 maFaolVGu6hcNWPJfCbkFdsuSV0x4fKL/Ig04R+w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergey Shtylyov <s.shtylyov@auroraos.dev>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 5.15 359/776] media: dib8000: avoid division by 0 in dib8000_set_dds()
Date: Sat, 30 May 2026 18:01:13 +0200
Message-ID: <20260530160249.854031753@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[linuxtesting.org:url];
	SUSPICIOUS_RECIPS(1.50)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258275-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.987];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxtesting.org:url,auroraos.dev:email]
X-Rspamd-Queue-Id: 23D9B610F29
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergey Shtylyov <s.shtylyov@auroraos.dev>

commit dde3c37af95cd6fa301c4906f33d627bc9dd874c upstream.

In dib8000_set_dds(), 1 << 26 (67108864) divided by e.g. 1 apparently can't
fit into 16-bit variable unit_khz_dds_val, being truncated to 0; this will
cause division by 0 while calling dprintk() with debugging enabled (via the
module parameter).  Use s32 instead of s16 to declare the variable, getting
rid of the cast to u16 in the *else* branch as well...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

Fixes: 173a64cb3fcf ("[media] dib8000: enhancement")
Cc: stable@vger.kernel.org
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/dvb-frontends/dib8000.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2694,7 +2694,7 @@ static void dib8000_viterbi_state(struct
 
 static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 {
-	s16 unit_khz_dds_val;
+	s32 unit_khz_dds_val;
 	u32 abs_offset_khz = abs(offset_khz);
 	u32 dds = state->cfg.pll->ifreq & 0x1ffffff;
 	u8 invert = !!(state->cfg.pll->ifreq & (1 << 25));
@@ -2715,7 +2715,7 @@ static void dib8000_set_dds(struct dib80
 			dds = (1<<26) - dds;
 	} else {
 		ratio = 2;
-		unit_khz_dds_val = (u16) (67108864 / state->cfg.pll->internal);
+		unit_khz_dds_val = 67108864 / state->cfg.pll->internal;
 
 		if (offset_khz < 0)
 			unit_khz_dds_val *= -1;



