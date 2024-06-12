Return-Path: <stable+bounces-50247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6CE9052AA
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A782B2355A
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4D817083B;
	Wed, 12 Jun 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkE2qfFg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A016F8F6;
	Wed, 12 Jun 2024 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196043; cv=none; b=DIaQn/qESKMbKV0liWXAnymHzq9PWRPE4Di+HlnyqQDCo2GLOJbxklI2AEcDlxc18bkadDeujD6nNw7stM8DIQlfFzfYU61ykrjp0g0rzzJTcs69SwYIolPiDIudDqYyYKdlQDOPK1LALdT+q7vs+LMILJZwbbiMQLSHz1HSafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196043; c=relaxed/simple;
	bh=TP1yu/xhwamcN+t7ECjqu+OZDTu63d5HCrwm5Ai7cK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfniWUHUlHEHnDr+NGX21jdtPaHGrccEagOsxjjn59MJZLfM9B4ncPrfPSo0z5otg/ZXKlCeMu0CtKr8wq77VmMA7GaB8WboNEmtXJeUuIrkV1CvVJCSkxdm3SBn1zbBatqmiuu5HFZBlUs1MY5Qc/yT/DaiXef266FBweWvQ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkE2qfFg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE97C3277B;
	Wed, 12 Jun 2024 12:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196042;
	bh=TP1yu/xhwamcN+t7ECjqu+OZDTu63d5HCrwm5Ai7cK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RkE2qfFggW1XRs257HkqgXylqf83UoiftQnLbDGlSCAkxNU9kwHrgjcsVXfkfpNhY
	 4G5m9xCzj5YonKpiBTnw5mghT5GAjV78i11ayAgKu546wEncagX7WQyGkxmlZ/jT87
	 hebzuKhFc4K0GS1vjbseJySoPkQFpYgFgCxcMEoo=
Date: Wed, 12 Jun 2024 14:40:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: Patch "platform/x86: xiaomi-wmi: Fix race condition when
 reporting key events" has been added to the 6.6-stable tree
Message-ID: <2024061223-deceiver-other-dc06@gregkh>
References: <20240526194314.3503546-1-sashal@kernel.org>
 <d691d3c3-1cb7-44c1-85f0-ecc3c74e966f@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d691d3c3-1cb7-44c1-85f0-ecc3c74e966f@gmx.de>

On Mon, May 27, 2024 at 12:59:49AM +0200, Armin Wolf wrote:
> Am 26.05.24 um 21:43 schrieb Sasha Levin:
> 
> > This is a note to let you know that I've just added the patch titled
> > 
> >      platform/x86: xiaomi-wmi: Fix race condition when reporting key events
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       platform-x86-xiaomi-wmi-fix-race-condition-when-repo.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> Hi,
> 
> the underlying race condition can only be triggered since
> commit e2ffcda16290 ("ACPI: OSL: Allow Notify () handlers to run on all CPUs"), which
> afaik was introduced with kernel 6.8.
> 
> Because of this, i do not think that we have to backport this commit to kernels before 6.8.

Thanks for looking into this and letting us know!

greg k-h

