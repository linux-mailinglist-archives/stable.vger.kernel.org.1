Return-Path: <stable+bounces-271838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xx7dAx/wR2pshwAAu9opvQ
	(envelope-from <stable+bounces-271838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 19:23:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B77049DC
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 19:23:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ua9LD8QK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271838-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271838-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E919F300EE8E
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 17:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A37C2F532C;
	Fri,  3 Jul 2026 17:23:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF072BDC05
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 17:23:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783099420; cv=none; b=KNrRPBZGdjmEi2mcRO0OzT5XFlrlPDAh/hNnV4ixb0CU9moH6diBc4IXnYRudHsvVOQ4eJVOYVEbp6uRWx25wjM/E+2TVr8tkLNUlftWWabd8Va3qRznOJAFoFHUZazRLGXRQuRF6oFowg+xZBWQbZrf5hJ2fe5SMU5W7rWR1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783099420; c=relaxed/simple;
	bh=8HqZvmtSpKpbc4rAzW+Ze+DAfPCGyxrnTcJDK5klviY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s2hdFK7ytHtihBU88w93IHCPZ30GTdQL2QB32a/TCeayrn+lcX56euuQSip56OTOJvHmCNZ4nZ1plNaYv1N7Bn55yXN2eSETf8HrtR1rvq4qsoZJnKsLAHWjcNBJsUBDERDS+fKFQ1E9xMT51Vic1s/cctpKB3kQmRLhtCCxD1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ua9LD8QK; arc=none smtp.client-ip=209.85.215.177
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so507512a12.2
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783099418; x=1783704218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmB60ZYgB9p5pDJ1IW0pInjCKWd5FsZYny8bxTgtxgE=;
        b=Ua9LD8QKBMii6ajblUKlRo9RyjV7r982zImoLS++8U75PDfNlk0sAv6AG9mqR8j2BW
         XjVygOakP0JFrATJc4vU9FC/l/vkD34wbk2lsdsnFxzUyf9SxfOH28/zgf+0CHccLna8
         N3oWom18J/uYHNIEVe68SnN6kuQdctt/nrn9dxW/+Z2ARAm8xnEAZkIy1qvS4ogLySVx
         SDEVAtcQj4a+MPY9oWPj+1NUNx353Wl4y4M6ZvHRK/QZfpy6SvzQYWxbxV3Ow8Mr+3MS
         JhpBPhMMJVu2iOQuw+ryx4Zj+OvytI9+JvqfhRkFEyjGccBYfxpNdoi12Y+1OAqD0/T6
         3cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783099418; x=1783704218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nmB60ZYgB9p5pDJ1IW0pInjCKWd5FsZYny8bxTgtxgE=;
        b=ALbI+LQSce6pJ0ZCShfxMVQ4lfxETbxjfG6Phu2trXCdXVknbaV7NMMaocjzC5+Ya/
         gUiwNo4pvotDPleeYaFuT5kc/Frp1IPukNvL+h3qDphtY0MlQVCSusOkvRGfqMlPE02R
         +7DP/eK3Bm12fKyuu4/AttVx1UajRbTrFsYwvVcDQ99B7N2Z/Hzb01MTeP5T7+AMosh5
         2WR24ELR0NJGeO2FtvqH922ZOECbSwmMJ6f54Gb3CHBlBjUWswutudFBmRht5VBwEXmI
         LLTq4IHc5D69fRQcHxrTAd3RCoAZ14PDKktZsXIypCE87FWx2+Gv1TYOYdtMqkekX5qn
         FD5A==
X-Forwarded-Encrypted: i=1; AFNElJ+w5nR/WmxLUVMubBQ4dl9MjiPn10I/+IhMcZ5ctKFAH9oWjjyEnD5miCvVHCyFKOSADGTtbg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH3vvI2dGEnGrlrlVvO1uhsnBX9soLX2WV3jHJGLW1ITHu3bB+
	liD0vJ0WjEJCRZC5xjOXWghCOwu1Zyn9GTyWPYBdwRURAXZB6HlyyuzN
X-Gm-Gg: AfdE7cmebhqx4UX0FU1AZBQmDTezalkeDJry0wYSq3d7a0slT5wCXIMP0ZVNS/Qlzm6
	tFDNk8x3gEpKO+hynFAK3bTV8gzzaX7Ddrw6rY3u9SBDH1KdsZC4zyvj3wDtzFZzCcET472S8qO
	Gc1kAEKYQ5f3YxQy1zOpzbe2Prh4B6oeV7p/igGFm7MCjTLJkY/jImdX5v7gRx6btMlS8YmyF0y
	q2ctIdEiq/SMGBvFVo1qEaW65cd2x1rgjXLWMSXsKGVHbn1XeQ7uKDWND4GuzMukI2DKcQgpKHo
	JWFPOtgE6d0C/eLik8ocynOO1sZb5DJjp45ApwF7OGG6at/smFOVcHcNGBo83I5+5VNbppQ8+s2
	AsADHyGQWkAi/3cpNxejvr1kYKSGKlCZ1X+Ogoyn1EF74OSzuoKxJZE4huGK3zt+BrvUoPNmbFc
	8r7pM1R2WhE/Q7cw5+dRULv1k7O7LHakPDiX/Zp8KbAEiyBT8=
X-Received: by 2002:a05:6a21:490:b0:3bf:b960:6fc4 with SMTP id adf61e73a8af0-3c03e498393mr276344637.30.1783099418128;
        Fri, 03 Jul 2026 10:23:38 -0700 (PDT)
Received: from birens-macbook-air.local ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb843fasm22278176eec.18.2026.07.03.10.23.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Jul 2026 10:23:37 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
Date: Fri, 03 Jul 2026 22:53:22 +0530
Subject: [PATCH 1/2] iio: accel: kxsd9: fix use-after-free on remove
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-kxsd9-v3-proper-v1-1-e9f08af25d7e@gmail.com>
References: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
In-Reply-To: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Biren Pandya <birenpandya@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271838-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jic23@kernel.org,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:linusw@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:birenpandya@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B3B77049DC

The kxsd9 driver currently calls iio_triggered_buffer_cleanup() before
iio_device_unregister() in the remove() function. This order creates a
race condition where userspace can still access sysfs or ioctl interfaces
while the triggered buffers are being torn down, potentially leading to
a use-after-free.

Fix this by swapping the cleanup order. Unregister the IIO device first
to guarantee that all userspace interfaces are destroyed and no new
accesses can occur before cleaning up the triggered buffers.

This vulnerability was flagged by the Sashiko automated review system.

Link: https://sashiko.dev/#/patchset/20260621193036.78549-2-birenpandya@gmail.com
Fixes: 9a9a369d6178 ("iio: accel: kxsd9: Deploy system and runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 7ac885d94d7f4..27adcdd312014 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -478,8 +478,8 @@ void kxsd9_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	iio_triggered_buffer_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);

-- 
Git-155)


