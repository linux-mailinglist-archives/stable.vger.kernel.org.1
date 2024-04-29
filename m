Return-Path: <stable+bounces-41632-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2A8B562B
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E361F20FD8
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99DF3D996;
	Mon, 29 Apr 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="loDyTRb+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D693D56D;
	Mon, 29 Apr 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389073; cv=none; b=W03R1/b/X8tmDCCX/Y+8FpmwBsghp3+YWCNMNzp+t93uJvQgI0K5kF4H4pTazdFbeHhU/uR3LBiXum/bqfgWCgyFkutTPybNOXc1jlGBYxrKGufoQF0n9UcYyMr6VTZbu1spndJQ5qT8oCeLAAFcrgyrH3X+OjyFZ9WjAmGg6pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389073; c=relaxed/simple;
	bh=MzgPSWRlF3fkUG8J93WnV8SLhNn5zTh9KSlgGTEHt/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3sHDHOa5jo/bzPeU7B0BOdib47oysWvTH7jOREz4L/scEBhFFcsXQG8VEjvvhGri8Uuywlj+Mm1VuAs2qrUVA6M7hVIHXaV+kZ+YQIP11nLEFfpzYeeJay9XR/gObqSmHYm8RNsQj8IHGEyTnuppbdDLQ2l2d3i4dskCvXwqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=loDyTRb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD030C113CD;
	Mon, 29 Apr 2024 11:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714389073;
	bh=MzgPSWRlF3fkUG8J93WnV8SLhNn5zTh9KSlgGTEHt/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=loDyTRb+lhpP9vQZJpBIDAwjgWS1W0ROpASDimvgjAAnSSuLmhBnRj9+l1HzJIshV
	 kiG33Yk6e+XTzVfX4HmUOK/ptnBWmkVvqDX6AS/CEAb3MRz5d6T9eFXj01Yk3pQ3ju
	 z3T8mT5okVPNq6+XtANwFDN+gcbX2S3rKF+dDruM=
Date: Mon, 29 Apr 2024 13:11:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.10 0/2] introduce stop timer to solve the
 problem of CVE-2024-26865
Message-ID: <2024042934-dreadful-litigate-9064@gregkh>
References: <20240428034948.3186333-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428034948.3186333-1-shaozhengchao@huawei.com>

On Sun, Apr 28, 2024 at 11:49:46AM +0800, Zhengchao Shao wrote:
> For the CVE-2024-26865 issue, the stable 5.10 branch code also involves 
> this issue. However, the patch of the mainline version cannot be used on 
> stable 5.10 branch. The commit 740ea3c4a0b2("tcp: Clean up kernel 
> listener' s reqsk in inet_twsk_purge()") is required to stop the timer.

This is also needed for 5.15.y, so we can not take a 5.10.y only patch,
you know this :(

Please also provide a working set of 5.15.y patches and then I'll be
glad to queue these 5.10.y ones up.

thanks,

greg k-h

