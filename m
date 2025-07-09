Return-Path: <stable+bounces-161442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF69AFE9B0
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 15:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FE1882255
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3332DBF75;
	Wed,  9 Jul 2025 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2anEjFma"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2B35962;
	Wed,  9 Jul 2025 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066547; cv=none; b=d2m1rVGSucSBMf7JEipYV7btVBzF6Q6ZtuLPA9XEC6jeVsbyZEXb01wa5h/qw5XfoAD8gDPSGHPtYK8WaF4jB8Z8MBNgQ0C7YxNIxugLuBX/EUCzdOdwq/U3Do0/anA34oRzB9qzGrlB0xIZJ6XtE784Oig5xCc4CqIElqc7Ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066547; c=relaxed/simple;
	bh=VcrkJOKYoElm5nSFyr9BCkbo0248Iv7a8XslVXTjpGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7IlOK9DaFQrT9kloUQWkmvRyeW/H93W4iVaNg7UH3fqUMf7ZlpbThyK+FQTWZsoHRB1uqRUMvWxEmL3pisJgzn3+ol++GWZVowQkmpQeqRwxhWOaKaTl+Hv2VXG4qp2Af6zCv3F8xjepENyespY8sdfSS2IPeZXkjy2luIxbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2anEjFma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D866FC4CEEF;
	Wed,  9 Jul 2025 13:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752066547;
	bh=VcrkJOKYoElm5nSFyr9BCkbo0248Iv7a8XslVXTjpGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2anEjFma8mkOp6nuQ/BwKsM15221uj4AMc+XSM9BpqfmCkA/dbpbmDHwFXp5eEMwT
	 87dvIqBHl9GEc9WdPQppDPrlUTdefs979mV3TeS3W7eFLW4fq/rSrNkyP9UOXDguha
	 sHoBzDKA+N7oOh5jQTwkUI5kWO8H43qjX8aMWny4=
Date: Wed, 9 Jul 2025 15:09:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christopher Turcotte <clturcotte@proton.me>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"alexey.makhalova@broadcom.com" <alexey.makhalova@broadcom.com>,
	"ajay.kaher@broadcom.com" <ajay.kaher@broadcom.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: VMware Workstation Pro w/ recent Kernel-6.15.4
Message-ID: <2025070938-abiding-speller-23be@gregkh>
References: <4baJtp-j_IHshbbcugGEFuYVWNnoYMQ_-KELjaMMYPw1XwqyMJgfW4tO-hj1UhMId4hypNTOZrucUaOGx4qb3E-fIvhqS289kwlu_LR9nH0=@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4baJtp-j_IHshbbcugGEFuYVWNnoYMQ_-KELjaMMYPw1XwqyMJgfW4tO-hj1UhMId4hypNTOZrucUaOGx4qb3E-fIvhqS289kwlu_LR9nH0=@proton.me>

On Wed, Jul 09, 2025 at 12:42:02PM +0000, Christopher Turcotte wrote:
> Good morning
> 
> I'm hoping for a resolution to an issue I'm currently having with the latest kernel release and Workstation Pro (Free Edition). Every time I try to open Workstation, it's prompting me to reinstall modules that ultimately fail (see screenshots). Also see the attached log file. After doing some research, I see the issue is that several header files are missing. I've tried to manually compile and install original modules, but with no success. I'm still faced with an incompatibility issue and the latest kernel. This problem does not occur when I switch back to kernel 6.14.

As you are using external modules, please contact the authors of them as
there's nothing we can do here about them, sorry.

greg k-h

