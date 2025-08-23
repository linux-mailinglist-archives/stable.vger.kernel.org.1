Return-Path: <stable+bounces-172555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7DDB326D0
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 06:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5451C25D80
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425191F4CB2;
	Sat, 23 Aug 2025 04:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar9hj4FG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A61A9F88
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755923037; cv=none; b=M15UrFP1wVT/5j29O0UD4V3yAdMLL9lyNefypeY0ayZtGLSv4uhKq2vFlR38VrK+nH3YOWVuIiW50qtZjXK1gI42dEyDC/WiT+nqwAqvbaDJYW7S4w00qtnVubZLPiVLf5RtV/FAjwPBHQr+9X0MB6BzY+ddhSB3iB6ST2Uh1ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755923037; c=relaxed/simple;
	bh=qudw8v/Rgr/X566aVd4LPiSDONjWP9CQS0rnYiLYKEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDzM/ofer09G0tiMffjmKoKn3M12kBCSy/dvhIrlPMUKD37GQeOk1xDdanOkfedHJSNuuRDI6Y8rU8ZPJVCoMG0Z2LZ3/JcRPiH4FzYEa9/RssBn/lop/yZqAwSElwx+EA8WykbCWcvhW/3BOdmN57vitPaWr8iTDFnhuNwo5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar9hj4FG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0AAC4CEE7;
	Sat, 23 Aug 2025 04:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755923035;
	bh=qudw8v/Rgr/X566aVd4LPiSDONjWP9CQS0rnYiLYKEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ar9hj4FGJL679tfsvaVFD4AL1YWB/kdgI2RZ2MBtHBTUynfYgOJGFSmYqQnPXDZAE
	 /AqSAG2Uuo1ifCr5hWijvLiryYzbGb+4jYpTx5OS/QbLQAQAjGJ/KetFcbfrYH7U0h
	 Q+OIBTxvx4xDbJBkrl7uNDc1H86pOOrNNHdSzt3Uo2NOOtHzt9PYW2qwYMkBdlJkEX
	 SlU3qu2b/IG2WTNHRcyJH4D5ZlbdeiZXD9k0+YJ7oneyHErzXxmhejymqKZqd9rzbI
	 EW2HKaikEICFRtN7OixLKUQdQKXQDWq/NmIIkirV5BHjaoj/v+M2UGuLzE+MS4nOSK
	 SNw7jIG39B3og==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: qcom: camss: cleanup media device allocated resource on error path
Date: Sat, 23 Aug 2025 00:23:52 -0400
Message-ID: <20250823042352.1850575-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082156-dense-tightwad-fbe5@gregkh>
References: <2025082156-dense-tightwad-fbe5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

[ Upstream commit 69080ec3d0daba8a894025476c98ab16b5a505a4 ]

A call to media_device_init() requires media_device_cleanup() counterpart
to complete cleanup and release any allocated resources.

This has been done in the driver .remove() right from the beginning, but
error paths on .probe() shall also be fixed.

Fixes: a1d7c116fcf7 ("media: camms: Add core files")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[ err_genpd_cleanup => err_cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/camss/camss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index d074f426980d..a4d3cb61b9d0 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -888,7 +888,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_cleanup;
+		goto err_media_device_cleanup;
 	}
 
 	ret = camss_register_entities(camss);
@@ -945,6 +945,8 @@ static int camss_probe(struct platform_device *pdev)
 	camss_unregister_entities(camss);
 err_register_entities:
 	v4l2_device_unregister(&camss->v4l2_dev);
+err_media_device_cleanup:
+	media_device_cleanup(&camss->media_dev);
 err_cleanup:
 	v4l2_async_notifier_cleanup(&camss->notifier);
 err_free:
-- 
2.50.1


