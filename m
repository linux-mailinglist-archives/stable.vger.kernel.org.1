Return-Path: <stable+bounces-148094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168CDAC7DB1
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 14:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504F53BC487
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C8D22422D;
	Thu, 29 May 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqnNaxtL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB72C155335;
	Thu, 29 May 2025 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748521579; cv=none; b=bdVhAZ1akhD6I6bj1eKXeDV3fhzJVK/otisdIZhrZMYogFAskvg/z6/46Ian/+u04j/lfK6/SVeSUsFmgTf2CEcOGpvtPpQ5/hlzJ2zd0BM26GSTdJs5tqbPWzzWiq3YNGhANKgvPwzyqnYK85K/1bYnmsPpXzJ+o9gakOZfNIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748521579; c=relaxed/simple;
	bh=tL7rLip292FF1t+bBf/HHC6SRjqiUvBedR/lQakJNo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrDYIpu/xPtnHQdxM4ObSi2zKMZpuelXnt97sRkVhIQjV7uaKFADXvuxZ8A76XckBj20t5kI9jyA6iza6ad+llb2g5jpiMykKk252fbcfjd0pPCaJ/UcI6Buw8+DbUW1rAz+idXzlK+J3qIET076bFoLk+GLNIzwkH4JcCVEziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqnNaxtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1FFC4CEE7;
	Thu, 29 May 2025 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748521579;
	bh=tL7rLip292FF1t+bBf/HHC6SRjqiUvBedR/lQakJNo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqnNaxtLCAXbZPjMp3hEqG0GHwboDweMpwGNdyKjTMHW0AYuMiYFiy4BNoojkRJUu
	 otsTl6CEnN6CldrU1A7c/pqHQVjIX40DIG6JolFo38m7N6x7C+fOFRBflxb2jIfMDt
	 VYFvKOce00nsvfTdUaJckOcHnKKW5bM6uYrHM6CI=
Date: Thu, 29 May 2025 14:26:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>, Michal Luczaj <mhal@rbox.co>,
	Rao Shoaib <Rao.Shoaib@oracle.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, Lee Jones <joneslee@google.com>
Subject: Re: [PATCH v6.6 00/26] af_unix: Align with upstream to avoid a
 potential UAF
Message-ID: <2025052907-varmint-referable-3054@gregkh>
References: <20250521144803.2050504-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521144803.2050504-1-lee@kernel.org>

On Wed, May 21, 2025 at 02:45:08PM +0000, Lee Jones wrote:
> From: Lee Jones <joneslee@google.com>
> 
> This is the second attempt at achieving the same goal.  This time, the
> submission avoids forking the current code base, ensuring it remains
> easier to maintain over time.
> 
> The set has been tested using the SCM_RIGHTS test suite [1] using QEMU
> and has been seen to successfully mitigate a UAF on on a top tier
> handset.

All now queued up, thanks.

greg k-h

