Return-Path: <stable+bounces-235186-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFt9Efml1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-235186-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:01:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF443C22E7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9CB1300B9CB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F753537DF;
	Wed,  8 Apr 2026 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VGW6Fkoq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77073D6694;
	Wed,  8 Apr 2026 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674790; cv=none; b=a+HVW4Ii8nFcKqwU46hSKcoGAJyM/j1sP+UJjEtPpfoOQIkcyYofey+wgFCfAw3Q36X+0UD8dC6NQkAKte1H/v1Hn7HlL7QMOP6KaN2FOjg/LE+rFRmztZlrn8tuyP5rEK94+3MzjkhP6Zq58KZwTCOQ1FewIcVZczqBElUkm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674790; c=relaxed/simple;
	bh=B4qLjOrNSgKhExoNNEfKLGCEl5grLH1KkVsEE8GjZgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wz0cqXZObXB+LRSnTRzjIvRcCNQ8XoXNtRrTMy6u9s4hFF0pfHoKCGhYMLE2ff+H+TYMv45pTTTJUZsWoG/kKGLnSB3GV/iW9jul4JKtMizHQnUWnClyJSGXQXiw96oa6GDGQdbB/d+o5RtLdHAtKxzqmFy0LjMBQuDaxrHXF4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VGW6Fkoq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF83C19421;
	Wed,  8 Apr 2026 18:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674790;
	bh=B4qLjOrNSgKhExoNNEfKLGCEl5grLH1KkVsEE8GjZgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGW6FkoqPs1O+Kg+CLRxzRtYh/bKxhuS6JUwoCH3lewwzNE1O79ugn/3iMKlKHXj3
	 KX9YKEV0U6TDBWChl6SxF3pN9lzOy/qWx2VGQl05gYPei3GM4CEhtu1/VtXL/LHYtU
	 nCbsDLcog/bRsxcMS0vrKgApYddyzdQpvkJc+0K0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.19 234/311] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
Date: Wed,  8 Apr 2026 20:03:54 +0200
Message-ID: <20260408175948.133426304@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,intel.com,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-235186-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 4EF443C22E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

commit d14116f6529fa085b1a1b1f224dc9604e4d2a29c upstream.

The triggered buffer is initialized before the IRQ is requested. The
removal path currently calls iio_triggered_buffer_cleanup() before
free_irq(). This violates the expected LIFO.

Place free_irq() in the correct location relative to
iio_triggered_buffer_cleanup().

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/gyro/mpu3050-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1278,9 +1278,9 @@ void mpu3050_common_remove(struct device
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
+	iio_triggered_buffer_cleanup(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
 



