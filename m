Return-Path: <stable+bounces-18877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2884AD75
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 05:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8161F24B57
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 04:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6C38DD4;
	Tue,  6 Feb 2024 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHGPVUH2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605F24A1A;
	Tue,  6 Feb 2024 04:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193815; cv=none; b=IDE/p5OuJ1MMSULODNzhVP0jV61oUoEdlqAXUQOXrgr/pgiSbDk2ekmiRV52nHN6mCxP+GgHJlRKZsUGze4RQ4sVaFK/OSC09K1kkMyrf/zRk+tYfekc9EYY/9vkapthvWXSHYL9y3pgWrYr3cUDuxyqlK3ndj6SdaIwAw3MsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193815; c=relaxed/simple;
	bh=AmnWmDdim7gYChLNqqyW6hIpuiK3qYdWtDhIEifJhiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cR7q/9kREeuYGko7vV8MpC1AcRdrxfPq3L1jYYsGPz8DQ9a6Vn62uld+op9yKgQza5elQZiT8QnB6UVxpG1yBVbm4+kHmMRyFhySlqtPGe4IV+9nqE0q7jdoBv/PFXnB0Vfgx40V63HRXU7yNHyEdvbE3PIvAM23Vx3k/VOhbGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHGPVUH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCADC433F1;
	Tue,  6 Feb 2024 04:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707193814;
	bh=AmnWmDdim7gYChLNqqyW6hIpuiK3qYdWtDhIEifJhiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHGPVUH2u0rX2x8ta4bqIJo0mSOq/JwlQSKgJgKgrpXIjNE+GMIEjkxwKr8KAut+g
	 GicwzFXYrhz8X2NCpLsNxhTv5tsE+4DxFkTq5XeHBo84SI/gzAPVhYJNFeaSSXwkqR
	 qEPS4lfWGAuVxz3p9Gj4JrtbQdpMvDilNUzzYMe/UMAa/6U/LAqdESeSYtKeDBUdGF
	 Y3Uv4stT3IeDmbec1d3HxfDyBb84s0dYO52oZ2kEap1jJzLgADrPh3Uae1bSpNDQJo
	 sX3xU7h+C0MgYL+BluKSWk/2g/Y8C+Zs6/Xw382ycgHIZP5xTlNKssDKxx5bKhpBYV
	 z5Wsbqrvu9emg==
Date: Tue, 6 Feb 2024 05:30:04 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
 linux-doc@vger.kernel.org, Justin Forbes <jforbes@fedoraproject.org>,
 Salvatore Bonaccorso <carnil@debian.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] docs: kernel_feat.py: fix build error for missing
 files
Message-ID: <20240206053004.6abf49c9@coco.lan>
In-Reply-To: <20240205175133.774271-2-vegard.nossum@oracle.com>
References: <20240205175133.774271-1-vegard.nossum@oracle.com>
	<20240205175133.774271-2-vegard.nossum@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon,  5 Feb 2024 18:51:26 +0100
Vegard Nossum <vegard.nossum@oracle.com> escreveu:

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

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

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



Thanks,
Mauro

