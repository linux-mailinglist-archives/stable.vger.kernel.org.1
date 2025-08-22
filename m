Return-Path: <stable+bounces-172388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50094B31907
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 15:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920161892822
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF02FDC27;
	Fri, 22 Aug 2025 13:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="esmGT7gR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C912F99AE;
	Fri, 22 Aug 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755868496; cv=none; b=d9wMseXWkld5xZEdycd8JXLVh7Fp24rc3tFqsz0QUMaUAKXQnbUCPCF+pBE5/NHNnc2nAF5lq9YQnoINRgdi17D/alJoDNVEQFmWDlSJDDw5ANlE0pPNdn3jwvsZuGEOPzIFBc/5MUQxUGGTIuxmnHradf+4Sl6yGmO8re7V34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755868496; c=relaxed/simple;
	bh=OSk0FlS7YPnOOnzpzVwZCD1eeI9gpLGRPubVS8YyYbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWpheVMeZjaQoerV+MWnMN6rX9j8KNVi3xyTjuVNO8C1rYO9DQd6HDsvOYvPdTZJ21igG3Mj/dtLHOeCX+FTJjJ5X/CVAasgLLaBByBFdOIUpQHRvkVO+BS2XKe0ucgngy0ZhIc4Nu3BeP9CXRVmsdFbmMhNLlqiixzKfbLNL+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=esmGT7gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29184C4CEED;
	Fri, 22 Aug 2025 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755868495;
	bh=OSk0FlS7YPnOOnzpzVwZCD1eeI9gpLGRPubVS8YyYbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esmGT7gRWZUly6hrk5d6hsCjDFJF8TWRjOdSLvm9qBsBfXvS8WH4R0m4zzr17vSzz
	 S7SnXrKnIpQuQ2/0paSi3RqhxHQAFOK32KTTNYkhpoB3hpJeM4DIBfH7Odan+GoTC6
	 +BQkDtMe5Nq2Wt7+sjophwWL0aPJDnM48jH8Y0Kc=
Date: Fri, 22 Aug 2025 15:14:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: stable@vger.kernel.org, Lion Ackermann <nnamrec@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Subject: Re: stable 5.15 backport: sch_*: make *_qlen_notify() idempotent
Message-ID: <2025082202-albatross-atlas-b4c2@gregkh>
References: <87960e35-5b7b-4b7e-9bba-50db6292cd5b@hauke-m.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87960e35-5b7b-4b7e-9bba-50db6292cd5b@hauke-m.de>

On Thu, Aug 07, 2025 at 07:44:29PM +0200, Hauke Mehrtens wrote:
> Hi,
> 
> Kernel 5.15.189 is showing a warning caused by:
> commit e269f29e9395527bc00c213c6b15da04ebb35070
> Author: Lion Ackermann <nnamrec@gmail.com>
> Date:   Mon Jun 30 15:27:30 2025 +0200
>      net/sched: Always pass notifications when child class becomes empty
>      [ Upstream commit 103406b38c600fec1fe375a77b27d87e314aea09 ]
> 
> See here for details: https://www.spinics.net/lists/netdev/msg1113109.html
> 
> To fix this please backport the following 4 commits to 5.15 stable:
> 
> commit 5ba8b837b522d7051ef81bacf3d95383ff8edce5
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Thu Apr 3 14:10:23 2025 -0700
> 
>     sch_htb: make htb_qlen_notify() idempotent

Now applied.

> commit df008598b3a00be02a8051fde89ca0fbc416bd55
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Thu Apr 3 14:10:24 2025 -0700
> 
>     sch_drr: make drr_qlen_notify() idempotent

Does not apply, please provide a working backport.

> commit 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Thu Apr 3 14:10:25 2025 -0700
> 
>     sch_hfsc: make hfsc_qlen_notify() idempotent

Now applied

> commit 55f9eca4bfe30a15d8656f915922e8c98b7f0728
> Author: Cong Wang <xiyou.wangcong@gmail.com>
> Date:   Thu Apr 3 14:10:26 2025 -0700
> 
>     sch_qfq: make qfq_qlen_notify() idempotent

Now applied, thanks.

greg k-h

