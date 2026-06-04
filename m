Return-Path: <stable+bounces-260329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k5r9I1I+IWorBwEAu9opvQ
	(envelope-from <stable+bounces-260329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:58:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EE463E3EB
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 10:58:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=xGQatzS2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260329-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260329-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED313178477
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BBE3FBB62;
	Thu,  4 Jun 2026 08:45:27 +0000 (UTC)
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A983FAE1F
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:45:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562727; cv=none; b=Cf7VmIpxAOACptH9l2rzf6nCz/ANbZxcOV6mLHS6JUKMyDBC31dyPe3kkV/Tvb6wk1B2I+a6CwXVVkzTYrxVytbLgnQdOEMVaJbHEQSPSHVlThYJYlWIBGqXLA0fRZCh+1IPgPsw0SwLnjux9+4LjlZpOUtEDbL+IC36uXqIIws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562727; c=relaxed/simple;
	bh=MhRZ3VAu2oEHGeQICZgpM7TyVP5+ZmGhDg3RVQOMBQk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fyLXxEBKx2XH8MB/rm7KrVGNENJxD68LBpTRYCrjE3M2XzphM7neT1c3S9BXytSatQbYZfkE/zMBClB9PMkFmOtX4G5h0gpSksqDuxH5+Qla6wvE8lJOz+/DLMkKU/yEZG5giAaHxdIo9/57CcH3YzejTyyuDq4FjQJCHBImKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xGQatzS2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9C81F00893;
	Thu,  4 Jun 2026 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562726;
	bh=1+S/RypXQIfTo8ZN4YTtBXVrNHxlpObOmoCSvvcaq0Y=;
	h=Subject:To:Cc:From:Date;
	b=xGQatzS2z0ZfPQtZ77xaFiOEYaHhysBw7n9l2BlPbO6bg139U8XEYx2digaSEGkXf
	 jd4s+kHVVW0TDUf7d0jxbjKOHBUYccW20ZnBiZ1wAO/ZDeIj8re7FMkhrZbKDuLD6t
	 tFEUynvWmI8IKrF2+NTscKnWNatCTXZCi4pZlWuk=
Subject: FAILED: patch "[PATCH] iio: dac: ad5686: acquire lock when doing powerdown control" failed to apply to 5.10-stable tree
To: rodrigo.alencar@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:44:29 +0200
Message-ID: <2026060429-struggle-judiciary-4ace@gregkh>
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
	TAGGED_FROM(0.00)[bounces-260329-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rodrigo.alencar@analog.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F0EE463E3EB


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5237c3175cae5ab05f18878cec3301a04403859e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060429-struggle-judiciary-4ace@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


