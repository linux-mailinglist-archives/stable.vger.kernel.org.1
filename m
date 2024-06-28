Return-Path: <stable+bounces-56080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB6F91C3D3
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 18:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09697B2262C
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CB31CB331;
	Fri, 28 Jun 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wsnlQMzm"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550111C9ED3
	for <stable@vger.kernel.org>; Fri, 28 Jun 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719592600; cv=none; b=ZXxZ2/DOivU9pJpPdycGbkiylDwI/EcbRZ2nr9wQlkn04mDHvt8byzakV4bexML/FoFAvkNWXbLP3ccs5mXzeW8ZbOk78e1fdcLzLGFR62x1bB9IgntwiLGhonG2/8bMIXEfCgCCrp6KJ4vEa6bvdfMdualxWr2zqTJcX2lXU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719592600; c=relaxed/simple;
	bh=848nm0ohXy+F2HyJmHqLg9sTXzaU4Px6SKTmynJ2E+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GAS50uahXkpTmwdtc182q3BzerOSl+xzQR0LNSCAzVN0UyOOPgmsoy7lvDYmBy782L5XnXaq2dV77eMt1WGkOtiAc0XeJDJ8JujWotQ+9Ad6n52Au+V1p5mdTurK3tdZ7MouItpwWbQi0FuhD67feReSYJzKtQcA2BmuirljLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wsnlQMzm; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-24c582673a5so113078fac.2
        for <stable@vger.kernel.org>; Fri, 28 Jun 2024 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719592598; x=1720197398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mnAY4vIH5ynp04nDhzElY6h/MUY8SJM8BPqCHGK0vEs=;
        b=wsnlQMzmD36CPuecFn5sArEa6jTNrnzPTpOJTyK1NgcasexqvjGL/vb6uiodsuddM4
         hBPveo8r6H4wPnDdZhz3iWm6/Ii5qTvYk8gPJtCnxMyUkLtViVb+FhPmcL1LGrRwkPB3
         i82//ROcQGwOmYdBfKIus7PXQJYjEj5LPEgvDe0KkmxZ0aMJRdLy+z6EiPOpTDMBiibE
         iSSL3kpa/7i5yoeVJrT2GWaFsdu+ejrS5tR/GWLXVxoVq41NXnzhbXx1/VK6Hj5P2fEY
         M3u4boiKFoU7fIptGi0n/cz9VafU73mgd5V2q6M6RGy0FCcI3WGLNA4TmgcSoxCQGJ5E
         FZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719592598; x=1720197398;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mnAY4vIH5ynp04nDhzElY6h/MUY8SJM8BPqCHGK0vEs=;
        b=XnsQIUvBzeUcF2WmL6klzS8h/Oygk12ZNlk28hVuEOwGCcS+Q/oJQhs4foTHsk0VW/
         if97Fp5ii6+SlVtU5zuIMxCFRp9uGP4uL+wz+7FpnXZOs8K+1Ep0denmklV66LsS7tUU
         kTyzecfm06++nvxJXTDhNB3Nl2f/0lmk1t0ZEAx5DZERT0p3wxssoTRHyLP7he62MLCx
         xN4Sh6neWgmvYFLQv3LyEjpjzbVCgnrqSnCLkLO9u/DHtX+yTjGbSUwLsWSsLPJpqsqj
         947f53wrWTETbbQhjZopkcXPxh9MaIyoUvLFmKgG4Sv6Clqhdq33eoXegR3sAI39b4eh
         P85Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU2G5nyCYQ4bXY9AE0obFyaKMckWZ2MZ+qp8/xG1PUyouWNQD+LxDvfCYZiZkCCSWexuiQafdYMFrLspRcIjaGijw2G1MY
X-Gm-Message-State: AOJu0YwhoKbG8mWFGTLgIpwz/XA7T8ErejAzy9pM0d0sdjq2U2r0Z6oZ
	KFgC0Nz6IElW8huMVfhA5ei877NcNW9qYcIvRDT7vbc7uVKht2W7Sirvrsydpr4=
X-Google-Smtp-Source: AGHT+IF1MrSPaFiGv7Y2jPWgbALIRZ2SUkEg0PmUnWlYJ/496Gy2rOo8kkNnUQk73i3Swv8ZaDXuJw==
X-Received: by 2002:a05:6870:5589:b0:250:826d:5202 with SMTP id 586e51a60fabf-25cf3f2d0bbmr19603325fac.3.1719592598381;
        Fri, 28 Jun 2024 09:36:38 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25d8e15f608sm503255fac.1.2024.06.28.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 09:36:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 Ye Bin <yebin10@huawei.com>, stable@vger.kernel.org
In-Reply-To: <20240620030631.3114026-1-ming.lei@redhat.com>
References: <20240620030631.3114026-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 1/1] block: check bio alignment in blk_mq_submit_bio
Message-Id: <171959259700.887658.13351594054149607736.b4-ty@kernel.dk>
Date: Fri, 28 Jun 2024 10:36:37 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Thu, 20 Jun 2024 11:06:31 +0800, Ming Lei wrote:
> IO logical block size is one fundamental queue limit, and every IO has
> to be aligned with logical block size because our bio split can't deal
> with unaligned bio.
> 
> The check has to be done with queue usage counter grabbed because device
> reconfiguration may change logical block size, and we can prevent the
> reconfiguration from happening by holding queue usage counter.
> 
> [...]

Applied, thanks!

[1/1] block: check bio alignment in blk_mq_submit_bio
      commit: 0676c434a99be42f3bacca4adfd27df65edbf903

Best regards,
-- 
Jens Axboe




