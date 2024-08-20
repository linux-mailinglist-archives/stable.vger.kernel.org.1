Return-Path: <stable+bounces-69685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 159C89580A7
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 10:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2B61F21D24
	for <lists+stable@lfdr.de>; Tue, 20 Aug 2024 08:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE32189B99;
	Tue, 20 Aug 2024 08:14:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DD18E345
	for <stable@vger.kernel.org>; Tue, 20 Aug 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141676; cv=none; b=X+j6z7eSRT7gqGc6yL4GUEWM70n34NQRP8bpEt7oOw6gUQqk3mXvFJXDxdX9g3NPbO6XR8EKCUpqoWg8l7YN9/l/K+CFYZOg303zEIReGhDHLjjliNsqhhoGjxy0Lid/yjR4QJA+tLm3pKrpsGUork3DjcQVwSvRG4OnjGSzrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141676; c=relaxed/simple;
	bh=TYmY1Xnnh0qRU1sPt7WOjOr24QrgTjNS/vGg75mC5dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBhOQ8qnzUJnr6+M+Fp4tezwVcQk1H9bYDCN7e6lXZUC3mFur2SJ8j32AaETsXuTlA2clPg63+kdC150DTkQzq7y3bom5ZmhO76c8Hu2ZTPqkuo+azYNEDd8XzwE1pM6aYIgKilt04+YuLIclvniB04dlD4Q6tfrdIbLquFhQIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5bed83489c3so3749810a12.3
        for <stable@vger.kernel.org>; Tue, 20 Aug 2024 01:14:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141673; x=1724746473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLrcrYijvHYdmm6lZD+iH93v7IqstLwP2Xt/dCZ6NjA=;
        b=jWCOJ19XsN4XFP71A53LsKBvApzDULE41HJOyP07Lt246z/9W81hDMXsYgm0yAIbhM
         8f+I397NC6sfDngOQQwywLWK0EEzveewIMSQmEOYkPFr6cQMkjk6WPgdLVqTfkorP1q7
         uLjP9Ixcd0e++lgzSZWBgSMOYB5+zqWDD1+XHozlTnAnNo+1g+bJLNV2bwiwuZuFtsnF
         I9qe5zqed1mRhvrGA+PFxLGMKCuXP0sH5E/eTpH32BCUbJ+/oEtc+fWaLTrqb6ZmFIiC
         fQMWiOmLHD2w1sOEMomdlEqfyt/K6w2UFXSC77BM6o2b8qzBZ1l64SnfbQMM/bM004F/
         5Ilg==
X-Forwarded-Encrypted: i=1; AJvYcCWRIbhN1bqyZMglr7vVJ0Tv4m8NYqKLcddBHFQOA4LBm7vY82oOW5PzQD0ot1WGQO1uC6O0/cXjK32A2p85lB5l6Xi8O1Nt
X-Gm-Message-State: AOJu0YwBLtoKtiE0kn0kCmlf2+r2u/r3ewRpX8rotgjlfaiVT0yK6bY3
	D7XB7O7f5lyGtuKCBrdRXcXlkB/U8TQ35cvCgVQPXFXhushhPKny
X-Google-Smtp-Source: AGHT+IF1NhV/4IC+EXoqixYOas23Kznp/ufBZVLc/iSHzaBInTrFEm+PoaDz/YEB7qz+DdBFbj+Ovw==
X-Received: by 2002:a05:6402:2745:b0:5be:d2be:50b1 with SMTP id 4fb4d7f45d1cf-5bed2be550cmr8660497a12.11.1724141672062;
        Tue, 20 Aug 2024 01:14:32 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-012.fbsv.net. [2a03:2880:30ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebc081afbsm6398544a12.94.2024.08.20.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:14:31 -0700 (PDT)
Date: Tue, 20 Aug 2024 01:14:29 -0700
From: Breno Leitao <leitao@debian.org>
To: gregkh@linuxfoundation.org
Cc: andi.shyti@kernel.org, andy@kernel.org, digetx@gmail.com,
	rmikey@meta.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] i2c: tegra: Do not mark ACPI devices as
 irq safe" failed to apply to 6.1-stable tree
Message-ID: <ZsRQZZiSo2sj5EaI@gmail.com>
References: <2024081950-amaze-wriggle-3057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024081950-amaze-wriggle-3057@gregkh>

Hello Greg,

On Mon, Aug 19, 2024 at 11:31:50AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

I am working to backport this fix to 6.1 and I should have a patch ready
soon.

Thanks

