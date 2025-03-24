Return-Path: <stable+bounces-125895-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F93A6DDD2
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0073AD5DA
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECEB25FA2B;
	Mon, 24 Mar 2025 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZlp/Oi+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB725EFA4;
	Mon, 24 Mar 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828819; cv=none; b=t9tykTq3AUdpMjybcGTDTvbFE6fVaPiTRkStWv+L4+YzZVSziMPwSoJZ0d69d/QppcxYIuKVTTP1+9LNl52yA/ybxGAv7Z4vjFKMCGd3rwbCFKechzkG8RrBaYJ5JUEIFBzfa1GSwGhYpHV2tfF8O9JdHe4eOEGTkNMYs6YNMQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828819; c=relaxed/simple;
	bh=SnVSl6CFkIX1PkG6+5tqHKeiuhjmt7k8KNcJ9EMCjNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUGQ9G9GQdWVMuvJnP1yxYGPa9bk2zfCWgKEf76mbO64NYrjqr4sLbkG/o4yZFPaMmuKIo5QtKChI+BRkZ6AtYCF0zKuo6iH5pv5ufoV7/l8YuIDJ4JJf5YNr4bjqb4KfQ5pLe6oxEjwVPLc5M3nDj3glmhhmjyKE+Pzia7KVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZlp/Oi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79172C4CEE9;
	Mon, 24 Mar 2025 15:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742828818;
	bh=SnVSl6CFkIX1PkG6+5tqHKeiuhjmt7k8KNcJ9EMCjNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZlp/Oi+lydf9fiE3l+P76ctLCKI9DERztCr2kxIwLt7Ou1/j/s0QZgnAL7o5XsPT
	 E5BxaWDmH7DKF+FiQlAiXFizJnopkoU1ZCpK6HukkTk5ICp5Y1aTEW5/bhsmJgP41M
	 WqdU6bO7H5DuQ9iTokQq8f+FuamvnIFX4Eefljjcq3/cPMVJ23USkIXNmaWDICJSDk
	 tCSSJAntvyA+JNk6sZlaJ2OZa6gjfaxFs+XD1sCNVfdFVdo7tx4qw7OvNrg+NmvBpJ
	 ORKs96t2zrEmRZweCqfRqPiVpFkZZhTnR4FP1F+UUhcQTTDxf4SDhubHSPQkSywXtZ
	 p7o/ce2miSkwQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1twjOE-000000002vu-0XPG;
	Mon, 24 Mar 2025 16:06:58 +0100
Date: Mon, 24 Mar 2025 16:06:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
Message-ID: <Z-F1EoFxY3qVZiXZ@hovoldconsulting.com>
References: <20250321145302.4775-1-johan+linaro@kernel.org>
 <5d872cf0-ca57-4017-b06e-fce9c11813dc@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d872cf0-ca57-4017-b06e-fce9c11813dc@oss.qualcomm.com>

On Mon, Mar 24, 2025 at 08:03:15AM -0700, Jeff Johnson wrote:
> On 3/21/2025 7:53 AM, Johan Hovold wrote:
> > Add the missing memory barrier to make sure that the REO dest ring
> > descriptor is read after the head pointer to avoid using stale data on
> > weakly ordered architectures like aarch64.
> > 
> > This may fix the ring-buffer corruption worked around by commit
> > f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> > ring") by silently discarding data, and may possibly also address user
> > reported errors like:
> > 
> > 	ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
> > 
> > Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> > 
> > Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> > Cc: stable@vger.kernel.org	# 5.6
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Does this supersede:
> [PATCH] wifi: ath11k: fix ring-buffer corruption

No, this is a separate fix. There are more places where barriers are
missing, I'll try send some further fixes during the week as well.

Johan

