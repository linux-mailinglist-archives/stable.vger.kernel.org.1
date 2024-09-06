Return-Path: <stable+bounces-73761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AC96F0A6
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00EF71F22FB7
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB651CB15E;
	Fri,  6 Sep 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cgS7oNvs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B11C8FA5;
	Fri,  6 Sep 2024 09:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616616; cv=none; b=k6a40e/q6KN5SggccfpoAlfKm9CQ7k2NdBw+WtO8fKGmiZhk5wF44dW32i4+A9+I0Wwai//FQYfvIgVzMNpNTmIE5Q9fIOOANxslpnmt+HvrJhazBzc2vXtoH/0AcbsprvoxR7q988P+2/issMz2dErt4ttynBfUHdI2ys5D6EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616616; c=relaxed/simple;
	bh=54BuMMnqmQ9PMqkntCuUc/wAVnx2C0JJ8YuQURC+HZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMddLCLpf1QwsxOaq/nmq54jgoqiKDPKHymMI7fHY5Xub5WUC2yz5893hS6O7m0eaCx/NR+LjsOnNsTyixCYlOb62/PN+58M1epdLffxEqhm78onhfnTsEErzBmPt7jbjCu3vzs6hip4e7ABYul/zN/LDmBZy2DCdyNHBj8xhtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cgS7oNvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667A0C4CEC4;
	Fri,  6 Sep 2024 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725616615;
	bh=54BuMMnqmQ9PMqkntCuUc/wAVnx2C0JJ8YuQURC+HZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cgS7oNvsIO+waEL5DI+TOOt5SnA6zRJ35Dsri7sPsQ7YbGFREFKMQp96rxaA7HrQc
	 H1Zq2PLA7kCiKgxdfjIUnOOMVUgdwKC2yRzzWR7kxFxh8m0l4IZ0UBB3D7Wdr9rMCZ
	 ynCTvU2ns4xjzyDeuUkPumju2Sx4p+Lzs2Kdw7Cw=
Date: Fri, 6 Sep 2024 11:56:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: MPTCP stable backports: is the workflow OK?
Message-ID: <2024090642-viewing-happier-23b8@gregkh>
References: <32148274-08bb-4031-a55b-6b16b48a5497@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32148274-08bb-4031-a55b-6b16b48a5497@kernel.org>

On Fri, Sep 06, 2024 at 11:36:25AM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> Thank you again for your support when we send patches for stable
> versions for MPTCP!
> 
> Recently, I sent many patches for the stable versions, and I just wanted
> to check if what I did was OK for you?
> 
> I tried to reply to all the 'FAILED: patch' emails you sent, either with
> patches, or with reasons explaining why it is fine not to backport them.
> Are you OK with that?
> 
> Or do you prefer only receiving the patches, and not the emails with the
> reasons not to backport some of them?
> 
> About the patches, do you prefer to receive one big series per version
> or individual patches sent in reply to the different 'FAILED: patch'
> emails like I did?

One big series, per kernel tree, would be ideal as that way I don't have
to pick them out and guess as to the order.

Also, if you don't respond to the FAILED emails, that's fine with me, I
don't keep track, but maybe Sasha does as I know he does backports based
on them at times.  So I'll let him answer that.

But in the end, whatever is easier for you is good for us, thanks!

greg k-h

