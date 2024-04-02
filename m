Return-Path: <stable+bounces-35605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B5895514
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 15:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA7F1C220B1
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B72D81752;
	Tue,  2 Apr 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=preining.info header.i=@preining.info header.b="YqZ08d2Z"
X-Original-To: stable@vger.kernel.org
Received: from hz.preining.info (hz.preining.info [95.216.25.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B4F7A158;
	Tue,  2 Apr 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.25.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063890; cv=none; b=TlQhn3VFqLXdVoWWD63EThK4JVj7EKXnvfTAgsbEMOQIk36Xy18Q77FJdWC7/vVQdN8VOm4JV+o++mHHcMl8LsMVHM9h34WUxBk71Qpn3Sd6axB37iYgLC+SsdM++5J1BCyE9pQa5DbR75a6N90G5Yxshi4xT5cOxs4AaT9Xypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063890; c=relaxed/simple;
	bh=80IhwDgD1gPqa9vTqSCEAKUjeZBU8j6RuuQa/+lWtsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgVBpQh+hx7zopbR0Zn+7Fj5DF4ltIf5A6CNJKr194pxsN100vCeFIvrUwSQOBosBk+SOy5vamtNfcL6AtIeYAIjicU5WH5t8rbmKpydnJQ94OcsfoT362hxpowe4iwxkotc9nUpJISlvyqK8Fmn5m7i7QqHImn8M8cqQfQWPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=preining.info; spf=pass smtp.mailfrom=preining.info; dkim=pass (2048-bit key) header.d=preining.info header.i=@preining.info header.b=YqZ08d2Z; arc=none smtp.client-ip=95.216.25.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=preining.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=preining.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=preining.info; s=201909; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=G5P4FMG63I9JSCmj4VgPs+r9J18nRxq7QCCPof1NWb8=; b=YqZ08d2Z55jJgnSijAQ1kJ/xiU
	qw+x1trC64zVlt/IHhIH4HJZK0FUVKR5dasr1NNg8iuj7ea3pVyeQ4s20Z2QNF/pzi2BdWX0U4DtY
	4Fu0Tc/57NbcycLX2WLoMuZvhSZb8ZFEvl7B8AEd4P/1okPvaDGDqdtWpknjaK2oFPndpfenHGLuj
	3RSjSVVACHHBWJoEunfnDdCOTV74ouAqIYSZSxP6Lh8a2s/bJwtRPG8M+xhaBSvHaMReAZGbeNxO/
	iWSIH9sZfqLEgRq+OhSrYLUEc3+iiesbSOj4JxcLdXKIXDoeDvaNWvxTTLcIGHqjn5jT4tez9CDof
	QljD9XAQ==;
Received: from tvk215040.tvk.ne.jp ([180.94.215.40] helo=bulldog.preining.info)
	by hz.preining.info with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <norbert@preining.info>)
	id 1rre1d-00F0hY-2F;
	Tue, 02 Apr 2024 13:18:06 +0000
Received: by bulldog.preining.info (Postfix, from userid 1000)
	id 464361DF3C0A; Tue,  2 Apr 2024 22:18:01 +0900 (JST)
Date: Tue, 2 Apr 2024 22:18:01 +0900
From: Norbert Preining <norbert@preining.info>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: Regression in kernel 6.8.2 fails in various ways (USB, BT, ...)
Message-ID: <ZgwFiaLefPAaH3tw@bulldog>
References: <ZgvkIZFN23rkYhtS@burischnitzel>
 <1c698f8e-c7ca-4909-8872-057d6ae149ff@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c698f8e-c7ca-4909-8872-057d6ae149ff@leemhuis.info>

Hi Thorsten,

thanks for your quick answer, much appreciated.

> Thx for your reports. Nitpicking: next time, please report each issue in
> separate mails, as mentioned by
> https://docs.kernel.org/admin-guide/reporting-issues.html

Ok, will remember. It wasn't clear to me whether this is just one issue
or multiple.

> > * Plugging in my Yubikey C does not trigger any reaction
> >   (as a consequence scdaemon hangs)
> 
> Have not heard about a problem like this yet.
> 
> Could you bisect?

Will do.

> > * sending of bluetooth firmware data fails with Oops (see below)
> 
> A changes that hopefully fixes this is in 6.8.3-rc1:

Nice, good to hear.

> > * shutdown hangs and does not turn off the computer
> 
> That might or might not be a follow-up problem due to one of the other
> two problems. :-/

I agree. I will see what bisect tells me.

Best regards

Norbert

--
PREINING Norbert                              https://www.preining.info
arXiv / Cornell University   +   IFMGA Guide   +   TU Wien  +  TeX Live
GPG: 0x860CDC13   fp: F7D8 A928 26E3 16A1 9FA0 ACF0 6CAC A448 860C DC13

