Return-Path: <stable+bounces-104448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D79F9F4593
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 08:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE36188D60C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B81818A6AE;
	Tue, 17 Dec 2024 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eQLsPrGs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F1DA29
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422275; cv=none; b=qWpBlJwH9GGmT5YDddEeBHKcNOQ8xqQXY8xW8GCqBEMIIc1yzsox/6v7EsGcXhi12kemftZnU9O71GyFCe9XmS0FgGVdMSf854vPjsHxaa9ipqdcHWbiflMCqrN4s/qG7U/KLzvWq3EuGU7WIMvGRVFqySI+WJ1SqiY243n+zqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422275; c=relaxed/simple;
	bh=CZ83kjIEEtR1Mz2hEz2qgiBm4NyV4NnWYt7mVajPp+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeDm/Jlxft4HB/QhzoPwGaMAZvDMQyXE0tcHPF5+K0YNF3Cfm7J0ohRPuMMm94nZYmKbvVCs2JtYEWzIQrXUi8PXFo6sHFVdFwR5boZNWN8iHsMJhKpeK1ZNtMRvgSqZtfiW1Q3+fLzC+VitAZu4Tndnx8Co8/owhAdnO58qspQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eQLsPrGs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382610c7116so2481288f8f.0
        for <stable@vger.kernel.org>; Mon, 16 Dec 2024 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422271; x=1735027071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AJiojS7FHbvuQIVPd4Apv6tEaVVGpEOgN03/VsXjZt0=;
        b=eQLsPrGs4mGS7zzWodRuDcQQQ92sKFfQOyOOm9sWytKeolDEwBB/0V6H84Fd1Mn6uY
         MxGoW65xFRB3uJGJOKClfXHj46zbpRpyrjuRnsSqtxgcZeG9QaBMZfXgh6ZL2A4Xeaz0
         4doaB0QtwzBuUJciRb/k8np6Qlu5STFesRvBIc8Z0DIgY3GUzTN9irMHT0pqhQU/ou9p
         mfvHDd664VUNvThoJ83tiHg463hAwKoLuAY2aMsMspP1yfi3ndzaUBtXhWnfT1kJrk4h
         PO50n+jGcB81maeDeaygipVkm5gzXJH/h4Uw+b+QHT8I/Uf8pGjYiNs3NBJnjiOb0Xjl
         wiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422271; x=1735027071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJiojS7FHbvuQIVPd4Apv6tEaVVGpEOgN03/VsXjZt0=;
        b=nEOMDHtthkV1+pGuFqVtroSSmyRmjSHkoYjKwatVoVpnEqc7286pQIyPj8po5S0gUm
         JuXZnvwMWRKNdAmAkL07Ela7lxFWlawbLqu5HSh1adMi5/Tsovl2xUu07rZPR+nqudAz
         8uq1Mvu55jANg4zPRpepFvDdoZodDUKxkAk+vm+KschublsQW7fxo07caqpP2GBZ7dE+
         K0JnVdNuYmljdWtfmWJ3Bn3fBHjv+agboagqWawr8TDJ1sGoNEqGkjkbOJwc8FxpizNM
         JPidUNXHvV+7NeqzhkKnN6YGyiu25vM6y+93ThNXONMMjvFJbIl1UkrLMs7dqMMV2MYl
         BOAw==
X-Gm-Message-State: AOJu0Yzi2UcPvn5sSsKb4hDMgYFJ31hwEt+sFL3XvyqeAUtm3EHrqEji
	bk3cKrvj9jUK4CaB02/5tvGJ56iFgPI35rzvRYatEVPt6nwSwWq6PEujHKz1uIY=
X-Gm-Gg: ASbGncsT2o5d9/fOTnFe4U8RdqhWI1Bgbhr2qGf6DpOimJjYPSoscO4kEXoewcskwL8
	I3aHp/Nx858IXSWPFx/O+IR2bfef/+pGXTx+cARlRQwwYvjqoXKCePvdVEb/gNSTfi5FN5iLpdR
	ogZe50AwFZVXpqs2n3wCqkiDYpvrJHdEiHFye2udXAh+fRtIWQmSYdp9xVCTajcYUtqcOObI9KD
	YAw4w8yKMd3vdVJV0mP6gAtQlFLcv5Vkfhjik1PABrjpcOXz+76
X-Google-Smtp-Source: AGHT+IFrs1ALETn1ASdv/KVKauug6ccS4pr+rJLBDrwVAY5wkpqumgRdmu2XrBvmUj7SduqVU9F8Ug==
X-Received: by 2002:a5d:5849:0:b0:385:f69a:7e5f with SMTP id ffacd0b85a97d-3888e0b8e63mr13594510f8f.38.1734422271629;
        Mon, 16 Dec 2024 23:57:51 -0800 (PST)
Received: from u94a ([2401:e180:8862:6db6:63ae:a60b:ac30:803a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5d7c5sm53724445ad.199.2024.12.16.23.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 23:57:51 -0800 (PST)
Date: Tue, 17 Dec 2024 15:57:45 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH stable 6.6 v2 2/2] selftests/bpf: remove use of __xlated()
Message-ID: <zl3u573akymhd3onhqqypufbp6lijj744q5az36gzovpxufolm@wp6jbzggbx5i>
References: <20241217072821.43545-1-shung-hsi.yu@suse.com>
 <20241217072821.43545-3-shung-hsi.yu@suse.com>
 <2024121700-mystified-hush-72d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121700-mystified-hush-72d8@gregkh>

On Tue, Dec 17, 2024 at 08:41:40AM +0100, Greg KH wrote:
> On Tue, Dec 17, 2024 at 03:28:19PM +0800, Shung-Hsi Yu wrote:
> > [ Downstream commit for stable/linux-6.6.y ]
> 
> What does this mean?

Trying to make stable-only patch more obvious, at least I thought it was
the preferred thing to do. But judging from your reply that it isn't, so
scratching that.

[...]

> So this is just a fixup of a commit in a stable tree?  Can you properly
> set the Fixes: tag then?

Yes. Will do.

Sending v3 soon.

Shung-Hsi

> greg k-h

