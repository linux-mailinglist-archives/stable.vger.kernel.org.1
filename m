Return-Path: <stable+bounces-16042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757A183E89F
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 01:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F1B1C223CC
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E40211C;
	Sat, 27 Jan 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o8M6ttZn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E817C3
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706316202; cv=none; b=CeMo/qZZKq8G4PUDFcKpt4rIebACuU/PtnP5GmQgZSSJQ8+deBwzDTJHpYsTpf9FmD3LbNdVkiewhBXLN0jyRwsJIVScyzUapPpteWflHYT/xQEoMHEazHtVtduvGWWnAArC3A6MLP1EOQ8c2VySS4j1qOz3icuxOcsspOQeaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706316202; c=relaxed/simple;
	bh=2RC+PNBR03WsE8Pq/YVBfM6G8Nf2Ms9cWVaaKOKYjss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaQEsnJcy8jbA18sJWHq5MssjuIERG/M2GuW634Ip7hG56wjSGtgs4RI+VqK4TkSoPpzpmiI7tSN3EA/VS7fGO2IZ9h6k4u0YEAOZjGjTo6PuuTEKRchmmWqWp+Y9QuClP4GEsGJt3kSav+lDSYF+E6ir3cXtAHCB9y07gTsWf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o8M6ttZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55901C433C7;
	Sat, 27 Jan 2024 00:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706316202;
	bh=2RC+PNBR03WsE8Pq/YVBfM6G8Nf2Ms9cWVaaKOKYjss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8M6ttZnuCX2SU85dxLoAF3ZHpqYwW/itU7cc2E0fJxfmXpSZDjr6rcZmmxkWlCFy
	 vXu2F8CvTUQLFpEPM9rD6/7suL3sl/6luJV55oaq22+X7Lk8q/9hR+TBYqqThhyK9a
	 +5yzEaVgM1r+VCyArNerz/ZU2Fnxz9YLJL22MPYs=
Date: Fri, 26 Jan 2024 16:43:21 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y 00/11] ksmbd: backport patches from 6.8-rc1
Message-ID: <2024012614-gave-liking-6c12@gregkh>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
 <2024012246-rematch-magnify-ec8b@gregkh>
 <CAKYAXd80WYNKJ2DEBEzbiECCFJupd81ZPBREz7KaOT4cc0fdjg@mail.gmail.com>
 <CAKYAXd9UdKnR3Ty8VppdU7J+WPERqKKqsLvJuft5LMh95sqYpA@mail.gmail.com>
 <2024012537-pastime-bobble-8a7d@gregkh>
 <CAKYAXd8TKpJVD85rU--oCsO8Z=2iUnu_2e+mmjaTU8xTc1X6sQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd8TKpJVD85rU--oCsO8Z=2iUnu_2e+mmjaTU8xTc1X6sQ@mail.gmail.com>

On Fri, Jan 26, 2024 at 10:59:17AM +0900, Namjae Jeon wrote:
> 2024-01-26 10:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> > On Fri, Jan 26, 2024 at 10:25:36AM +0900, Namjae Jeon wrote:
> >> 2024-01-23 8:28 GMT+09:00, Namjae Jeon <linkinjeon@kernel.org>:
> >> > 2024-01-23 0:03 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> >> >> On Sun, Jan 21, 2024 at 11:30:27PM +0900, Namjae Jeon wrote:
> >> >>> This patchset is backport patches from 6.8-rc1.
> >> >>
> >> >> Nice, but we obviously can not take patches only to 5.15.y as that
> >> >> would
> >> >> be a regression when people upgrade to a newer kernel.  Can you also
> >> >> provide the needed backports for 6.1.y and 6.6.y and 6.7.y?
> >> > Sure, I will do that.
> >> > Thanks!
> >> I have sent ksmbd backport patches for 5.15, 6.1, 6.6, 6.7 kernel.
> >> Could you please check them ?
> >
> > Give us a chance, we just released kernels a few hours ago and couldn't
> > do anything until that happened...
> Okay, I would really appreciate it if you could apply them into the
> next version!

All now queued up, thanks.

greg k-h

