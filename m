Return-Path: <stable+bounces-136457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12782A99676
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 19:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F78465C5C
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA328D82B;
	Wed, 23 Apr 2025 17:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PIsTen+t"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3939D28BA88
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428932; cv=none; b=qWXJme/X8X5ybdep5p+aBR6ilwTY2Opk63dzaJFsGJ3E3NXmrsorLNy82WdWO8oN0dRtd0dPfSCDnvos/p/jQg/+Xjsw00PKgY9aovIa/qakpTdqcZCmQedXrxb41G9e4o+qB2MkUHhokuMzNLezQ5ipYk1PkQwaFkWsLlH8CJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428932; c=relaxed/simple;
	bh=oJSYqGkH8eJ7nnI4eONslaNCAK4zDKV2Mf6cPlywreQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dcTo0M1cH1sSz2GyzT2QVNaD2FDY6rCA1pFtF47Bam6RSDj4EhTU2Tl0DL43M78es5U3PajVaO1db2QcuIOm6rJcOD7dslcTrAOK8u4uDMSz2716n5muK/EiSqbBZJTtypry3xtsuyHvD8bZ19hAE59Xj9dy4F9gSeUWuCLpHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PIsTen+t; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39d83782ef6so959555f8f.0
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 10:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745428928; x=1746033728; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I/fWatsoyC3ISeEvWnCn+x63EPNqLu0aQi3bXvQHx9s=;
        b=PIsTen+txJ4y14/TzBIiwRaPQhjL1Zx7srnlszJHjVqrqoKe6tLh23V9tXqmqwAVRo
         7wEO3Vmo8s28ddYy9Ypyap4toFXwh/GUYi8/LOXySKfHS38D+4kGvEwhLks/LmtHT5ln
         orS+xQg2/vhfolUbGfDwoSmMuNtf0HNlH42P8h+BtfjE8c9FCHMaNXs0iedaq8VNM0N8
         xMrapZFwNbFHuxIU9PWus5fWm/CQyIY8oFLGwgqb9ckR3+3z1AnDFcztUPi8OU7ESN5D
         jrDw6efb0GulF2VEsgAn9kNv6cIk3etFBwxRzW3u8LwJYToDTrSyxUf9RF7V4SgefNFI
         gOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745428928; x=1746033728;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/fWatsoyC3ISeEvWnCn+x63EPNqLu0aQi3bXvQHx9s=;
        b=Yr8zREmhpPOADYaH6V77ug53S6FPKXPjI122BKJxTRTvW00i6h4bC/nQJJWP1ml0Pr
         ACAVtq6HjWZHzUZXUjepK6y6dyXTn2n3gUfusKznIaqpd3m0u2zMFRmdLTLjzcTye3+Q
         DkJkOYDHSqkFb/Vag2zuF4o6Bijlc6DuLBL4mhHQImWopmWrrQvIoLG5SmHVi/QUU6Zf
         7Dy6YBLuRQ540OYb6XY2Actc+eDqnox1dS1WGS1Qb0na017YiZsRg6z/IUlFR7W3nrV/
         Hv15yorS6pkmfeWVBTbEK6ylGHInDU7EkjCAO/0o/asFRmlyPdqm0LL31yeTZpiRueXB
         Ra1w==
X-Forwarded-Encrypted: i=1; AJvYcCVk70i0fxHs9fWVX6xEiX+MNi7t0WJBV4sdrD8VQLCN4HTgUkTQL7rsrbHtC6ZiDmZqnDcu1b4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IjlH/i9s2GvzxlA4dO1r+HYYHo3tlWwmFibu91aJ4ACuqHPD
	nY1DIOi/wj3/LRB1liO8G8e/1FGRYcQmrZLmzk2nYDnqlEovJfQx6Ngc63IaWaQ=
X-Gm-Gg: ASbGnctdNxvp989nP1NEFKz5B9I+oPCrk+2VCCDeP9Gp2+WdUeVGhcZ7rJlItN4BMEX
	bDKlXuc+dD+tOEeExyfFDBzjpayui6ag6m74PA0TgtwJ1KhzIn37Ksj/LceonYWvV8i7MN+BK4P
	SKvg15IE52cuWob2hkn0AFZRGQQs6T7zB/RR6wnXJqBG6+J4ufLZOK4iiGRjJDIJVCVK1X1m7Ah
	SV2NP5Bn26DbXSE8PtaVqQ3nG5DFN/XWoEfCuHtBUF+8KquWx0bHy4BiL6DM5m5XPqvUwdLGegc
	mYmbdM9v1B5XlFf4eB+kid0i8C2paTGsUBVrCOEWv11gIA==
X-Google-Smtp-Source: AGHT+IHpb3M2AX8ubADr1y8Clnmgy74dWjubTc/OZ082AsTXoWv1+RFKxrQiRpJTvsF1zuzQls4pfQ==
X-Received: by 2002:a05:6000:1acf:b0:39a:c9ae:9eea with SMTP id ffacd0b85a97d-3a06c6bd8cemr18787f8f.10.1745428928559;
        Wed, 23 Apr 2025 10:22:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa493115sm19460396f8f.78.2025.04.23.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:22:08 -0700 (PDT)
Date: Wed, 23 Apr 2025 20:22:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Marek Vasut <marex@denx.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] rpmsg: qcom_smd: Fix uninitialized return variable in
 __qcom_smd_send()
Message-ID: <aAkhvV0nSbrsef1P@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYs+z4-aCriaGHnrU=5A14cQskg=TMxzQ5MKxvjq_zCX6g@mail.gmail.com>
X-Mailer: git-send-email haha only kidding

The "ret" variable isn't initialized if we don't enter the loop.  For
example,  if "channel->state" is not SMD_CHANNEL_OPENED.

Fixes: 33e3820dda88 ("rpmsg: smd: Use spinlock in tx path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Naresh, could you test this patch and see if it fixes the boot
problems you saw?

 drivers/rpmsg/qcom_smd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 40d386809d6b..bb161def3175 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -746,7 +746,7 @@ static int __qcom_smd_send(struct qcom_smd_channel *channel, const void *data,
 	__le32 hdr[5] = { cpu_to_le32(len), };
 	int tlen = sizeof(hdr) + len;
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	/* Word aligned channels only accept word size aligned data */
 	if (channel->info_word && len % 4)
-- 
2.47.2


