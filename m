Return-Path: <stable+bounces-36396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0DE89BD7C
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 12:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D86F1F21209
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA435FB8C;
	Mon,  8 Apr 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zClRFTug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7D75FB84
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573288; cv=none; b=F0KuJIZnluhXGRzkkFsYVi7156ertwEC7Ot+ItIU0TQ+dsrx7zcPVjyUiKylOPkDk49sKcZw4gSsb9Z6jP6i89eWOuKZBcGj3saLr/12UEzWDOh3Qv+WHjGm85bqEy0tSXZ+FoMZJyIryWydlotPh7nktS+zWe4VhZ58ICiAQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573288; c=relaxed/simple;
	bh=zVJi4udRvgSDH5N1T+ho6dW6nFrhAcfHhfMhhZSyhwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z70wF8KsQiqhXecqJxd3CUzL+vEP8l1NvVhEZhImylnfhzvcD+HN+Gdc3ncIgxymFW4dlaUQYaY4tJrgxhW0P53NxKi7jdpa3T5kK60z/znlgpChkwpvNxSH7C03rImlBX27SO9tY5wtOvdcHmdSGNblLnbDpTvTGdme2We/D3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zClRFTug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83170C433C7;
	Mon,  8 Apr 2024 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712573288;
	bh=zVJi4udRvgSDH5N1T+ho6dW6nFrhAcfHhfMhhZSyhwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zClRFTugzO+PD7d+70eNwSj15w5sReLIY5/tgArLuTkGWHkaEdERjPpEbmnjpINFe
	 1Ho1OK/p6xkp4vY8SiD8hJ2MZSUu0bMDGbmeQsLfXZZD5aG67Xpe9JI9NxzQT8QW5K
	 zz6rLbRdzN633ROswM+KCKEVAOjaI8ieTyd5ARgo=
Date: Mon, 8 Apr 2024 12:48:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: mingo@kernel.org, torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/bugs: Fix the SRSO mitigation on Zen3/4
Message-ID: <2024040850-vibes-bartender-e21a@gregkh>
References: <2024033031-efficient-gallows-6872@gregkh>
 <20240405140432.GAZhAE8CuUO6vwOyKK@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405140432.GAZhAE8CuUO6vwOyKK@fat_crate.local>

On Fri, Apr 05, 2024 at 04:04:32PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Thu, 28 Mar 2024 13:59:05 +0100
> 
> Commit 4535e1a4174c4111d92c5a9a21e542d232e0fcaa upstream.

All backports now queued up, thanks.

greg k-h

