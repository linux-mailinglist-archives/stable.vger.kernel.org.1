Return-Path: <stable+bounces-74062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD57971FCF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5D4284A5C
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B017916726E;
	Mon,  9 Sep 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ELZAGKBH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD618C31
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 17:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901317; cv=none; b=JOmv95clf5eusDycriZ4ChPUpn06D6Mr2oP7Yb3WbCQrZ8sNCH27AEDpt8UAzrapEeDnqKAfcv2SR7SAEpnQFwI1y8qiAE1rhB9xt9WKu4XgADc+aYjONBx8UHjDUbay9JzhaEijSTr7K1+LAPZ8h3NcqlSZ6J05+zoy965fAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901317; c=relaxed/simple;
	bh=TtrubgYAh2uiPCmQichRID5EQ2w8DsQw8PwCPVS21rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+bcDX9BbnYrSTVPvfJ09HegfUz0hG5a6+lbcFDFW3Lw14jDeygmYVgSkuiDUQ+TKiZR3uIe8mSHWu7HrJgGpo7K5sMl2Hzn1UNfOs7N222akljBiB6auyXXgZB2/GHz7sQBD5HTLO3S7Xliox6Fop4JPi9at/XEhrFJSva5wpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ELZAGKBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8622EC4CEC5;
	Mon,  9 Sep 2024 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725901316;
	bh=TtrubgYAh2uiPCmQichRID5EQ2w8DsQw8PwCPVS21rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELZAGKBHDdaiu174+GJf4UFaVaZHgcbKXKH2Dwb8ZPOFo/pt3bbHFFyT5lKEhAjAG
	 HRqE3EzlM4v8oRixXo2sO2B2AqrUtLGrIXViBvbKqryC2mZCbN6rKHd3jb/h86isAD
	 7u5jF5Mb95P70b5W0IudkjPnQX/vttdnjN4x7Ptw=
Date: Mon, 9 Sep 2024 19:01:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Dumazet <edumazet@google.com>
Cc: fw@strlen.de, kuba@kernel.org, syzkaller@googlegroups.com,
	tom@herbertland.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ila: call nf_unregister_net_hooks()
 sooner" failed to apply to 4.19-stable tree
Message-ID: <2024090940-singer-sterility-f1dc@gregkh>
References: <2024090859-daffodil-skillful-c1e1@gregkh>
 <CANn89iJU9jPB+G5ETqwcEKcrRFt5ONVGF7=TsLnA21FUKT3+Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJU9jPB+G5ETqwcEKcrRFt5ONVGF7=TsLnA21FUKT3+Rg@mail.gmail.com>

On Mon, Sep 09, 2024 at 09:59:49AM +0200, Eric Dumazet wrote:
> On Sun, Sep 8, 2024 at 2:51 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 4.19-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 031ae72825cef43e4650140b800ad58bf7a6a466
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090859-daffodil-skillful-c1e1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
> >
> > Possible dependencies:
> >
> > 031ae72825ce ("ila: call nf_unregister_net_hooks() sooner")
> >
> > thanks,
> >
> > greg k-h
> 
> Hi Greg, I think you can cherry-pick this patch from linux-5.3 era,
> adding the pre_exit() method
> 
> commit d7d99872c144a2c2f5d9c9d83627fa833836cba5
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Jun 18 11:08:59 2019 -0700
> 
>     netns: add pre_exit method to struct pernet_operations
> 
> Then cherry-picking 031ae72825cef43e4650140b800ad58bf7a6a466 will work
> just fine.

That worked, thanks!

greg k-h

