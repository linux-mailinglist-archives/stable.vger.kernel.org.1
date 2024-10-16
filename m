Return-Path: <stable+bounces-86428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E369A00E1
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 07:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF15C1C213B5
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 05:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8D318BC39;
	Wed, 16 Oct 2024 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rFhinqrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0984218BC2C;
	Wed, 16 Oct 2024 05:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057356; cv=none; b=UslZ6uY//hw0fgOMcxWeQiL7Y4AmsBaG65FMeBWbSGE2a1Qb94G2XIfvOIWFIqM4V9YmX/1jmllYTK3w+rhzYaWRmJDEnyPrttOcyILfI6n7JhoJ11rRkTWVwaX3DCo2l/0VX354mlThTLoiTJkwO/QoU0hfGt1TLoOrtBHCrm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057356; c=relaxed/simple;
	bh=VBS7EJ50GUS6vnNz48rkACqmxiiN4X8WRWJRKPX8I9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vp/NPGEOygI1xP4aAKT48Jh8VjMlUsqMN7PJjI8riE8P7eoL72OaMYCxyiFx7EqEw4BKb1GVmdvAlvFHmEMEXCL4Tr92okr/PBniglP58rjfoVgbC42KvIj84TzJtKHF1IzxxKQxheUnITCZN6hY8GvEmvAqIKAVTeydlYdrFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rFhinqrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C89DC4CEC5;
	Wed, 16 Oct 2024 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729057355;
	bh=VBS7EJ50GUS6vnNz48rkACqmxiiN4X8WRWJRKPX8I9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rFhinqrKcBi86kjQ0Q7EtGxTEeOu111m8JhCtVnECxqUQfN0B8p/y1aFIYWY2pA7K
	 4g1IHS4cXIm0JipSz0Dyb/MuNbtYiqywPF92dHtVS58pWIIxeSz3CZbf8LY8NY72Kx
	 EndrusNn23V7cp95TXNtoUXE+1aDU0lQYhv9U+ss=
Date: Wed, 16 Oct 2024 07:42:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dean Matthew Menezes <dean.menezes@utexas.edu>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: No sound on speakers X1 Carbon Gen 12
Message-ID: <2024101613-giggling-ceremony-aae7@gregkh>
References: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkK70Tke7UxMEEKgRLMntSYeMqiv0PC8st72VYnBVQD-KcqVw@mail.gmail.com>

On Tue, Oct 15, 2024 at 07:47:22PM -0500, Dean Matthew Menezes wrote:
> I am not getting sound on the speakers on my Thinkpad X1 Carbon Gen 12
> with kernel 6.11.2  The sound is working in kernel 6.8

Can you use 'git bisect' to track down the offending change?

thanks,

greg k-h

