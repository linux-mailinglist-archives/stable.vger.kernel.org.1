Return-Path: <stable+bounces-251750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFFfJucdDmoa6QUAu9opvQ
	(envelope-from <stable+bounces-251750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:47:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0005659A1B7
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3427833A65BE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0093E123F;
	Wed, 20 May 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBKt/SBN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4173D75D3;
	Wed, 20 May 2026 17:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298796; cv=none; b=o29fcXC74IxzqOF9rGKJ+sLjrfbCUVMXV5i66Twnr59U3xyBwif6u/f6ecm5NSXeUUUdeY3fubVFNiAI6geMdEZAy8GJRvbdzEjzXgOrelYCmIuWWA3mUFdM3nn6o+IKSKkxjVhRvn8Y2Oj94p56lBe8tE815CZcODTAo8xBOc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298796; c=relaxed/simple;
	bh=mfQVKMLjaOLEaIWe7xtvEEkXmsMZ3oZPxMuk+x4nSVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X79ILM0BV7zFmAGzey6egEyLHcAq1gZnnRVNIo3WRmOayMuOop3OiFIa/H2EnBG93/nVZD7SmAXi0ZB7FtqnZvg5T4j2zkv9qTTJUFwGP0c7DvlI4r6kDHn73wkFBBClK/hkyDZfxi9erlwkPQNYoilNn2f0NNNDLfB5McJKIac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBKt/SBN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13161F000E9;
	Wed, 20 May 2026 17:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298793;
	bh=XE3j8vGt+PA3kuVOU/xJh1K7yu2Ump0WLLY/6LDoyKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mBKt/SBNYaKWWVGUdoI84GiF6+cxpHoKmhEL3fgGqekcCEPfQXDFCd28XuykYf2GK
	 RjtHdIVeyBn0k6NHtTOHHkETrBtByJRUz/QkvHi+bw5i4kiKSKQM41u41PXW5jNR54
	 H+t2OduLv2QrM952+Cqu23FNo77WIcWazosnwOcw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen Ni <nichen@iscas.ac.cn>,
	Linus Walleij <linusw@kernel.org>,
	"Daniel Thompson (RISCstar)" <danielt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 529/957] backlight: sky81452-backlight: Check return value of devm_gpiod_get_optional() in sky81452_bl_parse_dt()
Date: Wed, 20 May 2026 18:16:52 +0200
Message-ID: <20260520162146.005294015@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251750-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 0005659A1B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 797cc011ae02bda26f93d25a4442d7a1a77d84df ]

The devm_gpiod_get_optional() function may return an ERR_PTR in case of
genuine GPIO acquisition errors, not just NULL which indicates the
legitimate absence of an optional GPIO.

Add an IS_ERR() check after the call in sky81452_bl_parse_dt(). On
error, return the error code to ensure proper failure handling rather
than proceeding with invalid pointers.

Fixes: e1915eec54a6 ("backlight: sky81452: Convert to GPIO descriptors")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Link: https://patch.msgid.link/20260203021625.578678-1-nichen@iscas.ac.cn
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/backlight/sky81452-backlight.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/backlight/sky81452-backlight.c b/drivers/video/backlight/sky81452-backlight.c
index 2749231f03854..b2679b24de14b 100644
--- a/drivers/video/backlight/sky81452-backlight.c
+++ b/drivers/video/backlight/sky81452-backlight.c
@@ -202,6 +202,9 @@ static struct sky81452_bl_platform_data *sky81452_bl_parse_dt(
 	pdata->dpwm_mode = of_property_read_bool(np, "skyworks,dpwm-mode");
 	pdata->phase_shift = of_property_read_bool(np, "skyworks,phase-shift");
 	pdata->gpiod_enable = devm_gpiod_get_optional(dev, NULL, GPIOD_OUT_HIGH);
+	if (IS_ERR(pdata->gpiod_enable))
+		return dev_err_cast_probe(dev, pdata->gpiod_enable,
+					  "failed to get gpio\n");
 
 	ret = of_property_count_u32_elems(np, "led-sources");
 	if (ret < 0) {
-- 
2.53.0




