Return-Path: <stable+bounces-179808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 129A4B7D68B
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AE811C065A6
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 08:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6DE2F60C4;
	Wed, 17 Sep 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btaq8iV0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15027E040
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098788; cv=none; b=B0nSMu8ZoaJJCKkeBEjwKsB8lVmaKahzPC3KNpQBqihpCQUo4ufmV0fwHXHZuSb6jBsUTC0vUzDrtwGAlT4XYh4YJu0X6jM/0mlxupozqy4bcIXgH2cw0JFx1x6dA58D+5Zq8aT6TpvqHwvq8CZSAWjZp0KdgOvrL5b5v4sCgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098788; c=relaxed/simple;
	bh=j4ynRoxvc2dvgPMLjmM+9UfwUxN3lE9pESSOB82QLWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWw7LdbAOTdBod+CpjntIRPIkiQcQYPv11gVrHpR9dGDdFdR8oOv9giNBRRJb3vh/v/pHbg1rKDfP7GXWJPjeos9MvQWrrp0qmMB8IwTnsOtds4qPn+kXSeZlXtIOkuMjWnXVbUH2KJoIerWzFEPFArTw4/nzo4/HzbbMeGpmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btaq8iV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD38C4CEF0;
	Wed, 17 Sep 2025 08:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758098788;
	bh=j4ynRoxvc2dvgPMLjmM+9UfwUxN3lE9pESSOB82QLWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=btaq8iV0Xs+YXpHN+ri6w4krrlTkt/iirkK9acL1JNF9HXo7nkiaziwpVeGwZdv6E
	 v+0dCo8ej/BGedvQE/0+F/0YrnFp55aPQ7v9TQiUfydNdTRuo+y3lsATcrBazdM56Z
	 PHyA/546dQKarsb4sJlmU/UpzeBhFpIyoWO4xMr0=
Date: Wed, 17 Sep 2025 10:46:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yongqin Liu <yongqin.liu@linaro.org>
Cc: stable@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	John Stultz <jstultz@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: Please help to cherry-pick 25daf9af0ac1 ("soc: qcom: mdt_loader:
 Deal with zero e_shentsize") for the 5.4/5.0/5.15/6.1 versions
Message-ID: <2025091709-flatworm-magnolia-d08e@gregkh>
References: <CAMSo37UP50E6gAeP9bRmcJ2af9v+kNU4DJxrrZcsLEzM0PY7OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSo37UP50E6gAeP9bRmcJ2af9v+kNU4DJxrrZcsLEzM0PY7OQ@mail.gmail.com>

On Wed, Sep 17, 2025 at 12:22:07AM +0800, Yongqin Liu wrote:
> Hi, All
> 
> Please help to cherry-pick the following commit
>     25daf9af0ac1 ("soc: qcom: mdt_loader: Deal with zero e_shentsize")
> into the following branches:
>     linux-5.4.y
>     linux-5.10.y
>     linux-5.15.y
>     linux-6.1.y
> Which is to fix the issue caused by the following commit in the
> branches already:
>     9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past
> the ELF header")
> 
> Just please note, for the linux-6.1.y branch the following commit
> needs to be cherry-picked first:
>     9f35ab0e53cc ("soc: qcom: mdt_loader: Fix error return values in
> mdt_header_valid()")
> before the cherry-pick of the 25daf9af0ac1 commit.
> # if this needs to be in a separate cherry-pick request
> # please let me know.

All now queued up, thanks.

greg k-h

