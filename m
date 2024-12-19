Return-Path: <stable+bounces-105251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3611A9F71AA
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 02:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7D31889CF3
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA04482EB;
	Thu, 19 Dec 2024 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NTrMBnPH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1540BE0
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571208; cv=none; b=ctn87nScvdSslEVc+90bTtzDtWmmq5ypBvplgYB9HY7JIcgJ2aSUyVcRr6Syput+Ui1Vo/dvjIicnj2l8arcBlx5WKoX8mv01l+fxPoNyCd7lJIkMmkwxVK5n2qpBdMSl1Gksl7Hrscijd9wKHD2T7IRlD3B9nsYreaMMOGEAR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571208; c=relaxed/simple;
	bh=75zpHAYNNqaRd8aaNF8sw9oJd2zCUlOTXIKcoWP+MKY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rfDfiEkdia6x1qZig/4UxAx4yIFnNjMhbcDoF1UaK7HbRjWHSKjFjs3cYCzhGKzWq0fzOoS6AiH4KVgw2FQYAW+vq/RM0tNN2is/iP+GNr6S1x37v6EwEvdYJ1tM+/+MwFXpdDMk+teS7tVFXMaIsv8PDUIDDMf1gX7qLSaOcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NTrMBnPH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2162c0f6a39so13032035ad.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 17:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734571204; x=1735176004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+DOnah1GMsUpAPjPp+7YAy+E0nqFBMmLEVKuZUZxK4=;
        b=NTrMBnPHOIWmsOm09nwhr00lnrq06ImRmu6l9CdIjNCg1NTUVZefPhTNDGxpUn4lVF
         DvPJRubAa25oe+L19RFw1KcTxU82wLw+6+QfYPheIZwreLeqlO1R7zZLR76JffJ/Txc4
         7MaoaGcZoLKir6yS0TNxO765uM+MHxg1k0mhXK0W2HDlygFya/DK7KhsRF+0EGAHCW42
         /fbtLugfFNA8OqX5FbWbtAJB1R0W3vRWGivHTvQ08QS2C/VOW7LbnyzcKbrv1TZaPd3t
         3iDeYNfYqAaxcE8/6pwOig1mXsCdZsiRPRpXbcVX7YothOsaCIRIiqDP1z6dPeubkYBH
         S4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734571204; x=1735176004;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+DOnah1GMsUpAPjPp+7YAy+E0nqFBMmLEVKuZUZxK4=;
        b=JSc3v2hRq6/04YDOwD3S/2sC97ZWdSN0oisyG62PKNdSSTvdFzIRUD2czb0laRrEux
         FX2ZhmyyDH/0rGJpP3L5lF+fJ6+JlF4IOl2J8yFQ8z+Pj43ucBbq2WgDDxFW8K0G7dLE
         2HD+vpi9Rb3Tb8Hko+d2dxl443dOvbp8aqiGiQW1LeUVdWu9hkibF+vrizLXWry0potP
         S1YP7ip3lJXdLlR4rqZ93kJPzGURqWYuYl4Np+xBXIARh31O9D+B0cQy//6cRvJ7luUX
         OjkRt+pMcAS8/D44avk27K//na8O+xxEyphDf2/NGmGGh7wAhe6w+f85iSN+ep8GTCf4
         Bfiw==
X-Forwarded-Encrypted: i=1; AJvYcCXDQZdpV/FvTTYix2csuAwlQiT+KPHrSKseu500utEMatk9FkCQ2oR4HRXTu8I4XN9KdJgzcDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Qf7+1TZX+E2hx8J6RZW/iMfYWefqplCsKvAsnNYyIh5/BeKb
	1TX8TvDfOUCUOLGMzL/6mksFafdnFUGS/x5eQ1u8NIKUZ97ClzD/syektiVpW2Nack2ZHjb3DRS
	C
X-Gm-Gg: ASbGncvWhrgQVvrQ8VtlD3SLOhnVZehAnw55sUeTX6pAeGtJvoRwgTe/OrdJ7q0sk7F
	De6RgW/7jlgQhwyOSbX7HqNIfZ5oEO6n++b1AYyaXquJUj5zJW5Qcyi7Vwz72r5SXz54C6xogKP
	UyEihsuFYElmavadRpiyfxY5GaCjx3qCqJgdyJy2U1qt9OOXtaoiglUqkwlnxBVEaZtH5VNVpF2
	twL+JY/9kRD2SpzFapYTygTxdG5sm1HPR7wbQp/qFx3UyfP
X-Google-Smtp-Source: AGHT+IHTG/+j0zzNohECjV/Ng8Bs7duXDHt4qA34KIIPFKFZVDer3b3BdqIAputJTK5KzycIRQRP8Q==
X-Received: by 2002:a17:903:11c6:b0:215:8847:4377 with SMTP id d9443c01a7336-219da5eb59emr23753595ad.15.1734571204449;
        Wed, 18 Dec 2024 17:20:04 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc972251sm1668765ad.96.2024.12.18.17.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:20:03 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, Jann Horn <jannh@google.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241218-uring-reg-ring-cleanup-v1-1-8f63e999045b@google.com>
References: <20241218-uring-reg-ring-cleanup-v1-1-8f63e999045b@google.com>
Subject: Re: [PATCH] io_uring: Fix registered ring file refcount leak
Message-Id: <173457120329.744782.1920271046445831362.b4-ty@kernel.dk>
Date: Wed, 18 Dec 2024 18:20:03 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 18 Dec 2024 17:56:25 +0100, Jann Horn wrote:
> Currently, io_uring_unreg_ringfd() (which cleans up registered rings) is
> only called on exit, but __io_uring_free (which frees the tctx in which the
> registered ring pointers are stored) is also called on execve (via
> begin_new_exec -> io_uring_task_cancel -> __io_uring_cancel ->
> io_uring_cancel_generic -> __io_uring_free).
> 
> This means: A process going through execve while having registered rings
> will leak references to the rings' `struct file`.
> 
> [...]

Applied, thanks!

[1/1] io_uring: Fix registered ring file refcount leak
      commit: 12d908116f7efd34f255a482b9afc729d7a5fb78

Best regards,
-- 
Jens Axboe




