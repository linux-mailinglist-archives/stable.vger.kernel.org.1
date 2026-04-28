Return-Path: <stable+bounces-241734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC8ADd7k8GmoagEAu9opvQ
	(envelope-from <stable+bounces-241734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:48:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD9E4894CD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 770A3313A815
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110AA3264DF;
	Tue, 28 Apr 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZEih+yr8"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFD6DDA9;
	Tue, 28 Apr 2026 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394012; cv=none; b=a2lH7PCOmEsPCkNgETyXP1gU+sCDK3an92euyC0mcQP5rn3W6daCanu1TaZ/EDU3wWrfaQWc3O/l4r7rb3DC7udHxCgv9VdDZyQ7ju5qrGQsxfmDxy18+Rs6FrtQCjyXFRFQ+TbkldPEymc1NC1ZxLz0STQPLbDBFqF2n6KdX/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394012; c=relaxed/simple;
	bh=68AUE+rNo6vS7Yl5grOwzZobGoIdJ5ntoXAFGiShIiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WqKfeIbytfAvOvm+64mbqF04KHj8Ic+HqeTL6Q79CmYBWlBKDok6U3hCNAZzZFFXjZ/yB+s+LcyinVBZPJSSIFYedxPysMF5JKcLGk9g5kEL5ejiiVQo1U7/1POW6uQe2/2SgS8jQUhxYURRre9SctQ/FAyeLq405ngUSfLdPpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZEih+yr8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A000C4E42B5C;
	Tue, 28 Apr 2026 16:33:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 71E88601D0;
	Tue, 28 Apr 2026 16:33:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 138D510728EC7;
	Tue, 28 Apr 2026 18:33:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777394000; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=RLmfpWDoWjVy/iLit4ugD0dmNcaraSoRaKNFKWYi+xg=;
	b=ZEih+yr8bYPQOvySc9JN60576r04K6RRgxPf+V7cnSPcA4iPnSZOMsjY7k20peS9Nm4QLj
	O3dPK2ulrbLD0tWUVavnnOtYDa6mn6ZMzrkKMzDn9IIrKZ1KfflHs3X7bJcp8k9NDd9ID4
	NmiiQRLh1R1W3LsyLD478CrMEWAO84xDF2pni/nW6hU1aetLv/LMBXkC0R8bBiyLnw5CoC
	JB+FxJ96saRPeyJwmssEcgZSwvM6oBgbS4okhXdg1QUqjaGb0omHu6m0pA0MAcfTJ5QlF7
	Ztx2SJt+5bji+A6YGjbSMaRyPQ9MdTVGagU6JSSMHSIu5phQ2xXT1e+g+OvDbA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v2 0/4] Drop in-flight Tx SKBs on MACB close
Date: Tue, 28 Apr 2026 18:32:56 +0200
Message-Id: <20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/1WNwQ6CMBBEf8Xs2TWloEVP/ofhQNtF1khL2kowh
 H8X0IvHmbx5M0GkwBThspsg0MCRvVuC3O/AtLW7E7JdMkghT6KQOXa10WiD7zGN2JwNKamksOI
 Iy6QP1PC46W7gKEH1LeNLP8ikVbRiLcfkw3s7HbIN/vmLf/+QYYY6J6NVqWxZ2Kv2Pj3ZHYzvo
 Jrn+QNdSuniwQAAAA==
X-Change-ID: 20260423-macb-drop-tx-f9ce72720d05
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>
Cc: Paolo Valerio <pvalerio@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7FD9E4894CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241734-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The first patch is here to allow giving a drop reason.
We dissociate consumed packets from dropped ones that way.

Second patch is the main one: it drops unsent packets on close.
MACB driver forgot freeing its SKBs (and associated DMA mappings).

Last two patches are to fix stats reporting on dropped codepaths.

---
Changes in v2:
- Increment tx_dropped stat once per SKB, not once per frame.
- Reset tx_head & tx_tail to avoid keeping stalled cursors.
- Fix SKB dropped reasons throughout by adding the reason as parameter
  to macb_tx_unmap(). This is a new patch. Then the drop-all-on-close
  fix can use this ability to report we are not consuming SKBs.
- Add increment to stats->tx_dropped on DMA mapping failure and
  tx_error_task. Done as separate patches (3 and 4).
- Rebase upon net/main @ 46f74a3f7d57, nothing to report.
- Link to v1: https://patch.msgid.link/20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com

To: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Paolo Valerio <pvalerio@redhat.com>
Cc: Conor Dooley <conor@kernel.org>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Benoît Monin <benoit.monin@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---
Théo Lebrun (4):
      net: macb: give reasons for Tx SKB kfree
      net: macb: drop in-flight Tx SKBs on close
      net: macb: increment stats.tx_dropped on tx error
      net: macb: increment stats.tx_dropped on DMA map error

 drivers/net/ethernet/cadence/macb_main.c | 57 +++++++++++++++++++++++++++-----
 1 file changed, 48 insertions(+), 9 deletions(-)
---
base-commit: e3684df8e778a9988b7f7a84e08daea8019b661e
change-id: 20260423-macb-drop-tx-f9ce72720d05

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>


