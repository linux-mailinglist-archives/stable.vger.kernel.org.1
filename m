Return-Path: <stable+bounces-265488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tgBzBrqKMWpzmAUAu9opvQ
	(envelope-from <stable+bounces-265488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:41:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AD66935DE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:41:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Bayado9z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265488-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-265488-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D2E9300F268
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55847AF5F;
	Tue, 16 Jun 2026 17:37:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E3331A44;
	Tue, 16 Jun 2026 17:37:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631456; cv=none; b=czTOXNWb+6v/9GM8JFhmQVJooAvn6mWVM9boHtdMzPYiihJ0oqkDohZbdHKzdfBvX/OoLWao2qCC477+Z0K+3YfyXh729KIWSbD6AzbDVgxuCcXzZZSEVBIFJHPoIzRT+j0w3XORns0MhvMvXFgZYTVvwUt3CwLTaDvccGj0j1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631456; c=relaxed/simple;
	bh=YU/FB4lL9eJofz9RHrCyr7p7lvdiS9Xbrj5FLzb6k1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsrdoERsUgIO0i4zIktRSE/SxQi70rzA1nJ25jE9j5etBfKTlqvLXDcpFbJzpkmii55SfXF952b0f0wl5eblwvMKsYGDKGVVaKwDQKjddAEvfzQa2G2LA8apqgO1XRX3EgPlzYcBK+oQxry75CHP2hKxvrIW0H6OSj20YiR0hls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bayado9z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AAF1F000E9;
	Tue, 16 Jun 2026 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631455;
	bh=KOdk38Eh8YedefCdKSEoJk9jHtEPCX4vHwVbWrAz+nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bayado9z6Kq81AoWJqWFHvlcRfex+8tnrd4YxVWIWCoMWkjfuPgAnC6yHmwvVGajm
	 FBlHwgrXErsDKju1nOyZBdE3Vwc9GMS6eeeLdsgGMwY8q1RTd3Xtd34xXbUvPmAcoO
	 tjL/mw+2jYcBTcWaoGkHFaQozzl6okA/oAu0/Xy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 225/522] net/802/mrp: fix vector attribute parsing in mrp_pdu_parse_vecattr
Date: Tue, 16 Jun 2026 20:26:12 +0530
Message-ID: <20260616145136.538051258@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn,kernel.org];
	TAGGED_FROM(0.00)[bounces-265488-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zhaoyz24@mails.tsinghua.edu.cn,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,seu.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tsinghua.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 13AD66935DE

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

[ Upstream commit 7561c7fbc694308da73300f036719e63e42bf0b4 ]

In mrp_pdu_parse_vecattr(), vector attribute events are encoded three
per byte and valen tracks the number of events left to process.

The parser decrements valen after processing the first and second events
from each event byte, but not after processing the third one. When valen
is exactly a multiple of three, the loop continues after the last valid
event and consumes the next byte as a new event byte, applying a
spurious event to the MRP applicant state.

Additionally, when valen is zero the parser unconditionally consumes
attrlen bytes as FirstValue and advances the offset, even though per
IEEE 802.1ak a VectorAttribute with only a LeaveAllEvent has valen of
zero and no FirstValue or Vector fields. This corrupts the offset for
subsequent PDU parsing.

Also, when valen exceeds three the loop crosses byte boundaries but
the attribute value is not incremented between the last event of one
byte and the first event of the next. This causes the first event of
the next byte to use the same attribute value as the third event
rather than the next consecutive value.

Decrement valen after processing the third event, skip FirstValue
consumption when valen is zero, and increment the attribute value at
the end of each loop iteration.

Fixes: febf018d2234 ("net/802: Implement Multiple Registration Protocol (MRP)")
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Link: https://patch.msgid.link/20260603060016.21522-1-zhaoyz24@mails.tsinghua.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/802/mrp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/802/mrp.c b/net/802/mrp.c
index 6c927d4b35f06e..dea0fd28cbed88 100644
--- a/net/802/mrp.c
+++ b/net/802/mrp.c
@@ -702,6 +702,12 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 	valen = be16_to_cpu(get_unaligned(&mrp_cb(skb)->vah->lenflags) &
 			    MRP_VECATTR_HDR_LEN_MASK);
 
+	/* If valen is 0, only a LeaveAllEvent is present; FirstValue and
+	 * Vector fields are absent per IEEE 802.1ak.
+	 */
+	if (valen == 0)
+		return 0;
+
 	/* The VectorAttribute structure in a PDU carries event information
 	 * about one or more attributes having consecutive values. Only the
 	 * value for the first attribute is contained in the structure. So
@@ -752,6 +758,9 @@ static int mrp_pdu_parse_vecattr(struct mrp_applicant *app,
 		vaevents %= __MRP_VECATTR_EVENT_MAX;
 		vaevent = vaevents;
 		mrp_pdu_parse_vecattr_event(app, skb, vaevent);
+		valen--;
+		mrp_attrvalue_inc(mrp_cb(skb)->attrvalue,
+				  mrp_cb(skb)->mh->attrlen);
 	}
 	return 0;
 }
-- 
2.53.0




