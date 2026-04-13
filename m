Return-Path: <stable+bounces-236698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI5mIPMc3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B1F3EF8E5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C217030AB5E1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A830B50F;
	Mon, 13 Apr 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ko9vn11E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370C309F09;
	Mon, 13 Apr 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097574; cv=none; b=RCmXdE9nkjv5xzBe/VCIhTzBb0gBlclUMUezrLgg6E4CXkiVDeY4OHBwtt2HI9GSFDIdqmgOpXKaqmRjeEhbkxb5StnHiVdwrFyIgsCUJG6psdHedVSYarHTpIQ1KM9xwN6UhqccKG7e3/hS8K0NTiNTTM9/aZrYr7mKEGZxKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097574; c=relaxed/simple;
	bh=slQLGL6cOu4fcuhefxU1VLh3HblUdtatjlpSdk/Cc/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaEZ0Yj7OoZ6zSROzeDX0TsTPTM/R9n3Zf6rvt3PKgyFW7WbC6oS3yPkYTWYsG8SwKVCZSW77FLl7N73OTI6/3r98f2c9zta8ONL+EO0oUsyiIP5osokCmMsOvgO3lIn7xfaXcFSyKLAyAmUHIHl7lzliwAL0ieTM9kUHBtm2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ko9vn11E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A50AC2BCB0;
	Mon, 13 Apr 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097574;
	bh=slQLGL6cOu4fcuhefxU1VLh3HblUdtatjlpSdk/Cc/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ko9vn11E4X7GSL+2McnRepSA2dRtCMgMINBGhE3Hoh6CxZTRnMn2rXwhWgfiOJ0Dz
	 z+kHi/z8JJdQCdwe8BOtL2rjTPT2dcx96omZgkRvwz/yguEEVzfnMJfF4IjGWtjpgW
	 rKR9PkP9hDgv4Uvx+GDTyfBQtR1PVAdA8HulCIXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.15 188/570] iio: gyro: mpu3050-i2c: fix pm_runtime error handling
Date: Mon, 13 Apr 2026 17:55:19 +0200
Message-ID: <20260413155837.502392040@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236698-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,huawei.com:email,analog.com:email]
X-Rspamd-Queue-Id: 93B1F3EF8E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit 91f950b4cbb1aa9ea4eb3999f1463e8044b717fb upstream.

The return value of pm_runtime_get_sync() is not checked, and the
function always returns success. This allows I2C mux operations to
proceed even when the device fails to resume.

Use pm_runtime_resume_and_get() and propagate its return value to
properly handle resume failures.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/gyro/mpu3050-i2c.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iio/gyro/mpu3050-i2c.c
+++ b/drivers/iio/gyro/mpu3050-i2c.c
@@ -19,8 +19,7 @@ static int mpu3050_i2c_bypass_select(str
 	struct mpu3050 *mpu3050 = i2c_mux_priv(mux);
 
 	/* Just power up the device, that is all that is needed */
-	pm_runtime_get_sync(mpu3050->dev);
-	return 0;
+	return pm_runtime_resume_and_get(mpu3050->dev);
 }
 
 static int mpu3050_i2c_bypass_deselect(struct i2c_mux_core *mux, u32 chan_id)



