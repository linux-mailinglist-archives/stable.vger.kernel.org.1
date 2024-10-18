Return-Path: <stable+bounces-86746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0B9A34F7
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 08:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B07283C98
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 06:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216B4185B48;
	Fri, 18 Oct 2024 05:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ulFnnto9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C0B1547C3
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 05:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231157; cv=none; b=F2b+CpupiH6fZhiKlC523CPKwtOWE5TZ4ehYtR4uumCYf8IE1agxJWzvNyB18aKX0d/m9V5RjXDqqlk9H8POn5j5hSGRIoKMiCwTepZ396BRTAZq7BiSU1UMw1OZFi1MOxDAPIaDfQUxYlECGqWLMDlchvkLIUC/7kKJDgNELbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231157; c=relaxed/simple;
	bh=10tvtgHSsUmRtJcXtncfWwvg1bH6DDD5l3ljyjE8ZJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPBMYLGcVJuIiPwaiDQ/GLodoFt1jv7UcjQmx1Vmr2qjXnCvUh4w2KZASq8gUnM4IoQxhyP89KL9RV0qAanfWK90Y8FR/lsjcrdd+Qyxji+Xv2+5BmeBIYUQr0Pb+gZL9B6RfLvmebTkJLAMZHMIalKJjBKMsjPnhgJOkP4wR28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ulFnnto9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E48C4CEC3;
	Fri, 18 Oct 2024 05:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729231156;
	bh=10tvtgHSsUmRtJcXtncfWwvg1bH6DDD5l3ljyjE8ZJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ulFnnto9QAK9pxzu4vpglIKrlrkRzgzRy754+ai68RnN1ruEEukF9PzUHDfk9FCUo
	 9qqGvIttNZWQGvK8qwTVp0MhtJMwfGqq4GB71FrORN82dFJ8+tABjWI9lDBpVDl/ju
	 5+9tCoZMonKKwVsVhabk16yYFZlnbkPpP2P1Sd7E=
Date: Fri, 18 Oct 2024 07:59:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: chrisl@kernel.org
Cc: stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>, Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	kernel test robot <oliver.sang@intel.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: Re: [PATCH 6.10.y 0/3] : Yu Zhao's memory fix backport
Message-ID: <2024101846-manicure-unwilling-4744@gregkh>
References: <20241017-stable-yuzhao-6.10-v1-0-4827ff1e64ce@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-stable-yuzhao-6.10-v1-0-4827ff1e64ce@kernel.org>

On Thu, Oct 17, 2024 at 04:35:35PM -0700, chrisl@kernel.org wrote:
> A few commits from Yu Zhao have been merged into 6.12.
> They need to be backported to 6.10.

6.10.y is long end-of-life.  You can always see what is currently active
by looking at the front page of www.kernel.org.

thanks,

greg k-h

