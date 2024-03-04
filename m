Return-Path: <stable+bounces-25878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD08286FF16
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA8AE1C20E2F
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1832AEFF;
	Mon,  4 Mar 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="InxgcuYA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF62AC29
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548328; cv=none; b=I9f4kHfDmJduJIEsrvpKh5PamEeI0qj14C8GpmvKaVjD4jMTyW3JNBVfWiG4I9hEFa0Sjr6vCHDmmcyq9IDZNPuH3Rzj8AanXq9WW4FXaojw0xyRh1DFw/MTQbr3eG6Kqq1h0TnXAhBYUgmp2C4fUATmwIFIt4+COPmzwkYuD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548328; c=relaxed/simple;
	bh=bNMod/MjVeFoLdIYhkyYS3HpuQmoikxAEEVrP4bsRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ej2uAMGlHJMNhjGnlKvlE92VaSEO8bQA0UYf5ozM9Nq/r6mhHPe6Q3z5gbdPgM+pdoD8R+J3QOGqStYoK9r00b3vYkj/Zag9raEIxW4SxJK0SA5i2a2zKWiHJLWquNg8uzKEqoWBmnOm1ZE7L821f7uRx012HzMokbW26EVHOpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InxgcuYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CE0C433F1;
	Mon,  4 Mar 2024 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709548327;
	bh=bNMod/MjVeFoLdIYhkyYS3HpuQmoikxAEEVrP4bsRfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InxgcuYAgsvlrQ6ZZ/8wDquCN5x2QW/ut7f+ZkCAid/Z8T/g5mEyx+ZjLDh2PygWJ
	 SD/7kvwwAnwm03V4Fz5e+zO3TuHuBx80u6UGXIj7BvrKGjvCOKlJ/hVOLXFw52yXYT
	 xZ2+0TWPivbDks6CZcjwaqumP/QsCOWfxtiHMdg8=
Date: Mon, 4 Mar 2024 11:32:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: tanggeliang@kylinos.cn, kuba@kernel.org, martineau@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] selftests: mptcp: rm subflow with
 v4/v4mapped addr" failed to apply to 6.1-stable tree
Message-ID: <2024030430-pessimism-unveiling-715f@gregkh>
References: <2024030422-dinner-rotten-5ef3@gregkh>
 <0991a6b7-2d74-4f26-9959-68d745086902@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0991a6b7-2d74-4f26-9959-68d745086902@kernel.org>

On Mon, Mar 04, 2024 at 11:07:01AM +0100, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 04/03/2024 09:30, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.1-stable tree.
> 
> Thank you for the notification!
> 
> (...)
> 
> > Possible dependencies:
> > 
> > 7092dbee2328 ("selftests: mptcp: rm subflow with v4/v4mapped addr")
> > b850f2c7dd85 ("selftests: mptcp: add mptcp_lib_is_v6")
> > bdbef0a6ff10 ("selftests: mptcp: add mptcp_lib_kill_wait")
> > 757c828ce949 ("selftests: mptcp: update userspace pm test helpers")
> > 80775412882e ("selftests: mptcp: add chk_subflows_total helper")
> > 06848c0f341e ("selftests: mptcp: add evts_get_info helper")
> > 9168ea02b898 ("selftests: mptcp: fix wait_rm_addr/sf parameters")
> > f4a75e9d1100 ("selftests: mptcp: run userspace pm tests slower")
> > 03668c65d153 ("selftests: mptcp: join: rework detailed report")
> > 9e86a297796b ("selftests: mptcp: sockopt: format subtests results in TAP")
> > 7f117cd37c61 ("selftests: mptcp: join: format subtests results in TAP")
> > c4192967e62f ("selftests: mptcp: lib: format subtests results in TAP")
> > e198ad759273 ("selftests: mptcp: userspace_pm: uniform results printing")
> > 8320b1387a15 ("selftests: mptcp: userspace_pm: fix shellcheck warnings")
> > e141c1e8e4c1 ("selftests: mptcp: userspace pm: don't stop if error")
> > e571fb09c893 ("selftests: mptcp: add speed env var")
> > 4aadde088a58 ("selftests: mptcp: add fullmesh env var")
> > 080b7f5733fd ("selftests: mptcp: add fastclose env var")
> > 662aa22d7dcd ("selftests: mptcp: set all env vars as local ones")
> > 966c6c3adfb1 ("selftests: mptcp: userspace_pm: report errors with 'remove' tests")
> 
> (...)
> 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From 7092dbee23282b6fcf1313fc64e2b92649ee16e8 Mon Sep 17 00:00:00 2001
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > Date: Fri, 23 Feb 2024 17:14:12 +0100
> > Subject: [PATCH] selftests: mptcp: rm subflow with v4/v4mapped addr
> > 
> > Now both a v4 address and a v4-mapped address are supported when
> > destroying a userspace pm subflow, this patch adds a second subflow
> > to "userspace pm add & remove address" test, and two subflows could
> > be removed two different ways, one with the v4mapped and one with v4.
> I don't think it is worth having this patch backported to v6.1: there
> are a lot of conflicts because this patch depends on many others. Also,
> many CIs validating stable trees will use the selftests from the last
> stable version, I suppose. So this new test will be validated on older
> versions.
> 
> For v6.6 and v6.7, I can help to fix conflicts. I will just wait for the
> "queue/6.6" and "queue/6.7" branches to be updated with the latest
> patches :)

Should all now be up to date, I don't see any pending mptcp patches in
my review mbox to process.

thanks,

greg k-h

