Return-Path: <stable+bounces-220401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GQwNUlIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 077A91C78ED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A316D31B2840
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7672A3AC61E;
	Sat, 28 Feb 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3ItAufy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD73AC616;
	Sat, 28 Feb 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300293; cv=none; b=G+TL/9UTfqqvNecPeJvKgmruHsGqGBS9tp5fKN8eJVr3fJJxJ9dM5vWkRLJdtrl3WrUScdFpFxE3uGHCzeqcXMxnEzLmnWtS9mluUtR/N+IeM7Iyov06hfGyvnL6wBUPKKs3/2PyRhPcmSYZ7pYbODAFj4+ZIWYTxGRDNB4unGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300293; c=relaxed/simple;
	bh=iBDXLbaRLhBUSeiye2udkHyAyFZG9CUC0CKCq+tjCA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDY1QU1tlhV/UYbCKl4bIrocvwV4qqRzFDKSm7fcKufw68c37S2g1YuJMSegXKNK5wf9vF6cYTAq3cyb1NjU8OExgB25/JSbtHAwhX/wfBaPw+cnD9ZxAZA8Xgp0xMIAgVsjCoVIRspd66MpHkAkMEAbubQ3Zm+6S03clD4w2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3ItAufy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649BBC19425;
	Sat, 28 Feb 2026 17:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300293;
	bh=iBDXLbaRLhBUSeiye2udkHyAyFZG9CUC0CKCq+tjCA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b3ItAufy8Z8AsONSg69sBoBG+itWNRiJHSBeQa1rLIUoGrynCYpHiJMSNBtzRsPdw
	 Z0uhEP+1YBrpKJ56Iy3cCHjMUJ1y5PexO8ZYQDepjyFRe9QwDL3Vu3DLFLJbLCA8CQ
	 FG2RyhJME0QQSPgEvpmLN0+0wxVqgRDqEwC77FP3iKbAbgWSnBiHRmzcEvK+t939tf
	 +PEfnQRtBfCChNSVlUiG8ccTZAOGQtzbcl/4Zpr3dV4T7TlHF4+HSlQQKsXK9Om7oW
	 fw8DqXTNckcW2RrmVf0Zmtb7tHI9j8M62o49UxhkdjOpNkVuZG54hBu0xVRY/HBfIX
	 JDZlOCG5Vu1Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geetha sowjanya <gakula@marvell.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 322/844] octeontx2-af: Workaround SQM/PSE stalls by disabling sticky
Date: Sat, 28 Feb 2026 12:23:55 -0500
Message-ID: <20260228173244.1509663-323-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220401-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url]
X-Rspamd-Queue-Id: 077A91C78ED
X-Rspamd-Action: no action

From: Geetha sowjanya <gakula@marvell.com>

[ Upstream commit 70e9a5760abfb6338d63994d4de6b0778ec795d6 ]

NIX SQ manager sticky mode is known to cause stalls when multiple SQs
share an SMQ and transmit concurrently. Additionally, PSE may deadlock
on transitions between sticky and non-sticky transmissions. There is
also a credit drop issue observed when certain condition clocks are
gated.

work around these hardware errata by:
- Disabling SQM sticky operation:
  - Clear TM6 (bit 15)
  - Clear TM11 (bit 14)
- Disabling sticky → non-sticky transition path that can deadlock PSE:
  - Clear TM5 (bit 23)
- Preventing credit drops by keeping the control-flow clock enabled:
  - Set TM9 (bit 21)

These changes are applied via NIX_AF_SQM_DBG_CTL_STATUS. With this
configuration the SQM/PSE maintain forward progress under load without
credit loss, at the cost of disabling sticky optimizations.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260127125147.1642-1-gakula@marvell.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 2f485a930edd1..49f7ff5eddfc8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -4938,12 +4938,18 @@ static int rvu_nix_block_init(struct rvu *rvu, struct nix_hw *nix_hw)
 	/* Set chan/link to backpressure TL3 instead of TL2 */
 	rvu_write64(rvu, blkaddr, NIX_AF_PSE_CHANNEL_LEVEL, 0x01);
 
-	/* Disable SQ manager's sticky mode operation (set TM6 = 0)
+	/* Disable SQ manager's sticky mode operation (set TM6 = 0, TM11 = 0)
 	 * This sticky mode is known to cause SQ stalls when multiple
-	 * SQs are mapped to same SMQ and transmitting pkts at a time.
+	 * SQs are mapped to same SMQ and transmitting pkts simultaneously.
+	 * NIX PSE may deadlock when there are any sticky to non-sticky
+	 * transmission. Hence disable it (TM5 = 0).
 	 */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS);
-	cfg &= ~BIT_ULL(15);
+	cfg &= ~(BIT_ULL(15) | BIT_ULL(14) | BIT_ULL(23));
+	/* NIX may drop credits when condition clocks are turned off.
+	 * Hence enable control flow clk (set TM9 = 1).
+	 */
+	cfg |= BIT_ULL(21);
 	rvu_write64(rvu, blkaddr, NIX_AF_SQM_DBG_CTL_STATUS, cfg);
 
 	ltdefs = rvu->kpu.lt_def;
-- 
2.51.0


