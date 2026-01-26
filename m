Return-Path: <stable+bounces-211657-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GNiEimfd2kCjQEAu9opvQ
	(envelope-from <stable+bounces-211657-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:06:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD988B468
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DA16302C6FB
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88251344021;
	Mon, 26 Jan 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXpvRFC4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C69F335547
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447056; cv=none; b=fNxo2Q8IHHLffOvapLOPu/cchfkZkBbgXBXJy/rWCIe7CwbA0/Rt8iyyPkxxtb9GL8YGb4NrEbFjyJGWhy8iQJTBgjyY/zgSqRijvw0DTp7phmaX2lT/xa1GdzdQfeZ7/yAP9nGGIdvwPA8hFzY/LQegO25jhyuDWn9udQjxcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447056; c=relaxed/simple;
	bh=Nsgbiykaiv6wE8HrML3RAW32X13gMc9lRhsI1qNkY0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MN7xkKD6EbpaoLlaLJcMhziWOiQR5op9EixJ6iYFR3lJi6yXktm1/r0RXXgwH8+Yn53qmlL7ILLQSOA5haWaMkBoqIoHeDCDrmRsbIYmvzpXe8Cl6dT/Z+G39r3lu5z1EImdZ2+b08ld/d01YYrQFc0kFV0GVzvK3Az7fqc9+PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXpvRFC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDD9C116C6;
	Mon, 26 Jan 2026 17:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447055;
	bh=Nsgbiykaiv6wE8HrML3RAW32X13gMc9lRhsI1qNkY0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXpvRFC452Oq7GtppU2tFKjMik55qtzbaWkBB8JwXk3I7BeFj74CteOCfPtFa8aow
	 byCSATi6TmU0k02FxwaVWj1Rc8tmpjYzrTxUGUPzCNsvIth7jZyUsvHGyvplwbFdLn
	 1HPpxmjaTlQTd+6VRkgzf+uQxwVamVbaAaOLwuMMTbLxBBjlLbSu9c/edWnA8+KdIt
	 oNDnabHTFuRwXTpGkrBbWnlrQ2ZdDKTp2YrqM1IH1dNDEpUNt4ZaO9DCZ4botzWAST
	 zVwxEULph/3SWSZ1cmPBWCBHNkmpHjxUG3xKrAFejb6ayFVxQkM+v+jRz+ysuLZ7Ef
	 ImBkanG4lG1Vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] iio: core: add missing mutex_destroy in iio_dev_release()
Date: Mon, 26 Jan 2026 12:04:11 -0500
Message-ID: <20260126170413.3418184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012655-stipend-xbox-ead1@gregkh>
References: <2026012655-stipend-xbox-ead1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211657-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,intel.com:email,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iio_dev.info:url]
X-Rspamd-Queue-Id: 9CD988B468
X-Rspamd-Action: no action

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit f5d203467a31798191365efeb16cd619d2c8f23a ]

Add missing mutex_destroy() call in iio_dev_release() to properly
clean up the mutex initialized in iio_device_alloc(). Ensure proper
resource cleanup and follows kernel practices.

Found by code review.

While at it, create a lockdep key before mutex initialisation.
This will help with converting it to the better API in the future.

Fixes: 847ec80bbaa7 ("Staging: IIO: core support for device registration and management")
Fixes: ac917a81117c ("staging:iio:core set the iio_dev.info pointer to null on unregister under lock.")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 9910159f0659 ("iio: core: add separate lockdep class for info_exist_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 6a6568d4a2cb3..43b842a062271 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1628,6 +1628,9 @@ static void iio_dev_release(struct device *device)
 
 	iio_device_detach_buffers(indio_dev);
 
+	mutex_destroy(&iio_dev_opaque->info_exist_lock);
+	mutex_destroy(&iio_dev_opaque->mlock);
+
 	lockdep_unregister_key(&iio_dev_opaque->mlock_key);
 
 	ida_free(&iio_ida, iio_dev_opaque->id);
@@ -1672,8 +1675,7 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	indio_dev->dev.type = &iio_device_type;
 	indio_dev->dev.bus = &iio_bus_type;
 	device_initialize(&indio_dev->dev);
-	mutex_init(&iio_dev_opaque->mlock);
-	mutex_init(&iio_dev_opaque->info_exist_lock);
+
 	INIT_LIST_HEAD(&iio_dev_opaque->channel_attr_list);
 
 	iio_dev_opaque->id = ida_alloc(&iio_ida, GFP_KERNEL);
@@ -1696,6 +1698,9 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
 	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
+	mutex_init(&iio_dev_opaque->mlock);
+	mutex_init(&iio_dev_opaque->info_exist_lock);
+
 	return indio_dev;
 }
 EXPORT_SYMBOL(iio_device_alloc);
-- 
2.51.0


