Return-Path: <stable+bounces-252123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKtyHIgiDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:07:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FC359A790
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DAAD37DA89D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688813F20FA;
	Wed, 20 May 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tvCdMCYe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D1817A309;
	Wed, 20 May 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299851; cv=none; b=Q396sspQh7+p9DiarHXFYGQeNZqqgvLat7fkd5cCV5gTayMnBjHV7XyI2uFEjQYsp/K9LE0Ug4+u1fXyJOPqRUDQNvYRCjTc9JYhHa4TSoo6dyLhXRv2/EGIGucet7zLKYs87YrdhG+3u4UukakhTM0aq/HncW05gzyj0lQ+7WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299851; c=relaxed/simple;
	bh=J1qO4cDG6arpMAdqTq7qtOFHhOYSiYX2cmBskso3hdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXKw4PlabRUUjVscQ/AFKaHxUvlMK5tuYv7Z1P5Er1H3MQSLWPBfjTVzi+NJ94oz4zkVCPG8GxL366W/uHO7feJ0YiBGmJLp6Zt+OBjqqIU0w+g7yxavJxGm+0CTxWtzUMZCNbXUtm4gBYK1Ncl8dr500XAYh6E+6LhX/b8ot9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tvCdMCYe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4667C1F000E9;
	Wed, 20 May 2026 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299849;
	bh=ihvuYRGcyoKOZKVi5XkgTGfrIUSQ/0Vb2loMxj3Hk5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tvCdMCYeUwIk0HiXYtDcc6IU8zEOLyU0kEVXHJfe6MoXdZ2lM40eQFKW893iaz2jx
	 ZMH5/Jl9GU2XBHTFWovyV2rL7hbQXLUEuyW8U4WyQCs5FafL5zwQLZHWktJOgINM80
	 y0GorUc0hOgGJD3yolODkD6+fA4jLULRWObZlq8o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gyeyoung Baek <gye976@gmail.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH 6.18 910/957] accel/rocket: Fix prep_bo ioctl leaking positive return from dma_resv_wait_timeout()
Date: Wed, 20 May 2026 18:23:13 +0200
Message-ID: <20260520162154.310371584@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-252123-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,tomeuvizoso.net,arm.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tomeuvizoso.net:email,arm.com:email]
X-Rspamd-Queue-Id: E1FC359A790
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gyeyoung Baek <gye976@gmail.com>

commit 74570e12b4705ea11dcdfbfbd0a0b0fdaeff3059 upstream.

dma_resv_wait_timeout() returns a positive 'remaining jiffies' value
on success, 0 on timeout, and -errno on failure.

rocket_ioctl_prep_bo() returns this 'long' result from an int-typed
ioctl handler, so positive values reach userspace as bogus errors.
Explicitly set ret to 0 on the success path.

Fixes: 525ad89dd904 ("accel/rocket: Add IOCTLs for synchronizing memory accesses")
Cc: stable@vger.kernel.org
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
Reviewed-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Link: https://patch.msgid.link/c0ebf83b345721701b22d8f5bc41c52c0ecf5e16.1776581974.git.gye976@gmail.com
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/rocket/rocket_gem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -144,6 +144,8 @@ int rocket_ioctl_prep_bo(struct drm_devi
 	ret = dma_resv_wait_timeout(gem_obj->resv, DMA_RESV_USAGE_WRITE, true, timeout);
 	if (!ret)
 		ret = timeout ? -ETIMEDOUT : -EBUSY;
+	else if (ret > 0)
+		ret = 0;
 
 	shmem_obj = &to_rocket_bo(gem_obj)->base;
 



