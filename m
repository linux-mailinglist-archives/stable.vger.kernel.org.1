Return-Path: <stable+bounces-211658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SISrHpWed2kCjQEAu9opvQ
	(envelope-from <stable+bounces-211658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:04:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48C8B40B
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFB173006239
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7BC346791;
	Mon, 26 Jan 2026 17:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo533I+o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C5B2BE629
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447056; cv=none; b=PtOTnh8J1rzErBBtucaH5jCE7qHMXKBnSu0cgUw4QHlkm0lxQCXeBjSqvauoLqyRN6SLy7KwaCX48I5y8ZBoILJCh1HB3GfHUKI4ntIKH/4bveSpJERDiuBV3VH+2ALDpAM6rTWIAbKhSN8zj39MJBJCjn1NDLdO8Xq2rn1+J2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447056; c=relaxed/simple;
	bh=d49hIDkyITTKoC8KVYgygP4fMeMrZ+4uKjUyrcO2cgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9NsWgxn7eg3MFNXYNzK4cTQCY2CoY4RRJcBC4LSN207RU6TMqoWcrUt4dPE/dzeDVCagPY6WpVHtBqxuTB4wgxBIQaVrkR2IDhJe1gJiCu+BKGwqlrxEaUW+J0oWlss/g7MU/HyXv8JhSTj19e2GnBLfblWB0KlGiAJXRdEme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo533I+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B9FC16AAE;
	Mon, 26 Jan 2026 17:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769447056;
	bh=d49hIDkyITTKoC8KVYgygP4fMeMrZ+4uKjUyrcO2cgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo533I+oQZVangHHw7QM3DogTJrjeKllZyQOwj7ijrsvTGZjNl7tzk0ken+VxOf+9
	 6JU7iRFadQmQMb4S+u6sAnUL6KTp4Bv9uAg4E8XMacma25W/a2x5LpwIrCT4ZCb+CT
	 zPOYw/iL2jN9W5yDxWBGhAQVTZYBjJdbLTo0BEFB0Q16QuikbQy+i5eb67dEPdk241
	 yZuhvv5JLSbQ19NVs6oFAuYl9tanXrkWvCqF8eAribJU4G0ilWT3frBJZKAeeNtqpp
	 JvXDuo+cd6630cSJRGTqksViuCn5ZROBi8KjIsG6/zIRyayc3rfLi+XYcK4lsujEr9
	 6dE2JZ8v3O6VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] iio: core: Replace lockdep_set_class() + mutex_init() by combined call
Date: Mon, 26 Jan 2026 12:04:12 -0500
Message-ID: <20260126170413.3418184-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126170413.3418184-1-sashal@kernel.org>
References: <2026012655-stipend-xbox-ead1@gregkh>
 <20260126170413.3418184-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211658-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: 7C48C8B40B
X-Rspamd-Action: no action

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c76ba4b2644424b8dbacee80bb40991eac29d39e ]

Replace lockdep_set_class() + mutex_init() by combined call
mutex_init_with_key().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 9910159f0659 ("iio: core: add separate lockdep class for info_exist_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/industrialio-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 43b842a062271..f08211730ca20 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1696,9 +1696,8 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
-	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
-	mutex_init(&iio_dev_opaque->mlock);
+	mutex_init_with_key(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 
 	return indio_dev;
-- 
2.51.0


