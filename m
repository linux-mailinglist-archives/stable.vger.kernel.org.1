Return-Path: <stable+bounces-10885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829EE82D8AB
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 13:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B2CB2186C
	for <lists+stable@lfdr.de>; Mon, 15 Jan 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0DB2C68E;
	Mon, 15 Jan 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vz5Z4Tck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4098F28DD1;
	Mon, 15 Jan 2024 12:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6945EC433F1;
	Mon, 15 Jan 2024 12:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705320084;
	bh=23NMlKrz5ni0noSWtwWBgVpMu1uF1nQgucJdnlFMuk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz5Z4TckEQYRyPWQMmsydfEPwV8G4Hi+C8g39c7BAdA3VeAbiMiKYLQ3h7vzSP1zE
	 E4S4OXchwewgIiw63BOLPyRQe8Q+AZuzE1R7A369pFaKL9JaEG8whn8UYuM9yV6TDa
	 iKS4hS7FTf+AXhIrCriP8bkG/LkQ6kmdNVWFjcOA=
Date: Mon, 15 Jan 2024 13:01:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: kernel BUG on network namespace deletion
Message-ID: <2024011533-kebab-headway-0461@gregkh>
References: <CAEmTpZHU5JBkQOVWvp4i2f02et2e0v9mTFzhmxhFOE47xPyqYg@mail.gmail.com>
 <2024011517-nursery-flinch-3101@gregkh>
 <CAEmTpZHcXrPTC15KS9SvC6auK1G2nugny_wQA411+9CXrW0dgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEmTpZHcXrPTC15KS9SvC6auK1G2nugny_wQA411+9CXrW0dgQ@mail.gmail.com>

On Mon, Jan 15, 2024 at 03:00:36PM +0500, Марк Коренберг wrote:
> Hi, netdev. I have found a bug in the Linux Kernel. Please take a look.

That's not a good way to post, sorry.  Also what does this have to do
with stable@?

Please resend your original message to netdev, top-posting doesn't go
very well here, as per the email guidelines in our documentation :)

thanks,

greg k-h

