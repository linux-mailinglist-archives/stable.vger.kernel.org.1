Return-Path: <stable+bounces-262108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XS1XCIYbJ2oEsAIAu9opvQ
	(envelope-from <stable+bounces-262108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:44:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 693A365A214
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 21:44:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=QSn3IHpf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262108-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262108-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693363037B87
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44C83E6DFF;
	Mon,  8 Jun 2026 19:42:27 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6502387363
	for <Stable@vger.kernel.org>; Mon,  8 Jun 2026 19:42:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947747; cv=none; b=mHjgVyQbUbPPnyLdLpyz53v9yF5P/NpyUYhpQOwSOEEirSbiig/4ZKU+KlAlSlq1cdTd0KfjEaoay1KwQgegbi5sep8bImPA0ZSGBlrjeuHXtCAMUY9cwEYEgnH8EWZcgH6aBILDRH2wxWgMPMaGRwtMZ7/klFiySaWcDXW6McU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947747; c=relaxed/simple;
	bh=kkR11O5JNerz44GLs76rgb1MOjWu0AQL34WKmDAxbTE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=p82n6PbjwQYuMlilUreYlEm7bWcfYKZtEeIskXI8olprs7Kg08ieex7RdpZizkp3ma4/oS5DU3DDU355FvCPGnQaUeAZCcWzTYk0vtpWuI2WssrUpw9uwsV6aW3X8DawbOoeJwjngPgDSCCEyXj7yFcdgsITF2lResVGjmEOguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QSn3IHpf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A901F00893;
	Mon,  8 Jun 2026 19:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780947746;
	bh=CwFSpyUsjPQcAGifiwGPjyNNXwU0CdD9LCCP/L1m8Dk=;
	h=Subject:To:From:Date;
	b=QSn3IHpf1h7/q2YNaNZ7bBh9vOdWIe9t8hjyODQSbRw2weZ8LJR7itdFv3fnJQpSb
	 ocB10NzngWzx+cXm7S1rDinO6TzWQpEW54qGG+wXfReSchQ9nJTytjQrnWKYq+fbYw
	 dVRRO4pEuw5CLnZXORHaQ1+2wexMdARPlPQJ1/qM=
Subject: patch "iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend()" added to char-misc-testing
To: andriy.shevchenko@linux.intel.com,Stable@vger.kernel.org,jic23@kernel.org,joshua.crofts1@gmail.com,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Mon, 08 Jun 2026 21:30:32 +0200
Message-ID: <2026060832-elated-busybody-1b5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262108-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,vger.kernel.org,kernel.org,gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andriy.shevchenko@linux.intel.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:joshua.crofts1@gmail.com,m:sashiko-bot@kernel.org,m:joshuacrofts1@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 693A365A214


This is a note to let you know that I've just added the patch titled

    iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend()

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From e94944d7364d3ddb273539492f9bd9c9a622549a Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Wed, 6 May 2026 10:27:55 +0200
Subject: iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend()
 call

On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
Balance it by calling pm_runtime_put_autosuspend() on error path as well.

Fixes: cde4cb5dd422 ("iio: magn: ak8975: deploy runtime and system PM")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5550fc%40gmail.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 44782c26698b..e70101abfcd3 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -784,6 +784,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
+	pm_runtime_put_autosuspend(&data->client->dev);
 	dev_err(&client->dev, "Error in reading axis\n");
 	return ret;
 }
-- 
2.54.0



