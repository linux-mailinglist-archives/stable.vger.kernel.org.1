Return-Path: <stable+bounces-242642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NkF9JTzV9mlOZAIAu9opvQ
	(envelope-from <stable+bounces-242642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 06:55:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 303334B4740
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 06:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BDAF3001D4F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 04:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A72BE655;
	Sun,  3 May 2026 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRmQxr6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD61A9FAB;
	Sun,  3 May 2026 04:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777784119; cv=none; b=fxKeX/dkpcd1B19EZ4mehlu+V4/ffw9EPV5zH0SyagA/FUpopSRgC0JKT7Pfk0/9AJbCxC9KQYk/PC+T8yCOmCXD/DNN5ZkJ+CG/v///9rJg2C76CugQ3/Jtse/B7xbhDM7LBeeCKppiRo/xtBEYGk2m2VmsfGHp44UWMQmhKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777784119; c=relaxed/simple;
	bh=YEFoIJ/Fi6EtnySYXpFC2mKMsowIG5i2CCCObToJRo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m26O0nac7dvD2ATmucc38PPptRpFA50it5sDi6Lx7999xdUEFdEettE9iNALA3X38c6zp9acy/1ewfuEbZeyCSqsDBUuxvcsN92XwmAQwrnBISp0meLVJ2A5vP84xTmzAzbLuedkkbSivLtxVvwFkrhAwKakTdCWIN8MIEhABoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRmQxr6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570C1C2BCB4;
	Sun,  3 May 2026 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777784118;
	bh=YEFoIJ/Fi6EtnySYXpFC2mKMsowIG5i2CCCObToJRo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRmQxr6OGZzUqZijj3mTfX1nWRgO+NSw3iSHvJrMMqPjEBjHjHT0s7S1w/e1fnPkD
	 pSGrFvL+h4p0VwTruYga0XGu6SO2Ir2WfMgGgoPHrAMR74cCOBeALEkKEmtHEOCFLA
	 mvKBxkP3nLl1vs42RLgaZbb2gE6i0El8JPvd4H7pLZfSLH/3xJs1Si8JEYW0voCGjT
	 iOGYEdHN6nmrrUokAdaW7/lIR0U5rPzvt7x3aUgVmhKjg0qD07Jy35M4RIYmZLuSS7
	 Pxw3LsWYDeg4LmjVNSN7CUTKUhcpUDB/HMelKzHPvXgZbUXHkbgOGAOI0C52HeSPfp
	 ShZ5oC/D1W4wg==
From: William Breathitt Gray <wbg@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guangshuo Li <lgs201920130244@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] counter: Fix refcount leak in counter_alloc() error path
Date: Sun,  3 May 2026 13:55:06 +0900
Message-ID: <177778406130.426389.16825154395288414003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260413134604.2861772-1-lgs201920130244@gmail.com>
References: <20260413134604.2861772-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=819; i=wbg@kernel.org; h=from:subject:message-id; bh=mZeqFfl0eA05brX2qFIUSN1ITJpJe9n+w+1At8YmAns=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJnfrgr885M6tDBvwjWny9s1ebb/bmTmFtRf7WUhaffN+ /8cYd6WjlIWBjEuBlkxRZZe87N3H1xS1fjxYv42mDmsTCBDGLg4BWAiphMYGea4r5pxesITia+f jd/K7UrgTs3wLX9/8tfExZkfw6d8s65lZNj9QOVLaLNR48/QS6ufnLVPreKZ8KtayORHxsoqYcU ESQ4A
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 303334B4740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242642-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linuxfoundation.org,pengutronix.de,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wbg@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


On Mon, 13 Apr 2026 21:46:04 +0800, Guangshuo Li wrote:
> After device_initialize(), the lifetime of the embedded struct device
> is expected to be managed through the device core reference counting.
> 
> In counter_alloc(), if dev_set_name() fails after device_initialize(),
> the error path removes the chrdev, frees the ID, and frees the backing
> allocation directly instead of releasing the device reference with
> put_device(). This bypasses the normal device lifetime rules and may
> leave the reference count of the embedded struct device unbalanced,
> resulting in a refcount leak.
> 
> [...]

Applied, thanks!

[1/1] counter: Fix refcount leak in counter_alloc() error path
      commit: d9eeb0ea0d2de658663bfaa9c26eccdd8fd64440

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

