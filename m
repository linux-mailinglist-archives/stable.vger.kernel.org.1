Return-Path: <stable+bounces-6766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B700B813A58
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39291C20C8F
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D1C68B94;
	Thu, 14 Dec 2023 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VCashXzR"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26F6A0
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:52:25 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28aea039fb4so771443a91.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702579945; x=1703184745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rImHCsxBNKVfJ+c60QpaIL/Q2xoj8qYkJJp7A+VX/rU=;
        b=VCashXzR1QZxwtBILQle3OdSJbRryTEOg50ccXYWOJq7VH9tj4bKqWFv0c+ZYyxHxE
         CIkQlWBCMzToc6BxQDoAdtF4PV7aszgXOPn2WxttyY+eCnCWlmFhiL4WqBiw4YWdyR55
         8vFYj3SkziqU5b3/Zv5NGL9ax62kjYLOHUsm1ex8UkXhlLjH/qJoCwjBt48EhzU3eyUv
         YcU0Kun3gvv7ao10LSELfulH0v1N1z4ySzji5OGUG770Q7HY/Y3SD7DTcVx4A06FL9nU
         YYEXMFgtvrz6uexbOBYXtk/nH/+F1iRJ8HZWxAg1ylhtvJX5rlb6m37WdFNav7V7tUiU
         OzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579945; x=1703184745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rImHCsxBNKVfJ+c60QpaIL/Q2xoj8qYkJJp7A+VX/rU=;
        b=D+g7S1GkHckxhMuRQUZK4PxfnDuzb9C5sOH41sHErvua4AOhkpws8F78iK0PH/5eLX
         JWy5zPqGJTOyIaNwGMVZd1kpj7M8s11rglOvXFg/MtJtNaFapuCRoGPZ6vvTN+k8EoQd
         j4SJfwJQzjD2yqIuFEDdhSkudNfnG8hGFc0X1WpYAY5vj5p2nrG0NFDmkpM0n5WcQHET
         Q/YsGw6JwUO9XiCo8LxtMLe93A89oGBnj61jxiWxcCgK+7rC8WNI/0BY6v0PDHuUhRzt
         R3xKbuiSkhnv4nyqjdTdDVg6vSQuUVY/sJWV73FnKJol/BbhsJvPUEds/0E821PBBTh0
         19xw==
X-Gm-Message-State: AOJu0YxsbqqaMVGrRc5DjcJy1KOT9VCkWzNcTpAwdLGBr2NRU81UitIq
	62VK+i08jLUVZja7bYjPjRqtQCGabD1yZdifZh+77w==
X-Google-Smtp-Source: AGHT+IFFPK/FQnOtvnqYcD+pRqVHsOVtO+Ib/v3KYjT3Z2KKMpI7zUMO9ANya8vDK+ukDGxr1cYd5A==
X-Received: by 2002:a17:90a:bd90:b0:28b:1d62:c00 with SMTP id z16-20020a17090abd9000b0028b1d620c00mr806134pjr.8.1702579945261;
        Thu, 14 Dec 2023 10:52:25 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id r15-20020a170903020f00b001cf5d0e7e05sm12724846plh.109.2023.12.14.10.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:52:24 -0800 (PST)
Date: Thu, 14 Dec 2023 18:52:21 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Joe Perches <joe@perches.com>
Cc: stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
	kernel-team@android.com, Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Aditya Srivastava <yashsri421@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5.10 1/2] checkpatch: add new exception to repeated word
 check
Message-ID: <ZXtO5Ym8vFDRdn1j@google.com>
References: <20231214181505.2780546-1-cmllamas@google.com>
 <20231214181505.2780546-2-cmllamas@google.com>
 <8f7d59b8945a2205ea7acf66da23d4673e48f166.camel@perches.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7d59b8945a2205ea7acf66da23d4673e48f166.camel@perches.com>

On Thu, Dec 14, 2023 at 10:31:02AM -0800, Joe Perches wrote:
> On Thu, 2023-12-14 at 18:15 +0000, Carlos Llamas wrote:
> > From: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > 
> > commit 1db81a682a2f2a664489c4e94f3b945f70a43a13 upstream.
> > 
> > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > moved the repeated word test to check for more file types. But after
> > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > new warnings of the type:
> > 
> >   WARNING: Possible repeated word: 'git'
> 
> Why should this be backported?  Who cares?
> 

Our CI for stable cares. However, it seems it would be best to run the
version directly from master instead. I'll try that. Sorry for the
noise.

