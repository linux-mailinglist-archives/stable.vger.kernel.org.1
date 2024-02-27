Return-Path: <stable+bounces-23858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88908868B80
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB9A6B2207B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD8134CD5;
	Tue, 27 Feb 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAZQ3oO1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979354BCB
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709024560; cv=none; b=o3wPCCAmlZnuI26YO4EhXA4hKtRKrHtSarSgdSC7JpJuVpMa0aS1rodF8iC5PSrN6BX0z0J+jmO3YEOL5dJy0pj8mj31m737YPQiiM9AJmI91INL/td1hcQGjwO3mkVDfTkqaK7kYwShDtOxkvwW2wyyxTfxXJQ5Kqm8Lm5/q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709024560; c=relaxed/simple;
	bh=G6ONL25hZVRVWAF5FLNG1O2VBGWUiYF4qSi2Ttyuc10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrJhSCqSI690ICuT5jf69+c4soQrvXPFcWnWRTl/q6qqK353tBGJHhhP/aDWRxw3+ebo9bSrJvO0DmlmKYa5Iy89sxqLWCc/fqF3Oe4bWxoU2g8dJVOat8TpSKXfyB+eVgZSQNAaFbxnWqDAmvr1P0R0frfVBcTkRXycVqMNl20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAZQ3oO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EE5C433F1;
	Tue, 27 Feb 2024 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709024560;
	bh=G6ONL25hZVRVWAF5FLNG1O2VBGWUiYF4qSi2Ttyuc10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAZQ3oO1z3A9JXfd5mJVO5YPNOXQUt+olZex0rm2tP+yPKl8zspBCidJL//oEKqFO
	 zJLhW63+hyRsTUf6UcM/saIjy+qKEhdYObk1Dzaujc4LZmsXL/y3Ps56kkdW37AIed
	 I9WTLCIZ3g3F56yD4BBKAl26dQ9+mLHjqFQ4GHb0=
Date: Tue, 27 Feb 2024 10:02:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
Subject: Re: [Regression] 5.4.269 fails =?utf-8?Q?t?=
 =?utf-8?Q?o_build_due_to_security=2Fapparmor=2Faf=5Funix=2Ec=3A583=3A17?=
 =?utf-8?Q?=3A_error=3A_too_few_arguments_to_function_=E2=80=98unix=5Fstat?=
 =?utf-8?B?ZV9sb2NrX25lc3RlZOKAmQ==?=
Message-ID: <2024022728-gecko-vagrancy-c3f7@gregkh>
References: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
 <2024022453-showcase-antonym-f49b@gregkh>
 <fa878f45-3b59-40e5-b909-29dc0b1acd11@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa878f45-3b59-40e5-b909-29dc0b1acd11@manjaro.org>

On Mon, Feb 26, 2024 at 11:28:33AM +0700, Philip Müller wrote:
> On 24/02/2024 16:11, Greg Kroah-Hartman wrote:
> > 
> > Odd line wrapping :(
> > 
> > Anyway, what config options are you using?  I can't see this here and
> > none of the CI systems caught it either.
> > 
> > thanks,
> > 
> > greg k-h
> 
> The config should be this one:
> 
> https://gitlab.manjaro.org/packages/core/linux54/-/blob/cb28712a0dd32966c25b3d1463db29fec4c4157f/config

Ah, here's the config, let me go test...


