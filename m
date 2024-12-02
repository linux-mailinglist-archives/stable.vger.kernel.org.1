Return-Path: <stable+bounces-95926-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E3E9DFAF9
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 08:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9397E281BBB
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645A1F8F11;
	Mon,  2 Dec 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k6a8KJen"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5881F8EE7
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 07:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123855; cv=none; b=fR+R6aefRb67Hjs1JjhCuhWQLSMmkMDc2pSfGxL73peFVPEebgOwCKjZKhQvN5qf7FZX65LfhpIekyGyKKrtdR/goLKuqlYwTPGMwkQ4Z/jUfB14wUF18uivkkIK/LzTCgdkXOpsw+sc3LdAN0oT2+Ts4yyxV/oLWmJ/bBGkI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123855; c=relaxed/simple;
	bh=kooD3OZn0sK2RtQu2y4BJ/3qiIua3PwBJJxFw3wxARc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTwVFgQYpycrk9DDmDqhpZVPWFVDnYYFIqntgRSQ+9XnlivfUmFkzEkJHxlMauw0RYeDs75gTMQyPrURLAgsqZNcKy5aEQwkJikhDgJxNMAoXYyy1+hY3Pj68NLlz8o6UPri2lSLQhcD99b1WyMc218m4HnSK1gkvDjUNak5dFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k6a8KJen; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-724f41d550cso2233960b3a.2
        for <stable@vger.kernel.org>; Sun, 01 Dec 2024 23:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733123853; x=1733728653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z2WZIJ8AYovp0nZDoremrJ+zQLezbNuCp9D1+GAtZok=;
        b=k6a8KJenInOLkTTrneXazJ9tEkFS9rGt09g+o169ZqHBncWbaDtOxGLblypOGJkWEM
         vpPCEiIokx2bRsozpely574MVORYz4KcyrGUwPrHfqtrlhKFsEUiRg52DYqTGDRxsMi1
         MkPu6t6u8LZfrULuAuNF9+reCbWbHaeOgqt4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733123853; x=1733728653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2WZIJ8AYovp0nZDoremrJ+zQLezbNuCp9D1+GAtZok=;
        b=YfhszPsNz1lbdju/BPOemlZkGvRK92vYl3YsEj1u/PZwU095oypG1JuvfJ7Sq1sh+0
         jPU/bFS6P5ni6TE+V9j5He6yIiLx5HWpZJBEjNdEhZ5GbYa0uJusDVA1FpTnFzYJ3AnE
         IvAXkKgOyNYpGcUZxi1EFqrycFyBHr5Od/6EQXdVe5uGp6RVgIuNhhNjfyZq6Lnl1wuI
         5Us5JD7S0GqRxIk/s+Vc8Y2ilOSzDIWUaBNMuj9QrCMwa5xH+FMiBnpN6VVrKlFFCuPK
         cEH4Hl9ZfaL4WGtH6vDs255enc3DrR9y6/MopwNUTeqZVWcLM6rvZFUSfC1jPHXFQAuN
         ZdNA==
X-Forwarded-Encrypted: i=1; AJvYcCXbBRQHpgk86BKmlYjUNJcyrcB41ng+KXp/cIfQjAZCQpctRfEFxp4w/f0+GatWHozjqwZbpf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxiip4UvR73tewXYh/pBfz9aZ3/zNVgTrUwJB95oFyHDs3NJBB5
	k5qFfikGTb0t/aTYi2QYPp1zLu0vlcVCsTfyPIaMVzpqkYB0yYiyq5FR4O74y9yrL62eDNFIl6s
	=
X-Gm-Gg: ASbGncu17rPdDNBiK76KNW/9Iv5Qd+D9LUXuYI2BQTXRlFOJIbXgBZZnDbCELp7mxMv
	d72pf8xTVd2lyV0nPAco8wTYQvY9Hk1dtSZ0Jr+FZp50FZFwIolCuGq2sTvqpMi5sdCSKzOHmHw
	CRE9qRBf8OIqBh+eTQENQuZaKJPMYpc60Y6qu4pFOUAFo/xIo+9R/5DG+r4CdX7mxKOA2Pp8eyP
	wKeRSlyCOBdzMQltxRyeMzYo+cJMS4vqNpKCkToP1WjXj4Zx2/Nkw==
X-Google-Smtp-Source: AGHT+IHLcwXWSTFmgXoLb2yqZL/wkXQlvJBzol/iukRpaSyc+eTg5BRaxziv4ODmGZT/WqFosH1k5Q==
X-Received: by 2002:a05:6a00:21ca:b0:725:64d:c803 with SMTP id d2e1a72fcca58-7253018e6ecmr32255224b3a.26.1733123852923;
        Sun, 01 Dec 2024 23:17:32 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:13dd:b39d:c5ab:31c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176147fsm7754486b3a.10.2024.12.01.23.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 23:17:32 -0800 (PST)
Date: Mon, 2 Dec 2024 16:17:28 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org,
	senozhatsky@chromium.org, minchan@kernel.org,
	caiqingfu@ruijie.com.cn
Subject: Re: + zram-panic-when-use-ext4-over-zram.patch added to
 mm-hotfixes-unstable branch
Message-ID: <20241202071728.GB886051@google.com>
References: <20241130030456.37C2BC4CECF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130030456.37C2BC4CECF@smtp.kernel.org>

On (24/11/29 19:04), Andrew Morton wrote:
[..]
> When using ext4 on zram, the following panic occasionally occurs under
> high memory usage
> 
> The reason is that when the handle is obtained using the slow path, it
> will be re-compressed.  If the data in the page changes, the compressed
> length may exceed the previous one.  Overflow occurred when writing to
> zs_object, which then caused the panic.
> 
> Comment the fast path and force the slow path.  Adding a large number of
> read and write file systems can quickly reproduce it.
> 
> The solution is to re-obtain the handle after re-compression if the length
> is different from the previous one.
> 
> Link: https://lkml.kernel.org/r/20241129115735.136033-1-baicaiaichibaicai@gmail.com
> Signed-off-by: caiqingfu <caiqingfu@ruijie.com.cn>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>


Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

A side note:
Well, we should not crash the kernel or corrupt memory, in this
regard the patch makes sense, however, if data is being modified
concurrently with zram write() then zram simply should not be used,
we can't decompress data that is unstable at the time of compression.

