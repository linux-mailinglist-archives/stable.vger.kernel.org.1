Return-Path: <stable+bounces-268129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UQ9tAj+oO2qkawgAu9opvQ
	(envelope-from <stable+bounces-268129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:49:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982816BD0EE
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 11:49:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=HR+15po+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268129-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268129-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BCCE3018BF0
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 09:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F33B893C;
	Wed, 24 Jun 2026 09:48:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CF62EEE7B;
	Wed, 24 Jun 2026 09:48:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782294508; cv=none; b=M9P5WFYz+EmrQ7fXNQ2k3d0GY/mjf5YYsmvW0+jjn1V723jlWBe+NNTIfzOcR3uEI11ategpEdcbOO1nf7TWOk6lXMLBc++Rct6W9MtjPftoPOcjrPx8Ko1Hxh9GFmmBB72K98xeIhke5rApRDWuLwpOzSPlfJllL5Gr4uISlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782294508; c=relaxed/simple;
	bh=Ib6Nfw8Bxf016usbY9np812MuOm2KJ8WCraqSIuQTDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKA9AkAmKIbdVlNNoM88YiDn1aHmiEq9tTaisNGyDc9gvK4ZyuUyjZT1enf4jPo/YXbyLEQlByxay80949q3tn6N+dVHlBkKo7BdbTDtcJA1UX8vgnUjI39HuEjoHjbwcT+t7rWooQn9DfeAQtL4PS+6KAxYcrThoHMotJC/9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HR+15po+; arc=none smtp.client-ip=52.59.177.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782294468;
	bh=plWgbLtUpR634DYvUSGAQODOkMojss9ye2y6WT4yKSg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HR+15po+rpghZZSUnchct9DNeIZarM7l43Vr4Ophf7lMi7b0W5yFfXzotDj1XY6JU
	 daOyZ8LkhVh9zTGbI7kMvPB8dZFn4ZNN50/Wzg0dlIZSZkA5+zsCWtmLUmlp2I20WS
	 aApJ2nN2Tryjo7o2AsEocqm1hz8WiFtXVe3unftc=
X-QQ-mid: zesmtpgz8t1782294464tbeb4cc39
X-QQ-Originating-IP: dKW6+wiPIAheWHLP0SUnNj08CUT2eY4MA5RGvdiKo/I=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 17:47:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4957559374499701399
EX-QQ-RecipientCnt: 8
From: raoxu <raoxu@uniontech.com>
To: James.Bottomley@HansenPartnership.com
Cc: deller@gmx.de,
	dmitry.torokhov@gmail.com,
	linux-parisc@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] Input: gscps2 - advance receive buffer write index
Date: Wed, 24 Jun 2026 17:47:39 +0800
Message-ID: <460B5655BA580C60+20260624094739.850306-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MmIUUz9KGMMdf7ciTnOWCYjf+qHinLV0KcmFcoutrucLq7benMVZ+l3R
	WydHuPVp2TGA880Y2Aj73i3OaxV2sfZBtWAD3g/ghYgBAfgTa5pjoKovJ9HYZiEU35SHNhk
	jeWiBL0zWeASvj6pNk0vVR1j1yzQ5hPCPOkMZGqiA/LTH+C3zx6ugqCZxzwLRtPB490diZI
	ZBVa4XePjEqNgP/qSkU/EmnhVbsq0HjJvmICLZhU6Gp8HMeri4ue9M14u9GLE30YL17p34e
	0p7fg0Wyx9WqaqLlO2IVbEG09WYDq/PFLQ3TYQlPIR84L3NzlG2QFDd0Vthq7YRG8SxM8mW
	Y80wIFids7vsHmmqIWDrcECrLYAieYvEJyTOWtfxISykDc0SHMA29j3JFkDwuyf0wDdFsVh
	k+a2nMslajrxqKpwEmtymjR+9WBorEzllF0FMoSfZfzLzsm39fJUXVkH3eglaWMNzkR+FRj
	WG2SyMslNjivL2sAnq2YPHQ7rUR168kAtcLcR9/tz7BSITktQ31q433XO8Nex7ZXGE+EWeO
	xTB4h6AOhiT3sc4Cid5WKt9vROG9i9PxjEfi2ery/fJRFnxEfRsNgdYlvJDG18KNGJc03r8
	Kz7cnZGQtpp1m+zMxbVXj1HDnKyS/20XyBYAC9rgzNsLOG/Tgs3uEO5fIgblO4hOc6b4XgM
	CMXMfWvpbJYrSp339LoMv3pK/ZRiOunmjcr+zs1MDRzBP9RpfPoRz/4AiiMCXs/VMIjfEFb
	DNWt9DRGavTnMMhQ3FOBZRbQnLX8D6zEmwzR4F6iXngCVaGRxLKXf2N9IhMLv+vZhE7Qs76
	K9a+4fAN5VTAmJJZwcMDGW/YB7cD6ID9VE/axH3A18X85R00836F+csaU4qV3GHCAxyNuvO
	20zbNYch1SbgisatQjN3HM0iFJ6DqVZfNATe2MPwGUZAXlhC/srvkUd4Sr8/U6tR3fQYttv
	gVr2e8TPXQmq8h1+la8mkAnj1KxwSxt6jiEK/qaxiqvFoXRGItQdnwsNT/7dFGO1YaU4jPe
	JaOXSlCvXVftbuDp/8pkLfrRYK939uzPOKPZR5Xaoi6QAChKx5dtej+QJKoiljc6dQbfBtu
	/hZU+fV2xYI
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,gmail.com,vger.kernel.org,uniontech.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268129-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:deller@gmx.de,m:dmitry.torokhov@gmail.com,m:linux-parisc@vger.kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 982816BD0EE

From: Xu Rao <raoxu@uniontech.com>

Commit 44f920069911 ("Input: gscps2 - use guard notation when
acquiring spinlock") moved the receive loop into gscps2_read_data()
and gscps2_report_data().

While moving the code, it preserved the writes to
buffer[ps2port->append], but omitted the following producer index
update from the original loop:

	ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;

As a result, append never advances. Since gscps2_report_data() only
reports bytes while act != append, the receive buffer always appears
empty and no keyboard or mouse data reaches the serio core.

Restore the omitted index update.

Fixes: 44f920069911 ("Input: gscps2 - use guard notation when acquiring spinlock")
Cc: stable@vger.kernel.org # 6.13+
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/input/serio/gscps2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 22b2f57..bf9b993 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -219,6 +219,7 @@ static void gscps2_read_data(struct gscps2port *ps2port)
 		ps2port->buffer[ps2port->append].str = status;
 		ps2port->buffer[ps2port->append].data =
 				gscps2_readb_input(ps2port->addr);
+		ps2port->append = (ps2port->append + 1) & BUFFER_SIZE;
 	} while (true);
 }

--
2.47.3

