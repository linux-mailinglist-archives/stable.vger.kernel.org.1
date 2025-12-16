Return-Path: <stable+bounces-202033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E543CC2CAF
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B26433053B71
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEED034D397;
	Tue, 16 Dec 2025 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXt8FO3Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E098F346767
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 12:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886604; cv=none; b=gB80sRMXGqMLatmaHxmfX4omEZ+EFtu24RXrRfA4YmWfUgXVW37sVYWAgwjp7602Gj/TwMY21huzRPJeoNy94n2HYxGL8DpvuSREj1SxjkTWenYNIeJ8qYVat6fCVUvae0VmCyGLXDob6MMtjB1kUs+OeXG+RSaTHFqC9iRUuGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886604; c=relaxed/simple;
	bh=+OuTyfPiRyHJRaVNUHS0ZfufPGLqwrs9N3H9aVM5u4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqRCNFFUo4usOB/+FiCxdG1vaSdIpxSwQhsuLp7dMDUmKJvhn6KhZA2WfvELGC3+RXt4Er6qltoOW/dMF6Jycbv9A5qLondbCh1HwNCNiSD3/BiDUFjqR4RDNRe0AasU+IFsIr9wInfxF5XPk8XVR/4d8TqMyETuisj0syiMDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXt8FO3Z; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-34c27d14559so2637352a91.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 04:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765886602; x=1766491402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nudjjo9tQjXv4Uc7N0zXlvtzn7nmSytE9z2pqTH9TYo=;
        b=TXt8FO3Z4QHyD1qe12IG4cCSQUwYs3l2gP+grKakCFo3FlwuHDiVigGrmslm7pshtd
         Mii4PUJJm3RqEJGujlW1nq2FDQKDgoXB3afDTROnVU3XZTKDz99eSRiB0OIaepuCnfOT
         4ZpKcIt/GGwUD6ltTpsVQvhUFKYt9tsa7/DQtZbx6Ku3YgoPD6GbRV0u6OPw9x7uQWiF
         eDDhdT0aMTJvKNmygvXCZe2lkinNCur+IUpF8IiCrfZPyHPOvemsXVzGTIg2fRLQ4yek
         w5u3Ct+Nv2uTS8qCANJV6w0wFYMqqA0syQkGfEnOheC+ehb98GEeQe3eN9wD2r28z3YZ
         fG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765886602; x=1766491402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nudjjo9tQjXv4Uc7N0zXlvtzn7nmSytE9z2pqTH9TYo=;
        b=ARJbJ71gqA9wnBOB9uYa+QKDP5HIclFYD3od13ChnocJKENAN909GURkVflr4uo4cS
         zDsIK4m/5KT883JMnM25dxsTGWKkq41CvWrWNAzSLzYjXI3Ih2h/78hFEE9peeanpP8+
         eO1ACNhZPSJFGqUlVTo61F4Ab5/QFR2+gWAV205X0LffaDGPWUnAG0GlEQPNH+gUoe1G
         7bo9lHZO9/kt05PocCo/DomtABct8IJR3btaqLVWrViXGQd6lPs1ECHmUn9v98WobblM
         YGtfSQXduX6peOxjd1B1mIdMggyKyWZRutt2C2I5U8DCmfuEUJ4NITA2lXPK2jdUo0SY
         RtSQ==
X-Gm-Message-State: AOJu0YwnLLTYRLf7psFoV7JXawuPmsSoRew2mpSrYMiYfGFohNlq9mMV
	i7DTwa+jVbDFp/bEuDblRmKDvDMAQo0rJZehkAe/k/nWwDADUWP7F9Lc
X-Gm-Gg: AY/fxX6W/buwm1zk+2eorLEQhku3kiEqQGTMFB6RKPgAdkxkzllbb4BZNaqn/6T/vmB
	WejeQlBBpLgMflHepPPmJlm6Bvqqtogs9yEMujQt8YAPT4xqka8qNFDoIF1mbQnCIiVmZuvw2vQ
	m+C5iYgZacgTz5FdoZtZycGpkTaQMAdnOGPrFixdBfBz4EliUjZVDHx0yPdVvhpcJp+CPI17oC6
	Qxca0qp53gxLSETxtodj3R3bHyWraMELKBfzfsCIn1jXEVNxUtwm1ZYsgDdlWeY2gan/rnlkvOX
	J8wISDOS7R1m/IkZoOOPb4QwEJvZwZPhHXdEi+udDeoR/dokc3ggUakoJz8NZPIUgishNZ9edJw
	Jb655oLbe5eGDSAh2iOTPPtpsz2pE7g9DBdi4LjITYXUH2KqC1uzvKnQXs+FZ0cdqAiF0WZ/pY0
	o33dA=
X-Google-Smtp-Source: AGHT+IGRE101MPbPNoCKbWtuok2GQamkgSTAc4yz+nOa0mSToWIwvtlKCanMm5xotu0FurQEcAzDWg==
X-Received: by 2002:a17:90b:4f41:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-34abd848841mr14720357a91.23.1765886601355;
        Tue, 16 Dec 2025 04:03:21 -0800 (PST)
Received: from localhost ([2a12:a304:100::105b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba5e3sm11476016a91.5.2025.12.16.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 04:03:20 -0800 (PST)
Date: Tue, 16 Dec 2025 20:03:18 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org,
	syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: xattr: fix wrong search.here in clone_block
Message-ID: <aUFKeAcD6NeBbZ6O@ndev>
References: <20251216113504.297535-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216113504.297535-1-wangjinchao600@gmail.com>

On Tue, Dec 16, 2025 at 07:34:55PM +0800, Jinchao Wang wrote:
> syzbot reported a KASAN out-of-bounds Read in ext4_xattr_set_entry()[1].
> 
> When xattr_find_entry() returns -ENODATA, search.here still points to the
> position after the last valid entry. ext4_xattr_block_set() clones the xattr
> block because the original block maybe shared and must not be modified in
> place.
> 
> In the clone_block, search.here is recomputed unconditionally from the old
> offset, which may place it past search.first. This results in a negative
> reset size and an out-of-bounds memmove() in ext4_xattr_set_entry().
> 
> Fix this by initializing search.here correctly when search.not_found is set.
> 
> [1] https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
> 
> Fixes: fd48e9acdf2 (ext4: Unindent codeblock in ext4_xattr_block_set)
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  fs/ext4/xattr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 2e02efbddaac..cc30abeb7f30 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1980,7 +1980,10 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>  			goto cleanup;
>  		s->first = ENTRY(header(s->base)+1);
>  		header(s->base)->h_refcount = cpu_to_le32(1);
> -		s->here = ENTRY(s->base + offset);
> +		if (s->not_found)
> +			s->here = s->first;
> +		else
> +			s->here = ENTRY(s->base + offset);
>  		s->end = s->base + bs->bh->b_size;
>  
>  		/*
> -- 
> 2.43.0
> 

#syz test


