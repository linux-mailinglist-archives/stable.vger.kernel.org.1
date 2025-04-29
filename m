Return-Path: <stable+bounces-137009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D7BAA04A3
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 09:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454E63A8BE5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 07:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB59B277811;
	Tue, 29 Apr 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="skucnygv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABAA1F76A5
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745912159; cv=none; b=bVvSWWkD/6yoF8De625DOZ3siswsSLfMtRLqAHHo5d+8sEXK4wVkkvMY3JwY0n4EY3EVOiq7BVYBt2qLYpIpmiTWZFZhkgZk++ASJvauMjqZ3O1l5szslf8HMUBFOffoGmliF6BpFJMszfkCX15S4puCtgxMd4stinxl0IWQduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745912159; c=relaxed/simple;
	bh=ZQpWfgy+xxBSfwcaZp6Tosn5xJjUdFeUF/Jc6BCdYtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D79Cg+fIzCrdeao3ot+/LpgK40vrmPIHVBm1nOZI6xnFjQBfWCrQ7FdAHallGvkzW2EmWh+7qYXeDK4DFGjIfk/TOpSsam1oSbGVjA8D/FIotErWJ+vthQEyBal84PtfsiZW/tIwjKQhcIVrBtvJM7G0ANNb5gCM7e1800LHrmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=skucnygv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE8C4CEE3;
	Tue, 29 Apr 2025 07:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745912159;
	bh=ZQpWfgy+xxBSfwcaZp6Tosn5xJjUdFeUF/Jc6BCdYtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skucnygv7JWcJH5B66x9ocQtPiVEJ0zyKIQjL3oFbtaJYR+RmuORhcaaBNaCqgpLp
	 BvY47RCMJmmlvDTZ0Q+RxwKB4EuBqEwIYrU0HDPWv1tCh3GRP6vMXnAihPgSHZCGaM
	 p/SsQcasQN5Yamu2mjL6aqLdl8Z0CKlYIUj1Yl7w=
Date: Tue, 29 Apr 2025 09:35:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH 6.6] iommu: Handle race with default domain setup
Message-ID: <2025042955-pelt-scorebook-dd4d@gregkh>
References: <e1e5d56a9821b3428c561cf4b3c5017a9c41b0b5.1739903836.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e5d56a9821b3428c561cf4b3c5017a9c41b0b5.1739903836.git.robin.murphy@arm.com>

On Fri, Apr 25, 2025 at 03:19:22PM +0100, Robin Murphy wrote:
> [ Upstream commit b46064a18810bad3aea089a79993ca5ea7a3d2b2 ]

<snip>

You seem to have forgotten about a backport for 6.12.y as well.  You
know we can't take backports that skip stable branches, otherwise users
will have regressions when they upgrade.

Please resend this when you also send a 6.12.y backport, and we will be
glad to queue both up.

thanks,

greg k-h

