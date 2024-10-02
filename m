Return-Path: <stable+bounces-80585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49198E0CC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E01C23E14
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A601D0F63;
	Wed,  2 Oct 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjW9tEqU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775271D0DC8
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886583; cv=none; b=hpYoV0+mVBmbgW/8bdZbl42DNPXq0EHMQoG+SlnhDumhollzRah+E5zThytT6QkEcs5C0F1iez9iLgVjg28Okx9c2A2nvOO9kLQA5OfyzWZuuTvk4P6q61hvkelmR8LX1vGGhb2F3oR66iIYNO0MqX2AQdRFgD/Q8MHyQ6T+2FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886583; c=relaxed/simple;
	bh=CMoKwG8R8J2MsM+C4uVX32WVizbzLVZfFLmQ54wp2qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq/53E+JkTjAApmt+O28issFAAjfNjE/Sfk20STb5okQg2JtsXxnoBlL3B8YYS5qMSQv8P3d1tfSOlKrWrX8ZTATQy59RlOfvAVp3BMEpJ//LFxkZf3GKUl3nN/V3V09FVCUAFteETWK7oA+MwtBegpFec0WTdTehVljU1YjJu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjW9tEqU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37ccfba5df5so14345f8f.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 09:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727886579; x=1728491379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fg+/e9YtHNEG6y+1vE7Oi7vo7y3TqWerLMYj22PqEog=;
        b=KjW9tEqUGW9dIDu4EPg5OxxA2zEQEN6pN7WgTSxhawpQj6KMxtnJ+a4e4ktzTOa06m
         jVxT9HRWxGdrOWkkDdJkCWIOpaP0M+ESzUXHw9lj+/tcpecxuMOfrAfPFGjjZ954cX0B
         oZqtMgWFwjsA3uS7ZvOnRcYAel4s2z9Ilu/1fk5wofseda4GUwN1wUi8Yxwrk9JeLSI0
         rX2sZN9XkVMr1XAB6QRb/qwJo2gONSadKNNT55pM7Hz3sNNZZUwUISEMNEcSyZkfmQLv
         kLkWr3mTyzMc+kvEUBDfgBg8bakPLuPzqNNJ/m4i3JBLTWLC5stOwNKDUFcjPNzAzCQi
         lIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886579; x=1728491379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fg+/e9YtHNEG6y+1vE7Oi7vo7y3TqWerLMYj22PqEog=;
        b=kwZaCrYzXgvpRRVojsLJAPjUx/zYpA0oFScQ3fUqCBI8ymWDYG1rDjkuuPFy/hx77J
         RkKL8JX09H4I7I3NgSo0a5TNueQbAWB8KitvYJ2tMbsarGSkGlMLSOHSbjz+eqjlmexu
         uamXsHPNeStzzO3/ompOGzVwkjbEMGcAgP376pfmSTVK+N4f9Nm3QPIPeBrrS7Z/4fDu
         xWLHC3ocogXbIYp1UuCD9t9Vl0j7nxHHN98moT+4pD/3zHDqsk4AG0J7ofue4ugIXJq5
         chmg6FSKZZQzk7VEGhrNGUjG2MkHFJnM6eNq/Eb6sZb7Duadu00ZTek9z4O/d9aJnrF7
         1jhg==
X-Forwarded-Encrypted: i=1; AJvYcCVwcYP0gGesaqdiheOq9ZoSU44VijMZiKXfV5vcTkFU5u/ivLOkGhftDiY3rWGBLwDp4VgTQVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWFAqvQccJtjnSNgpTFMNhnaELARzhhKvuWcfxzTqORj+Jf8af
	MZA9mqxOGsp1GhLL5uJiYtVHp14YBXwyFpUvuwH1NAO6GcU2NzVKAWdqsONr1Pg=
X-Google-Smtp-Source: AGHT+IEM/qsAOpJxeBhxttCpk9GhkMAPV6cHAEtnkEsKZXgSRahxzIEONhMhcRG+3l48Mk5OA8r1Tw==
X-Received: by 2002:adf:ef06:0:b0:374:c6af:165f with SMTP id ffacd0b85a97d-37cfb8b18b9mr2498980f8f.12.1727886579549;
        Wed, 02 Oct 2024 09:29:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eac7casm23168045e9.11.2024.10.02.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:29:39 -0700 (PDT)
Date: Wed, 2 Oct 2024 19:29:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	pavel@denx.de, cengiz.can@canonical.com, mheyne@amazon.de,
	mngyadam@amazon.com, kuntal.nayak@broadcom.com,
	ajay.kaher@broadcom.com, zsm@chromium.org,
	shivani.agarwal@broadcom.com,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Biggers <ebiggers@google.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH RFC 6.6.y 01/15] ubifs: ubifs_symlink: Fix memleak of
 inode->i_link in error path
Message-ID: <58274759-8f53-475a-b80d-c3dc0740ade0@stanley.mountain>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002150606.11385-2-vegard.nossum@oracle.com>
 <5095e302-333e-4b8f-a6a5-c9ffc002c023@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5095e302-333e-4b8f-a6a5-c9ffc002c023@stanley.mountain>

On Wed, Oct 02, 2024 at 07:26:06PM +0300, Dan Carpenter wrote:
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > (cherry picked from commit 6379b44cdcd67f5f5d986b73953e99700591edfa)
> 
> There isn't really a point to doing a cherry-pick -x if the information is
> already included at the top.  I am surprised that you're on cherry-picking from

s/on/not/

> the 6.10.y tree, though.  Most stable patches are clean backports so it mostly
> doesn't matter either way.
> 
> regards,
> dan carpenter

