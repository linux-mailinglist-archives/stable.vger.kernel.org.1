Return-Path: <stable+bounces-146455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4137AC51D9
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C813BE702
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0F227A45A;
	Tue, 27 May 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u4n1z/aH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23E1E48A;
	Tue, 27 May 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359184; cv=none; b=Ug8/za0CbEhRaKcqaZ4+DEaYM+H8X9RyA1Ugel4a7oHUn1sKxQ2/nPxtnJOK5gB6ggSZl6fsXn9cI6Y4bT9lk11CxQcy9ygVyABd0MSRWVJGBX8Ttjrb7Z0n4tSDrp5JSeatRR7o5jxAggY0JAj2tuxSCrlXelWJI8oj297yB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359184; c=relaxed/simple;
	bh=yaqLPREsZ5DBpUbJp7QATzT55FXW/OJktnUUCBMCZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SerRMwbSYnFzzQ1zRWo2EvsGIZdhraZGXyA4yQRz0US2BWyPRUy8Xb/tbgfzjrRJvCMs21TERYYgzcbS3WP4CQgnt7L7GJIUki9PJmMdJmOJYTD5K5bL/+t0X73j5syFbSAZobIFsarZFMAFs5QApGL6tRjcwPDCwgNnLPwjO9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u4n1z/aH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9749AC4CEE9;
	Tue, 27 May 2025 15:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748359184;
	bh=yaqLPREsZ5DBpUbJp7QATzT55FXW/OJktnUUCBMCZK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u4n1z/aH12pozGIdkliOn7jNTX5Y6JNGr+BR4CScnwiNk0axCiURDgWs0SiFNBLGy
	 iQbYamPFwRG9nokrRRqM8eK1AlrugxiFflWhovc759/n5Ce6tRrzmONVz8uCKUscnu
	 erkgOJmopKMoJU053cPBjd0X/Y8J4O6vTpChqMw8=
Date: Tue, 27 May 2025 17:19:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: Backports of d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca for 6.6
 and older
Message-ID: <2025052722-stainable-remodeler-d7f7@gregkh>
References: <20250523211710.GA873401@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523211710.GA873401@ax162>

On Fri, May 23, 2025 at 02:17:10PM -0700, Nathan Chancellor wrote:
> Hi Greg and Sasha,
> 
> Please find attached backports of commit d0afcfeb9e38 ("kbuild: Disable
> -Wdefault-const-init-unsafe") for 6.6 and older, which is needed for tip
> of tree versions of LLVM. Please let me know if there are any questions.

All now queued up, thanks!

greg k-h

