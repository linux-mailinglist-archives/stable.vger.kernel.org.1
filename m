Return-Path: <stable+bounces-226005-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D/YKS9UuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226005-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:16:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB52AAACC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8E983137C7A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523DA344D88;
	Tue, 17 Mar 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z1Yg7Y97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AE38F620
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752983; cv=none; b=Tzt7NqtJRkZGwlhzsr/okrF2D7/z+jnhQbhuAs2xlL8YAOocX2hE/Z6mURF6fIC1HkIXwCYzMxozXiZP1ujn7/ZjL1Gcssbx+XLIjrl1KMAJF2ajArjNymZzk5YOLdxX3IuzijGgYb4ijnQF6J7lgK3h8S6VTxOGz9jqSay8JZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752983; c=relaxed/simple;
	bh=UhI31X50ifHGoJjr9We76g7XrCzkEuaVIERby8Nj2xE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uW0Uz1S5a+onHmvB+w+88smauvAjjnktUEqfolzGoHcXTb3lymEEHt5YvyoKWcfvApydlgfdjRxBVlrHWneCz9VpuMN0pMS8a31GUqg2qii9F6GyaDyC4L9VQTJNkvKqsDIqbAv3mnUTr0OBTpQxHNTovsViGZsQXaPt7wa6CY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z1Yg7Y97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099C3C4CEF7;
	Tue, 17 Mar 2026 13:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752982;
	bh=UhI31X50ifHGoJjr9We76g7XrCzkEuaVIERby8Nj2xE=;
	h=Subject:To:Cc:From:Date:From;
	b=z1Yg7Y97ZN+DPs+UwucgibPmcpu4tL1nRKmnVqY9KpUlzOf1RrKGxhDGC1gZGKP3O
	 tzaE2hcEcNK/rR8A9FwDxzL0IjQn1mKJ82Z08TGP0sSp9UqEOzXEPIefAgP64Xavx/
	 Q5ppzZg3RFfOvZp8vkaQt2xWZqX0j4rl9FZcvzjI=
Subject: FAILED: patch "[PATCH] iio: imu: inv_icm42600: fix odr switch when turning buffer" failed to apply to 5.10-stable tree
To: jean-baptiste.maneyrol@tdk.com,Jonathan.Cameron@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 14:09:38 +0100
Message-ID: <2026031737-trophy-prison-d009@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226005-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:dkim,gregkh:email,tdk.com:email]
X-Rspamd-Queue-Id: 13EB52AAACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ffd32db8263d2d785a2c419486a450dc80693235
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031737-trophy-prison-d009@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ffd32db8263d2d785a2c419486a450dc80693235 Mon Sep 17 00:00:00 2001
From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Date: Fri, 30 Jan 2026 17:10:23 +0100
Subject: [PATCH] iio: imu: inv_icm42600: fix odr switch when turning buffer
 off

ODR switch is done in 2 steps when FIFO is on : change the ODR register
value and acknowledge change when reading the FIFO ODR change flag.
When we are switching odr and turning buffer off just afterward, we are
losing the FIFO ODR change flag and ODR switch is blocked.

Fix the issue by force applying any waiting ODR change when turning
buffer off.

Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index ada968be954d..68a395758031 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -371,6 +371,8 @@ static int inv_icm42600_buffer_predisable(struct iio_dev *indio_dev)
 static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42600_sensor_state *sensor_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &sensor_st->ts;
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
@@ -392,6 +394,8 @@ static int inv_icm42600_buffer_postdisable(struct iio_dev *indio_dev)
 
 	mutex_lock(&st->lock);
 
+	inv_sensors_timestamp_apply_odr(ts, 0, 0, 0);
+
 	ret = inv_icm42600_buffer_set_fifo_en(st, st->fifo.en & ~sensor);
 	if (ret)
 		goto out_unlock;


