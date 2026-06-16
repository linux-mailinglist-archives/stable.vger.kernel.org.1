Return-Path: <stable+bounces-265667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D4qNDXiNMWrxmQUAu9opvQ
	(envelope-from <stable+bounces-265667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:52:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCFE693947
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:52:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=a8gxT6ou;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265667-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265667-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95BA3300138E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6883FD943;
	Tue, 16 Jun 2026 17:52:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F073D34AD;
	Tue, 16 Jun 2026 17:52:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632369; cv=none; b=btxL+Fm89y1WerpKnVdaG4aEwYr6bIvGgo6x9YJynriC/wfwRUPCE+rvUu2M4qQqhUwnI3l0ioM9+6HkcNm4Ei5SmgC9YmyFKQZW3ePOmrwsjoA7f6rshzydCnpgN0QxsaIsnjG4unEnA2kPmBbPMPxUS8D33mo2SwrzeYaBINM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632369; c=relaxed/simple;
	bh=pd/VrXF17jtZJxntOiv7JtWdbP/zh0BROScawxpyEdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LulQ/di4Ck3SXRy1iZeZYIMOv89eiIjalexaga826Q+R11Rcf6M+mwumLVg/3h+fK0DTqaMaN3y8fKEp6hz2x3FIYJjY0JSFth9H6KkAd5aP0g36f2nQ6nhjj0GogMI4QDI/Vgc9+KHhCmjxZZnNQJDaLD2XBdAHd9naqR0DZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a8gxT6ou; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBF31F000E9;
	Tue, 16 Jun 2026 17:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632366;
	bh=riPhiLl3zeaX1/RJbTGD7ZFY+tT9NvlVmxgY8JkNecQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8gxT6ouzNouZzrZXFbQZbuqxb0e+BBtb3kEePk+MWNnPdWshaIFOzrGYBMK3NFs5
	 naeiha7fnSvshY3H7I8q2OSUccB+eQ9462CutTUDgOul484EK21p1dKNAEesqO3hMc
	 UF7sbXNa7woC58mjjIMFv9Wvi14K1FPD4YFWx3aQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zeng Heng <zengheng4@huawei.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 397/522] mtd: spi-nor: core: fix implicit declaration warning
Date: Tue, 16 Jun 2026 20:29:04 +0530
Message-ID: <20260616145144.648987912@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:zengheng4@huawei.com,m:tudor.ambarus@linaro.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265667-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DCFE693947

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zeng Heng <zengheng4@huawei.com>

[ Upstream commit 25e3f30601a368642678744fc8a9b1dce183c7bc ]

spi-nor/core.c needs to include linux/delay.h,
or it would raise below compile warning:

drivers/mtd/spi-nor/core.c: In function ‘spi_nor_soft_reset’:
drivers/mtd/spi-nor/core.c:2779:2: error: implicit declaration of function ‘usleep_range’ [-Werror=implicit-function-declaration]
 2779 |  usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
      |  ^~~~~~~~~~~~

Fixes: d73ee7534cc5 ("mtd: spi-nor: core: perform a Soft Reset on shutdown")
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/r/20220923031457.56103-1-zengheng4@huawei.com
Stable-dep-of: e47029b977e7 ("mtd: spi-nor: debugfs: fix out-of-bounds read in spi_nor_params_show()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/spi-nor/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -16,6 +16,7 @@
 #include <linux/math64.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/delay.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/of_platform.h>



