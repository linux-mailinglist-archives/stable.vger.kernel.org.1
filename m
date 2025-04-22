Return-Path: <stable+bounces-135089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC5CA966E9
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE323AF1DE
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 11:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216A4277028;
	Tue, 22 Apr 2025 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0hh6OpJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41C8277016
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 11:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745319872; cv=none; b=LQTXSIPqfG+ILXgFQI6pFpBN9GUKN+9uKIYk3pJGZ/qX4cUhpU+rLQm7UIWhU/VP+tTGPsGNy9Gnxy9nIdelHtMTRTfYbbsbOWGXyAClgCAMluEBCbNaU7BK91DpZ3OmDjw7TibOFJOXmyZt4smyfpcmyIlP8Q3QyPpOki0/ORQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745319872; c=relaxed/simple;
	bh=H17sabuSu2ALywrqm5Be2Uu/rBONOqaOU+uo9WIORNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Og2m1NAR3xRyt9s+V5YaJTcF9pQtpRbEZyZM32+eF3Pdd1xOCOStTqGsbvLOEVHFnUdUqgHD7gn/KlRFVbt0OGKKew7zxIW0Pn4GtqN59lja8q8q4ao6Wjuom4VIn3NV5/2m+gz3kUk82U0lAHj7GbsA3x0YHgipG1Pmv6UL8ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0hh6OpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77436C4CEEA;
	Tue, 22 Apr 2025 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745319872;
	bh=H17sabuSu2ALywrqm5Be2Uu/rBONOqaOU+uo9WIORNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z0hh6OpJb1cuukLu8Eh2LxitNSh2P48z2mWAh3jnWqplZxSZnuIuua8Otijqc8u0w
	 0WLSgFlH3Agb9Ofya4ytY0m8BlWyjQSH5TDoE/yTSLEny2sugpEtUlnaLKrGqEGAaa
	 wt4tTRsfwDZU+gsLhoLfHylxbPA3RuI7SgpakLSs/3SvdbIaFaZn44K1sQoVepLIJ7
	 2zReYHht/lEZCVs63W9c4FgZuz4av1Z1MXXSMUMd41IZ1vCV20OaCQBzJ/YC97u/9p
	 Cl37T2it7eCdx/3W/brFTj1Wii1F60Qph5nsQ6IR9Zm2iULhzobHMagpCt2xx+djSX
	 TG1Fh1kWGXERw==
Date: Tue, 22 Apr 2025 16:25:34 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: stable@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Santosh Shukla <santosh.shukla@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: Re: Please apply commit d81cadbe1642 to 6.12 stable tree
Message-ID: <ht7jaoxtqi2njlb3blzgztmqukjbadkpt4cy2qxzgnqc26nbj2@2ja6ubtzaiip>
References: <j7wxayzatx6fwwavjhhvymg3wj5xpfy7xe7ewz3c2ij664w475@53i6qdqqgypy>
 <2025042207-bladder-preset-f0e8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025042207-bladder-preset-f0e8@gregkh>

On Tue, Apr 22, 2025 at 09:40:22AM +0200, Greg KH wrote:
> On Mon, Apr 21, 2025 at 11:00:39PM +0530, Naveen N Rao wrote:
> > Please apply commit d81cadbe1642 ("KVM: SVM: Disable AVIC on SNP-enabled 
> > system without HvInUseWrAllowed feature") to the stable v6.12 tree. This 
> > patch prevents a kernel BUG by disabling AVIC on systems without 
> > suitable support for AVIC to work when SEV-SNP support is enabled in the 
> > host.
> 
> We need an ack from the KVM maintainers before we can take this.

Sure. Adding Sean and Paolo.

Sean, Paolo,
Please let me know if you have concerns applying this change to v6.12 
stable series.

Thanks,
Naveen


