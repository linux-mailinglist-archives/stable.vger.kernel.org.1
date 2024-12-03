Return-Path: <stable+bounces-96239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2DB9E17B2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15DD2B23B1C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CCB1DF278;
	Tue,  3 Dec 2024 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EPQ+3M2m"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD001B1D61
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217593; cv=none; b=rSwG+w0pZ96ADbuNUILdfDsTlp5K239MGj1ys03Cx6+p9X0xtCVoNRKHY9T59E9dPlhBnLGJcuR+n0W2G0yK8qPF2wfR92tt/B+U9SXB8qntDF/wFrxgfxPu33l6gUA7QlYX86Te441xRvzryZd2I3HJ1hgBfFgXR4KoNGF8UcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217593; c=relaxed/simple;
	bh=nLThmMAA2N57J/MS2sf+bnzXenpNMRykKU0iA87ZQGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X02Dp8CaUO1BwrHFy8dfix6ihS4HH/q/NS5zraAux8jES2Ipe3x3d0q1XstJ+TUNsSZABIocEsjmjqRYT1NkDo3R/hd46uM7e4GHdRThSZyJCgkJj1+levLHAZa4n5fopn5V5PwXK6W5xTvQ2TOUoL1aTIFRyYliCLNmcbzMhMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EPQ+3M2m; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3000b64fbe9so3593721fa.1
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 01:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733217589; x=1733822389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJIGF7RI3yQ0jOMcBQ0mbBInLSfp4wTYHHtbYsIeWVc=;
        b=EPQ+3M2mV9MTR4TAJzCzgH/ZEgJACgHshLjDeMKxTri8A5mbkVcf7PEqyfujq05wWR
         CauXwlgwDaw8M+UxmRvzEXkK0p7MTvFQrM5JwSi3j50oNf0ZBZZttfpmBvhkTBqfTYS8
         meDzjPL8GOlhRXqM6kMqd00ArW1UFeF7+Fw/crAydnmC87Z37bCWBFHuClmVozXBGOki
         OO4Rmhkx5i1A+UfBWmHDm4Ms5nskUsx5eHgU5ZsqeO/CTuFEx7fyUCLuNujpdO7x56tE
         l4ESI9nwkPDxCRAEcpJA44rraPpOYnzVbw2n0EzKWoPIYpDwzzh0pOZ9qpbgOPt9dm8B
         iahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733217589; x=1733822389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJIGF7RI3yQ0jOMcBQ0mbBInLSfp4wTYHHtbYsIeWVc=;
        b=ffSLf++QgCshKMTJZ4XwwVu1M1+7nyxo1HeiK/USHBQARgGPCRX44q9plDrlOO282f
         +f3wn6iPWCLTPE6dxHjDzIXxVqgA9BV3VAGDD1FmP+RViJfKXNpeqffJ8gK0Sv5uZx8r
         aYf14EekguRi/EnGK1n6E+pmnLV0xQi5N8AFPrH75dyNrvF24qTwKt2v95x4V7hsoDv4
         xl3TjAzG2oEqOnnSFQg8cBgF3SSCkWmGUQPEgCCDQStVJ91DmyyPfOIxyBWZ5awcGkME
         kgTZxnRclNDZ4sCo1zf8MAoNaJ5IweJBpElYf3jKv52byHz96bdB2GHnA2Ao4PjmNW5n
         9ofg==
X-Forwarded-Encrypted: i=1; AJvYcCVr2bDweMysEGYl8ZI6YcnIsmtdnh1ginAt+yZRTkLFZpQ6BFpLBq+4P8YtNeCnJpqk+g/wNSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS8rHiYRtzBgXuvCYK/oqcDiQ6nysc1leVrKGwuYSJlox7GUuO
	ap4Xg7aLVKmdOX0NPtffz32UamP6UG4f6rmRVQuUIXGmWo/s4eCtm00DF0hdgxQ=
X-Gm-Gg: ASbGncts1wYg1ZFi4cvtANZgav+6Yn+Tt1Z1H1iYUCRC689Y42u6uZB0HpK2zvH9Oom
	6QjD1oidXFQmrJuU0ketfoWAR6+El1pdgxQ/r7qPRM4SZCmTp+AJKEo1tlcF9X+/0J/YOz4SOf1
	DEFAfX2VVdOl2D8l5Y4CcMstyS3hmzOwmhuDCchnCkTciT97DpK4RujOzn5/aCwIfa3kWj9Qr4t
	ibNafsfPjZ838Arcf8CsF9fonKELzLG+ccJhcQUFBfzCXXK2OMxgbXYCC1Yzc662T+XTnzocn4E
	pJb1YcY=
X-Google-Smtp-Source: AGHT+IEfC5wjdly2Oi2VTsboD7iJTTa5MEqGX/XpE56Oi78cwJFI7MJEAubiWLgbkwBOanVP+66elg==
X-Received: by 2002:a2e:a80a:0:b0:2fa:c014:4b6b with SMTP id 38308e7fff4ca-30009cc80ccmr10990311fa.41.1733217589521;
        Tue, 03 Dec 2024 01:19:49 -0800 (PST)
Received: from [127.0.1.1] (217.97.33.231.ipv4.supernova.orange.pl. [217.97.33.231])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfbb915esm15591811fa.19.2024.12.03.01.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 01:19:49 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2024 10:19:29 +0100
Subject: [PATCH 1/9] crypto: qce - fix goto jump in error path
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-crypto-qce-refactor-v1-1-c5901d2dd45c@linaro.org>
References: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
In-Reply-To: <20241203-crypto-qce-refactor-v1-0-c5901d2dd45c@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=826;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YB5a3XXobSonCeqEXm7LbV3WosWHg1/Yxs2aSCuvkxU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnTs0wYallq8NjSyGqGvvA+foSvpLbFYIrIvrHR
 woqO06Z3q6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ07NMAAKCRARpy6gFHHX
 cs2+EACJKlJsbURMhP9mtuBKWgdQiwB8DpCV0aASWdjnwswK4VaXJuGoi6yZLhXIOszQAhb5I5M
 ZuaDUbGbqSyhNXGQJlSGUgnfhfOTTl1BWx8XEfSNSAcCCvrqkBs2s3z3Q538FmOUZOektwppCXY
 MTYq2BTyXSFM4z/1pOWQ8AJIJIBZCy9SWkRpcWDG0UQbYzwGS7QIEv6JTd6KJIxxYnI8W6/W55G
 WoOPBOrVx1EOvYhSZlbXb2OlcThLBo05+QYmNKWzgo8cxwyWN+T5IqU1jUXwWBoKYaVjZqhu3l2
 BKNq93HrcXUPvLwZRiKZpx3DK5gsnOvFsZmodCB9zS9fkXcphUKCXud7Jukn5Ung7+qpCozp8qQ
 LX6IxG0WpBdkFoqmK1Av0peZiE7ejVZVuEkmmmpGogqSm3n9WPcE9igdf//67Sea6noR6/VJhlt
 Gr4Oqm1vcjX1fGg6+/6DjluspbZ0/1aG23TJqVFWhICMmCVtl0BTZ3wBMkyMgVTl450JEtldWlv
 yXHED3oaixiRzibBBnMvGLsQLl5UWvYkZcsfAbcd2Qq7OfgmPBpXkzjqp3qO7ZiSPjvQShHOjIN
 k0KPeN8d0bZGesxwudYEmmZRuLwS2U45kfT7oB+ktNm0Bo/i0fz3j5pAYSS6OvvR8IDDe5h5EUX
 0iUqsU1PIKPr9fw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

If qce_check_version() fails, we should jump to err_dma as we already
called qce_dma_request() a couple lines before.

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e228a31fe28dc..58ea93220f015 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -247,7 +247,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 
 	ret = qce_check_version(qce);
 	if (ret)
-		goto err_clks;
+		goto err_dma;
 
 	spin_lock_init(&qce->lock);
 	tasklet_init(&qce->done_tasklet, qce_tasklet_req_done,

-- 
2.45.2


