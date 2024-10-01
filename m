Return-Path: <stable+bounces-78549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4F98C124
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FEEB2682E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3751CC16D;
	Tue,  1 Oct 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gy/UdYDi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F751CB320;
	Tue,  1 Oct 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795025; cv=none; b=eJ5M1jrC+DgIvo6BrZgJwuBnxKJAv2kLhOk4OU73ypn4/noDrhrbNVsDoq/ht+GDBzhoZytYkSR/+s2R8+0ut5IgUiy6KJPMzb1BdzLOGx9RTYMpwd30XKYG20X40l33FkBwcnHG4JNQGQ42btXwyCbLZwqfKB6J/ekm5nnZ358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795025; c=relaxed/simple;
	bh=/XA4LtjeNpKQ1vUujz9VdDZnErzJroDnTK0l2QM1P38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6SHjPSfbwzNyzk2evP33+VREOiuvaGq2yD/U2+Cay/qC2XWbu0ZEesumakv6F30clfv79BmqiC6Lyo5lHvMax2l4MJUptPASrrv2EZQ15rFQ2Nc30SfgelCojHBpE5U/J18TJpwpZQDJxhViaKp1S2n8BHNE3UHHGvs8sjgIVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Gy/UdYDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69897C4CEC7;
	Tue,  1 Oct 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Gy/UdYDi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727795022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68Lf0Q0SqeR4r1GgH+pfoatfoaicVhZ/o9Lk46pC7wg=;
	b=Gy/UdYDiOCycCz612YWe0eseWR1tlzVOOkVSyz2FV6ZQbvRtmApa1y0s2/8it25UVaQjVo
	d2ks+PjLFF8f6JXKEar+zDdASHvsk2fCVwg1RO3u15cDWdSysvQ9heSVkcy68+bj+RTlx3
	/SP7PA702xy+3lLKaUmeBozwrH3JOb8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70e088b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 15:03:42 +0000 (UTC)
Date: Tue, 1 Oct 2024 17:03:42 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: Patch "selftests: vDSO: skip getrandom test if architecture is
 unsupported" has been added to the 6.11-stable tree
Message-ID: <ZvwPTngjm_OEPZjt@zx2c4.com>
References: <20240930231443.2560728-1-sashal@kernel.org>
 <CAHmME9rFjE7nt4j5ZWwh=CrpPmtuZ_UdS5O4bQOgH8cVwEjr0Q@mail.gmail.com>
 <433ff0ca-92d1-475e-ad8b-d4416601d4ba@linuxfoundation.org>
 <ZvwLAib3296hIwI_@zx2c4.com>
 <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <279d123d-9a8d-446f-ac72-524979db6f7d@linuxfoundation.org>

On Tue, Oct 01, 2024 at 08:56:43AM -0600, Shuah Khan wrote:
> On 10/1/24 08:45, Jason A. Donenfeld wrote:
> > On Tue, Oct 01, 2024 at 08:43:05AM -0600, Shuah Khan wrote:
> >> On 9/30/24 21:56, Jason A. Donenfeld wrote:
> >>> This is not stable material and I didn't mark it as such. Do not backport.
> >>
> >> The way selftest work is they just skip if a feature isn't supported.
> >> As such this test should run gracefully on stable releases.
> >>
> >> I would say backport unless and skip if the feature isn't supported.
> > 
> > Nonsense. 6.11 never returns ENOSYS from vDSO. This doesn't make sense.
> 
> Not sure what you mean by Nonsense. ENOSYS can be used to skip??

The branch that this patch adds will never be reached in 6.11 because
the kernel does not have the corresponding code.

