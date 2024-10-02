Return-Path: <stable+bounces-80584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32C798E09C
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02B91C22DE8
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C8E1D0E0D;
	Wed,  2 Oct 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZoiHGrrK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89F51CF2B6
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727886374; cv=none; b=S2fmWM1z3W7PR1707vrcCcia+wm0QE4VayJ5kpy3u8cvgZ90WhnJ03JdiADhskyeAm196Uma5rKJ9IrXvvoSl1VIPYytS4/UNFwCGr5fEmCTBtU5npV74sPn5jI+HwaAX0YD5+GPpEIieungud6yiHCjN+dP7y4FMjyIe3alDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727886374; c=relaxed/simple;
	bh=+OEkMmtAuA13Ik6W+IiUtOdVkPtn02rQmhinDlsA3u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhkwGCrmj+oNK6roaAdQS/1V7DRrj+d/sXTDv6O5qsHjI25M4KNM+Bh/r/vlvFipl1NEPCJjmnWAXCnYn16ofvX2+jsdD3hYC3ddnP8O0AcUrb3CFPHl3xM/gxHluJoGFpkY49kUss4a348CFCc2yu+wigrj/b5sPOTj6bugElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZoiHGrrK; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cd3419937so12112f8f.0
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727886371; x=1728491171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GHNMsaLcHGh/o5gx2U7ezAd14bPFEkHNqmqsriZg1sM=;
        b=ZoiHGrrKkDaCe14edpd5hx67NMy77It7pjHAXjOxeN7UdTulTxttqFgz/biszpqmwh
         JmpF4MLX8PYY8wcF9ZCM+qcjnzpgceeK4amR/8g9QewJM4ybAQ0o4eDUpOUazbMkk7Sr
         T4KpHBZ9Rui554sx11mWRBmCrY+Qrb3gZ5BK/IDHg2c7mFyisiBdwosPyTwx+Ch/RIVI
         1AXMAhNUNmdBzeuKEQsq8OMeXrtJGNSpcRsHRYzAOlh6MBFk5qn3Ck5x63PDIAkYUmtG
         38NuRQ7Azi+3qXAV+9tZOwJ4YR+Fy7iIfdONU+nVpivIF0GNOtZcAGMzKihmPQ926IqT
         HpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727886371; x=1728491171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHNMsaLcHGh/o5gx2U7ezAd14bPFEkHNqmqsriZg1sM=;
        b=JYZB5KtTxLYivNl+nrJ5OPieNA2pIUMoeaL0RWjvOd+jwVMg8+VOsht5n6oNfop1lb
         8+xLx2kxxfCiDHM6wDkBWaD+jHDQxma+iv0iYk4CxD732RkMT8TObh2Um2joH24UdzO9
         TcJBM9eXBGNkUyEdMlLy3dwrQMWHw/fGrBpoRhEq18p7ED9ZxjV+w/JZAe0M5szPO6BT
         PhZVljZD5p+M1ZcOdai8X90pvO4Ti/xApOkDuBYboGsfLLMW1TI5uh3kkVCPNu9EakUm
         bDsddDP1g7/ytGPP2l8QlRIbbDGOycfxaZ9w09TjjMdCQxPFstlDkS+Pml6t220ofva8
         qJow==
X-Forwarded-Encrypted: i=1; AJvYcCXTLZUz/1EUwMh5av0m7fzU7VImOxZnXwWE1mQ7lSyPjl9vGHsRYsm+dSyAHZU1RuZiAil09gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySdnJcClE2WeJ1E4ZDf95nWZAWbbnW3GzrUXX+9WFDJXqc7X/s
	7U9YYkCjz4m/Yfm+R/2fk7WUx8JlZ9TaZEDuhmEhbtdSIjL9Ilt3L7hFaacYYBs=
X-Google-Smtp-Source: AGHT+IGTRDbRPgOM3296bwAyMhHTQb/Ij5csrF/cP3ASlXfxTEpcZpjwYZaQ4foC4FGXkiOV8oTo+A==
X-Received: by 2002:adf:eb8b:0:b0:37c:cd57:d91a with SMTP id ffacd0b85a97d-37cfb8b63b3mr2088941f8f.12.1727886370907;
        Wed, 02 Oct 2024 09:26:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd5752a09sm14154511f8f.108.2024.10.02.09.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:26:10 -0700 (PDT)
Date: Wed, 2 Oct 2024 19:26:06 +0300
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
Message-ID: <5095e302-333e-4b8f-a6a5-c9ffc002c023@stanley.mountain>
References: <20241002150606.11385-1-vegard.nossum@oracle.com>
 <20241002150606.11385-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002150606.11385-2-vegard.nossum@oracle.com>

On Wed, Oct 02, 2024 at 05:05:52PM +0200, Vegard Nossum wrote:
> From: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> [ Upstream commit 6379b44cdcd67f5f5d986b73953e99700591edfa ]
> 
> For error handling path in ubifs_symlink(), inode will be marked as
> bad first, then iput() is invoked. If inode->i_link is initialized by
> fscrypt_encrypt_symlink() in encryption scenario, inode->i_link won't
> be freed by callchain ubifs_free_inode -> fscrypt_free_inode in error
> handling path, because make_bad_inode() has changed 'inode->i_mode' as
> 'S_IFREG'.
> Following kmemleak is easy to be reproduced by injecting error in
> ubifs_jnl_update() when doing symlink in encryption scenario:
>  unreferenced object 0xffff888103da3d98 (size 8):
>   comm "ln", pid 1692, jiffies 4294914701 (age 12.045s)
>   backtrace:
>    kmemdup+0x32/0x70
>    __fscrypt_encrypt_symlink+0xed/0x1c0
>    ubifs_symlink+0x210/0x300 [ubifs]
>    vfs_symlink+0x216/0x360
>    do_symlinkat+0x11a/0x190
>    do_syscall_64+0x3b/0xe0
> There are two ways fixing it:
>  1. Remove make_bad_inode() in error handling path. We can do that
>     because ubifs_evict_inode() will do same processes for good
>     symlink inode and bad symlink inode, for inode->i_nlink checking
>     is before is_bad_inode().
>  2. Free inode->i_link before marking inode bad.
> Method 2 is picked, it has less influence, personally, I think.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2c58d548f570 ("fscrypt: cache decrypted symlink target in ->i_link")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Reviewed-by: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> (cherry picked from commit 6379b44cdcd67f5f5d986b73953e99700591edfa)

There isn't really a point to doing a cherry-pick -x if the information is
already included at the top.  I am surprised that you're on cherry-picking from
the 6.10.y tree, though.  Most stable patches are clean backports so it mostly
doesn't matter either way.

regards,
dan carpenter


