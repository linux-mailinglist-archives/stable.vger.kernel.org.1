Return-Path: <stable+bounces-55924-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DE091A042
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A5A1F22828
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254533F8E4;
	Thu, 27 Jun 2024 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BqpzFspb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5411BF3A
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 07:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472721; cv=none; b=GdwTJdmh+DtKkDg3hmli3boyVT/fFz8yp5VbC4QipjA1rSJarr6JzCky5fuUTOOnkzfayXyAxPvaY4gmqA0oUxbh3G8Y4yAJQp3F6fzS4225yqLClwfeuS0XdT3kD0EqPykidPdgw/Cf486oWnvHiLKn01V9d8wCH2uzJ3xNgG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472721; c=relaxed/simple;
	bh=v0kO8n0S9u+caj12j8j8Li0xb+2ikn8KuL6oRonDjmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUJ7kodYRrvtRaBszxbpyxqlo8FvGGx9qt76PPIAYLluOwPNJPFRXJklYGcOpIINpjiMTyXCNEYRJAhfyvw1kcVmXrZNZXJrqVTCl7b4GfTtH0ROB6LdgZrjgsnHXXDfxcv4hGyQN2tiyNSzXTngP+0cN1MExPjn6fiadAs03+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BqpzFspb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B37C2BBFC;
	Thu, 27 Jun 2024 07:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719472721;
	bh=v0kO8n0S9u+caj12j8j8Li0xb+2ikn8KuL6oRonDjmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqpzFspb7OjF6RckGLWGXBCcfPDNvZf0KA7lllacXYtlFiSXoKBCH9JJmfvH9mEuZ
	 7sk1U/mZexMGGvVfXrrlHQGoXzEAiGaef3URe1Wr1FodG2FhhAFLva6253Oak0ZQPr
	 m9+vE9+RNP69sYD9jywIA+j5jqsnXYTh5ynK6bRo=
Date: Thu, 27 Jun 2024 09:18:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: stable@vger.kernel.org
Subject: Re: Please backport 2ae5c9248e06 ("wifi: mac80211: Use flexible
 array in struct ieee80211_tim_ie")
Message-ID: <2024062745-erased-statue-0a01@gregkh>
References: <fc31dd6f-ec32-4911-921f-1f34e9ad2449@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc31dd6f-ec32-4911-921f-1f34e9ad2449@quicinc.com>

On Wed, Jun 26, 2024 at 11:32:22AM -0700, Jeff Johnson wrote:
> Refer to:
> https://lore.kernel.org/all/CAPh3n83zb1PwFBFijJKChBqY95zzpYh=2iPf8tmh=YTS6e3xPw@mail.gmail.com/

Please provide the information in the email, for those of us traveling
with store-and-forward email systems, links don't always work.

> Looks like this should be backported to all LTS kernels where FORTIFY_SOURCE
> is expected to be enabled.

And where would that exactly be?  Have you verified that it will apply
properly to those unnamed kernel trees?

thanks,

greg k-h

