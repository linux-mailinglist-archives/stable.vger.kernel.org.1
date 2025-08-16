Return-Path: <stable+bounces-169846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA93B28AB6
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 07:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE58A1C8091D
	for <lists+stable@lfdr.de>; Sat, 16 Aug 2025 05:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D418F1E411C;
	Sat, 16 Aug 2025 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MChmmSVU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D621E49F;
	Sat, 16 Aug 2025 05:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755322786; cv=none; b=BZyNLyvi2bKo6thLtKk9spg7Cq0ykOt0KUelGPw4YDCumiZHCmISxLp/opW9F+HvUfpHAparUCGmj0VOgZubCU7QS4EYRte5+pEiDygqEd41HoV7hbxqJA2Uz3nHqOTYzJC7r415M5sz4KIqACHoPgPmSPGkT57IFoLPgzMM4ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755322786; c=relaxed/simple;
	bh=4wn104ra76AoUwmdyaFPGDk1qiVGjHvNzVS7DARoOtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVyblP0xfyBMwCcBtS1Ec/7efFuSk5467+mEeohQCfFcs8Qft/PUnUR5YF5xddzOzpy31Eqt7IuyrDax0Ay4zaJEc8Wi/dTZtWlEbAjYbHzooQUpvOjzMGfXtWFOWdMR/q+kX2XdXFc2usNyq+wj/k90hAHYBcj7gSSeDDROrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MChmmSVU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92511C4CEEF;
	Sat, 16 Aug 2025 05:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755322785;
	bh=4wn104ra76AoUwmdyaFPGDk1qiVGjHvNzVS7DARoOtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MChmmSVUJ9XtMxNp4QroiKgVigg6cnrrBfLi3duj8GnITJxCurnMUYx/wKFQJJrIX
	 h+cOy9W9wEkVvKDCEHT7oDDpwjT+BYNNefVf1+iy/FrnR0RxlcM+Wl3sw7rC6CWzFJ
	 ONM95Llk94yZZmEUj31uvO0e24lTuSSHN6W7yBmc=
Date: Sat, 16 Aug 2025 07:39:42 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lars Wendler <polynomial-c@gmx.de>
Cc: wangzijie <wangzijie1@honor.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] [BISECTED] linux-6.6.y and linux-6.12.y: proc: use
 the same treatment to check proc_lseek as ones for proc_read_iter et.al
Message-ID: <2025081615-anew-willpower-adca@gregkh>
References: <20250815195616.64497967@chagall.paradoxon.rec>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815195616.64497967@chagall.paradoxon.rec>

On Fri, Aug 15, 2025 at 07:56:16PM +0200, Lars Wendler wrote:
> Hi,
> 
> the stable LTS linux kernels 6.6.102 and 6.12.42 have a regression
> regarding network interface monitoring with xosview and gkrellm. Both
> programs no longer show any network traffic with gkrellm even
> considering all network interfaces as being in down state. I haven't
> checked other LTS kernels so I cannot tell if there are more affected
> kernel branches.
> 
> I have bisected the issue to the commits
> 33c778ea0bd0fa62ff590497e72562ff90f82b13 in 6.6.102 and
> fc1072d934f687e1221d685cf1a49a5068318f34 in 6.12.42 which are both the
> same change code-wise (upstream commit
> ff7ec8dc1b646296f8d94c39339e8d3833d16c05).
> 
> Reverting these commits makes xosview and gkrellm "work" again as in
> they both show network traffic again.

Is this also an issue in 6.16.1 and 6.17-rc1?

thanks,

greg k-h

