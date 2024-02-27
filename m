Return-Path: <stable+bounces-23867-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A9868BE5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 108C41F22218
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315A9136658;
	Tue, 27 Feb 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JhU/z06X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBB13540A
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025087; cv=none; b=Q3j6lWMmOkz8B6ZXrzdGFtZ79kgHqYUN5hKGUqBMkwSWjmfgoR91shAbZ2hp0ZdODZyq/TCXS2hzwMLAgqM58yz6YOxz5mjk9jPZ+qvALH7KVi7/KoV6IXuQ0NX6+g68h0JDGaS/ZzWC/bNjuf0B3UWJHaLwdH8iuEhXvHQJ1PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025087; c=relaxed/simple;
	bh=LvEveEsH6bbba26NvLuV0QJ3q4+jYVJzVQUUtOm0ExM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAkjBbjseutV1dRhCM3jVe/WVn3ZFT7Mz5YXEmcBk5ZLsTfqQC4ew0pYuP1MVcn7pP9RxP0jxPyjMUlKTIquynYzfR/pINj5zEYLIxag6EUnBoWvCx6r2pYvYVLlE4dXp6No1IVCmuYwscFw6wgCtjmxtVFFUlg+RHKq3TRq5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JhU/z06X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB9EC433F1;
	Tue, 27 Feb 2024 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709025086;
	bh=LvEveEsH6bbba26NvLuV0QJ3q4+jYVJzVQUUtOm0ExM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JhU/z06XLIqF4qGy1MqmLgnzIRMUnbCgOHprstzxw5ImbkkxhLCp+3ihXG2oG/e/f
	 6jW7HTwneaeCwHW6+a9VRgCrdiaE+37wmhV1DM2A5LxAZsdvAjZ/3MmcXLfgucRKbG
	 FGqdrj3YFX8OhKHPy5PA8pKSrvl+0o5Glt7EEkwA=
Date: Tue, 27 Feb 2024 10:11:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
Subject: Re: [Regression] 5.4.269 fails =?utf-8?Q?t?=
 =?utf-8?Q?o_build_due_to_security=2Fapparmor=2Faf=5Funix=2Ec=3A583=3A17?=
 =?utf-8?Q?=3A_error=3A_too_few_arguments_to_function_=E2=80=98unix=5Fstat?=
 =?utf-8?B?ZV9sb2NrX25lc3RlZOKAmQ==?=
Message-ID: <2024022751-barmaid-existing-63d0@gregkh>
References: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
 <2024022453-showcase-antonym-f49b@gregkh>
 <fa878f45-3b59-40e5-b909-29dc0b1acd11@manjaro.org>
 <2024022728-gecko-vagrancy-c3f7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024022728-gecko-vagrancy-c3f7@gregkh>

On Tue, Feb 27, 2024 at 10:02:37AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 26, 2024 at 11:28:33AM +0700, Philip Müller wrote:
> > On 24/02/2024 16:11, Greg Kroah-Hartman wrote:
> > > 
> > > Odd line wrapping :(
> > > 
> > > Anyway, what config options are you using?  I can't see this here and
> > > none of the CI systems caught it either.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > The config should be this one:
> > 
> > https://gitlab.manjaro.org/packages/core/linux54/-/blob/cb28712a0dd32966c25b3d1463db29fec4c4157f/config
> 
> Ah, here's the config, let me go test...
> 
> 

This config builds just fine for me here.  Are you sure this isn't some
out-of-tree change you have in your tree?  I'm going to need more
information here as no one seems to be able to reproduce the issue...

thanks,

greg k-h

