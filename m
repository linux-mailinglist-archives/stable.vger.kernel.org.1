Return-Path: <stable+bounces-6764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3201813A1B
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 19:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588801F21A64
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FD460B83;
	Thu, 14 Dec 2023 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NlnYcnKs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CED10E
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:37:48 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d336760e72so31630855ad.3
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 10:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702579067; x=1703183867; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDgADLf+ugrlfKVT9FOMGTOdBFuVSZM0X+ljXn8jqCw=;
        b=NlnYcnKs/QFblYchBu7S4cGKOOZ+o5VrfFy6GxYCUhfuJSprrO70cdBl6Tn3pJTFUS
         Cejnrc+KUNTvP9Rvvs4YKmjbCwK4i9lATyeEXuAruIFLNq5gvQsdEROl2AtcFUnkLiRB
         FYY+zMdx80Sg28IJqwHGPBJ2gX7DKG+Mu7FgqP6HP/tFN1EOcUpHAnWRK1tPFKWlrJEj
         8LjspApE07In2t8hPSb4RhMizCbIrQJUNBUyJwqcpplQ29hy2+cY232A0rmS6pUbSbqd
         31u2s46+rajNwTvsDVLNEfgzAT7VQc+qXbQnWc9Z7Fd63cNGvoZcoZ6mC5t2GC/ka8Iy
         IzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702579067; x=1703183867;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDgADLf+ugrlfKVT9FOMGTOdBFuVSZM0X+ljXn8jqCw=;
        b=P3DSaCYHe5qrneya3JtHfpl9EuBJODcipkh1XfqQwOi/yc4PTpsDW7Rg5xG9EBv0N4
         7Rvbk2P2ubS3QFuQw61N5J6c+N2EYl3d32RZTKgHlGCm1oVZ1MIiz10h15x+vD5j4KHV
         qNnG/eR61nYVWIr6gUXjBoeVv1t2HrfR2Cz7629aRcrde6KD1dN4ONkE3sCASIPrX+JG
         0Et34elaKKf64ceqOc/EvWyyN5F0ek/tvkrCXfSN9jTzxqpjC/oiTeQY1nVwXjB9DfDS
         7uegTxblDPITu92ywMvqsFsdSOREY21h1MI6sFsk4cFgpN4Y/2PFiNP238ERw8dIE3/p
         c0bw==
X-Gm-Message-State: AOJu0YxmnbmQYm3y37cu4puzUKecA5idx6VoUgB2mscUtCR7O2fW0Jpm
	5395lNt+NgNRXvU2ua/H7uKPQV4yex4bprgi9ZDGCg==
X-Google-Smtp-Source: AGHT+IHt+wkw1pLK7gtfjIiAC9Pi1kkE+KD88ilWVYL7tpNQun1+WEruXW9A565w59Kl3XKiKQcEiQ==
X-Received: by 2002:a17:902:d487:b0:1d3:7bec:18e1 with SMTP id c7-20020a170902d48700b001d37bec18e1mr504388plg.121.1702579067533;
        Thu, 14 Dec 2023 10:37:47 -0800 (PST)
Received: from google.com (170.102.105.34.bc.googleusercontent.com. [34.105.102.170])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902748100b001d36292f2bfsm2070535pll.48.2023.12.14.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:37:46 -0800 (PST)
Date: Thu, 14 Dec 2023 18:37:43 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 5.10 0/2] checkpatch: fix repeated word annoyance
Message-ID: <ZXtLdyHSamRjH94u@google.com>
References: <20231214181505.2780546-1-cmllamas@google.com>
 <2023121442-cold-scraggly-f19b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121442-cold-scraggly-f19b@gregkh>

On Thu, Dec 14, 2023 at 07:23:28PM +0100, Greg KH wrote:
> On Thu, Dec 14, 2023 at 06:15:02PM +0000, Carlos Llamas wrote:
> > The checkpatch.pl in v5.10.y still triggers lots of false positives for
> > REPEATED_WORD warnings, particularly for commit logs. Can we please
> > backport these two fixes?
> 
> Why is older versions of checkpatch being used?  Why not always use the
> latest version, much like perf is handled?
> 
> No new code should be written against older kernels, so who is using
> this old tool?

This is a minor annoyance when working directly with the v5.10 stable
tree and doing e.g ./scripts/checkpatch.pl -g HEAD. I suppose it makes
sense to always prefer the top-of-tree scripts. However, this could be
inconvenient for some scenarios were master needs to be pulled
separately.

--
Carlos Llamas

