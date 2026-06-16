Return-Path: <stable+bounces-265921-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o5yRDaySMWprnAUAu9opvQ
	(envelope-from <stable+bounces-265921-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:15:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B63F5693F49
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:15:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="bpp/s8hY";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265921-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265921-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356383172CA9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E353D47CE;
	Tue, 16 Jun 2026 18:14:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3853CEBBD;
	Tue, 16 Jun 2026 18:14:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633699; cv=none; b=gvA5+NOumafGBtLvC97R9wa5ha6/prre2WPiqsDc2nFTr5fMkrYnGttjIFTvnCtRfG4hxjjk0TUjhxlNk0XCzOJa5Pefk8Og+1b/B9EXSFqW2U3XMxMik+QcXHz3Vx0abm0CVQT+LJlNJlEePS8lN6cVCzztiz9XhPJwUtzl8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633699; c=relaxed/simple;
	bh=biLggEn2GhmXPBxNLWXQj/6zpQTwfuYnHXCxGkFeQns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uykNVNdxn/5Ul4tWDhai57P8J4t20Te4O2YLI4tjKzN5F6Zg+JxWrsCRy7joUkqsGQhGeqVXGifBVvL8aecYqfd44Kuz85MCVohcGV/l80VBrzKrwxGkukhvHB3S/WSjM7YOKVzUWJ5iPrVli1JeqGSACI8zfuhThUwdsk0KRjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bpp/s8hY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624511F000E9;
	Tue, 16 Jun 2026 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633698;
	bh=Bp+jGTSi7WwnsakLN7+68jyKG8ZIh+xNUAZm3r66X78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpp/s8hYSSmiCPwgRQvmJpZ6NVesUc+dhkNHmUkr9feI+ynclEiHN+wKtAGeUJls5
	 CJa4HVaJYp5j3/T+ECwX0B4EMHe4HvIIyc5ee7/VXICKm2EftRKZVTqwgoWUDsPTAa
	 r4mysIiu1eosaRQrsFeNgZ/pH6L8ErfDieFRas/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 085/411] macsec: fix replay protection at XPN lower-PN wrap
Date: Tue, 16 Jun 2026 20:25:23 +0530
Message-ID: <20260616145104.770269951@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265921-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:danisjiang@gmail.com,m:moonafterrain@outlook.com,m:kuba@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B63F5693F49

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit e68842b3356471ba56c882209f324613dac47f64 upstream.

In macsec_post_decrypt(), when pn is U32_MAX, pn + 1 overflows u32 to 0
and the first branch never fires. If next_pn_halves.lower is also in the
upper half, pn_same_half(pn, lower) is true and the XPN else-if does not
fire either, leaving next_pn_halves unchanged. An attacker that captures
the legitimate frame carrying pn == 0xFFFFFFFF on an XPN association
can then replay it indefinitely, since lowest_pn never rises above
the captured pn and macsec_decrypt() reconstructs the same IV.

Extend the XPN else-if to also fire when pn + 1 wraps to 0, so receipt
of pn == U32_MAX advances next_pn_halves to (upper + 1, 0).

Fixes: a21ecf0e0338 ("macsec: Support XPN frame handling - IEEE 802.1AEbw")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Link: https://patch.msgid.link/SYBPR01MB78813FD49E58F253B989F197AF012@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/macsec.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -824,7 +824,8 @@ static bool macsec_post_decrypt(struct s
 		if (pn + 1 > rx_sa->next_pn_halves.lower) {
 			rx_sa->next_pn_halves.lower = pn + 1;
 		} else if (secy->xpn &&
-			   !pn_same_half(pn, rx_sa->next_pn_halves.lower)) {
+			   (pn + 1 == 0 ||
+			    !pn_same_half(pn, rx_sa->next_pn_halves.lower))) {
 			rx_sa->next_pn_halves.upper++;
 			rx_sa->next_pn_halves.lower = pn + 1;
 		}



