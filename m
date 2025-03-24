Return-Path: <stable+bounces-125861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C844AA6D576
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593CB169DA7
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF14E19644B;
	Mon, 24 Mar 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaappGi4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD64747F;
	Mon, 24 Mar 2025 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802737; cv=none; b=DXmdFwWNWJQEVHn/DfRXiYV6yDSvt7MG1ghKks3EaDqd254caCaipfe/15h/GYpD6nKEGgYqDnbF3pW5qRdzGw0EdlqRaY4KBNFrVaZG6zW6CJO16bQo+sCO4SG7+H5HI7z6gXaq3LLkZfyT1I6+RBnFmJ9y8FbpoREaYgQk1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802737; c=relaxed/simple;
	bh=Dp5AurwzM/p53iQBJHpyX02AtDUS6HyFc/sVGsh+7u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaU6iUW+PT9iSYN5is66dd9t8CVBE1UOA2YNOIIX+Vipay3IV88oxmV7VAiUBIpue5sVIAap0JEGCIuN8tYK7fB5cwmBmqJZumLnvy/qy4gu2xkBL2N71PUddyNdhoMMu1e8BWugy/hM8lrCs5Wm1NvcByzQKmN88rCk2TttaA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaappGi4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D769AC4CEDD;
	Mon, 24 Mar 2025 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742802736;
	bh=Dp5AurwzM/p53iQBJHpyX02AtDUS6HyFc/sVGsh+7u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jaappGi4tD5n5foRED2gXV/Y6EqSOjtTYMwgmkxFocdhJKrPshPcKS7ppKeZ9T7QR
	 2NjbHm09Jwe/BZp+1yP9TQlxj8Vzd2t8GVEulo+LiQHiPj7YC5Iv46I3H3lqWa3OgK
	 rM/bmOF9N7FrNupGLG0DwNDGdDQofeqj3qARdO/CBbVi7UYEY9qf1MD/HUKpb0hUac
	 zRvVPqpd2goJquYZrEB9o1c7VvclcqFrCvlavvKnbyNrQMZlhaUgOltDfektlpeicL
	 GD3hzcLSsU27NzIrZeIskBMuCuaMXbhG8+YSqSa5B03KG61l9DQsAyVYPki1t93XaZ
	 5wLcUuZmUEjNA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1twcbX-000000001Xy-3oIu;
	Mon, 24 Mar 2025 08:52:15 +0100
Date: Mon, 24 Mar 2025 08:52:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Steev Klimaszewski <steev@kali.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Clayton Craft <clayton@craftyguy.net>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
Message-ID: <Z-EPL36eK-TkKHt2@hovoldconsulting.com>
References: <20250321145302.4775-1-johan+linaro@kernel.org>
 <CAKXuJqh0_7fduDgDXWzCE2fYNHV-mDa29Lxq15h7-vam2Nin6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXuJqh0_7fduDgDXWzCE2fYNHV-mDa29Lxq15h7-vam2Nin6w@mail.gmail.com>

On Sat, Mar 22, 2025 at 03:32:08PM -0500, Steev Klimaszewski wrote:
> On Fri, Mar 21, 2025 at 9:55 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > Add the missing memory barrier to make sure that the REO dest ring
> > descriptor is read after the head pointer to avoid using stale data on
> > weakly ordered architectures like aarch64.
> >
> > This may fix the ring-buffer corruption worked around by commit
> > f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> > ring") by silently discarding data, and may possibly also address user
> > reported errors like:
> >
> >         ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
> >
> > Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> >
> > Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> > Cc: stable@vger.kernel.org      # 5.6
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >
> > As I reported here:
> >
> >         https://lore.kernel.org/lkml/Z9G5zEOcTdGKm7Ei@hovoldconsulting.com/
> >
> > the ath11k and ath12k appear to be missing a number of memory barriers
> > that are required on weakly ordered architectures like aarch64 to avoid
> > memory corruption issues.
> >
> > Here's a fix for one more such case which people already seem to be
> > hitting.
> >
> > Note that I've seen one "msdu_done" bit not set warning also with this
> > patch so whether it helps with that at all remains to be seen. I'm CCing
> > Jens and Steev that see these warnings frequently and that may be able
> > to help out with testing.

> While the fix is definitely a fix, it does not seem to help with the
> `msdu_done bit in attention is not set` message as I have seen it 43
> times in the last 12 hours.

Thanks for testing, Steev. Given that that the patch makes the warnings
go away in Clayton's setup it seems we may be dealing with more than
once root cause here.

Johan

