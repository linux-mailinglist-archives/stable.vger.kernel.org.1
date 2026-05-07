Return-Path: <stable+bounces-244484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIKcF5D3+2l9JQAAu9opvQ
	(envelope-from <stable+bounces-244484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 04:23:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5944E23FD
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 04:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC0F302880C
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20BA2C027B;
	Thu,  7 May 2026 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHo+0TwY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E07284B25
	for <stable@vger.kernel.org>; Thu,  7 May 2026 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778120561; cv=none; b=TMOqSjNB7dT7xpc62WHshf4rpTfm83tlu9PYrbRPTTMnx/eFKKoB2jjo2mpeSz6OKtCmj4eXtwhxEvFbx/9SQMdsQHKQiaKSpg7UOr8luFbeKkVOZ1o5uQRrzaOSx0Q17M6IU8o92qikRhBQYBUoU9W4fInBswXHkhO1jwLUu6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778120561; c=relaxed/simple;
	bh=Zl68Je2THxiwdgrtmVgPoRyHAnq26RpEGmiXgHyG+i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QM7yzd6Iw/znsga0ULUClnoiUHVWmJsEShpsfz6PXD/cqFMzEUX9KBbfI9fh0gAYxfpy5Zh/syHPEGYrObXoPAt4eJW3tx+ZbM+6jlfv6W+zTzCusJhxdoeKHBzwU0Fzn7fp6ovQ6bEE3pTGSzzvCRIoLv+9AXitHlAUnRzZ7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHo+0TwY; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso363457eec.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 19:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778120559; x=1778725359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2A7OPcIfEOOgPo/hUvss5p4sYWrcq7D2ShgndF76WM=;
        b=fHo+0TwYIMwabPTXEjFVd0tLPEN+rVmK8+bmjbgcvwbyMDarTb1h69oYOnq8wP8K1V
         v7eVsGYsjNBonkym+o0FYItFvEtdCAEwQdiu4Eep3N8PO8/apxtxmlOxFbK9/tVXRNFl
         ZAEgxXV+HH1wE2a5eQxkt8zsqbsDBX9WN6NPw7HCeYBg/I6xlf4npo9IsmVuHKGSJpG4
         Hvs4UZMqn8vSrWCcXKmKjUqHaJtWgWRdY6iUYVaebiC2We384hIsPVXaY/diy2BlHqOS
         jSCeJSFqF+KGBxuMGRA1BzghY8dAbb2JZhVqUAxUiFe1WkFoAy+A8W1tm8NNC4865KtN
         559g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778120559; x=1778725359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2A7OPcIfEOOgPo/hUvss5p4sYWrcq7D2ShgndF76WM=;
        b=C7aFXHUm0LrHK3CoD1Rd6bCCFKSrcSqBSgBiw+DYq+M1BBgyq749YMUhUCsyuD8DvP
         m1w8v2Zf6DTc4aVjd7oCnpnbFfzR3gxIpmCfB6uhV/CjATiDaAShaHfbCmxOUwbGoLcd
         N9V7O7tX9eCKkWBL36rJI8+X6ZGia47Ne2dQT0eFT39QxtC5DwDEFVkufmitDpN6T7io
         CsxO+//hU4VlKRIbUAFSzEcY4xo4HXRNCJSjY3iqJVmHOaWEusxe1ix+YawOwGh4dED3
         8pWvxm+G0fcOJ4ybWoXVQiR+yDoJOo1x3C+oh26yv/N4zw2/EAhcA6igILf4PFO62uo9
         VVvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LhMbnCMdlgeEkNhYoyzybxlrbtm4zWaPqAIjM3tuPULm8rGmFqbaKYlGtW14fiRdU+Q2feKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw538tZcdrq3y9EKfptvRQsZOvGbJfwIFedYZouX0DAYlwI55gB
	cYoR2N9tS7TFaXfygXxwFI4MuD8rbnB8mXAhTH35FdNRREXfMhCd5tGQ
X-Gm-Gg: AeBDies7fY0ZEC5KwVgaTWaqmJvF4RCV3MeGANGeNiD5zX5ZDNpWgTizWpSjDZdS3o2
	a3t9a0pKlNkjGjXE9QEz8BUzgq47qEml8S16yYwD3iWhYSoFPApAS1aAFsGFf+gHUja+vSGccH6
	aip5ezbaPMyc+AANvNCRNuoeG8HnMmZv9plu+KviP+NiwfqxvRMD9K14k9T7/Wjtgn/LiuMOUOc
	ZLIs9HIZ8FjrjZx9r58nT7/G4IeoflbjqrHv4KY6M07tdcUqTkC4fQY+aUWUdQiZ5jWAYo7WFuL
	ehA0ed5UeFJt8wyK5Djg9HUr3440KQ/8d8hBK8Xs0fkzUBoGFxsIxg+L/+CyBaee7mAguM0B/8A
	xFH/aqNlsC0+Vzh94lXZViRh9ywo74x15B0Xn5smTgE9bKRTgQ4q689QeOuNWZOrKSMSmRZw0yf
	mNhmUjIQ1AAdZumxH1DAMq65x1hoe/jAimX2GIsC12Hu6oEA2CwYbRTn17llmHBUN4Kw==
X-Received: by 2002:a05:7300:ec08:b0:2e6:e916:70ff with SMTP id 5a478bee46e88-2f54aa81abemr3065260eec.28.1778120559210;
        Wed, 06 May 2026 19:22:39 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm6658192eec.26.2026.05.06.19.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:22:38 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	luca.ceresoli@bootlin.com
Cc: thierry.reding@kernel.org,
	jonathanh@nvidia.com,
	skomatineni@nvidia.com,
	digetx@gmail.com,
	hverkuil+cisco@kernel.org,
	dan.carpenter@linaro.org,
	linux-media@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] media: tegra-video: vi: fix invalid u32 return value in format lookup
Date: Thu,  7 May 2026 02:22:13 +0000
Message-Id: <20260507022213.29290-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507022213.29290-1-dennylin0707@gmail.com>
References: <20260507022213.29290-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C5944E23FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-244484-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennylin0707@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,cisco];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Action: no action

tegra_get_format_fourcc_by_idx() returns a u32 but uses -EINVAL to
signal an out-of-bounds index. This results in a large unsigned
value being returned, which may be interpreted as a valid fourcc.

Returning 0 is not a valid fourcc either. This condition should
never happen, so use WARN_ON_ONCE() to catch unexpected out-of-bounds
access and return a valid fallback format instead.

Suggested-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Fixes: 3d8a97eabef0 ("media: tegra-video: Add Tegra210 Video input driver")
Cc: stable@vger.kernel.org
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/media/tegra-video/vi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index f14cdc7b5211..456134a9e8cf 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -80,8 +80,8 @@ static int tegra_get_format_idx_by_code(struct tegra_vi *vi,
 static u32 tegra_get_format_fourcc_by_idx(struct tegra_vi *vi,
 					  unsigned int index)
 {
-	if (index >= vi->soc->nformats)
-		return -EINVAL;
+	if (WARN_ON_ONCE(index >= vi->soc->nformats))
+		return vi->soc->video_formats[0].fourcc;
 
 	return vi->soc->video_formats[index].fourcc;
 }
-- 
2.34.1


