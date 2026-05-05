Return-Path: <stable+bounces-244199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICb0EIYM+mlsIgMAu9opvQ
	(envelope-from <stable+bounces-244199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:28:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 246434D032B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60E25300517B
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAE481FAA;
	Tue,  5 May 2026 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="G9Hr5XfO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071D4481ABA
	for <stable@vger.kernel.org>; Tue,  5 May 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994879; cv=none; b=a4TQNJFkxErEsrRL+gfwJ6N6ConCZwi/9uvRney1xeK4aW9xtHkdetF7TeI90Mf/IUcY6bTcS+rEfLg7eGjCpCo3oSMBqZQnQEjaYFjvyu+HHYyw2K40p1YL2o79sSAGfMBE7DO8bnScjDaycKc1sm8fCv/KORBpyM4XafGYytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994879; c=relaxed/simple;
	bh=wbp1p6GjLBI8BcMAYmvGQR7MHNMwkT/nZRaGpvcelPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajQO4bMPyJipWX0rL/jySWsKsvg9b9k0zlkdZto+P4XJliVNPCN3hQ8Xwn3ZLv0tF/Her6qW/QEvTHSqwsft4crGneJrHLGDGKMHXngrUPtIYEX3IUc+BTU2RnBjLydzqeOGBKI5B4jXCJ41p4NqNiNhHMpOtlVe8ZUaCCgERpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=G9Hr5XfO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8d7e7f48499so566101585a.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1777994877; x=1778599677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yub3mOGvWG3A9IM/tU0pZLVh4/23joC0/WvFOxpXwvg=;
        b=G9Hr5XfOAu/PBR/dELqBq5Qk63JbJkSIsvX398BS5dmiuRjJGKIla4Tcj4SycNuS0X
         h50ryGv2AdJ31SQN3eOcoBOA3kEA/JhJHR1BZFjUdoAN8F9Z4I745ywKM6jxNqU+wRJx
         frXK4KojvFO0nYq7XXJoTXyuvUugRGi8eaWv/YJrgigV+r86ktPkBuzdCG0F+2SoNxoW
         e5rj3RYD4zIM+2IqxZmHZLv6g5fQQd5hjmo/EvYotSU6PZYj4LwzzgQd/zKlMUPhjnnj
         RRepqByii5DXhRwUVfV6Z0wXOuovHjRouYbIfF1CIGYnDft3REGocG6PD+8WI8m9kEyd
         U5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777994877; x=1778599677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yub3mOGvWG3A9IM/tU0pZLVh4/23joC0/WvFOxpXwvg=;
        b=Ub0emuyms5l1CN7nCNVOqrlFXv/WRsEIBrlXjqUiy7WTiiwR6WFerlly+x0a1V9rux
         u075AkNIFVO8BpGE/AwFByczMmwVTf46YUuVMJJIqcW1HEmA2KPpmuy8RxZkxltMy6vT
         uz5/IZvZrh3yDTNSL/BGQj+bAr5e0+sKAshTzXc7ualw4NS1qR44dR+fp59zHKydYS0W
         fcwldiu54rwd0bISjkBTuLiKmSB7J/fway05nkPeEMXcuJx1F02EvIhR6wronKMSZLfm
         dYbeamz72DN4DctD12DaDa9IQDNoW313DUAncyM84OsWDTFDodbDB5Rht42shENB75RB
         odmA==
X-Forwarded-Encrypted: i=1; AFNElJ9X44IYKsOT69SJblbNL/7rsLL8al0HSdOQABaHYestUehYUHz4tRO1b7UlioePqhLkjsh2fPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlnil1kUdOOzIsWmeVzq9VmfEsr02hu0fhdkIWSEeCrB/IuMxv
	rz0CrYA0MxK7ExAWm9fZWHMD/4SZbZ7qBPTRzM67TNsIxFoCPSvczdQ/cMLH8ul/Tnw=
X-Gm-Gg: AeBDiesjpEXzlIEZfDfVIAp8YUZsTkUAB0mh3LyXo9DI8LgDmOqCjYnORF+KEzUlPay
	GulkHxTeyahmwVMkzMCaKlAnjNgpGhNSou9jo5N/9y9DO5zdrGRh2Sx+Nl8JUSgZ1BMaGQYTK1P
	M4D2NtNwpSwjAtCjxtJwh/b/VsKuZa4HWTwzN+9ijZ58XCHelv1WB3BqV6hLoNBU+00lEnr0hJ5
	OseLZJJnEhnm1+dYC0X3tWEtxwvc/98x5av0H+USzfNmP+R3Q4mhU18jjSe3gIR6dCwzRjGvzxy
	Um4YQSqYcu4pNb+2cEZuapVik2DZTcfMaZyxzdwS7GDXPlBD3ift2h7r58oEQM/QTkO1+DmUsQh
	Ut5udbVo+3FMBAdkmWNXnvTRtF5lP4AN2r7SV/RM8kMLJKCm3eXH319NMG/FfCa4HrD+I3YmPY4
	T0LfmdSwzIvb2+xNSNDDb3Tx7WorgGDr8FrsHu6sYmerTb6rp+XnQT36BbBN/Epg==
X-Received: by 2002:a05:620a:4488:b0:8eb:d38d:2013 with SMTP id af79cd13be357-8fd164be8a1mr2145708085a.17.1777994876982;
        Tue, 05 May 2026 08:27:56 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938e0b9sm1357740985a.9.2026.05.05.08.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:27:56 -0700 (PDT)
Date: Tue, 5 May 2026 15:27:55 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Brendan Jackman <jackmanb@google.com>, Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] memfd: deny writeable mappings when implying SEAL_WRITE
Message-ID: <afoMad-xL2bh0SZV@plex>
References: <20260505133922.797635-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505133922.797635-1-pratyush@kernel.org>
X-Rspamd-Queue-Id: 246434D032B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[soleen.com,reject];
	R_DKIM_ALLOW(-0.20)[soleen.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244199-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[soleen.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pasha.tatashin@soleen.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[soleen.com:dkim,soleen.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 05-05 15:39, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> When SEAL_EXEC is added, SEAL_WRITE is implied to make W^X. But the
> implied seal is set after the check that makes sure the memfd can not
> have any writable mappings. This means one can use SEAL_EXEC to apply
> SEAL_WRITE while having writeable mappings.
> 
> This breaks the contract that SEAL_WRITE provides and can be used by an
> attacker to pass a memfd that appears to be write sealed but can still
> be modified arbitrarily.
> 
> Fix this by adding the implied seals before the call for
> mapping_deny_writable() is done.
> 
> Fixes: c4f75bc8bd6b ("mm/memfd: add write seals when apply SEAL_EXEC to executable memfd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  mm/memfd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memfd.c b/mm/memfd.c
> index fb425f4e315f..abe13b291ddc 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -283,6 +283,12 @@ int memfd_add_seals(struct file *file, unsigned int seals)
>  		goto unlock;
>  	}
>  
> +	/*
> +	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
> +	 */
> +	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> +		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
> +
>  	if ((seals & F_SEAL_WRITE) && !(*file_seals & F_SEAL_WRITE)) {
>  		error = mapping_deny_writable(file->f_mapping);
>  		if (error)
> @@ -295,12 +301,6 @@ int memfd_add_seals(struct file *file, unsigned int seals)
>  		}
>  	}
>  
> -	/*
> -	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
> -	 */
> -	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
> -		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
> -
>  	*file_seals |= seals;
>  	error = 0;
>  
> -- 
> 2.54.0.545.g6539524ca2-goog
> 

