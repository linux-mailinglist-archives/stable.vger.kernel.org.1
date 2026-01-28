Return-Path: <stable+bounces-212406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aED4MRA2eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:15:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ACEA5531
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 507663058B7F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4B92FDC5D;
	Wed, 28 Jan 2026 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1J9Co1G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BE82E2DF4;
	Wed, 28 Jan 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615411; cv=none; b=QQF2KeGbNQAQAH8Y3aECa2pfnR4/LKLzbI1wGpX/15HcAoSWXiDYndQXRqdYbKtb7A1H4T5b4uX7Lh4AnQDO9C7DFejCC7Ebi3PSQYVYlSeliXnN2MSEAJtl/vrne9iLSHvjMoEY12IZhS2qtFx9WYwSJnxbJdjKQE1+4n0KBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615411; c=relaxed/simple;
	bh=Wd5wK3NIU2+XlIwKkhAPVzAmR2rdbeaaWUNT8ZGfJQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciUvNR0ERGMCelhbqieqP8uCQ9y8C1QsOpBNwzwFgLu4/QaA3sU1+A86rfMzw0xN11n2p+f7BD2uxN0DYTKijrzGWFzqde9Mj/pxlQmUUCEdanZjN7W7nP+8tJJ1+BnZ4o2HmHoISbnys/RWMKsWr5PQ42o003ibdUFt2rywXYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1J9Co1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EC0C4CEF1;
	Wed, 28 Jan 2026 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615410;
	bh=Wd5wK3NIU2+XlIwKkhAPVzAmR2rdbeaaWUNT8ZGfJQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x1J9Co1GdfGZPW8LrmOdSdoNfeUR9FhXwyU327fMS78Wk5kXRNucdMsa0r/1TJ3+P
	 cRpinIsRZJ1j8+BOdxfiY8EBy6e1huPu2/iJfZayF4szBg45vU+Zw/4TNEluo4+zYW
	 HtMvoXzyR6cAKz8ZeEiH3IyE9CDwvcOVrUAvrmbQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 153/169] iio: core: Replace lockdep_set_class() + mutex_init() by combined call
Date: Wed, 28 Jan 2026 16:23:56 +0100
Message-ID: <20260128145339.514394625@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212406-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,analog.com:email,huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: E6ACEA5531
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c76ba4b2644424b8dbacee80bb40991eac29d39e ]

Replace lockdep_set_class() + mutex_init() by combined call
mutex_init_with_key().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Stable-dep-of: 9910159f0659 ("iio: core: add separate lockdep class for info_exist_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/industrialio-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1696,9 +1696,8 @@ struct iio_dev *iio_device_alloc(struct
 	INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
 
 	lockdep_register_key(&iio_dev_opaque->mlock_key);
-	lockdep_set_class(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 
-	mutex_init(&iio_dev_opaque->mlock);
+	mutex_init_with_key(&iio_dev_opaque->mlock, &iio_dev_opaque->mlock_key);
 	mutex_init(&iio_dev_opaque->info_exist_lock);
 
 	return indio_dev;



