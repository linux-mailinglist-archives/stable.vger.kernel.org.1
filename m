Return-Path: <stable+bounces-263051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T1fWN69ELmrDrgQAu9opvQ
	(envelope-from <stable+bounces-263051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 08:05:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD968074C
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 08:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=GsNpk+UF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263051-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263051-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14A223015853
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 06:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB57C2DC764;
	Sun, 14 Jun 2026 06:05:15 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FE318EE2
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417115; cv=none; b=TZFV1dDtIBSj0gAMwB8C5ac1SEdMXm7c2hXQtfcjRd77B1ajCyMQc5V9MoatkvyXhJ1Xc00yf7fKivd53jIk05ED0jVnL2M7ce7FjQzEtRI5VnfP5utGQBC8Knl9wXc4tI5WLwYlHP7cro5saLW51P6PaFXyfXnpV6M6TqlzJFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417115; c=relaxed/simple;
	bh=rRe5au9idbX+SXqYsVRDNKFosEXD1UyP5gK5wp9kWro=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=LXXPGyduwQC/HKZwq6mBOlrGOd+WU0rEiXTL9m8nz9p/irs6qL221x2RmeQT0I8WrPiUDre0IBgeo97IIVpZ8mAaUxTNF89YO9B3fXKYF7mZFdBi5U9akTr2+cVDGPvnLh/tz40VDGHynLjwPcQeFKtveC/H8iG+cdwqQalFKrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GsNpk+UF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964481F000E9;
	Sun, 14 Jun 2026 06:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417114;
	bh=2p9SIwMQMi/A2L8OuH858lh8mmhHXmHorIyY73OSbOo=;
	h=Subject:To:From:Date;
	b=GsNpk+UF2o54WAN1x8uF0HnjMk8ITjPUbejUh91SYA7xCDu4RRSHtc8qYo2Givp7R
	 7sNJhScF6yvY0hpnU1Im85UW9Q7J2Fq1xyOr21ar1Kx0O5lelovdCOS9jSZb5UfSW8
	 GMK/xjb2aKeQLX40j5LEpr3deY+CaJ1iqqMEXe5M=
Subject: patch "iio: light: al3320a: read both ALS ADC registers again" added to char-misc-next
To: grandmaster@al2klimov.de,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:37 +0200
Message-ID: <2026061437-subplot-aerosol-75b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263051-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:grandmaster@al2klimov.de,m:Stable@vger.kernel.org,m:jic23@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,gregkh:mid,vger.kernel.org:from_smtp,al2klimov.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 74AD968074C


This is a note to let you know that I've just added the patch titled

    iio: light: al3320a: read both ALS ADC registers again

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 744bccc2647c6b2206290e8e40890a23812116b3 Mon Sep 17 00:00:00 2001
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Sat, 23 May 2026 13:44:58 +0200
Subject: iio: light: al3320a: read both ALS ADC registers again

al3320a_read_raw() used to read two adjacent registers
until the driver was modernized using the regmap framework.
That cleanup accidentally replaced the 16-bit word read
with a single byte read. I'm reverting latter.

Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/al3320a.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 63f5a85912fc..b9076f434417 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -135,7 +135,8 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 			    int *val2, long mask)
 {
 	struct al3320a_data *data = iio_priv(indio_dev);
-	int ret, gain, raw;
+	int ret, gain;
+	__le16 raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -144,11 +145,12 @@ static int al3320a_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3320A_REG_DATA_LOW
 		 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
 		 */
-		ret = regmap_read(data->regmap, AL3320A_REG_DATA_LOW, &raw);
+		ret = regmap_bulk_read(data->regmap, AL3320A_REG_DATA_LOW,
+				       &raw, sizeof(raw));
 		if (ret)
 			return ret;
 
-		*val = raw;
+		*val = le16_to_cpu(raw);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.54.0



