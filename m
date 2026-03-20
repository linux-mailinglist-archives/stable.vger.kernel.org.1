Return-Path: <stable+bounces-227401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNL3H/qRvGlU0gIAu9opvQ
	(envelope-from <stable+bounces-227401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:16:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F219A2D46D1
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8A9C3026887
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC21A1CAA7D;
	Fri, 20 Mar 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPVD2Yjw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AF1CAA65
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773965802; cv=none; b=NM2iSWVomGtiCIAOXX1/T87uVJHCBys4AHtvt1xrrZOe0FRDPvfqaIQtN/4grYjhqqMrg4/oGzy1DXiDHqECIpJUptAyziRxIR3fQVmCFBaXoOnfyJOHVfRV6w7oQe00zUMVPJxD0k3n0HVu4TfBPDXneh6JwTQwUBpEfYcQbus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773965802; c=relaxed/simple;
	bh=6yE/rFdm0clviVs+9lAMyfpRWD2ThgTGDVg1DeXUwUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dzamwb0KONWhCE2xz9u4PLKg3nfwSRC8EvDanq5xxF2+1ksKvdDOLytLIyE+IyFZnpXSCLSO+1r+K+VRD2HaD/XiiMUaurBbfMtTNr+PhZ3Vo67vToYha6W5FOALvzJcVr5ZxIbSwc7DH9b6DUO9whNKNdBin84ppPFPNb+QMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPVD2Yjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BABC19424;
	Fri, 20 Mar 2026 00:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773965802;
	bh=6yE/rFdm0clviVs+9lAMyfpRWD2ThgTGDVg1DeXUwUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NPVD2YjwFZ0CLOND/mnMqalG4Wv5QuFnYq5PSoiAo2uin5Fbp1j4As4jTU6TBdlyv
	 pLe/V9hFoelt3a7Es1VXasbKR9W4KcNeKuHLjPvqp9/jskwlLcegjuYpVujVvnwI9n
	 BcMxjT5OWRK+lFJAInZxYOjmna5+g/HgvvpFPmjEgcgrX5/m/l8CP4FBY+FBQMu6B8
	 F5VDM7rOxZXoOJGhl+DVY/x4edgLYDVQOo7Kw3n1PUOdGMZ9YKJk67b7ytgCSvwswn
	 nkiXcPzieMcMSRF7rTtlviMiab28v7bfn+hlh5l+4+64Ha/bIJM54pXO1QnDxJcI8Z
	 89xc1PVv9T5ww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: light: bh1780: fix PM runtime leak on error path
Date: Thu, 19 Mar 2026 20:16:39 -0400
Message-ID: <20260320001639.3247800-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031707-rehab-trio-c127@gregkh>
References: <2026031707-rehab-trio-c127@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227401-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.985];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: F219A2D46D1
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
index abbf2e662e7db..e0a72ff2ebf8b 100644
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


