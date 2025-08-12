Return-Path: <stable+bounces-167151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5FB22638
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C900B16EA49
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5792EE617;
	Tue, 12 Aug 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mM4jYoBT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D132E62D8;
	Tue, 12 Aug 2025 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999941; cv=none; b=q/w+d0Ib8ITGlsXNlzVcZCGWU5nDrdwN+VkDxObQtZr8zcY9/cmOIweDNmcg4mGhGlrhFx31rTlxrnQKFUFQbabqz5FdlSp2RwxeWRvKhCJqt3Fyhhr6BMiA3L+InELol27TXlxYoI51KqOYGHONN6HQor2PSpntDbOvXqEEjss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999941; c=relaxed/simple;
	bh=bFoQNPp4DCiblcqpjyNN3DM8ukhyKEZROnXDYuNO008=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nli+kb0uWln3S/DUJjiVVK6w+ZH8TBJGMQ8zfeE9LJczfUjYFI7Q/ZjQjGNK/4o/GAm4UuHsgwZq2Rvt+KAyNBZx37PpVA2gwVfGqxIuRM4JESaXQHdjDRlso5CeSTRZnV4WVgXsfj5vSTsvKoUPQuszNRfoSeJ6mCH2YDQ2d3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mM4jYoBT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F615C4CEF0;
	Tue, 12 Aug 2025 11:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754999940;
	bh=bFoQNPp4DCiblcqpjyNN3DM8ukhyKEZROnXDYuNO008=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mM4jYoBTLqkkfob6mMWgaOCMPw13PV1XAoIseHAV0UNIFP2KSnMzdLw6dBbjxx/mx
	 HXP6zRmPnPr6VbAOAHOoH21JM5DPeTdrMff4Bc8DwLvhqFc0HATKQ8vawbc+urrUN9
	 B1b64ghU6F3SOoMK9Bw9Iwf7yU6DD33v3OzDCKBc=
Date: Tue, 12 Aug 2025 13:58:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srinivasa Srikanth Podila <srinivasa-srikanth.podila@broadcom.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	vannapurve@google.com, Mukul Sinha <mukul.sinha@broadcom.com>,
	Ramana Reddy <ramana.reddy@broadcom.com>
Subject: Re: Regarding linux kernel commit
 805e3ce5e0e32b31dcecc0774c57c17a1f13cef6
Message-ID: <2025081231-boxer-footsie-7800@gregkh>
References: <CAGhJvC47-ku9-72pDwVu_2iuROfLGchZVtmofWeJoN0wV7yBPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGhJvC47-ku9-72pDwVu_2iuROfLGchZVtmofWeJoN0wV7yBPg@mail.gmail.com>

On Tue, Aug 12, 2025 at 05:11:01PM +0530, Srinivasa Srikanth Podila wrote:
> Hello,
> 
> I have come across the linux kernel
> commit 805e3ce5e0e32b31dcecc0774c57c17a1f13cef6 merged into the 6.15 kernel.
> 
> Kernel Commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=805e3ce5e0e32b31dcecc0774c57c17a1f13cef6
> 
> Currently, we need this fix into the latest 6.8 based kernel as our servers
> are all based on Ubuntu 24.04 with 6.8 based kernels. Please let us know
> the process for the same.
> 
> Could you please help in this regard. Any help on this would be greatly
> appreciated.

As per the front page of kernel.org, the 6.8.y kernel is long
end-of-life and not supported by us at all.  If you are relying on a
distro to provide a specific kernel version for you, please contact them
as you are paying for that service from them already, there's nothing
that we can do about that for obvious reasons.

hope this helps,

greg k-h

