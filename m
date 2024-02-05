Return-Path: <stable+bounces-18808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED98849303
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 05:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41BDB1C21380
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 04:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90FB667;
	Mon,  5 Feb 2024 04:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WaiputF8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9424B654
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707108331; cv=none; b=Fo4f+oQjZFr4RgF5VjgacORzck6TlU/pUGrnWlx0TaJfXQZmBSVljJZlMITvPeZAkDlG2ptlJUP0bJp2VcOkCCqTh/zhhmpwah68YAb49ZG8i9oakHbwdx7wJsKheKFlY+cbY2Lx+qo5b1xEplOsUvU22ZxMxWhHccC0a6SqFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707108331; c=relaxed/simple;
	bh=C3RFITXrVbMMXRyWOgvAlGjMpXLEn7kRJ/T5LQ+Dwo0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YRs+iYWvw2M6xPgC90P3qAR+eVhsNba0lt5CX4bwrTi7Quxd705nINXH6A5pKDivO6DvZWo8K5tp591POwHZXUvA0WnqyvcCqzPUHN8oJ7IbpFcaCzWONkel1NZEpcEzddGey6JvKgL5xTIUwLI5dtdO/K2nAo4kfHqSVR866ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WaiputF8; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e117eec348so2603406a34.2
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 20:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707108328; x=1707713128; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFHhMPLHf/PHf1gbdd9RUwHvdq1MmSrUv9OUUxHJPew=;
        b=WaiputF8vd4U0kfeYN/ht+9dmNVvtoLGkn6tO/aNgNVvBtRt61kLewQ0/y76sW6ozQ
         KA9K6k3MLDxHn47/PRK+yIGi/lwn1j0q0TolL7cSPZLHsDrGMXi2P1KLIZxg4GKAbTiq
         sjsopiQe9FdMoQjpHzMSrXZd3U7A/BuvgNBkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707108328; x=1707713128;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFHhMPLHf/PHf1gbdd9RUwHvdq1MmSrUv9OUUxHJPew=;
        b=HcV91dgc5U3KE6Fjchg+tvi6jwlpNwNslTXBmPUWpbxO46bEKHuoxlvpVF4G2NVT7h
         5Vg3RERUNLaFDAsqQtxwtSvBCb0/YPn9UCEjChhPmGt2RbujaoqbaXBQDZo3n9FOWtjp
         UA205GU4hj4jQxyGL7STKHAvYnQBPT3c+L5sjT4WykbTIcVnMEeZdWEjlS8luQDvRXXP
         iYYJz6Wvhq6TOqqoCi3WVHgmkI/fsrAHN51jHCAw0ci2V/fnon/Axf7/K5K9ZODTTP2V
         OKjNCsiVmm3YcZfOS5z54rsgSdLcvyab+nBzX+GKjpQ/jXCImHgrkzm3gZbr8SFNHQS3
         qDOQ==
X-Gm-Message-State: AOJu0YxBlxvaRhn+s0Yl+lgDgFH9yGJsiUOHSOAizwwt8Mxm9QM59ZKk
	Ihc+FdqlF2YXmzddXU1FoIeuHV2lRixq/GJT6jBwgmoeRBj4p9iE3z16Xtlnxg9TCV9gtHaxO3O
	WroLt6+S9RHJ6mAX8WafpO8ZBnj8uNnHWzzbGgGjsg9VTT5hqf2+5rWtgEacF2Xp/BsAhxrDGPW
	WKBG8I7LzkTuu2E2kc6taSmGYoa40XRRyngMlOhTWzRBA=
X-Google-Smtp-Source: AGHT+IEeow1gZHkiO9dO07aro34d2nGh7UFwtbunFPEaLK9acEtkUz+jqRl//y27TNHArCGQgN03pw==
X-Received: by 2002:a05:6358:6f9c:b0:176:4d01:22af with SMTP id s28-20020a0563586f9c00b001764d0122afmr15640958rwn.4.1707108327825;
        Sun, 04 Feb 2024 20:45:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWSs66Oq85yGtSLJxv6+8pzpNbVa3ZXxjh/OmBQ2BKZK+SA11XTL8J0LVDMWQBaAhsxtbQZjhkwrZZU6uqBJlVN3CqB3M96uRYUbYwgREloZ8xJ0UBMhP17tepemkj7G3clddifVS60IlEvho6kH/+heAVWvtuU0Yxy89vMaXqWfxp0Poe/9qEmImyduq7WEb9vdaQbYTbVvtnLncsbWzCCjBro3Pdv4LJThOPK2OJbrTWt27Oihzf4YXI1P9QbVCsli/lUMX+lcrtyUdSddk3jWFi9S7EawSmsiRvrImwCX63omLSMvM2N3SiMJgLlDOFqlOuqjcCVvIyUH30jfOTwHOKtHMtKOhqodCSwyekMQkq9XfRDsI9lFEzNN95SUfX83N0u09K2ajrW6KoDE59e0J9ugdrcdSpgxbTf+nP1i8E+NjksQK0SXrEMq2vMSQpsV0mP7qIa2sFDbLvOK3FjlLSR8l1w9vHVn/lFQUj1glLg4RGAy7STvndwRNqN8GFQktdimCeBcxTDsOf328veer2+vfA=
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id bn23-20020a056a00325700b006dbda7bcf3csm5629859pfb.83.2024.02.04.20.45.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2024 20:45:27 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com,
	florian.fainelli@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4.19.y] netfilter: nf_tables: fix pointer math issue in  nft_byteorder_eval()
Date: Mon,  5 Feb 2024 10:14:52 +0530
Message-Id: <1707108293-1004-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Dan Carpenter <dan.carpenter@linaro.org>

commit c301f0981fdd3fd1ffac6836b423c4d7a8e0eb63 upstream.

The problem is in nft_byteorder_eval() where we are iterating through a
loop and writing to dst[0], dst[1], dst[2] and so on...  On each
iteration we are writing 8 bytes.  But dst[] is an array of u32 so each
element only has space for 4 bytes.  That means that every iteration
overwrites part of the previous element.

I spotted this bug while reviewing commit caf3ef7468f7 ("netfilter:
nf_tables: prevent OOB access in nft_byteorder_eval") which is a related
issue.  I think that the reason we have not detected this bug in testing
is that most of time we only write one element.

Fixes: ce1e7989d989 ("netfilter: nft_byteorder: provide 64bit le/be conversion")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Ajay: Modified to apply on v4.19.y]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 net/netfilter/nft_byteorder.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index dba1612..8c4ee49 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -41,19 +41,20 @@ static void nft_byteorder_eval(const struct nft_expr *expr,
 
 	switch (priv->size) {
 	case 8: {
+		u64 *dst64 = (void *)dst;
 		u64 src64;
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = get_unaligned((u64 *)&src[i]);
-				put_unaligned_be64(src64, &dst[i]);
+				put_unaligned_be64(src64, &dst64[i]);
 			}
 			break;
 		case NFT_BYTEORDER_HTON:
 			for (i = 0; i < priv->len / 8; i++) {
 				src64 = get_unaligned_be64(&src[i]);
-				put_unaligned(src64, (u64 *)&dst[i]);
+				put_unaligned(src64, &dst64[i]);
 			}
 			break;
 		}
-- 
2.7.4


