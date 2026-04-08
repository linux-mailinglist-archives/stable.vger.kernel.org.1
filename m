Return-Path: <stable+bounces-234861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDaTNNii1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:47:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC83C18FC
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44D40303588E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8DB3AEF46;
	Wed,  8 Apr 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+5XjaYG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A189933121F;
	Wed,  8 Apr 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673955; cv=none; b=DkCPQUtMPJCUN+rFheXKeSc0KI5d6yZKOulzT3in8TVbJuRJN69xp3ElRtx5Oaj3xGy3Z+xg2+eLY3PmifDGzOGn2oy+Z7DD+TFt4he6NOMbOl1RORFmeXbOxo54Ejf9gyrnYCyA3/LTW7EYEhcjV+6PiN9D+qSTqg4LFym/SOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673955; c=relaxed/simple;
	bh=DFCDDfQ5yWimVnlYXsjU1aW03gs6NHIMYoi+BO46N7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnhusDzXwhCVd7IeznYcMNPiSw+eIHkGygV/HzGkUMhlUCtV9wuJtFwEaAgqQ+dT/0qddoSa5mH4lT2tSo5XGhjNWI62fj8IiDNxLiEvb5YBGo6odFU1srvQVxdgo+vKCyJC+740Wt6kMrHzmMVZgI1oIgBS9gwEn7Fy67SJc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+5XjaYG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3358EC2BC87;
	Wed,  8 Apr 2026 18:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673955;
	bh=DFCDDfQ5yWimVnlYXsjU1aW03gs6NHIMYoi+BO46N7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O+5XjaYG1tpSIvEVrGKl9OlPbYGJV0Gg05lzOxzFac9P1PIOokytGKu1gCPxO1IVM
	 vJz+7rQRxcPmH8nE8bi8IIisNq4L+Nuw+vB9Tr/WjdHXDhe/5ORL1LAF4UYIP5vgbb
	 1rdRmXXMezOk3JQKnIfTcSSHt1XYRMZukYzz47lo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francesco Lavra <flavra@baylibre.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.12 154/242] iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only
Date: Wed,  8 Apr 2026 20:03:14 +0200
Message-ID: <20260408175932.854648003@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234861-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58BC83C18FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Francesco Lavra <flavra@baylibre.com>

commit 630748afa7030b272b7bee5df857e7bcf132ed51 upstream.

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
st_lsm6dsx: add i2c embedded controller support"), this function is called
also when configuring the hardware FIFO for external sensors (i.e. sensors
accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -224,6 +224,10 @@ static int st_lsm6dsx_set_fifo_odr(struc
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only internal sensors have a FIFO ODR configuration register. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
+
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;



