Return-Path: <stable+bounces-50004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E8900C3E
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 21:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069AB284A8C
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF7614658E;
	Fri,  7 Jun 2024 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1Ia1cbvl"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D91B61FF6
	for <Stable@vger.kernel.org>; Fri,  7 Jun 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717787212; cv=none; b=E5rwQYCgTEsCLWuKFNDXZfaCPMMXBlvs+DsxdvEbeukNGQdcgeY+llJ9uOZfiMjd/5WDHZGeEpXuKjLjiKRvaA1qmun7fjQebqi96F+u9CbGrl3e6zNyatf3sYal7VCe5D+tvgjfMm0FRo58io+BQ36M8rMYawwMNuXB76Gpi1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717787212; c=relaxed/simple;
	bh=HmS14TUSJaRKWlhJ8aHl7kRtYgNFnsuNKjT4IGyTKQs=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=to2djTxbAS+X84QRGaKgc0e40zwUkHyto+5/ccipXb2UNJ1u/NPMbMM4vkeBG/ZJH/iF1BTLbHe5wmDlceb6YafmchR3Fnj7v9uL892U1binHiZrzA0AVKZc1NKtqdNTRk6Yrf62AfBVyV1lAjhxEpEABFY+XdipiGYEkI3nfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1Ia1cbvl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA4CC32781;
	Fri,  7 Jun 2024 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717787211;
	bh=HmS14TUSJaRKWlhJ8aHl7kRtYgNFnsuNKjT4IGyTKQs=;
	h=Subject:To:From:Date:From;
	b=1Ia1cbvl+g3zbsHV6eFKGDs3E19vDue0Lz/eegx6S99J/qqF8c2TEyPIcfqxHLtAl
	 LB+9l697+p9l2uru3HkhBZPYcw2Z4Q5VlKcLTS9TRcRzQT+C0XBcGaJsQZ/+4bR2/1
	 k6MiLQoI9hFHQEZA1e4LS110I+V8HXimA4uNs+mE=
Subject: patch "iio: temperature: mlx90635: Fix ERR_PTR dereference in" added to char-misc-linus
To: harshit.m.mogalapalli@oracle.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,cmo@melexis.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 07 Jun 2024 21:06:50 +0200
Message-ID: <2024060749-shining-jolliness-a298@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: temperature: mlx90635: Fix ERR_PTR dereference in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a23c14b062d8800a2192077d83273bbfe6c7552d Mon Sep 17 00:00:00 2001
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Date: Mon, 13 May 2024 13:34:27 -0700
Subject: iio: temperature: mlx90635: Fix ERR_PTR dereference in
 mlx90635_probe()

When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
like a copy paste error.

Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
Reviewed-by: Crt Mori<cmo@melexis.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Link: https://lore.kernel.org/r/20240513203427.3208696-1-harshit.m.mogalapalli@oracle.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/temperature/mlx90635.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
index 1f5c962c1818..f7f88498ba0e 100644
--- a/drivers/iio/temperature/mlx90635.c
+++ b/drivers/iio/temperature/mlx90635.c
@@ -947,9 +947,9 @@ static int mlx90635_probe(struct i2c_client *client)
 				     "failed to allocate regmap\n");
 
 	regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
-	if (IS_ERR(regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(regmap),
-				     "failed to allocate regmap\n");
+	if (IS_ERR(regmap_ee))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
+				     "failed to allocate EEPROM regmap\n");
 
 	mlx90635 = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-- 
2.45.2



