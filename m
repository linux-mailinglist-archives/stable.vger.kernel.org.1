Return-Path: <stable+bounces-263032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PA7UMRBDLmr9rQQAu9opvQ
	(envelope-from <stable+bounces-263032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:58:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597616806DB
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 07:58:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YDzI8W3E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263032-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263032-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7097630039B5
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 05:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A8B2F12AB;
	Sun, 14 Jun 2026 05:58:37 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD095247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:58:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416716; cv=none; b=KtjOKNJRKAtaqJ1i9Kmyly/1vqZ64txeSdZN1T2olpgAQBLeR77D9LdLDZDipthJSojbwQqxRp6zJiu9L5Fe7JUYlBjZCfzbkNi5936LFwFCNbtPWfH/bCwE7DQKtUXyvVH0T5puoxS5hQx5lBLLn0UJgGKU2bEtI+rfZVVJ8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416716; c=relaxed/simple;
	bh=o4Et1rg/GTLZUIpFgsBY3YW1Nt1CPsr4q2G4cSIcM2I=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=GG5CTh8nGr/Cd8Cq/1DSJaq+2Uk/Yp5MFVqL8kZhhOGr60NnU8iY9av5XR8Tcp3oQSUvAQdm62bgQox7YKc4bpWI5iQwNp+XXaBfTYC0N+9o4ovkpsRykLQNlYqYEagHC+e1r+7gQvhw9TuwzURWmytr/k9YXX86sOCfFHcQ2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YDzI8W3E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CCD1F000E9;
	Sun, 14 Jun 2026 05:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416715;
	bh=OsQteTfjfuBRVLbW1mezculhkXLfWAnmtrp//DU9mYs=;
	h=Subject:To:From:Date;
	b=YDzI8W3ENhGDeWZOQqKwr7Tgr2idAeDaiIXh3hJOX0WfatdheXTYx/JfTKyNxcJS7
	 wmqrMnCp4LlJJdK0WgyQoRoJ6O96+QDlAaHUTX1yPNAGf2q3iTov2TyuDmJ7MU3P+m
	 rx9sREhtF8D+91Mf5TDefvWC69uOgIcfhPFqAB6k=
Subject: patch "iio: gyro: bmg160: bail out when bandwidth/filter is not in table" added to char-misc-testing
To: sozdayvek@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:17 +0200
Message-ID: <2026061417-resistant-unengaged-0c1c@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263032-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sozdayvek@gmail.com,m:Stable@vger.kernel.org,m:andriy.shevchenko@intel.com,m:jic23@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,intel.com,kernel.org];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 597616806DB


This is a note to let you know that I've just added the patch titled

    iio: gyro: bmg160: bail out when bandwidth/filter is not in table

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 8320c77e67382d5d55d77043a5f60a867d408a2b Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Sun, 10 May 2026 07:35:00 +0500
Subject: iio: gyro: bmg160: bail out when bandwidth/filter is not in table

bmg160_get_filter() walks bmg160_samp_freq_table[] looking for the entry
matching the bw_bits value read from the chip:

	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
		if (bmg160_samp_freq_table[i].bw_bits == bw_bits)
			break;
	}
	*val = bmg160_samp_freq_table[i].filter;

If no entry matches, i ends up equal to the array size and the next line
reads one slot past the end. bmg160_set_filter() has the same shape, driven
by 'val' instead of bw_bits.

smatch flags both:

  drivers/iio/gyro/bmg160_core.c:204 bmg160_get_filter() error:
  buffer overflow 'bmg160_samp_freq_table' 7 <= 7
  drivers/iio/gyro/bmg160_core.c:222 bmg160_set_filter() error:
  buffer overflow 'bmg160_samp_freq_table' 7 <= 7

Return -EINVAL when no entry matches.

The set_filter() path is reachable from userspace via the sysfs
in_anglvel_filter_low_pass_3db_frequency interface, so userspace can
trivially trigger the out-of-bounds read with a value that is not in
bmg160_samp_freq_table[].filter.

Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/gyro/bmg160_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3275..58963f3ea186 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -201,6 +201,9 @@ static int bmg160_get_filter(struct bmg160_data *data, int *val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	*val = bmg160_samp_freq_table[i].filter;
 
 	return ret ? ret : IIO_VAL_INT;
@@ -218,6 +221,9 @@ static int bmg160_set_filter(struct bmg160_data *data, int val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW,
 			   bmg160_samp_freq_table[i].bw_bits);
 	if (ret < 0) {
-- 
2.54.0



