Return-Path: <stable+bounces-62726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE26940E0C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD1A1C237C4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C6195399;
	Tue, 30 Jul 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nLzck+ac"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921D81922C1;
	Tue, 30 Jul 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332500; cv=none; b=ZoLkVlY0OyHSeJNqCyycFx0Pm3YUGBJW97ftS5jYueariSnOGTdK+siNrvSwB8PP813PcPaMDJJ2YyVSPoddWe7eYLRsGltLGiDH7c8EcVw8IBsJjGYSNggeQ+CKc2cao75fp5zkw/4dDflfLLJ4uT+osncgDYhJ21AJgqgOQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332500; c=relaxed/simple;
	bh=2yuGekJQ/Y+uA5xgtgscCFoQwwD/LOARaWhNxdcLHXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aP2zGi1jTVfziYOXaqWAirHRqL8rfh70PgM75A4HPytuCQkpjJ/KHFLf8rd3DCMXYgqQqpttqa5UCX+8JKqzn1aJmMEW9qrDcwGZefpb7cuCNEz2dOW2hQVOaJTt4HRJE0etDNaPJFzLbS7KB01icn4UxKkixl7T269HUz1H00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nLzck+ac; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E34C32782;
	Tue, 30 Jul 2024 09:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722332500;
	bh=2yuGekJQ/Y+uA5xgtgscCFoQwwD/LOARaWhNxdcLHXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLzck+acBZIt3h7y50GR0LEqjvXhy4m6AoFkHy6opx8sCNQ6B2gBe3+UclyiUkL2T
	 aQFeO5r0NomidZUC7keW/LtQoG8sN04tjuGUwyRPcqb/WKhvHO0uF6JX3m7K7RtuIB
	 jmivZ43N6R9TtgYFEP705TLG14A+06bn61OQrS44=
Date: Tue, 30 Jul 2024 11:41:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: wujing <realwujing@qq.com>
Cc: dongml2@chinatelecom.cn, linux-kernel@vger.kernel.org,
	menglong8.dong@gmail.com, mingo@redhat.com, peterz@infradead.org,
	stable@vger.kernel.org, yuanql9@chinatelecom.cn
Subject: Re: Re: Re: [PATCH] sched/fair: Correct CPU selection from isolated
 domain
Message-ID: <2024073055-abruptly-safeness-665e@gregkh>
References: <2024073032-ferret-obtrusive-3ce4@gregkh>
 <tencent_CFCCB84E378797D6279497D81F9FA5530607@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_CFCCB84E378797D6279497D81F9FA5530607@qq.com>

On Tue, Jul 30, 2024 at 05:30:40PM +0800, wujing wrote:
> > What "current patch"?
> >
> > confused,
> >
> > greg k-h
> 
> ```bash
> git remote -v
> stable  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (fetch)
> stable  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git (push)
> ```
> 
> ```bash
> git branch
> *master
> ```
> 
> In the git repository information provided above, 8aeaffef8c6e is one of the
> output items from the command `git log -S 'cpumask_test_cpu(cpu, \
> sched_domain_span(sd))' --oneline kernel/sched/fair.c`.
> 

Ok, but I do not understand what you are asking me to do here.  You have
read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to ask for a commit to be applied to a stable tree, right?

thanks,

greg k-h

