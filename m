Return-Path: <stable+bounces-141750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E344AAB927
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF451C26F32
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DD728643A;
	Tue,  6 May 2025 04:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbWo8vOG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F25302039
	for <stable@vger.kernel.org>; Tue,  6 May 2025 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746496676; cv=none; b=TZERUg3LgUqcG2LckD8E1Z5ZNF35OOeXWFUkkSxWD0f2AzAAH8R1PztHHpkI3q98ck9uJ0MU3IBu6dPqeNnbz6C0xVgnvQEn+1SM2UEhnSEdwdcm/1alRqjxPxtJ8h4+pqnXjgOzf2KguBBWuI/IhEruoJ+0pxBxgKA8zjYjQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746496676; c=relaxed/simple;
	bh=3s7Hp5cIAh2gzAdflFBnqXwP/wo95uEvSqq+OEM9wOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqhW/RNRIi/ai8Qk26eP2E0O75fi5GHpzs3zxYEO50gf4q/rhy9Bl7Ly1hVx82ZKpAr2/QnOZ6KCnoNRznvqNLdy4M+tWBwOILNgnlzBhKwy0TChd8XaxTW9ppsJWKH0uFSnGq1AFqz3lGWiUjJCoKRwqpKNpvQsPKgW1yFA7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbWo8vOG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746496672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xMLcPl3iKBUpkeNrh92Lo4eyOS4pTDnll1BJ+NR3yFc=;
	b=GbWo8vOGws3vDcPygZZdQsJoGW9U96Mt1DGPsmzT2zcvSvOnDA/wrgv1tNe84Gc+3BqGPH
	WB3ZEhi8bi/r8kxJOO2vseblEVJwENhDybzRa7WyY3M1r08gIUJCw1RSPMlhWd1OGDUoAS
	avvVew9ls2ZNNZVbvK0acxmwYie46Xg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-hgTSLUC-Pl29w3CT06OXdg-1; Mon, 05 May 2025 21:57:51 -0400
X-MC-Unique: hgTSLUC-Pl29w3CT06OXdg-1
X-Mimecast-MFC-AGG-ID: hgTSLUC-Pl29w3CT06OXdg_1746496670
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d586b968cfso102078595ab.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 18:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746496670; x=1747101470;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMLcPl3iKBUpkeNrh92Lo4eyOS4pTDnll1BJ+NR3yFc=;
        b=qH+j/OZ+LmANiDWvXchuPhCCZmmBUshufjaOSXmKV3j1rSWoha9o65nUV9/sTfP003
         gUonO40BPkfX3gaghShY4vZgpMZ0jGCYi0xOwG5wb6BuQPXNuguq4ikdsAGsrEyE0ayD
         wxNQbfwX5VWMcl8IPjSHpF4y84vTdgtrebtVyCIiAA5iFFTAA6RRA0PnhktGjmySRx3c
         vqc28l6Wbt88FxEIgrpScLbhTGn6diVViJ+DeTTOb88VhUjWfOf8m45c8qUWsOSOh6vy
         4cgfRsmS+zSYkel1dzBPexfa7s85M+BkdnJcKxEn6Yk5R3ZkdtqB3BMvcQComRjgOtpX
         dsJA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Cu5RrZdTPib36js2YS6lQqRcXhsuICgGTBcjEGwh4+pG1sWdnFP9SlFGrp+cfBrdNuqUGxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzoZDTp/CfAZSHpZSm4JLeqRpd/MA4PzZ+gY+pn93y24QC2LTF
	8BgDFgJQYNF4pCpkrCyCq7NSs47n9YClGB2Y24053d3Y2VOuPhay4ZfK82QJCaEKMipyT58exwe
	VZN4sXl5HHGLFP2SVYt/5IQhl1rra14i6CYwkZAYHpLamrz1G6EozsZeNBMAr1GUP
X-Gm-Gg: ASbGncvuo4kS0+4sLTxCa/dLTUeYBpkZJXCBoCDdgxrJ32C3Av/4uDAVIoCJaE4M5Uq
	WfiNPaI/HJGSvdyFaAsNYbNPHIE1ygGxRr2tawrnvRzGE7QOU9zm8U30894M3bQ69oE7GFnLC1y
	K52LZ+fC7KFHxRAZGS3q5lKbqisTdz+kicZSbKPjqbT6y00ZrycgSoQLV7c5nYKpNIkjYeZ9Bwg
	bVr5fWPplxT86UHkxggCtIH3OT9EmOFk9YEavzC593agNUrOD6FkX+Ml3NFAb99+yPNSYTBstCi
	YFYiogF1Boz3XL1VTqiKYaAxwT9POoWlRRjuef/yI46E9P1kWQ==
X-Received: by 2002:a05:6e02:3486:b0:3d8:2023:d057 with SMTP id e9e14a558f8ab-3da6cde18c2mr16092345ab.11.1746496670318;
        Mon, 05 May 2025 18:57:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0rAJvKFUUhFhbgbTRiDocZ8gkc3d2s5yO8VLR73Cn1xBSmtzwyXjRkJ3Ch72ghFkrMJrr6Q==
X-Received: by 2002:a05:6e02:3486:b0:3d8:2023:d057 with SMTP id e9e14a558f8ab-3da6cde18c2mr16092185ab.11.1746496670048;
        Mon, 05 May 2025 18:57:50 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88aa93f35sm2003005173.126.2025.05.05.18.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 18:57:49 -0700 (PDT)
Message-ID: <2102fabb-bde3-4eaa-ad38-18eb79281e0b@redhat.com>
Date: Mon, 5 May 2025 20:57:48 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 6.14 156/642] f2fs: defer readonly check vs
 norecovery
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-156-sashal@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250505221419.2672473-156-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This commit is in no way a bugfix and I don't see any reason to
backport it to stable kernels.

Thanks,
-Eric

On 5/5/25 5:06 PM, Sasha Levin wrote:
> From: Eric Sandeen <sandeen@redhat.com>
> 
> [ Upstream commit 9cca49875997a1a7e92800a828a62bacb0f577b9 ]
> 
> Defer the readonly-vs-norecovery check until after option parsing is done
> so that option parsing does not require an active superblock for the test.
> Add a helpful message, while we're at it.
> 
> (I think could be moved back into parsing after we switch to the new mount
> API if desired, as the fs context will have RO state available.)
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/f2fs/super.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
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


