Return-Path: <stable+bounces-265901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id non5HI6SMWpYnAUAu9opvQ
	(envelope-from <stable+bounces-265901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:14:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22CF693F10
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:14:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fkPcNZ5O;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265901-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265901-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 352D130C4A43
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8353D566F;
	Tue, 16 Jun 2026 18:13:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AE33D812A;
	Tue, 16 Jun 2026 18:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633594; cv=none; b=jFaVmaGv3bsjQdCaFIWADncJCXMUlgV2SFLHTGpEeakgq6/aFqspKcEWqR+L+trh6r8os02EEfxS9fSXc783ngmQXpqaVHfjIZJjVSpfiOL2sblDaZB27yqPO0lf99C1l0sL1YoqjfERwChBHmZ1Cg28QpeQFUDn69HsH8sUzV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633594; c=relaxed/simple;
	bh=oC3AKgPQ9WjE6XjeSRM3+QvBQpv3a0epUMTkqtBvzsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoP+9fwqy0sYXW8K6EvKpebcjnEYa/wfxpkkvKrG8GF2KxXd++y6p2DNlxGpCtVQpqvACPfTnSQbdSgkrxzFTzSX7Ib1h/H6LebnJp/7v/lVhdK7wpo8SzirAsOsGCrsUdfYLX65zweXS1/ScbzMGngqM+L824hCA9D36QjDt8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fkPcNZ5O; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEBB1F000E9;
	Tue, 16 Jun 2026 18:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633593;
	bh=5AY2Pap/ddtkpyVsu6swpi1p9rDGAd4X3imOqGpsB3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fkPcNZ5ONwxnLOhhu1/duUA2eji/aeeVuy3LmV3gISzqV9a1qJJo56nbg+o5CyN2+
	 rjEGXRt+2IW3SoPBXUDsOyZDyfApZBniFEXeyfdV13t3prgrNXEZtlKCFJNZXqdfbG
	 FLHGXwiDp4zHaYjmJti+4usIEP4/O38742sEXxOc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Pecio <michal.pecio@gmail.com>,
	Tao Xue <xuetao09@huawei.com>
Subject: [PATCH 5.15 108/411] usb: core: Fix up Interrupt IN endpoints with bogus wBytesPerInterval
Date: Tue, 16 Jun 2026 20:25:46 +0530
Message-ID: <20260616145106.007976210@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265901-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:michal.pecio@gmail.com,m:xuetao09@huawei.com,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,huawei.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,huawei.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E22CF693F10

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

commit 727d045d064b7c9a24db3bce9c0485a382cb768b upstream.

Tao Xue found that some common devices violate USB 3.x section 9.6.7
by reporting wBytesPerInterval lower than the size of packets they
actually send. I confirmed that AX88179 may set it to 0 and RTL8153
CDC configuration sets it to 8 but sends both 8 and 16 byte packets:

S Ii:11:007:3 -115:128 16 <
C Ii:11:007:3 0:128 8 = a1000000 01000000
S Ii:11:007:3 -115:128 16 <
C Ii:11:007:3 0:128 16 = a12a0000 01000800 00000000 00000000

Most xHCI host controllers neglect interrupt bandwidth reservations
and let such devices exceed theirs, some fail the URB with EOVERFLOW.

Assume that wBytesPerInterval lower than wMaxPacketSize is bogus and
increase it to the worst case maximum on interrupt IN endpoints. This
solves xHCI problems and appears to have no other effect. Interrupt
transfers are not limited to one interval and drivers submit URBs of
class defined size without looking at wBytesPerInterval. Any multi-
interval transfer is considered terminated by a packet shorter than
wMaxPacketSize regardless of wBytesPerInterval - see USB3 8.10.3.

Stay in spec on OUT endpoints and isochronous. No buggy devices are
known and we don't want to risk sending more data than the device
is prepared to handle or confusing isoc drivers regarding altsetting
capacities guaranteed by the device itself. And don't complain when
wMaxPacketSize <= wBytesPerInterval < wMaxPacketSize * (bMaxBurst+1)
because enabling this seems to be the exact goal of the spec.

Reported-and-tested-by: Tao Xue <xuetao09@huawei.com>
Closes: https://lore.kernel.org/linux-usb/20260402021400.28853-1-xuetao09@huawei.com/
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Link: https://patch.msgid.link/20260518073207.5b7d26e7.michal.pecio@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/config.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -165,7 +165,14 @@ static void usb_parse_ss_endpoint_compan
 			(desc->bMaxBurst + 1);
 	else
 		max_tx = 999999;
-	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx) {
+	/*
+	 * wBytesPerInterval > max_tx is bogus, but USB3 spec doesn't forbid the opposite.
+	 * Experience shows that wBytesPerInterval < wMaxPacketSize on common interrupt IN
+	 * endpoints is usually bogus too, and recent HCs enforce interrupt BW limits.
+	 */
+	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx ||
+	    (le16_to_cpu(desc->wBytesPerInterval) < usb_endpoint_maxp(&ep->desc) &&
+	     usb_endpoint_is_int_in(&ep->desc))) {
 		dev_notice(ddev, "%s endpoint with wBytesPerInterval of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to %d\n",



