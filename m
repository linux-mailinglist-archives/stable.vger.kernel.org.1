Return-Path: <stable+bounces-208273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D66AD196EE
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99DF73026530
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B0292936;
	Tue, 13 Jan 2026 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0QbWSe50"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F0287508
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314434; cv=none; b=VxVC3Fos6WcXy9WHehCNz8J1qvzXbVzTEbUyEJngL0u2HNNktQu6ZJWuADht6RzQR4+M/Si3VcKZ/RKnNRyIfymTRTaZsExNa1eF9qJhwvN89o32q+jVAIfQVtNgurt4IAVaFmuujm3WuBd36khfHT4jlHzYt5HJWMMIFnJCh+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314434; c=relaxed/simple;
	bh=hf6s52dLGZ0lpKJRZoRViqWJQptNB5oe1T70COAuRSM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kpThyjbJS5Xy7q9bYzcxjeOKOoVx0LD2OGfQauPQhjWRQ62iyNlcZyvCRsYu+jKh6n48gi5wd4jQG/H4eE23lW5LVIAexg72meHMEmQoBgLpICfpnVmEuzOPw6opeeUOm/prwYGrgnCawciW8nk/8ExpBTIguZ0qHczrhd63VGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0QbWSe50; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-450be85b7d9so4934221b6e.0
        for <stable@vger.kernel.org>; Tue, 13 Jan 2026 06:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768314432; x=1768919232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzKL7ZSdDLz29zbAC5Cajq0TXX02OSfm0cUmfKHWr1Y=;
        b=0QbWSe50NxRPuIG+fTy3V0YFvPKPEqtN4cKYY+A438s3Mg+iF9SRa3FCa8vlQskhRZ
         jdALXYq/pv8nT8i1VhNWuTpj90eB3UyghEjlcB3hz6HaEuka8cqQk7gd6z3P9QemuwNo
         9mCfiBvB6k1R9SAdMMMo5uFmA6yQuQwocXfpbOq4+VK3b+tZ/Ijm4EWbavDcrucuOVwT
         ahvKqXzfQtIp3oaWKHj5xXmsiZxvFkv1FIFHVf1FxRl6C8rBhK415xX2ZerA2v8V//2k
         pV5tYcFTxHf4/pjdH8iYAyqEKNnUc+rkVp/1x+FJvuYoTHAplTjEMAlgj4+FkjqinWr9
         m6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314432; x=1768919232;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzKL7ZSdDLz29zbAC5Cajq0TXX02OSfm0cUmfKHWr1Y=;
        b=glGt8fXb7GXEyx9Zi6gu4eu2l6R/C9jiHZk+KQEZSjYR0TR2s51q2BRVDr9T+eHJTe
         FBHi7dBvDP3+DhZQQOHKjjR1TT/Opc/I5mDpbuTw5/SiODjVmpbO9al4QnFWI0hK2eIS
         MuFvCTRqGYFkvYd+AqMjL0gnwzyK95DBEp/EMO72JxjBIsRFgM1cRlEwCpPKn1RxTUoF
         DSFGNTDRtaS506hgWnnK2HTXeJt0L/d+oCD3VnUwt61aJQ6c6bWXBqf0N3n6VHeYDu+O
         CWmKTBLp2QjwJjf4/HExDnurFoifXZqOiidfsQ8rKr7ggVR53TUu/tfbCbXsnyavM0C9
         UQPg==
X-Forwarded-Encrypted: i=1; AJvYcCVU417qdkgQHOnpOISTe6CBVx2SFa7IfnOwkmn8rVcOma3oF6F5xfeu6USuB7IVHoJhMTKY+vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMnCvK2jiywoQ344elJmBmkJRCT6UJKNLA2xEX3YcsyeuWxXvE
	kBlQgzKJqrQoeqnCR9lXT+/Pynk6aqd86X5xXQgJKwXHgI198yeQ78UUe211KIDlsfM=
X-Gm-Gg: AY/fxX5T6mX7cpKFLsYIaNNi5I4LdtYt48pKkyO3BeNZzQrTd9lY0lz/N7rRUJj7qiP
	WQbf+aAwc0QzYRDLxd5GZ89CSOQt6wCt872qTaa8+MIv4njKGJMbd5kf/7AR+fKqrEwACWggxhe
	2cU7ghkQKzYTZiSXClZdExNN4084se1MCAS9xmEupkRAOQSVcnq5LaV/jg1G1L/4cHY5aWij39b
	smY220VN8ApI+dwxQ5tK2mUUTo3hI+nw90j6WUokSEqT/AFIsSSt4K7f7KafBPAFcBrKE5Igflw
	IxkcPLQwgzLqk7sKEIfkx6QvIeKynF+io0rVg89UhKTts4Ox2PzfYP6eBkNsB9Q92IWrl8NVHC7
	qcfvJ6JFEuMtM47d80rPqEtaghcxJxf7w4xF00sT+uLEvOsOE0T+I5YZ+5PYm+tfOQ4Sopj1Jjq
	ovwDGgXXiYnIv50A==
X-Google-Smtp-Source: AGHT+IGgoAVfUvQ5XNClJU9TQFXgAAOmUpO76vAflCfN019fvAQZ4m4UDxdQ4D8xBrgjsyvEsyTshA==
X-Received: by 2002:a05:6808:6508:b0:453:746a:c61c with SMTP id 5614622812f47-45a6bf00314mr11597395b6e.66.1768314431880;
        Tue, 13 Jan 2026 06:27:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-403fa2058f5sm456126fac.13.2026.01.13.06.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:27:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: gjoyce@ibm.com, stable@vger.kernel.org, 
 Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20260113065729.1764122-1-nilay@linux.ibm.com>
References: <20260113065729.1764122-1-nilay@linux.ibm.com>
Subject: Re: [PATCHv2] null_blk: fix kmemleak by releasing references to
 fault configfs items
Message-Id: <176831443053.313337.11697399001631923709.b4-ty@kernel.dk>
Date: Tue, 13 Jan 2026 07:27:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 13 Jan 2026 12:27:22 +0530, Nilay Shroff wrote:
> When CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION is enabled, the null-blk
> driver sets up fault injection support by creating the timeout_inject,
> requeue_inject, and init_hctx_fault_inject configfs items as children
> of the top-level nullbX configfs group.
> 
> However, when the nullbX device is removed, the references taken to
> these fault-config configfs items are not released. As a result,
> kmemleak reports a memory leak, for example:
> 
> [...]

Applied, thanks!

[1/1] null_blk: fix kmemleak by releasing references to fault configfs items
      commit: 40b94ec7edbbb867c4e26a1a43d2b898f04b93c5

Best regards,
-- 
Jens Axboe




