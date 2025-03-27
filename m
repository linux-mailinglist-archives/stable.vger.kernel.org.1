Return-Path: <stable+bounces-126877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D139CA735AA
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 16:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2432017B51B
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD7198823;
	Thu, 27 Mar 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b="HHuSmZTy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36C1494DF
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089560; cv=none; b=nDv6fguZxZq/KEcFZ/mMCwwPl29qX3y+4rF5PK4NIeApM23q0xSSEIx+Vb4xnsgjDIY2HQj+4tahk4UqqoauiAmFeJS2XkDTTndbfWGB2hFsSbQd7mmq5Ii7j3Z7Yp62M2dZtRgOlnVlcOpNePlmLU0c5EhDcWdZDk2KX9RONmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089560; c=relaxed/simple;
	bh=3G+HuaERos+QiAvljI/OgjMTC2Cp773SoX79nktQ2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHN94YQUoyNxHRFQOOCn7+azACrSO7ft7tq1nYPAxmxcRVj0qIYaJOS6JZt8RDPx2kete9o8ukLDbImTsPgrrDDkorKKYEhPOKdEpCjjG4Cv//rlitXmxBrSTOAbyIyaEGbQ+KOuC9aM02/pwzod6QRYFMrfQeb/H8eeTdajRrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.b=HHuSmZTy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-223fb0f619dso25454465ad.1
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 08:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa.ai; s=google; t=1743089557; x=1743694357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DyP4Gwd6LgeuTmywr8hPhevtaEC/wP51zCVtswndJ/o=;
        b=HHuSmZTyS1CBIbBEnaDDGCfh0SeuzTEeQ8XOr4XZtYS1wWBQThAFAfOJdqP4t2n0rw
         hH+UWXSLP/WxBDzeNAbfMCzWGu5W/4aOu3DDuB9KSqerEj77R3G1/0kAUcuhbq/Jpqti
         JPgBkczfQAsg9TeHZQEdTI7u3gnY7uk12CTJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743089557; x=1743694357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyP4Gwd6LgeuTmywr8hPhevtaEC/wP51zCVtswndJ/o=;
        b=WvwFirGenst56EjnVxODX9r68WHWlJ2nPer4bDvTi82wRkoowZMQJG0GjYoAYYaz68
         I+zMVyJyHg11wO7Nf3Eofg6qjfeRVNTigzo6EZprt6GXCWQXFRD/ipPzECF/DJRIpacA
         Sxo7JkyJvR58XtO8xgBD5qg1m+smC2hqLoIG2cPTNFIh0DFAgS4nCGv0cP/uzRZzJ8Jw
         xMbca7MQcxPyhxNwp7vv26y6vd66eY17qfTo67mbE/bUzhFo4TEW2W9flMHaoWfSDhOt
         kxGrIkaA4WHdv1En2N/dk74XcHvWspd9ZezxUc2uaV+L8rKZlcIVLQ0iWH3Kp7TB12ZV
         7DXQ==
X-Forwarded-Encrypted: i=1; AJvYcCULPog64RU57hTmdH6KY5BX37PHR5zFdzMsmp3sXrLx/f/AJ8U0g88Ev5jjau+IoGTtAe2r2ZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLWKraYNHEIDu8kqi91wP935j/eZLcOydHwdu3LQASdYteQh/A
	GN5A/BrKMHorFWh2SGI+IkFXe6mECCUkjFbUu8+0B6VVpR4iNjBEdmBarBLeJNI=
X-Gm-Gg: ASbGncuqlbtMoGxHgBjlBJvkXB1VWTyMzGhOOgXPGUA+lkj5D7NY5/5axStokywOCYD
	JzuNokFXn2wO9IoV/99zqsvaSnq0psZttkpTjLy1TDG3VAfAacHSoNXhY2iADZYgcTWX9JxaPuh
	o7MhwnNen4XDCXGhNgGn1yKLzDysLruyDdyyDT+BAcj9rUl/gsQgAd2orFeWLQYyJHMvZsN671D
	gRLTx0bIr8buqFHKCNc1q6TiCuogTXKH+QcOoN8Qw3zF8U3MhsLv8Mj/kaxnv7SBbcSNmF6vDsE
	q+PBOnTBqrNN7L4b5yjaLV/OZeJpUr7xOzeytlRm3H8DP3TXpGXikB868ATfa/vQw6lJKbqfJ8p
	y
X-Google-Smtp-Source: AGHT+IGWEAbgujzSA6nTHHUfIbzw+41dKReOpBxMtnnAJXi16HPvU6coZl9s4b3neOdk85PkywboNw==
X-Received: by 2002:a17:902:d4c5:b0:221:7eae:163b with SMTP id d9443c01a7336-2280493c9e1mr65257895ad.46.1743089557102;
        Thu, 27 Mar 2025 08:32:37 -0700 (PDT)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1f7cc2sm711265ad.258.2025.03.27.08.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:32:36 -0700 (PDT)
Date: Fri, 28 Mar 2025 00:32:32 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.14] btrfs: ioctl: error on fixed buffer flag for
 io-uring cmd
Message-ID: <Z-VvkDUUWLSqJ1tM@sidongui-MacBookPro.local>
References: <20250326155736.611445-1-sidong.yang@furiosa.ai>
 <411a996d-8e47-4b30-8782-4418cf701f69@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411a996d-8e47-4b30-8782-4418cf701f69@gmail.com>

On Thu, Mar 27, 2025 at 02:58:11PM +0000, Pavel Begunkov wrote:
> On 3/26/25 15:57, Sidong Yang wrote:
> > Currently, the io-uring fixed buffer cmd flag is silently dismissed,
> > even though it does not work. This patch returns an error when the flag
> > is set, making it clear that operation is not supported.
> 
> IIRC, the feature where you use the flag hasn't been merged
> yet and is targeting 6.16. In this case you need to send this
> patch for 6.15, and once merged stable will try to pick it up
> from there.

Thanks, I mistakenly thought the feature would be merged in 6.15. If so,
I need send this for 6.15 after sending the patch for the fixed buffer feature.

> 
> > Fixes: 34310c442e17 ("btrfs: add io_uring command for encoded reads (ENCODED_READ ioctl)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >   fs/btrfs/ioctl.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6c18bad53cd3..62bb9e11e8d6 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -4823,6 +4823,12 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
> >   		ret = -EPERM;
> >   		goto out_acct;
> >   	}
> > +
> > +	if (cmd->flags & IORING_URING_CMD_FIXED) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_acct;
> > +	}
> > +
> >   	file = cmd->file;
> >   	inode = BTRFS_I(file->f_inode);
> >   	fs_info = inode->root->fs_info;
> > @@ -4959,6 +4965,11 @@ static int btrfs_uring_encoded_write(struct io_uring_cmd *cmd, unsigned int issu
> >   		goto out_acct;
> >   	}
> > +	if (cmd->flags & IORING_URING_CMD_FIXED) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out_acct;
> > +	}
> > +
> >   	file = cmd->file;
> >   	sqe_addr = u64_to_user_ptr(READ_ONCE(cmd->sqe->addr));
> 
> -- 
> Pavel Begunkov
> 

