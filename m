Return-Path: <stable+bounces-146148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A76AC1A3D
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 04:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDA59E70DE
	for <lists+stable@lfdr.de>; Fri, 23 May 2025 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C827466;
	Fri, 23 May 2025 02:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZESbHTc1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A6849C
	for <stable@vger.kernel.org>; Fri, 23 May 2025 02:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747968599; cv=none; b=YsJyiGucpOQvHEg2Yf2bX0O1RCj5b6OLOb3+YgX/uuzv7qu7XzthUMmsl/G/kKVmj2svLDxuu9nQ3h9yCcoHefK55FVMrzz+O6sIVNYj2yXLzljN1ayq65jzEuAklLTZEqljWUiOZ/UCv4NLZEmU16bc85Il0qA5PhIW4OMbQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747968599; c=relaxed/simple;
	bh=bZ5R3v0C8CfHKu3lNyIlmFevZreTxW1jU++fS9TFOmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alZ3L14rEhEprTF17uoDMzBQmcpG9N9MD4rznvHkTodZey84w58Ap3gKRGsnO05b12TpREogTg9JVPt/Bpx6yU8hE6HkklG/0Sqxl87Ul8giDk7NxaCtRVrdDI+9vgjDvLixbvOYP3hzrCiyRPHJjX/C8Qhaj74/fjh3hGnzlEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZESbHTc1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747968595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVJt3GxZTr1s6ikChhifsKKUmqvEv8JzIKd18UCny6k=;
	b=ZESbHTc1PPrkDuD2+1J1VUQjClW+x1KV5fKPK82KOehSc8UzFNt6KNe9ayF6i1MeU4yZPC
	RSVUwD6CKoQ/WSZd2vs5bkUhojF8TnNNAsm5NathHATrSutd1wIfc6dWG4ZMGH1agxw9zh
	/nyn1+NUpsncubA3jEd13jQopOHbaR4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-HzsVyALyOPOIqJXLM_G9RQ-1; Thu, 22 May 2025 22:49:54 -0400
X-MC-Unique: HzsVyALyOPOIqJXLM_G9RQ-1
X-Mimecast-MFC-AGG-ID: HzsVyALyOPOIqJXLM_G9RQ_1747968593
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b41b906b3so789302539f.0
        for <stable@vger.kernel.org>; Thu, 22 May 2025 19:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747968593; x=1748573393;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GVJt3GxZTr1s6ikChhifsKKUmqvEv8JzIKd18UCny6k=;
        b=kSyvacmpqZFf2H1KFOJD9XrPvuPkjsRmuwhvUIKV4QpUm2ZZWIPAlLE0d+UOS6YtzR
         sWX6LXpII+VCpM2c1jPhQXMkbxhO+lYil1/b2FlW40PuLr277Qkcp1NCMuSCk1gQZMya
         PEP5sAd7HHkSL03fA9N5tjEynGaCJ+IYvQZht7q5rJMBirclgaU71U4Z4xA9XZH+5wKt
         UPh1qaYzjMTnk1iTGRw8DE/fNdgfey9tPUPnvskYU3BHdSq4PAmUFw8P3r9ob5schcVL
         7FF3T9R5CyBIFOESVSd2u03+z5O4nQ1jYq5kWazKhF8f2juWOlppkH54wMyBL60Y4gdM
         oOEw==
X-Gm-Message-State: AOJu0Yxpuvv2pK/fjv66EmPLMnKomk7fXvPLcju+42wRk502rdFeAVgA
	aF+bt8rXFt+WGJ742oA4TYWeNpnAn9A04jej0/LcGDswKCyVybZZrJZ6mdo8oCJDvulPaYsT4HD
	Gyu4ExpOzmGKf2aWRVbcstBhgqnGK5/eIiPPn30qOeyUaOY0ke832ktc9dKPk/rGlweAEun21zy
	un5m6VDK5t+ScrC+wwBeMxheZZw8zuPIZ8WZ7yH2fi5ds=
X-Gm-Gg: ASbGncvz+FFero8wIbwOGZEB+GFjb58+ugnMjSmHwzgYCCde3vQMOmG3fgF6rCyVvZH
	aqDujLOMuBPQMtjpC47JlnmyugCM+YlOAJsvrKKl2/9iTaq68jLI4BVbDD6FVYUe1kAOCukqKif
	1EY96QF2MuNcjc1HJvS1qIwiaSvFaOFwd+cq31dYx1mEucYxQRP1aalgSw+nxHSXQJNxRTmvU6Q
	NUkYRiCHG57RcK+pOsClUDRz9rB/7ApN8OppPOce2XJMJ62RAIz06Kx1tMF10XgkVkkrCWSJxNo
	9TH8dm5tDusPkJ5ytaMX
X-Received: by 2002:a05:6602:358b:b0:864:740a:e81f with SMTP id ca18e2360f4ac-86a24c8b69dmr3263910039f.11.1747968593205;
        Thu, 22 May 2025 19:49:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjWdFvg21P1dyea/2nFIAq9FJ8/GVtSadHOK2AcDIK8RspOj6lvn3nmZ2gks5OHMVVebyqzA==
X-Received: by 2002:a05:6602:358b:b0:864:740a:e81f with SMTP id ca18e2360f4ac-86a24c8b69dmr3263907639f.11.1747968592792;
        Thu, 22 May 2025 19:49:52 -0700 (PDT)
Received: from [10.0.0.82] ([75.168.230.114])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1b08sm3472118173.58.2025.05.22.19.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 19:49:52 -0700 (PDT)
Message-ID: <e28f2bbd-bd2a-432a-9e9b-7dcd369cc66b@redhat.com>
Date: Thu, 22 May 2025 21:49:51 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "f2fs: defer readonly check vs norecovery" has been added
 to the 6.14-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
References: <20250522211033.3121147-1-sashal@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250522211033.3121147-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 4:10 PM, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     f2fs: defer readonly check vs norecovery
> 
> to the 6.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      f2fs-defer-readonly-check-vs-norecovery.patch
> and it can be found in the queue-6.14 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

I already replied to the AUTOSEL email on 5/5 saying that this
is not a bug fix and should not be in the stable tree, but here we are.

> commit 442e4090bb78d5dce4506a591214ce2447d6ea50
> Author: Eric Sandeen <sandeen@redhat.com>
> Date:   Mon Mar 3 11:12:17 2025 -0600
> 
>     f2fs: defer readonly check vs norecovery
>     
>     [ Upstream commit 9cca49875997a1a7e92800a828a62bacb0f577b9 ]
>     
>     Defer the readonly-vs-norecovery check until after option parsing is done
>     so that option parsing does not require an active superblock for the test.
>     Add a helpful message, while we're at it.
>     
>     (I think could be moved back into parsing after we switch to the new mount
>     API if desired, as the fs context will have RO state available.)
>     
>     Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>     Reviewed-by: Chao Yu <chao@kernel.org>
>     Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b8a0e925a4011..d3b04a589b525 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -728,10 +728,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			set_opt(sbi, DISABLE_ROLL_FORWARD);
>  			break;
>  		case Opt_norecovery:
> -			/* this option mounts f2fs with ro */
> +			/* requires ro mount, checked in f2fs_default_check */
>  			set_opt(sbi, NORECOVERY);
> -			if (!f2fs_readonly(sb))
> -				return -EINVAL;
>  			break;
>  		case Opt_discard:
>  			if (!f2fs_hw_support_discard(sbi)) {
> @@ -1418,6 +1416,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  		f2fs_err(sbi, "Allow to mount readonly mode only");
>  		return -EROFS;
>  	}
> +
> +	if (test_opt(sbi, NORECOVERY) && !f2fs_readonly(sbi->sb)) {
> +		f2fs_err(sbi, "norecovery requires readonly mount");
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
>  
> 


