Return-Path: <stable+bounces-152865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0F8ADCE9A
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607237A6FE3
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA92E88A7;
	Tue, 17 Jun 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OVGLt+z9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FC52E3AFE
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750168811; cv=none; b=WJ0ywdl/zU4H8GBKzzR6JAuXfQKkd7IExIKjTIsVHTAbVLzsAYlbkXvOU9xhCrKWXMGHL6p4uyx8tlnTPUC1PQAk0V/rsT/aBibCl1rPM+kYraBJKWMD+DQQeBFnTqWHGPrN4NuKpugB7U+pVa+ifODuhRRtSmWYDnwYpD4ajYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750168811; c=relaxed/simple;
	bh=lveGyb5CwXs7l7/YUwXptP0951IGB1s/I0KCXYt3ZpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbN7YStE1dgDzOlx3NnQdIWy5K5vRmGVORdNQYKJKW44JERCC7pALAnDS08kjG07CkQcpaZsvzsNpLDmcL1L6rI2iIyR3cE7z1GJ+LEiqOXFmMXgvE5UKgtxourDWYYUdULMDjrdRNLfpEdNaV+IaXZ3Oi+vXN1JCZWQ+vlhq7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OVGLt+z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852B3C4CEE7;
	Tue, 17 Jun 2025 14:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750168811;
	bh=lveGyb5CwXs7l7/YUwXptP0951IGB1s/I0KCXYt3ZpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OVGLt+z9W2Ii6y+r0QP9jbt74WgztgkIFz0igzz1DvictQE88Qppbj9K9mw3WQ0R3
	 ZfDUAxO28Ma7jHZoOpwrpzYWm6QQskRxddo9l+neVzcvnQViEdPhwdCTasVyseRj4O
	 5vGjsaVNjPBCChabGXJuCv2KVvBVdk49nNUeSLxM=
Date: Tue, 17 Jun 2025 16:00:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
Message-ID: <2025061731-onscreen-lethargic-d2b2@gregkh>
References: <20250608145450.7024-1-sergio.collado@gmail.com>
 <20250608145450.7024-2-sergio.collado@gmail.com>
 <CANiq72mVx258c0rbGDwF1sP_gn0v_L7PPMG1q1XcBF2OQWH9-A@mail.gmail.com>
 <CAA76j93Bj00WmWEQeG3vi6YJtN1at8=fbryvf3-JP_gaBcnQkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA76j93Bj00WmWEQeG3vi6YJtN1at8=fbryvf3-JP_gaBcnQkw@mail.gmail.com>

On Sun, Jun 08, 2025 at 06:10:13PM +0200, Sergio González Collado wrote:
> Hello,
> 
>  Thanks for the remarks.
> 
>  The commit is exactly the same as in the mainline commit.
> 
>  The upstreamed commit, is mentioned in that way, because when I used
> the full hash, I was getting this error from scripts/checkpatch.pl:
> 
> ERROR: Please use git commit description style 'commit <12+ chars of
> sha1> ("<title line>")' - ie: 'commit 0123456789ab ("commit
> description")'

No need to run checkpatch on stuff you are backporting to stable, as it
should follow the same style as what ever is in Linus's tree.

We need/want the full hash here.

thanks,

greg k-h

