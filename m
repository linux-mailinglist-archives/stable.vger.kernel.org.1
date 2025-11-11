Return-Path: <stable+bounces-194486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 938ADC4E38E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 14:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E5C3A5A43
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C3331201;
	Tue, 11 Nov 2025 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iVR2yBi+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED2C342506
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868695; cv=none; b=njDPePGRBrqrxpdCybdmdeqNsDFFRk2Nk2aZAKSUH//8rx3y4fER7B9cADiw7HyPzHQ/GkEIAVXGOpS42OoIyVh6Tzdf/8kcWLLHIwUeIsoSSdIFodHubs1FmMTXSs9nJUqyybHHD33LCW3hTQNMgBd0aPyV8jI4HgmkLutpdt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868695; c=relaxed/simple;
	bh=BNOzgUYOcnJc6jUkH0FdQt5N0+21shSFRmdxMj09ooM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GI/0PW16hlSH6syysOb3E1qExyI+eza1QL5W801xYOqFnV4vZWtVPVhGPthWAv/CRE43SPuIU+5x2hX+lA/b55qTl8PxvlF+jcvIB4WuEaihsIcdwdlENR3Hvr7ggVbvcQLNrRT1BAzYSirVEbzv2Uxx3JN5x34rlSVFgtExWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iVR2yBi+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ed59386345so20251501cf.3
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 05:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762868692; x=1763473492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5k10nsHfVcysSEr6r8VgK9nyddtwoeg+8UBvBlu+UM=;
        b=iVR2yBi+p0/CxxmjW8z/R7YLCC3cfo1vUTqFNr5IWDLXMh68VqfXsbfsOh6uHElp79
         6ZsoU5Pov9DYmffEf5+OcnabUCqsGuAZhMuJlQZyI+DVVcnbhxMS8r+ci2F1pbPXPLsV
         kYSM8PgPR0IjhZ6g7Dhi3C4MvWIbD77nyA3yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868692; x=1763473492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5k10nsHfVcysSEr6r8VgK9nyddtwoeg+8UBvBlu+UM=;
        b=mMjGnp6TJnyXmgBRW6aJFW31EmXKHo5GtJm5vytiBq4PFsAW4KEKPrO+bHE9AXb8D4
         tLZXBgRj7ESH0HKPt3GSNUnLgTjiXEzzKGzpJ3jXuGuVuWS2r+WLs59iXyAFRa6b9J5Y
         wI8MFgRkQSkjUQPVlkfG4erOoInMIgYIFSVex+acC920K+01YwcvnY9W9zNOB1D3Msyw
         n3LjvPYPGufXhJr8xp6rF2fmRAZEV/PviQlT5chdece/B+057TAmx8gYlIQ/siiHk0rI
         IP/FCGxj5LY5Ph16QqsSTXWyDKTiK7x3xZ5JhSQG/rsD4XPrcACzMv0vpV6UYsZkcuwr
         CfYg==
X-Forwarded-Encrypted: i=1; AJvYcCV1u8Uzft1VJIxbgAsBTw85t4QDHbm3evBk5/mt3Ejip6EVZ97ppuuLGy/pQXZSvmE7OvWuBzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqB8TOTf+7w0JfKqW3dY80LNBZHo2u6+Os04M5irhDeSqTO8b/
	pyY8vViN8vg61FVsUQJ5hQDcazXYmbn5DUWdXUnTvtiN1PjC9LuTGCKS7CSkN1jU/aaHWCX80Bk
	xCa59S0WPobY6VlH4U5jwj9ZHrvFzrDNFluU0Bh1RgA==
X-Gm-Gg: ASbGncuHw4jlBQrDXWdZE8p0GmdHW+N8lcBCmeR0M4eX1khXf/VNURfFzDZnAqZ9swX
	KkogGYXp+bLbYQ1neUX5s/4MQldBYB3kSsY58Vunm7N8AVlLlatlIo2HjmEQk0a82WxUwcMUkAH
	gCOAX8/Yj8i/WLn5Iu6SiLLrDQsmnsxiDgLsQkEHNS3xp9cP40Wfmm8OVt7MgeCvYFvTCja6/1H
	ClCvPMwUjxAqzJMBSbGWjJTJaNtOcgCeR0R7Oq/DTjrTtxzTveIJt5QkM4=
X-Google-Smtp-Source: AGHT+IGU1JVoYyv7CzlTWKa1ok4sgDwrvXsmRYqaQymnTJaYvBz9aHj6lCwmrP45DypLkDeS6k2ETKDOOEEc/ip0FCM=
X-Received: by 2002:ac8:59ca:0:b0:4e7:2d8b:ce5f with SMTP id
 d75a77b69052e-4eda4ec5ea1mr146269961cf.36.1762868691867; Tue, 11 Nov 2025
 05:44:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-copy-finish-v1-0-913ecf8aa945@ddn.com>
 <20251021-io-uring-fixes-copy-finish-v1-1-913ecf8aa945@ddn.com> <CAJnrk1aOsh-mFuueX0y=wvzvzF=MghNaLr85y+odToPB2pustg@mail.gmail.com>
In-Reply-To: <CAJnrk1aOsh-mFuueX0y=wvzvzF=MghNaLr85y+odToPB2pustg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 14:44:40 +0100
X-Gm-Features: AWmQ_bnJaLVOFkPGKtY0u21R6DEAFTB_g34UsCx6_brZ8Fndr61_N1ZAbAs77Es
Message-ID: <CAJfpegsXbmzPkVzg4HabnCeTmRFzsTjD_ESeR-JRhV7MPeO4NA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: missing copy_finish in fuse-over-io-uring
 argument copies
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bschubert@ddn.com>, Luis Henriques <luis@igalia.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Cheng Ding <cding@ddn.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 22:30, Joanne Koong <joannelkoong@gmail.com> wrote:

> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -649,6 +649,7 @@ static int fuse_uring_args_to_ring(struct
> fuse_ring *ring, struct fuse_req *req,
>         /* copy the payload */
>         err = fuse_copy_args(&cs, num_args, args->in_pages,
>                              (struct fuse_arg *)in_args, 0);
> +       fuse_copy_finish(&cs);
>         if (err) {
>                 pr_info_ratelimited("%s fuse_copy_args failed\n", __func__);
>                 return err;
>

Applied this variant.

Thanks,
Miklos

