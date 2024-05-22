Return-Path: <stable+bounces-45584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717238CC45A
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5372842B6
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC14D1CD35;
	Wed, 22 May 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFwkQSCa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE71422A3
	for <stable@vger.kernel.org>; Wed, 22 May 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716392769; cv=none; b=uRvQKmNzKqgqwdxwLyfVPTO2IMg8BsLQO+iJBHEC9j7BRPETmBjWSSOpX4w8dhWJrAIpgVde1H0HKHHna62f+efph+6u+xA0dy/x7btyTyhsfK7gtifImZ/0brcgRaUTg5sxCbI/A4F5pYk1iyCuvKt5PKkxkBKpf+Z9GINsslo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716392769; c=relaxed/simple;
	bh=mNziexDuiql6cOeih29cWtp8jAuJHeaqyoD2fJILgz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm9dwC7Oqcwb6V3UIoG8SpQBFC+rvuLetiIcltTVRhS3q8Ob6LYGDv6DXIrzaN4knbsRiMp4Ju+NOlZT1fCbnKtkEVIVE5HE5sZtja886xFaBFP1vjHbKPB1+EoqpSkgFV7iH+D4TF6B/dad1zPqEDrqiE2EQYnHL+PViE8i9wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFwkQSCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E28C2BBFC;
	Wed, 22 May 2024 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716392769;
	bh=mNziexDuiql6cOeih29cWtp8jAuJHeaqyoD2fJILgz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFwkQSCaHpWdI00qR4K4daK1/fXqadv/wJx1AyKzzOEhSvSLUFVxNMAOpN9rWtBkz
	 uS5v9LBw3TGZS7uVMFm5K75fxc4nnRdUyKKNH/YBXvH+bAGoJ5dW/1ipMvOYDCnBKk
	 h7x0/53oE0DbM6zzYNMF5B3LqqiMdUweaUP8XdWI=
Date: Wed, 22 May 2024 17:46:06 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: stable@vger.kernel.org
Subject: Re: Pickup commit "mfd: stpmic1: Fix swapped mask/unmask in irq
 chip" for stable kernel?
Message-ID: <2024052257-system-ellipse-5fdb@gregkh>
References: <12c88a9d-0357-48b8-8f85-6f74a9d83a7b@smile.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c88a9d-0357-48b8-8f85-6f74a9d83a7b@smile.fr>

On Thu, May 16, 2024 at 12:04:43PM +0200, Yoann Congal wrote:
> Hello,
> 
> Please pickup commit c79e387389d5add7cb967d2f7622c3bf5550927b ("mfd: stpmic1: Fix swapped mask/unmask in irq chip")
> for inclusion in stable kernel 6.1.y.
> 
> This fixes this warning at boot:
>   stpmic1 [...]: mask_base and unmask_base are inverted, please fix it
> 
> It also avoid to invert masks later in IRQ framework so regression risks should be minimal.

Now queued up, thanks.

greg k-h

