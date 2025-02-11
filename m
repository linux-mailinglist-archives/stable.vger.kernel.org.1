Return-Path: <stable+bounces-114896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F6EA30889
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 11:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9874166011
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414561E5726;
	Tue, 11 Feb 2025 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jo1gmz7N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181926BD90
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269874; cv=none; b=j2NTEYd1hkFWhusMLVcQAHDa1vzLoAmxhejuAjMPzM5IrlVuLjGd/IIic0FUTdhncZDQqRh4M8ix8z7Vv15OegV/jN7TqVhXiQNX5Q5y8hz34JQQ13pjEVsfJlewKIcuxZLQvR05lDKCdXK2Mtel39De5ZqnsuuN/brUWrWs+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269874; c=relaxed/simple;
	bh=p43jDVHPfK3AmV5wkXvS9uiS50f20nSrbzGEIrouWdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meZmjVrIgX6zJ56kt9ku+5qEEU9lMAWsT36VjJQZfuZXfs+HZ3/olOyhIzH1ltEuuda7L+g34FjTJZjTfAhjIeMlsMj6zzcG+DAWkYT5H/XBocg7K6Wfo+SdKgsZH51iGqC6ljuMh5m7XIf+0pbE6DQ6aRIFt3frE5BTmW9iwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jo1gmz7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ACAC4CEDD;
	Tue, 11 Feb 2025 10:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739269873;
	bh=p43jDVHPfK3AmV5wkXvS9uiS50f20nSrbzGEIrouWdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jo1gmz7NZpkUTE9TMBmPRY4YZtEnw1m5nMf19D8kjkSbI4NGmbTPCo8hSJlsW8dgX
	 AXdujMiymUb3TyMF4IIKTacFHczOP2ggsm4xdpEX/wJlPaA8x6ba4IBcXgO8fjL7pV
	 ujy2uSEgpy5U5h34HN/2Rb6dmiDtcWzeo7cwTM1Q=
Date: Tue, 11 Feb 2025 11:31:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Cc: umesh.nerlige.ramappa@intel.com, jonathan.cavitt@intel.com,
	matthew.brost@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] xe/oa: Fix query mode of operation for
 OAR/OAC" failed to apply to 6.12-stable tree
Message-ID: <2025021105-superman-glory-06e3@gregkh>
References: <2025021013-cavalry-unsightly-0671@gregkh>
 <85jz9x3413.wl-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85jz9x3413.wl-ashutosh.dixit@intel.com>

On Mon, Feb 10, 2025 at 01:04:24PM -0800, Dixit, Ashutosh wrote:
> On Mon, 10 Feb 2025 05:02:13 -0800, <gregkh@linuxfoundation.org> wrote:
> >
> 
> Hi Greg,
> 
> >
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 55039832f98c7e05f1cf9e0d8c12b2490abd0f16
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021013-cavalry-unsightly-0671@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> >
> > Possible dependencies:
> 
> We had submitted a modified version of the patch, adapted for 6.12 here:
> 
> https://lore.kernel.org/stable/20250110205341.199539-1-umesh.nerlige.ramappa@intel.com/

As it came in before this hit Linus's tree, (remember, you referenced a
commit that was in 6.14-rc1 here, which is NOT what I think you wanted,
right?), it was dropped.

> Please take this patch for 6.12.

Can you please resend this?  It's long gone from my mboxes.

thanks,

greg k-h

