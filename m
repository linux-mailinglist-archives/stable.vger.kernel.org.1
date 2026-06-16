Return-Path: <stable+bounces-265409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VabBFV+IMWp5lwUAu9opvQ
	(envelope-from <stable+bounces-265409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7213693368
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:31:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=XXgc6V1J;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265409-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265409-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 495E7303BDCC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA8147A0DA;
	Tue, 16 Jun 2026 17:30:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7032ED55;
	Tue, 16 Jun 2026 17:30:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631053; cv=none; b=sbJvKcV3cYOP4gpm0Sw9KfRMlnr+U42pR1BIX0z0zSZp5/db5wy41JcaULaZv+7dmcVjQlQTX3K13mI0IAObKrt0ObznbUQHAVGvvxczL3U2IDZwough8BP0xVcJkSBsezBuOkQguC9BdYPVQqI3ZD0e1MKSl8HM62dyg3FaoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631053; c=relaxed/simple;
	bh=q2MJKQqPg0BCdfoL8nDt2FH8WwrEjCJYdRXTIaZPRIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eeOUJixHoNFry7XDBTRAg6CE+NW2qCCkLsySwJ9vjYnHjeRfvem0HSrt/Pak1VHo6d80IwH/cXAKUXlJZaDT7WM5GzVEczejHrKd6G8s7TYP6LfKRTvzkmsOFbwoswXIFu2BosjX9+CKJitLjo31JvZwmf2kOkLXyxdD1TQlc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XXgc6V1J; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD801F000E9;
	Tue, 16 Jun 2026 17:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631052;
	bh=P4iOlVXIx3RbeNvevBRUf+Syt8sPfy60Ov4jx15wwbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXgc6V1J4QfoBnqG2E2giwUY+GQYR7xyDOgmEJ9ehispzpBZ6FymYlrazBE3+yxeZ
	 6KeY7ibOSA7zZu9gM6Xy+BZZP8Q4wcL2zZiAUmftUleeuUBJPev3XxVcIiZ2GR5dDK
	 Upmp33aCnj+xREjn/aiy1U+zmQXMcCtj6GQXPXJg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	Heitor Alves de Siqueira <halves@igalia.com>
Subject: [PATCH 6.1 148/522] usb: usbtmc: check URB actual_length for interrupt-IN notifications
Date: Tue, 16 Jun 2026 20:24:55 +0530
Message-ID: <20260616145133.011169071@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,syzkaller.appspotmail.com,kernel.org,gmail.com,igalia.com];
	TAGGED_FROM(0.00)[bounces-265409-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com,m:stable@kernel.org,m:michal.pecio@gmail.com,m:halves@igalia.com,m:syzbot@syzkaller.appspotmail.com,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,abbfd103085885cf16a2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url,igalia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7213693368

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heitor Alves de Siqueira <halves@igalia.com>

commit 52f2ad3f7e5eb3b5908e1d685d4342519dc9cfcd upstream.

USBTMC devices can use an optional interrupt endpoint for notification
messages. These typically contain two-byte headers indicating the
payload format, but the driver does not check if these headers are
present before accessing the data buffers. In cases where the URB
actual_length is not enough to fit these headers, the driver will either
cause an out-of-bounds read, or consume stale leftover data from a
previous notification.

Fix by checking if actual_data contains enough bytes for the headers,
otherwise resubmit URB to the interrupt endpoint.

Fixes: dbf3e7f654c0 ("Implement an ioctl to support the USMTMC-USB488 READ_STATUS_BYTE operation.")
Reported-by: syzbot+abbfd103085885cf16a2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=abbfd103085885cf16a2
Cc: stable <stable@kernel.org>
Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Heitor Alves de Siqueira <halves@igalia.com>
Link: https://patch.msgid.link/20260505-usbtmc-iin-size-v3-1-a36113f62db7@igalia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/usbtmc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2310,6 +2310,14 @@ static void usbtmc_interrupt(struct urb
 
 	switch (status) {
 	case 0: /* SUCCESS */
+		/* ensure at least two bytes of headers were transferred */
+		if (urb->actual_length < 2) {
+			dev_warn(dev,
+				"actual length %d not sufficient for interrupt headers\n",
+				urb->actual_length);
+			goto exit;
+		}
+
 		/* check for valid STB notification */
 		if (data->iin_buffer[0] > 0x81) {
 			data->bNotify1 = data->iin_buffer[0];



