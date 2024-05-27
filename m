Return-Path: <stable+bounces-46572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A28D09C0
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5711C22063
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084A15F3EA;
	Mon, 27 May 2024 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m1pDgXnH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F501DDC9
	for <stable@vger.kernel.org>; Mon, 27 May 2024 18:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716833437; cv=none; b=IXWbktxGf05c/3HVgiVCw+OPQC5fJbghrpUsbmAeKSZubHWOzVw0JgdJOTCoZmhnCzPVHY5MPBdmp+YBY6STxd5E93P2zIXhHx51zgztTrrpI69kTAjkARnWE4izMQQXw1L3G9Yb1HBiv60gFdBB/0ckYO3h6wX0czxRyvE0CWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716833437; c=relaxed/simple;
	bh=EhCesqVbiIpD/xKZsyEp0/vuCEMlYSLBpSp9milgZOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if+sPanQBglyH/HcaDYs2+RUybYGYDFrDIGcIW1awOI55YxoxIck/Oelnzos5W3uBKR0WHUi+aqEo9o3DNB8LwkqhGmse4BJkJ7oxk2Z1udmhsrIgrl4Ibd8wEoh5pbn6gdrNQkvQ+KxYO/yulYh427ZJBB68uL+nFadKvJ/Em8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m1pDgXnH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7533C2BBFC;
	Mon, 27 May 2024 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716833436;
	bh=EhCesqVbiIpD/xKZsyEp0/vuCEMlYSLBpSp9milgZOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m1pDgXnHu35nmvSHfA/OddTQN7KXTFoE3F4qvH45YuINzY/qwxWTElPj5rmRL2mCP
	 q55iNrQKbRwdmfU5ue1juCbKBALJCnEie6F1wi+4VgeJx/Qzp8GMVxeNutEAFbO9sA
	 kPtk1hDX0+FP6WVh0Q85Q00G0e6RGFhuhof73oIw=
Date: Mon, 27 May 2024 20:10:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: stable@vger.kernel.org
Subject: Re: x86/tsc: Trust initial offset in architectural TSC-adjust MSRs
Message-ID: <2024052729-anthology-graves-7533@gregkh>
References: <CAMVG2sv-ZR5UET0wDQM_FvNsARSgrtPsyn+PBzX-U91ainV7nQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMVG2sv-ZR5UET0wDQM_FvNsARSgrtPsyn+PBzX-U91ainV7nQ@mail.gmail.com>

On Mon, May 27, 2024 at 07:11:00PM +0800, Daniel J Blueman wrote:
> On present kernels, HPET fallback occurs on some 8-16 socket x86
> systems due to the TSC adjust architectural MSR not being respected.
> 
> This was fixed upstream in commit 455f9075f14484f358b3c1d6845b4a438de198a7.
> 
> Please backport this fix to -stable for 6.9, 6.8, 6.6, 6.1, 5.15,
> 5.10, 5.4 and 4.19 branches to allow correct TSC operation on existing
> distros using these kernels. The patch cleanly applies to all of these
> latest -stable branches.

Now queued up, thanks.

greg k-h

