Return-Path: <stable+bounces-93708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C6B9D05C2
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA605B21352
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394BB1DB37A;
	Sun, 17 Nov 2024 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xfDP89QK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2CFF4ED
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731874932; cv=none; b=dAKh/MQPVGLBuIW1S+AQxAqZldeFrgs2TSGWXHd7NBUihtOR6de6f+G2tpZEHTF1YsTO8ZsHAZYgwnAjbszrPxtTR7ciTVsVh+v8lYD4QJs/RbXyfvLPa2VQcQ4r6BzmYWZTck13idf5qKGz0fYWOkt2J5hU3MdkeJwrVIP5+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731874932; c=relaxed/simple;
	bh=yqcUBllp4IN/GYd/xV27kQvcKr5fr7RC82dqq9+D8Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5PGJUWqG/g+k74E/299wXbIywzhF34kCiA6VfT8F8wxJh18eD+uFUlkcfmFIbbyVc82Dg8dZlm+NKE3bCPpi5eE/7Cr2oyNBN58+sK6l2bL85ye8akVy8cKnBS+W6VhjLEusmRC6+VPduh83qEQG7gAF5GOmcev3smu5AOy0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xfDP89QK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14F0C4CECD;
	Sun, 17 Nov 2024 20:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731874932;
	bh=yqcUBllp4IN/GYd/xV27kQvcKr5fr7RC82dqq9+D8Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xfDP89QKtL9Z5clyPGbjZD6iKeso0VhGb0C2czZg0ynQ3+Z/wnTCDYN7bpDYmi54H
	 3AwW6oLuFcYib+FDcQDE//zlSzedxQoSc6sVcb3KqdIWc/HrNKXbJtAXu+LDGlvBok
	 lEaX29CSnusk6pDUlb0e095Nh9VLV8skNkF2ci6g=
Date: Sun, 17 Nov 2024 21:21:47 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	james.dutton@gmail.com
Subject: Re: Additional panel replay fixes for 6.11
Message-ID: <2024111725-grooving-pretended-7b61@gregkh>
References: <62a02199-5213-4a6f-b2d4-7898a26344c6@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a02199-5213-4a6f-b2d4-7898a26344c6@kernel.org>

On Sun, Nov 17, 2024 at 09:20:29AM -0600, Mario Limonciello wrote:
> Hi,
> 
> A few more panel replay fixes have been made for issues reported on 6.11.y
> 
> commit 17e68f89132b ("drm/amd/display: Run idle optimizations at end of
> vblank handler")
> commit b8d9d5fef4915 ("drm/amd/display: Change some variable name of psr")
> commit bd8a957661743 ("drm/amd/display: Fix Panel Replay not update screen
> correctly")
> 
> There were tested by
> Tested-By: James Courtier-Dutton <james.dutton@gmail.com>
> on 6.11.8 base.

2 were already tagged for stable, I would have gotten to them this week.
All now queued up, thanks.

greg k-h

