Return-Path: <stable+bounces-227397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDESET6AvGnfzQIAu9opvQ
	(envelope-from <stable+bounces-227397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:01:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 968282D3F18
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E24D30210E7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7703BA243;
	Thu, 19 Mar 2026 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcevOz0S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF43BE165
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961274; cv=none; b=iRdaSlM1hgt63cHFHRmu3FWn0NvQmguNrow+pwZLI6RCk9xtFWmLWN+nNgQCVd6nqJ37TVA2EnEeFVUNkf/rUqCb61e2tpHxanGbkC7AkEiifrSmpt2e5hrLQs4gdYimGhgc+ry+Ozkfynmso6OxKnwyIq12V/fhuF4VEdWOJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961274; c=relaxed/simple;
	bh=5EgF47M4/lRdWkOE2/UeAVqpghGBiIUrKPrXyMQI3vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKqiMvyF3DT4yvuLlldkhffK8F1IbUE8HfXT+FRWSPD3JF6JOxtrQYGOXLiU9gDYlRyAfxdmVwMxB4iaTlfak8YfpkEzSNMcLUaBrBiqe0B91Kvlb4vJph0wq4xJ0cKQFN4LNQ+n9RlQ9Z8ge/3W25q5/vlRwOvzW5iT7UrWI18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcevOz0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2701DC2BC9E;
	Thu, 19 Mar 2026 23:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773961273;
	bh=5EgF47M4/lRdWkOE2/UeAVqpghGBiIUrKPrXyMQI3vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PcevOz0SkDvCCITvuQomrkn8JtysCAy2X4bEWKfldBlfc+V/H9BD33ZFjtVRss99W
	 hEiHoGiRIN/oTDx/cT49BVa7qu0xwIIIS/Go6DJl2BbML+hH4wrRFM/WwYriE3/Zp8
	 ONO/sRDmynGVLX8dEAZ0f8EA+8PEkL3sdwc9P6mt1bY1x1RHSiHLzdj96VLJGE9IS8
	 w31NKk1Hv8NbLzibxdsn+gI7gTEio1wOwMkgpvouCgqExfili1nm7AtKxc3byXFdwx
	 RPg8GMzEI1ZgjDOQo4WX61LWqJrBCY+3Nrwu4yy2g4CvkfJ3Hq/skZ+j4r1b5UQhKt
	 HLpxwPZvkqi5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] iio: light: bh1780: fix PM runtime leak on error path
Date: Thu, 19 Mar 2026 19:01:11 -0400
Message-ID: <20260319230111.3146058-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031707-pull-leverage-a222@gregkh>
References: <2026031707-pull-leverage-a222@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227397-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 968282D3F18
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
index 90bca392b2620..725cfd50d9e4c 100644
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


