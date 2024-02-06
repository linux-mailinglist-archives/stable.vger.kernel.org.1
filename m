Return-Path: <stable+bounces-18879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7284AE4E
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 07:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3B9B2483F
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462B182C8E;
	Tue,  6 Feb 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1H2yIKh"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBF8004A;
	Tue,  6 Feb 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199433; cv=none; b=a359QN9y/LWa1rTu0bwXwB9oFJ2yjxUNBB4CGnKsHLhOhdiATexIIivQgopyQoLRJz0mttEvopYrrdq1vJmNhAUarifXEl8eOHGt7k7IUVh5GJXS2nK4nuN/Fa3heqLQmZASpHk5ywxkTtLqcwvqmJLdNqSNxyNKKGlkhVn2dHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199433; c=relaxed/simple;
	bh=49+VR82bl0ZleNstFJHox4KSX3k01vOhnhTBd3oGKOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNfpOTdfZSPvph821EeoFfU2PFXOELdS/6ImYhRKPWERhFXkfenrympmnnS8nQJALQui5T7V0aYIlkGnyKqsZTvTtRn/Dye5hjY28Hhr2OhfVND+viR2/RH0ikMKsdjm5+RbRZ/ivEMny0luPmYq03Xn5hMT73TSkL9NB3et+vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1H2yIKh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a271a28aeb4so733210166b.2;
        Mon, 05 Feb 2024 22:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707199429; x=1707804229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hiAgHh+Gg4JAfLChPswcQYzPhkOPvxPL2BqsCIhKs0=;
        b=b1H2yIKh45zA8+8IubZ6wOD1Fp345KilZD7HVe9ztmjTSqV306NssuKSg2Jyj+opXn
         AeqoUs9bd7n1fA/yI66GTk9vdSTBZbYawpEmXTjGWvGaeHQcJ6Rd0p2T9WmSOXq3x6DA
         Z6lTmeKL80mh0ODvOYgWc7DqAITLQCgGt+8Z5oNB/YlB43RsquAq+CKzchAhwZMuz3Ah
         l0dDzxEFkjdwGifptNapn5woPA5BAasFMhyZwCz9aqO6JOBeLjUmzGPsw0f1bZiVjxuM
         QpmaPKpm25leAFQMw34BdiNkZqgKkmfUad0OGNd49pVhp1NUHM4eCUG2aMyeq6HzRkDr
         jA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707199429; x=1707804229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hiAgHh+Gg4JAfLChPswcQYzPhkOPvxPL2BqsCIhKs0=;
        b=QNkL2OpqtH0lgNK/yOpKqDVJzMD/GHKzedKcoaVFQ1VISflWSIF+1yTYUnmxwa85or
         QxEwQIRDfeOSCeUUJZAMfsdfb2XA5PZCt1fIbSgEeLmdiitWJUCs2dDKVnqafT8k0Lrr
         aYBocZRIy9iq033tGoHwRW6ANeh+EaJlvyiY7mZ7cgfpr81LXy1rjOGW2ddWlBaeW4UD
         CwQbKktQnR6SdXeTkW2OI/UJIhiwFzGHX7TSp8uQXb+WiXE90lAJNJcs0mYH++R7nwLf
         Vmj24qbX/n5sdhluFrHt+adoT9VPPg93aPNx+yKlZOkA5zeePjBHk6KrvVCxuS8CC+Wo
         8Obg==
X-Gm-Message-State: AOJu0YwKNixolEgtiHqZus+p8/XKN1O6sTSr+8HD9tHiYsekW4RprDeZ
	+l1GC6/GpUBflfKaFRs/ckfxcym6WOJuS1EimBJg5Xs39akt+vPV
X-Google-Smtp-Source: AGHT+IG/enrf3VM0r811NcE7hmAPj8XpxOJMeAamKMECLGCrshnSjWfi0+RbKqxcfdqszQvlgFy5pw==
X-Received: by 2002:a17:907:910d:b0:a35:b2b1:5372 with SMTP id p13-20020a170907910d00b00a35b2b15372mr812250ejq.68.1707199429121;
        Mon, 05 Feb 2024 22:03:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW8Bi7JjmWB3qtuj9KkUykIV/zUDOr9QT1tKft6rDYsrpO5G9tK5yW0ig8cJm/y+eHYvNKI6yA3LNUg2v5hDFvkCCr8tGEuWp2Q3OhKxtFRAC54v4aQ80bZqtVSN5WF47Z+TZMYYHOnh5IOElhPnrOzlaAfVwsO34gGqTRACnDVhKZmPD7UH0HDzKNWHo5h+Pzfjwwar2iwoJIHtHqQ/fdHHupZq7Ud9w==
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id tk12-20020a170907c28c00b00a377a476692sm704161ejc.213.2024.02.05.22.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:03:48 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 89F19BE2DE0; Tue,  6 Feb 2024 07:03:47 +0100 (CET)
Date: Tue, 6 Feb 2024 07:03:47 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, linux-doc@vger.kernel.org,
	Justin Forbes <jforbes@fedoraproject.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
Message-ID: <ZcHLw1wtypMD5497@eldamar.lan>
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
 <20240205175133.774271-2-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205175133.774271-2-vegard.nossum@oracle.com>

Hi Vegard,

On Mon, Feb 05, 2024 at 06:51:26PM +0100, Vegard Nossum wrote:
> If the directory passed to the '.. kernel-feat::' directive does not
> exist or the get_feat.pl script does not find any files to extract
> features from, Sphinx will report the following error:
> 
>     Sphinx parallel build error:
>     UnboundLocalError: local variable 'fname' referenced before assignment
>     make[2]: *** [Documentation/Makefile:102: htmldocs] Error 2
> 
> This is due to how I changed the script in c48a7c44a1d0 ("docs:
> kernel_feat.py: fix potential command injection"). Before that, the
> filename passed along to self.nestedParse() in this case was weirdly
> just the whole get_feat.pl invocation.
> 
> We can fix it by doing what kernel_abi.py does -- just pass
> self.arguments[0] as 'fname'.
> 
> Fixes: c48a7c44a1d0 ("docs: kernel_feat.py: fix potential command injection")
> Cc: Justin Forbes <jforbes@fedoraproject.org>
> Cc: Salvatore Bonaccorso <carnil@debian.org>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> ---
>  Documentation/sphinx/kernel_feat.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
> index b9df61eb4501..03ace5f01b5c 100644
> --- a/Documentation/sphinx/kernel_feat.py
> +++ b/Documentation/sphinx/kernel_feat.py
> @@ -109,7 +109,7 @@ class KernelFeat(Directive):
>              else:
>                  out_lines += line + "\n"
>  
> -        nodeList = self.nestedParse(out_lines, fname)
> +        nodeList = self.nestedParse(out_lines, self.arguments[0])
>          return nodeList
>  
>      def nestedParse(self, lines, fname):
> -- 
> 2.34.1

Thanks for the fix. Tested doc build on top of v6.6.16 and addresses
the issue.

Tested-by: Salvatore Bonaccorso <carnil@debian.org>

Regards,
Salvatore

