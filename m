Return-Path: <stable+bounces-124506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AB1A62DE2
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 15:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4221792E5
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 14:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4518E1FF1A0;
	Sat, 15 Mar 2025 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WanZX1kV"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527011F755E;
	Sat, 15 Mar 2025 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047622; cv=none; b=Ckw0eJynJFKEnNVqecgHD2IQnv1pk614A6u17583ycHWumwQXrp8zjJKj1gVvogXa7SJK6412b5iAzbOxTyA/nPk2o8dF1ly3GQnfTvMZWUk/3GifgxkaCzv3vfMrMJsVjXprSXo8m5VixB2pKQ8da4TGSgrz1FfhIiJDkQhSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047622; c=relaxed/simple;
	bh=JVDbtLCVlsfAE0DKLnc7htPf2h9AUEfuVUxHXsmEtW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMJqZEXi0za6OHWi+7CyfLJh/Eg9CgMAd+6ePMjloNE2lVntnwsTwlMSFDpeYtI2/NTsWxVQ8RHRuJf5R20XSxO0PucdmENCHS/ldC6pjsCknWucEVD33DhJ5PIbAhsTfMXN5h1CU3I77fyCfl+vCVsJRZAXkJdAjDXQ+7IY1lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WanZX1kV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac25313ea37so607902666b.1;
        Sat, 15 Mar 2025 07:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742047617; x=1742652417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fu6S1gMTWBKKSz25cBF2A3XN/mQqBpDLU5UkcNDyaKE=;
        b=WanZX1kV0ZeYSnYxLrHu33VEmoTSjyBlU8ue8fUA/MjOtSHKAuu3cJHjSvUXlwvOXm
         nZm+8gjG+e+6OBhawdkavUKwKLjebCZteG+CUdGYKU9vtce/4sMGNX384KwI1WOllQhO
         +gLoxrOacQ5LrVTmtP1FoU/NIw2kYYnFxg8GP/Fdh5vaJiUsSu7w3Txhv+vtsDDfOaVy
         Taew5UsjimSRKowjZJy2itRjd3cbi24DJsJs4lHf4z7NidnB90IGaEBaSG9ISJ01fbsW
         1QsUgjB1yu8ze+/y761w4OHX86ahkvHTCdfMoe08jFaWa9QoutQS3LS+pYWMIToFIRFu
         wzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742047617; x=1742652417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fu6S1gMTWBKKSz25cBF2A3XN/mQqBpDLU5UkcNDyaKE=;
        b=X/UvskhygFXbzCjMsS+c6ooevZnkk3P5c40OvQRXaak6WzF8TARnctvCW4KJspvnMR
         hZjQipdrad3jbJdZrgrbuGn4BqqJP4LAwaRPn6AsGDUCykGvFn3MkBhPCqXJd7KY1Z1f
         FKS1H4E8EWtM0iopAWWcTKNU4QvlIbrOauO/Swh0UKK8ZJo8AdYcVHDz6xr52aCDDNEd
         zlLpsjn8fhysAdIOEhEotzWUJoCIr60+7BYjmz/22l9SZ61rOOoBwax19EVtw5Pj3LqC
         SRVzgH0xS163zyURZjBAjUK6Vmp861nRnAtuaqqt5WA9rUsEFB7h99UrO6jT8/mlUm8c
         wRBA==
X-Forwarded-Encrypted: i=1; AJvYcCVRuGsGrA19+YbRPPEqC3ExpWP/huBUWSanRkr56tSB8oE0mSS8urLxNf3v6Bgwpa6IQbJ+LJ5eJNmbtJE=@vger.kernel.org, AJvYcCXtNfcBhVN731U5UIzeQckT6VSocAccYOnOPCkQT5HBW/thZFzMiVjK2V+iqG/JXc1XWgBxe6/O@vger.kernel.org
X-Gm-Message-State: AOJu0YzD61UAcw0e2n7kHxfiwivQV+7aK6qS4jveinSbcXnPh0ifoeE8
	439CTU8WkUdk46qIloFRuBimSDgl3YEKpWVL1hKS+HC7u6LO4ryp
X-Gm-Gg: ASbGncttWfnlkQ/3WSYoToL6DylaUeHBIYJ1sfltSZzRz1G60Wi1/7K4qrSrAbD3Lw6
	2GecrJBUAFEh/J31KaBmp4xprkWIYvk0w/x2ABCnd4KkDoCGNjv+vS0PHy356vL2/lezJ7t6yan
	mOiSKjIBnQdDQb1zfZPGCuHjAm5wsqYviF7PPP7KdrC4GQYYhfnCKYFdqLSZ6AcqTiA0oCGEKnD
	OzJaxG/7HoiWIe5QbMKSL5q9sXjcxf5Btk9Bl2TBvPXCDfDXF/oORPz6TebPtHyv8+AQ0juU2pK
	zCft2Uj0kAkeYJrePC0zgACM14IH7p6+TFX7JJZxFY36sMpa9t/0ySrPTsCK43bpqM68+jk2AYS
	pWA==
X-Google-Smtp-Source: AGHT+IFx4VLev9/ZgAGMtNB8wK/8e3AAjc3fTszFJmkBl77vfh+FSoCGptuIx+WDl8NiHsj9YK4mXg==
X-Received: by 2002:a17:907:3e06:b0:ac2:166f:42eb with SMTP id a640c23a62f3a-ac330110f59mr810161066b.2.1742047617447;
        Sat, 15 Mar 2025 07:06:57 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a9bce7sm372338766b.164.2025.03.15.07.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 07:06:56 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id CA3B5BE2DE0; Sat, 15 Mar 2025 15:06:55 +0100 (CET)
Date: Sat, 15 Mar 2025 15:06:55 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: dhowells@redhat.com, netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/netfs/read_collect: add to next->prev_donated
Message-ID: <Z9WJfyaaF1s_eJg_@eldamar.lan>
References: <20250220152450.1075727-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220152450.1075727-1-max.kellermann@ionos.com>

Hi,

On Thu, Feb 20, 2025 at 04:24:50PM +0100, Max Kellermann wrote:
> If multiple subrequests donate data to the same "next" request
> (depending on the subrequest completion order), each of them would
> overwrite the `prev_donated` field, causing data corruption and a
> BUG() crash ("Can't donate prior to front").
> 
> Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
> Closes: https://lore.kernel.org/netfs/CAKPOu+_4mUwYgQtRTbXCmi+-k3PGvLysnPadkmHOyB7Gz0iSMA@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>  fs/netfs/read_collect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
> index 8878b46589ff..cafadfe8e858 100644
> --- a/fs/netfs/read_collect.c
> +++ b/fs/netfs/read_collect.c
> @@ -284,7 +284,7 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
>  				   netfs_trace_donate_to_deferred_next);
>  	} else {
>  		next = list_next_entry(subreq, rreq_link);
> -		WRITE_ONCE(next->prev_donated, excess);
> +		WRITE_ONCE(next->prev_donated, next->prev_donated + excess);
>  		trace_netfs_donate(rreq, subreq, next, excess,
>  				   netfs_trace_donate_to_next);
>  	}
> -- 
> 2.47.2

Unless I did some mistakes researching both the stable, netfs lists,
did this felt through the cracks and is still missing for to be picked
for the 6.12.y and 6.13.y series?

Regards,
Salvatore

