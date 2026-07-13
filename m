Return-Path: <stable+bounces-273971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4MxqDpI9VWqMlwAAu9opvQ
	(envelope-from <stable+bounces-273971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 21:33:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F0174EB9F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 21:33:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YrEZg4sf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273971-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273971-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3B1B301136B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 19:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706F355F49;
	Mon, 13 Jul 2026 19:33:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A33353A88
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 19:33:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971215; cv=none; b=bAwEhRKJE7hsAu6cGUCvm89kShLnj21WcVatoOQRUPCHPNaNOqYlhqSyTaTXLH4tm0PEvKHs65XkUo9rezeUxhwMD5tRpG5DF/04TPwp1jkolj7TWGmb0Bf+AqCzut9GCRS4lsXeqTYRobai/U7Unn7REmcH4V3+BUbYQFqTrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971215; c=relaxed/simple;
	bh=WsysDYKlmNIi1GeaMYZNzj3eo5Jd1cfgBO4xygxqFM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gHaj+IrlMRm4NVTT5LdY4CxteonX73dfe1KtZ0MUVZm+v7FHyjti+c0P48deDqQMmYnQce/hWsF7TrLpE+ncD4yDCmh8K+ftpsr/e2jEJy7YdDQYs72YtBdFEcj5QWCLOGOamC5YXHu7WN5d8n00xd1dAmO2MFcY+jeiyoZAaBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrEZg4sf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7FB1F000E9;
	Mon, 13 Jul 2026 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783971214;
	bh=xg6cJ7Emy56zQk35qGT2BR2rdqy14HcsQeCTzOrDaOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YrEZg4sfjhcb7BZl6Ul8dP1gl3d1dlJYBrpxcR4EMFcv08ieHO4d7euALBtXzIgrg
	 Iz3e2fsB0ZuJNZc/2Gucw6c/p3bGkRWXyI0R3rJhxb9J6SYsmuLrSzXWPiY4ICJCQI
	 vc2dg1KN5RaDW31C0XQ/yu3ZcEOwYInoKSYCzgbjFeGpsH4C3aaIrJvXMdxD3ig9Pf
	 06lyWsASPQJ2TG5m+N5m//JNKNvg2oV02bjg7Qs0BXANniWpBRz/p9OxSJuWN7aJNn
	 ACIDvlUN2cSsDTa/walFPcA6I7vRTe8ZIjT9/yUl6Pl40JQ2/RoVDK4K9sWV2FUtm1
	 //5ln1o6W7UpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: pressure: mpl115: fix runtime PM leak on read error
Date: Mon, 13 Jul 2026 15:33:31 -0400
Message-ID: <20260713193331.2036682-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071351-alphabet-sleep-d297@gregkh>
References: <2026071351-alphabet-sleep-d297@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:birenpandya@gmail.com,m:Stable@vger.kernel.org,m:jic23@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273971-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4F0174EB9F

From: Biren Pandya <birenpandya@gmail.com>

[ Upstream commit fbe67ff37a6fd855a6c097f84f3738bd13d0a898 ]

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
[ moved pm_runtime_mark_last_busy() together with pm_runtime_put_autosuspend() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/mpl115.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 02ea38c8a3e431..e3eb154feb5fde 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,20 +106,20 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
-		if (ret < 0)
-			return ret;
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
+		if (ret < 0)
+			return ret;
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
-		if (ret < 0)
-			return ret;
 		pm_runtime_mark_last_busy(data->dev);
 		pm_runtime_put_autosuspend(data->dev);
+		if (ret < 0)
+			return ret;
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
-- 
2.53.0


