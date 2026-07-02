Return-Path: <stable+bounces-270959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HNwwEuaWRmp8ZQsAu9opvQ
	(envelope-from <stable+bounces-270959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:50:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62B6FAA2D
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:50:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=ycxp+azU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270959-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270959-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 627E7339D3EC
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F24343896;
	Thu,  2 Jul 2026 16:38:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759534751D;
	Thu,  2 Jul 2026 16:38:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010299; cv=none; b=R4xa6liYr6ZAyrlfP0SAVqYkRYVWq/TKQ71Z+oRwUd9faiiDoEggKZMshv41UFdXblo4eRvvRUjwpYYFtE57dBnOBOCTWW04uc7HhK2rogKtU9tw4OXP7JHWKzT245q8noG8ChooW6dElISzFPeivTZcqTwA5W/18kUSPxQZXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010299; c=relaxed/simple;
	bh=/Oq3MqBU+7xFhJM3yhRxv6TobmS91uNmNcF+bJJqKIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaMWsyyNHyJBiJF3V8wBsrg1xlTDbrMU98WvZlhgKNCLB2pD7P5U5q2NBvPcpQEq+fthD3qpRifAyyWv2nel1HQ1701U2n3OxIaT3ZZAFUO/kojUIm3A3uaZ3lp/DOTkw6wEcgNQ2B4LgV7ACX3RwImG1Jb9Io1Z9ZDSndUuUWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycxp+azU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9781F000E9;
	Thu,  2 Jul 2026 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010298;
	bh=CFztPrkjnKh1EsOS6/PUpAhxmxyaVqZmQsXrMRbcRe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ycxp+azUbOK1PCHdN7yLruu84RWWzFzXsrBIv7Gc6MvUw+HBONcbt+gTnufFTCUAm
	 u7uJm08JVM2yXWuyALPCeRiUvE2hF3QnmWDl6wUzT6uulK7KjUvKyDku+ndfAjbi3A
	 YNUw7tFIeysUcXMQGHD7vgkG3ALP90mYQKj+ZDzU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	Elizaveta Tereshkina <etereshkina@astralinux.ru>
Subject: [PATCH 6.12 019/204] iio: light: bh1780: fix PM runtime leak on error path
Date: Thu,  2 Jul 2026 18:17:56 +0200
Message-ID: <20260702155119.069507057@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270959-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:antoniu.miclaus@analog.com,m:linusw@kernel.org,m:Stable@vger.kernel.org,m:Jonathan.Cameron@huawei.com,m:sashal@kernel.org,m:etereshkina@astralinux.ru,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,huawei.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,astralinux.ru:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA62B6FAA2D

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

commit dd72e6c3cdea05cad24e99710939086f7a113fb5 upstream.

Move pm_runtime_put_autosuspend() before the error check to ensure
the PM runtime reference count is always decremented after
pm_runtime_get_sync(), regardless of whether the read operation
succeeds or fails.

Fixes: 1f0477f18306 ("iio: light: new driver for the ROHM BH1780")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ moved both pm_runtime_mark_last_busy() and pm_runtime_put_autosuspend() before the error check instead of just pm_runtime_put_autosuspend() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Elizaveta Tereshkina <etereshkina@astralinux.ru>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/bh1780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 475f44954f6110..f478f12640d536 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -109,10 +109,10 @@ static int bh1780_read_raw(struct iio_dev *indio_dev,
 		case IIO_LIGHT:
 			pm_runtime_get_sync(&bh1780->client->dev);
 			value = bh1780_read_word(bh1780, BH1780_REG_DLOW);
-			if (value < 0)
-				return value;
 			pm_runtime_mark_last_busy(&bh1780->client->dev);
 			pm_runtime_put_autosuspend(&bh1780->client->dev);
+			if (value < 0)
+				return value;
 			*val = value;
 
 			return IIO_VAL_INT;
-- 
2.53.0




