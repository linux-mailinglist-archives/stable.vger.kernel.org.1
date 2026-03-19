Return-Path: <stable+bounces-227374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yF1CGopQvGkXwwIAu9opvQ
	(envelope-from <stable+bounces-227374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:37:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D523F2D1B99
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 333483184EBE
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 19:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E73E867F;
	Thu, 19 Mar 2026 19:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVwI364X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5A3E0C61
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 19:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948961; cv=none; b=CtCs2KShxUTRL1MXv75Y3lOPk2eh38Ha5+MQvnWVJcAGlnZmNzbWRQGW2+q/8k+wc9HASP3UIC+KZdMw4z1RaAFDWgAr3QuqR7w8wWSV662HCVtERf5whe/xduopftSiSQ85pU5eUyIwEFESOXUyymbtYOp+fkN4gx74s42lNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948961; c=relaxed/simple;
	bh=gBsiZT9heuGhzW9WuaXBlNXrKXRx5IG2dKnnyAhVeDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIPvPDljzTnJJDl5ReJx8z4K8bFY/EbVhRH4kwnzTx3GjO5dz5oBVOGbAH+e9P1fJl5HqmYrHJ0iXslYuIeYMtFa9MU3rNOCxIBsqwX1BKo22/odj6mX3K3lsFk3byYojKS4DyHgzUjmhcXmmHtXPl5Hl2NqJz6HnMZWIeU9w3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVwI364X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5D2C19424;
	Thu, 19 Mar 2026 19:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773948960;
	bh=gBsiZT9heuGhzW9WuaXBlNXrKXRx5IG2dKnnyAhVeDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVwI364X/h0mOT4ZXooi/cIFreBTebbUYDcjrksS30jZVi+E2S6221NJHt7XhQ2eR
	 YBDHdxio/QZR4ByEz33ojPxCNkJwExz+P+aEAzvrEWc2kGM5eU539ELpMQJj3ZLMwi
	 LMw/vHmOCss5m2DXCaBvfGGlxSYkjw4O8CvqpngE4UTA4vCTDjKbU3SznldN1fUII4
	 l+rz1/ymla9eT662sukZb93rJQySNW8g0xJNvzINg9t+Umh9O4BUMPdsDuS4aGjglf
	 6ynPI3GsyOJjuwDVaBmr2yuM2o42CSpptAkU1qoA6PFUZjoop3dRVTZtvqkQIPOyxy
	 OSvAXCZqlnwkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: light: bh1780: fix PM runtime leak on error path
Date: Thu, 19 Mar 2026 15:35:58 -0400
Message-ID: <20260319193558.3026481-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031707-gravy-outlying-83e6@gregkh>
References: <2026031707-gravy-outlying-83e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227374-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: D523F2D1B99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Antoniu Miclaus <antoniu.miclaus@analog.com>

[ Upstream commit dd72e6c3cdea05cad24e99710939086f7a113fb5 ]

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
---
 drivers/iio/light/bh1780.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index b84166c5fa06e..f6b0b2fc4ecfc 100644
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
2.51.0


