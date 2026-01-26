Return-Path: <stable+bounces-211655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAtzLPibd2nOjAEAu9opvQ
	(envelope-from <stable+bounces-211655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:53:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4088AFC9
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3705C3004635
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1C344026;
	Mon, 26 Jan 2026 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv6BW3mh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E033375DD
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 16:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446386; cv=none; b=WxfPe7laQDHq9I/vLZ2SiPCXnbPSqW3YLIsaV26Dbcjfqrj6AEJlsGRMQ0YmF6NmhVYiWir4XhcwaMnXDxsBfo6bW1e1EJ96zzIREijOrIsb1Jw4oUdatkk5y0mewrSJJ0OOh7Pp0g5GpD+jk044JYl/rrQ0RWMh38jcqjFBc6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446386; c=relaxed/simple;
	bh=XY4oa1x0ETKvJaZFjXrc6mFzPl7V7og1Ff8A7ViwCQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tmKsDW2B4DpMEeQdJOc0HG5TnJsd+rNYNDSmO0R6FQciZZh3QEybAC1ozHKP7mjhVRj+aLnx1OhnDggHlKagjqZnf1bV5jgdgkTKfS/t8dZIO9tmF1B5PN0kgA0Wscq49eLR/TrQyEFyi0TBkPtrDhLnECeCH5y3mzVdsf4mok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cv6BW3mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CB7C116C6;
	Mon, 26 Jan 2026 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769446385;
	bh=XY4oa1x0ETKvJaZFjXrc6mFzPl7V7og1Ff8A7ViwCQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cv6BW3mhZrTyzertFdj/aYNAyfE8DSL6U4/L5uYMH+w7q/0I434l8bxQoErqX2INK
	 VmDPeyjYV6WsVUDmT6jSlYkNtyayQpv2j/8NEgquM12MDMqQ7HW4sAOLrFd43lZQS1
	 NnKs8L690En3J1ylpjoEWaCDjGPY+UVqUQbJXsB0eVFyY9T7+wb9Jkals90FM22MIu
	 pTh2CzXZtlbPKTTTehMAsWXcbN/oEFqSKsIowt+4RcgktECbV+P1p8ZqGP/sjvkc6m
	 nE5zpNVzssggTI4bOS/xJpmYQ7Tz2PPF3GOzVIIZfySbtQfEjVJ9OYOM3d/LJDAUOJ
	 4nbZbgsEr+qwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] iio: core: Replace lockdep_set_class() + mutex_init() by combined call
Date: Mon, 26 Jan 2026 11:53:02 -0500
Message-ID: <20260126165303.3408060-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012654-trend-outback-5af6@gregkh>
References: <2026012654-trend-outback-5af6@gregkh>
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
	TAGGED_FROM(0.00)[bounces-211655-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,intel.com:email,analog.com:email]
X-Rspamd-Queue-Id: CD4088AFC9
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
index 5d2f35cf18bc3..f69deefcfb6fd 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1717,9 +1717,8 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
-	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
-	mutex_init(&iio_dev_opaque->mlock);
+	mutex_init_with_key(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 
 	indio_dev->dev.parent = parent;
-- 
2.51.0


