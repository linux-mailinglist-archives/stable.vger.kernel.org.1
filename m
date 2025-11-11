Return-Path: <stable+bounces-194503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 745ECC4EBA7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 16:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2FB44FB8DA
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080135B15E;
	Tue, 11 Nov 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="F9KOPolJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808CE35BDB8
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873710; cv=none; b=QIuYjKcZgrv/H5FjSFBoPH1yf5mLh/XzNVb2iK5kLaPWuf7Vz6e7WBRYM6ThEUdOCsnN6uxyWXDC15PIs1hL4ITnX6B4ylhjWwX1m/OrEIxgHXqOtbTRGJ3gC9OB9MEiWYB4WSajza701teh5RFmLOhDB47fPjeHdS5TTQZ+scY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873710; c=relaxed/simple;
	bh=Xta2MvlZu3CQWRZS+oQzk+wp+MTHAV8yo94rNuOB0Qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q33bb/6pZMi39Joh0gX3nei7IU/3+xutOx4u23iz9Ldo4EdCzysnffHY6cCCSm5goUrqNZlLikLrrdLIeDqOswyHNpDd6chPf3TX7iCyKCrKfRo/vH2DWCdzEh5YKUnnhX2hU6VU75iUuEqWcHVlLcdhl8MOpI/D+hlMrShzpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=F9KOPolJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4edb029249aso22196781cf.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762873707; x=1763478507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kFQcYhT1UN/BdLra6ZICJpJxbL9J8g75Rx8chmg733k=;
        b=F9KOPolJZSXc4msL98P9LsmQf/8NwPUFXfz+M0LD9fGXgmQkV3beYTvT31uoxyrqjk
         BPguNFyZZzPUuSIFWkv2VMtDiMZL1mbQVnwcaNpx0NTX2ezPAFRzR17/6WFqLxZU7MTI
         w9Z3C3ZDSXLJ6hORIcldRc8VVYlXn/LncpedE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762873707; x=1763478507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFQcYhT1UN/BdLra6ZICJpJxbL9J8g75Rx8chmg733k=;
        b=FOoUfAQTJ7Xy6rv5bzmihbGBrEAgR95KQxAQtRAichHuxkdQNZG6Amm03OudJczROg
         JC0JQzo5u6GiX4spe6hH6t9AmsbDOY/p5CUCx3uzVINdq8upY+VqbaG7Da3wXKehvIya
         d7DMnKoV2FfoitNJFLgXW1IFQKXr7WmFWgGulN2Ix+opkTF17pYvKPhUgWS7dxwbm2eb
         JOjsu/HN17cFcz64opbFtx1r1SAu92Td1PDBEoaHDeTZAdIYytXyTnJN3TFpQIdb87Q1
         UvU7E2cGIF47REOz6CRc2qH4TBY9nIS2sxvjmbMyJu0ny829BarOx5lku6EVx3dU6AY9
         xY0g==
X-Forwarded-Encrypted: i=1; AJvYcCViUVer4uZmHYKNeE+8RIvFzZxwNm1+j/QEYk8siNMQamPcb4gcd1lvAOVFp4ps8NGUsnSZwzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAwg5Ep7p6ugs/59f6q5r1Rwy5QuIvOQ/P60gqwjGA52TNQo+X
	po8emQd7IAc9ftzuQ4v/No7dAo4xZAbmtsHs7cwtoYvoREAwi9jQls1HEKw35xIZnxnYyXE83Y6
	mbm6o0/DdVot7IjMF6Y8kVrIwMFXPM2gPd2Bn2YV6gg==
X-Gm-Gg: ASbGncssPUZS8UU4PWs3sm8OQvViC3uPFpyfaWEz2LAHCWLxDGAVKpGAyNuUk/CMXb+
	YNnGywX4FKikYhg7pU+ThnlW/3dLBvZzxP+9jRomH35B0dFYdQFACAVBMuHOZc6las0rYCXCUfB
	ZAWcttIX9ETbGFG6Ra+BnwR5B/+lLUbbcdauvqg1gL80yILAAT3b4/6kvbo6h5vFK+bzECK6Mgw
	hoRzlVf27eYEaPSMbiTDXdv8BSE7NoH1AR0fQJLFuwOpzif5dugsHSuIE5EvQTbjn6UpQ==
X-Google-Smtp-Source: AGHT+IGXw/+UkoN4jkqPn720diGcBgscMO4ai6PZknNP18Vmw/GLSm3jiiH43yVB2r34WCebUYV3Zhiy4R9PZZEabTw=
X-Received: by 2002:a05:622a:4e8d:b0:4ed:aa7b:db9a with SMTP id
 d75a77b69052e-4edaa7bdedemr134400811cf.79.1762873707134; Tue, 11 Nov 2025
 07:08:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010220738.3674538-1-joannelkoong@gmail.com> <20251010220738.3674538-2-joannelkoong@gmail.com>
In-Reply-To: <20251010220738.3674538-2-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 16:08:16 +0100
X-Gm-Features: AWmQ_bmHMQPQEUpSNB-Y7kkwlPoWl7xahS_phRTvRX4OCSa4FJeaLKf9HXN4Qes
Message-ID: <CAJfpegtCiEGxnnvQE=6K_otzhCkB4+SVLV74_nP4Oj4S_yeKPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fuse: fix readahead reclaim deadlock
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, osandov@fb.com, 
	hsiangkao@linux.alibaba.com, kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 Oct 2025 at 00:08, Joanne Koong <joannelkoong@gmail.com> wrote:

> @@ -110,7 +110,9 @@ static void fuse_file_put(struct fuse_file *ff, bool sync)
>                         fuse_file_io_release(ff, ra->inode);
>
>                 if (!args) {
> -                       /* Do nothing when server does not implement 'open' */
> +                       /* Do nothing when server does not implement 'opendir' */
> +               } else if (!isdir && ff->fm->fc->no_open) {

How about (args->opcode == FUSE_RELEASE && ff->fm->fc->no_open) instead?

I think it's more readable here and also removes the need for multiple
bool args, which can confusing.

No need to resend if you agree, I'll apply with this change.

Thanks,
Miklos

