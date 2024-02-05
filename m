Return-Path: <stable+bounces-18840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F10849C05
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD5CC1F24C8B
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C60822F11;
	Mon,  5 Feb 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRGhZumo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B1E2C684;
	Mon,  5 Feb 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140237; cv=none; b=LRx75Z/fdxMNMkTH7JjDidj8pwc7B7UQi7HzzEirHHErG6DLZRIOSPDcyx9w8JVNs9XtOA8/4SG9gnukocOR7JvKpuyymWWr0mZ4VemicVt8SgIn8o4NtNTnvfiDbeYSHqO1/YyBj9JJrk8kwQ2n5TX8T7F8yEsp2WLgk6WKKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140237; c=relaxed/simple;
	bh=u0SvxW6FlGR+ZXQaJdt3PAQTUwFsfKlcW34ooGGl63Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZwNsMnPCp6wqeNByaQ4Lu+GnvmAAk2JQMv78VHdtakght8zfEXdEMbYyNevAMQX1NGt6JmMoJg48o9VkCKfJNGlQVyAnJKG+8p3PZK4HOQP832M1bY0zHi0IIUqLh2FR+bi6lonV34ndzsE+Mc8mSy24e9Odaw3jrjB8hqwHRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRGhZumo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D935C433C7;
	Mon,  5 Feb 2024 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707140236;
	bh=u0SvxW6FlGR+ZXQaJdt3PAQTUwFsfKlcW34ooGGl63Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRGhZumoEzGkqOl7mOtMH5MJVpDCLK5lhPFo0HQreKh9gH/JP09snf5GL+RNwS6JD
	 xZHQHHbnxGUB/FrqRrgIB0/d+I7IJLFUoN/pna8E1FGIb/ipEKQ3G8wf6E9TB+FDHy
	 qejEDHMzbMxsNWlN6JF7GApKW29OKpk6bOVEHBtEXbp/0M+f/VUWSRAQKkySu59J+C
	 GBptYpRKur8DVKO9K8o/xtlWimCMytaDc0zmNcYfxAqvyyfGki1rTO9tW94jIsguwc
	 M96FVnygy6XOpL0EfV0pKAEvnYcIWfAHq/Vvz0tfkNZP68B7SewmTLWWFhF1YfUHQ7
	 FjYD9uftJ8ZZA==
Date: Mon, 5 Feb 2024 13:37:12 +0000
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	James Hershaw <james.hershaw@corigine.com>,
	Daniel Basilio <daniel.basilio@corigine.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net 3/3] nfp: enable NETDEV_XDP_ACT_REDIRECT feature flag
Message-ID: <20240205133712.GM960600@kernel.org>
References: <20240202113719.16171-1-louis.peens@corigine.com>
 <20240202113719.16171-4-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202113719.16171-4-louis.peens@corigine.com>

On Fri, Feb 02, 2024 at 01:37:19PM +0200, Louis Peens wrote:
> From: James Hershaw <james.hershaw@corigine.com>
> 
> Enable previously excluded xdp feature flag for NFD3 devices. This
> feature flag is required in order to bind nfp interfaces to an xdp
> socket and the nfp driver does in fact support the feature.
> 
> Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
> Cc: stable@vger.kernel.org # 6.3+
> Signed-off-by: James Hershaw <james.hershaw@corigine.com>
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Reviewed-by: Simon Horman <horms@kernel.org>

