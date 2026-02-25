Return-Path: <stable+bounces-218684-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MCvG4pUnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218684-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:46:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 990A418FD1C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA27330E83F1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D16626CE2D;
	Wed, 25 Feb 2026 01:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYYq5QNT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C446E2494FE;
	Wed, 25 Feb 2026 01:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983541; cv=none; b=R+jVKFhWzKpKyAB57ZLgZqgvzXPNFVatug+yjISMRRefcaHuN606LywtuYO1oHbbZ0hG3D0QlveZUjBVUcoIDZyUveWt/JqzBoF+54LV7syCxUHBM25WcFzOHvkjzIr3GknhsOnxAMYyV9L74kXyzaeT15unGtjGO3l83KXSdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983541; c=relaxed/simple;
	bh=f7zn+o0yNYBYTvjzEMTzJIyybZ8kv2Q14Cn3yIyA/R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BbsMMh5XsiE4ns1W0gERUcAq608E612oEYLMGFzTvmadSfKoOcwevY6kOvHdJi9rFz3K9buJR5r3Ofv1NqHAhG7hzHnlxS2Yf39nYUEXRU4qogcGVPvzuuj+i8eSeo/qc4Sr+WhVon4XxoY0TFO6Wpo1UGClqeW4l/qd5SCIs10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYYq5QNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED60C116D0;
	Wed, 25 Feb 2026 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983541;
	bh=f7zn+o0yNYBYTvjzEMTzJIyybZ8kv2Q14Cn3yIyA/R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UYYq5QNTQc4EujZVNgM5KuLRhK1U90Hq6rMyocMZ+pHT2bwHzO3tvLOzFzIV3JmUi
	 1UfiO+Z1icP4l9IgsipAWxHEZhbrJILAcN7mp5rWUa6PTPdRqE1vh7sLrmpLYs7F+2
	 uiTPXdRbH7gsXaprPGjtsZHrv7Xf23pMdL8mq9B4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Machon <daniel.machon@microchip.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 645/781] net: sparx5/lan969x: fix PTP clock max_adj value
Date: Tue, 24 Feb 2026 17:22:34 -0800
Message-ID: <20260225012415.617846390@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218684-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email,microchip.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 990A418FD1C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Machon <daniel.machon@microchip.com>

[ Upstream commit a49d2a2c37a6252c41cbdd505f9d1c58d5a3817a ]

The max_adj field in ptp_clock_info tells userspace how much the PHC
clock frequency can be adjusted. ptp4l reads this and will never request
a correction larger than max_adj.

On both sparx5 and lan969x the clock offset may never converge because
the servo needs a frequency correction larger than the current max_adj
of 200000 (200 ppm) allows. The servo rails at the max and the offset
stays in the tens of microseconds.

The hardware has no inherent max adjustment limit; frequency correction
is done by writing a 64-bit clock period increment to CLK_PER_CFG, and
the register has plenty of range. The 200000 value was just an overly
conservative software limit. The max_adj is shared between sparx5 and
lan969x, and the increased value is safe for both.

Fix this by increasing max_adj to 10000000 (10000 ppm), giving the
servo sufficient headroom.

Fixes: 0933bd04047c ("net: sparx5: Add support for ptp clocks")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260212-sparx5-ptp-max-adj-v2-v1-1-06b200e50ce3@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
index 2f168700f63c1..8b2e07821a950 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_ptp.c
@@ -576,7 +576,7 @@ static int sparx5_ptp_adjtime(struct ptp_clock_info *ptp, s64 delta)
 static struct ptp_clock_info sparx5_ptp_clock_info = {
 	.owner		= THIS_MODULE,
 	.name		= "sparx5 ptp",
-	.max_adj	= 200000,
+	.max_adj	= 10000000,
 	.gettime64	= sparx5_ptp_gettime64,
 	.settime64	= sparx5_ptp_settime64,
 	.adjtime	= sparx5_ptp_adjtime,
-- 
2.51.0




