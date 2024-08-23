Return-Path: <stable+bounces-69931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A780C95C369
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 04:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DE41C224FC
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 02:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62DB20B33;
	Fri, 23 Aug 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H/Wvx61h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F61AACC
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724381443; cv=none; b=LTTx/AcRzJHj1njH4/UbMHHG+O80hiW717DYz6DherqKvPGjZEYBFPNzxAMWNBZaYFaK9GXfQaylgXfp25tKSZ49MMwxKALB9fiKDJihuPcY9A+MBK+85XvoAwUMjU89vNvnlAwPqsGmLA2Ltmr1FG89MqlxmoWGBLdvf1pA/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724381443; c=relaxed/simple;
	bh=3UBGY3O0k69ZxSvyb+UsZpYE+MrQv/ZxxdMByKdn/wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqU1wpFXvxCzVqaXm35zFo7AMwR68RAKmvd80o3VCz7CweZc4PjYcUV88ogCvfwItvnjmAZtAZDDdMqCLDRR7uYFpJHlxqLwvNPkgmJN+WAT31FZ6zve48Bz7XVywM3RnAS3VfHbUUb+jttAUV+BMtcweeBhaImhz99OPZuu0Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H/Wvx61h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3719896b7c8so671873f8f.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 19:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724381440; x=1724986240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=53XrlSuAuXREy7P2IzzeTvOSusKWy1K+VpUQ4Y6Gnto=;
        b=H/Wvx61h3oXnRAn3BHZSbeYlJdOeHtuBwq0nG7Jh4r7a/sqdI//uVs/iG3IUAMG+0r
         UIgz+3/NJNpICnyqTQlIl7ApIWKjbiSVe92+eHjZ6BmfwV9QCbn5vMiJ3fFJOE+H6Moz
         zccG+yIU0QRtRuZs2dBNptaqn6faRsx9FLR5+LnJ3Q25oaCx6x91egyocmMfbvoImBgB
         INuJEnvf9SstV1L69Qm+SYZ02C7IytLqUVdOrlZuxv8AUT3AQ06ozS7gIUDkFVZ31aYI
         Et8psPZzIMsYGsIEAmNXtiH+86a/vnIID9jfEJ35zTRAE+3G+rIVneJJouIUqQXYLli3
         6mpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724381440; x=1724986240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=53XrlSuAuXREy7P2IzzeTvOSusKWy1K+VpUQ4Y6Gnto=;
        b=V1Fe/qXmAUETJqg4KP7pq7HYdDeWPR56PAOYWejoKrKdIcOP7gJ++cdIe1vWHVjiGP
         ARPFfnajOP0Vn9pgPDqHcjATfh0ATmKjYI0qNyN9ZN43UVeidXY/ZXZONRW0i00wZ908
         cbZZvWbBxYrZ2sSmSKm+0Dmt19ZQJHDy7MM6LCy1XM8vi62tip+9Hl45rm78HriiCFuC
         kYArCvQsgNRyMC9s3vb9vvPB2S9ve9aTgcktTVD70TQInk+3LeDLv8XAn3Q7M09HkQAZ
         93LxB1hOuxnJPGAjnpFGVQrXVWclLVIK+sgKmFhXG4bITajjTNvS5tocT2MIm8Dbg+91
         W+FA==
X-Forwarded-Encrypted: i=1; AJvYcCVKAmyCErBCZarWaEdugrTbs/prXSTSrSGYk5rbozUKVBHMLXcg4d3mrXpcvFDZWoa+pxq3YD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CcwZ4itLVcVy37unqHsaA/138mztbJISg+pfOzE/61dyTf86
	43NEbkgAqcK/blL0HsaQbVMUo3zQBpPNDi2h3JSVA08PJW88jBXS6uBkTr6vDRI=
X-Google-Smtp-Source: AGHT+IFMv0oKgB/ZacGfwkwqtINuUiN/SmrUy8TwR3JUnk6zrgUA6sIRQ0CqiuppG/42O/rlId4hWA==
X-Received: by 2002:adf:ffd2:0:b0:371:88a6:80d8 with SMTP id ffacd0b85a97d-37311863af5mr417426f8f.28.1724381439593;
        Thu, 22 Aug 2024 19:50:39 -0700 (PDT)
Received: from u94a (27-51-129-77.adsl.fetnet.net. [27.51.129.77])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cda0ada9adsm1342591a12.26.2024.08.22.19.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 19:50:39 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:50:29 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: maxtram95@gmail.com, maxim@isovalent.com
Cc: Sherry Yang <sherry.yang@oracle.com>, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	gregkh@linuxfoundation.org, john.fastabend@gmail.com, sashal@kernel.org, 
	stable@vger.kernel.org
Subject: Re: BPF selftest failed to build
Message-ID: <xycnahurpkbaym42w7lm3asy3uzqxowvxkckvbbpoqphxo2dad@c7z4ztfe4w6r>
References: <20240711184323.2355017-2-maxtram95@gmail.com>
 <20240823014514.3622865-1-sherry.yang@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823014514.3622865-1-sherry.yang@oracle.com>

On Thu, Aug 22, 2024 at 06:45:14PM GMT, Sherry Yang wrote:
> Hi All,
> 
> We found BPF sefltest fail to build with following error:
> 
> 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:1: error: unknown type name '__failure'
> 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> 08-09 20:39:59 DBG: |output|: ^
> 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:17: error: expected parameter declarator
> 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> 08-09 20:39:59 DBG: |output|:                 ^
> 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:17: error: expected ')'
> 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:16: note: to match this '('
> 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> 08-09 20:39:59 DBG: |output|:                ^
> 08-09 20:39:59 DBG: |output|: progs/test_global_func10.c:24:52: error: expected ';' after top level declarator
> 08-09 20:39:59 DBG: |output|: __failure __msg("invalid indirect access to stack")
> 08-09 20:39:59 DBG: |output|:                                                    ^
> 08-09 20:39:59 DBG: |output|:                                                    ;
> 08-09 20:39:59 DBG: |output|: 4 errors generated.
> 08-09 20:39:59 DBG: |output|: make: *** [Makefile:470: /root/oltf/work/linux-bpf-qa/tools/testing/selftests/bpf/test_global_func10.o] Error 1
> 08-09 20:39:59 DBG: |output|: make: *** Waiting for unfinished jobs....
> 
> It happens from the commit e30bc19a9ee8("bpf: Allow reads from uninit
> stack"). We did a further look, '__failure' is defined in
> tools/testing/selftests/bpf/progs/bpf_misc.h, and was 1st introduced
> in commit 537c3f66eac1("selftests/bpf: add generic BPF program
> tester-loader") which is not backported to linux-5.15.y.
> 
> So we may need to revert the patch, or fix it.

To fix it I think we just need to drop the use of __failure and __msg in
progs/test_global_func10.c, and update the "struct test_def tests[]"
table in prog_tests/test_global_funcs.c with the new verifier rejection
message.

On the other hand I believe commit 537c3f66eac1("selftests/bpf: add
generic BPF program tester-loader") should be relatively easy to
backport, just picking that commit up and resolving simple conflict in
Makefile should be enough. It will also save a lot of future headaches
like this one.

(Note: the generic test-loader patch will need to backport it to stable
6.1 first before it an be backported to 5.15, as per the stable rule[1])

1: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#procedure-for-submitting-patches-to-the-stable-tree

