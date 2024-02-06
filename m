Return-Path: <stable+bounces-19018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD684C03E
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 23:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CD8288BE1
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 22:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39761C2A3;
	Tue,  6 Feb 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="jS7Ta0yv"
X-Original-To: stable@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54461CD1B;
	Tue,  6 Feb 2024 22:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260023; cv=none; b=j/8hOYISDmy7Kw6ChhFvuJbd+DWu9jxKAdLvI6gXs1HRsQayPFA1daQspkbo/JNFq1LlIsCzvJQw3Z/XdJSfcJoajEZKMwygQtbrf6Zis7Il1Fexwjos2ix6PKyYSLwDRXjciBQ3L23PPWaZtCRNQldfkwA+eYxO0shOjc0jtZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260023; c=relaxed/simple;
	bh=gqWCgtIQNiWQRcOEYu4GbVL9AHer2eW2yhhV780RTVw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lc0hGXPMc+0P5PR+usBUrViznFtxduOkeXOuhAmy1gsj39RuidqbIDpA7Dsc1h5qmV+GJ6Lzok+E4ePFsWeZuc2o00arjnvNefPzJpLMpnOvrU4MXMYYZsn63XqjhVpYrJVxm53yY1FkRs534r6i6DZ+wcZ2doKpaTqUXCUA5c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=jS7Ta0yv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B6C2A47A96
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707260014; bh=ifUlThlZnaIn1NXIBn5DUg6p31lEGCwBlMhkGajBwcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=jS7Ta0yvSKNPFv/0ewBDQuZcbhdW54/WnRVt8pemsP1o5ty5UH9/IgKSVUJ5xFBvq
	 yphvGHiVrWIWJ2N5RXhDpGoyRLb+TbnYWUJUaHwdoGjISrH12fUSYzjByj9BumB81m
	 XLtg51DbQNhUpmqQ7FYUzH9b2M6Kbx2wXoqYuKrpDCNM8xWT62grcITX0OuUXBPEnt
	 rvCDVP+nFiGX6l0adZDBR/94KDHN1rqv+4PpGwbMnUnKaBvhi15SCmFDq9uMBjTVnp
	 MDGQILfYme2hLFAPPmyYrG002yowEdiUVXJaoq79GHQyQDyX948vOGwaq8gHRwSsNJ
	 b3Pq6HekRLyTg==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B6C2A47A96;
	Tue,  6 Feb 2024 22:53:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, linux-doc@vger.kernel.org, Vegard Nossum
 <vegard.nossum@oracle.com>, Justin Forbes <jforbes@fedoraproject.org>,
 Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
In-Reply-To: <20240205175133.774271-2-vegard.nossum@oracle.com>
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
 <20240205175133.774271-2-vegard.nossum@oracle.com>
Date: Tue, 06 Feb 2024 15:53:33 -0700
Message-ID: <8734u5p5le.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vegard Nossum <vegard.nossum@oracle.com> writes:

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

So I can certainly track this through to 6.8, but I feel like I'm
missing something:

 - If we have never seen a ".. FILE" line, then (as the changelog notes)
   no files were found to extract feature information from.  In that
   case, why make the self.nestedParse() call at all?  Why not just
   return rather than making a useless call with a random name?

What am I overlooking?

Thanks,

jon

