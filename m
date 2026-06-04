Return-Path: <stable+bounces-260370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UzD9CPdUIWpxDwEAu9opvQ
	(envelope-from <stable+bounces-260370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:35:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1522963F175
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:35:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ZDI6Zfii;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260370-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260370-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D11730FD6A3
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231433431EF;
	Thu,  4 Jun 2026 10:16:57 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD8C1E1E16
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 10:16:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780568216; cv=none; b=Ntyenm1OVtY8G8dIRmokapyePcdxKLG/VPDN2r1jfDmV0Agr3a/XlNL5yfZOZJuY96sVz0HMQTGojEuE5Oq8JqSMlL7WOQubJabPPJdvvfpwppt/EmUgZiPiohAJ5t+Ml69kIkioOT6uKjLCUdpO2UVHgnkOfjSNfssarRvUumI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780568216; c=relaxed/simple;
	bh=VAKMw0ZPq0soWXuZdjSmTIpMVjSTteBkuQk8tSiABWQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cSK7KzjXOFAjDpPGtCMucXrS4rzolvqKPXCSdTRmeyyoGCwWMus4KAD/wQBovpkrper+ficKRmMEKfojUaORzfFQfEB3f4K5fCBQfkhgvx4dWkaMKuoGFfscad8SybYkej40hS09RRjI4Pmx7g9lfgROc38WRdZfA+tabacpf3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZDI6Zfii; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D771F00893;
	Thu,  4 Jun 2026 10:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780568215;
	bh=li+/a9v/YjA3OYwlFOjuMPcxea+FXXANd+Nr6Pfm38Y=;
	h=Subject:To:Cc:From:Date;
	b=ZDI6Zfiipo3B++j3PTK5G6/A6eXvG4mcCFqGAknuvdRE4NQWWIGQBTXP2XXZGe4wr
	 AA1mK4RrLJ6M99uIB3QAVpFFHYmwRTdGWD6Ub5jvxhn2Um8Ml1oR+wHhVOWT78oXjt
	 YcOjC7G8BWOnBTEYkmK5E4AGWhDakDYJ3zh/8BwM=
Subject: FAILED: patch "[PATCH] iio: dac: ad5686: acquire lock when doing powerdown control" failed to apply to 5.15-stable tree
To: rodrigo.alencar@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:15:58 +0200
Message-ID: <2026060458-baked-charter-80ae@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260370-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rodrigo.alencar@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1522963F175


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 5237c3175cae5ab05f18878cec3301a04403859e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060458-baked-charter-80ae@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5237c3175cae5ab05f18878cec3301a04403859e Mon Sep 17 00:00:00 2001
From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 5 May 2026 13:35:04 +0100
Subject: [PATCH] iio: dac: ad5686: acquire lock when doing powerdown control

Protect access of pwr_down_mode and pwr_down_mask fields with existing
mutex lock. Each channel exposes their own attributes for controlling
powerdown modes and powerdown state. This fixes potential race conditions
as those the write functions perform non-atomic read-modify-write
operations to those pwr_down_* fields. This issue exists since the ad5686
driver was first introduced.

Fixes: c2f37c8dcadc ("iio: dac: New driver for AD5686R, AD5685R, AD5684R Digital to analog converters")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 27878a6318ff..2e443fcfeb39 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,6 +30,8 @@ static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
 }
 
@@ -39,6 +41,8 @@ static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
 	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
 
@@ -57,6 +61,8 @@ static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 {
 	struct ad5686_state *st = iio_priv(indio_dev);
 
+	guard(mutex)(&st->lock);
+
 	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
 				       (0x3 << (chan->channel * 2))));
 }
@@ -77,6 +83,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
 		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
 	else


