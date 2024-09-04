Return-Path: <stable+bounces-72998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D9F96B875
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 12:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A079283AB5
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4701CF5E0;
	Wed,  4 Sep 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Re7RN21V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D211CF285
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 10:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445617; cv=none; b=CsS9yNJqccrFpqlosh+2HPK+Ik76cVekSVDCj3gGr3YXxOOrnk0NeLsmzbVYXKFauv+25fTztiLozQquA4SbGMLTmso1F0GfY2r7yczX0tMYTcjeC7qAWKaam0xuDD/jTFp2KHzr8Qg9ckhtAnp3Eewda1r2I01tdKT+I5+GVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445617; c=relaxed/simple;
	bh=bQJ9op+hLchEjpljJs38I2S7x3RtwUsE4Hu2gQDMnSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnRMcQttzpkoED6UXdsTCCDvRGAVsmpqS/Wa4ek1PzjTF71zDh+y2StAa9MuYiwewlp0qUc2YRqObqCyJ2kV9mDkGe/xJxp1tbTbYIPE2Tj8Teh3TeMXFamsFyypPfI73d/23fEJYhRALX7gh1m3501r5mb6CE/uiNMNJRtvuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Re7RN21V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18396C4CEC2;
	Wed,  4 Sep 2024 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725445617;
	bh=bQJ9op+hLchEjpljJs38I2S7x3RtwUsE4Hu2gQDMnSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Re7RN21VKpNzfg2IjsZWRmj1n/WAXTktkWy9ql4oSc57cpaZNf5Gme0QBooxxG0wv
	 +pCkaNSnpF9S0L8Ncv1gaeRDzTC/p+HMkm6hAh8T2pIgqxXHVA/Q4L4V0BcsTo9jNi
	 WAQBe/ZMqeYxFDJdzdXldBqQpT5iLDmqwywK+kxc=
Date: Wed, 4 Sep 2024 12:26:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: sashal@kernel.org, dvyukov@google.com, stable@vger.kernel.org,
	syzkaller@googlegroups.com
Subject: Re: Missing fix backports detected by syzbot
Message-ID: <2024090428-exception-animation-aacc@gregkh>
References: <20240904102455.911642-1-nogikh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904102455.911642-1-nogikh@google.com>

On Wed, Sep 04, 2024 at 12:24:55PM +0200, Aleksandr Nogikh wrote:
> There are also a lot of syzbot-detected fix commits that did not apply
> cleanly, but the conflicts seem to be quite straightforward to resolve
> manually. Could you please share what the current process is with
> respect to such fix patches? For example, are you sending emails
> asking developers to adjust the non-applied patch (if they want), or
> is it the other way around -- you expect the authors to be proactive
> and send the adjusted patch versions themselves?

We expect someone to send us patches, we aren't going to be able to do
it ourselves :)

thanks,

greg k-h

