Return-Path: <stable+bounces-75793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C77B974B7F
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AABB21F95
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8327D14375C;
	Wed, 11 Sep 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAffp/gg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7FD13CF9C;
	Wed, 11 Sep 2024 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726040089; cv=none; b=NtH4nw30yIy+/KxrhxzaxMo1/Tu23LXV0mt5FqQiuDaCD4WvKrxzli9+mW61XuvyExd0rZYYdVTEm3K6kVK6x7Vxb8pzCD7ntlhRqWjbgNDlDESBDoiMxLRR+APq+nIzBQlO2nORvcZCVs14k2UWv6rYakraJQktnz09VvR4ivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726040089; c=relaxed/simple;
	bh=sLTAmujLBBEb6mPMznNYykNiEq0ccUHvfasd/iof3Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUKqz0WJFBJoy/c4rYAwsGUjdjVa56z1VRjoxSuBltW68fPWYJNo7Ved4eMGOHYr/wts4yYRy0uqtYGH1l5iSS2CkBmvhcVRWjoarWOWoaDgAQO5JmYVi2C1DlZ0J803IAZRuSV4Grz4wsCZAcfUp3ZzQT6imghSXpU24qby+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAffp/gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E7FC4CEC6;
	Wed, 11 Sep 2024 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726040088;
	bh=sLTAmujLBBEb6mPMznNYykNiEq0ccUHvfasd/iof3Ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAffp/ggG0vRk0ayKQkVa8R7o7MBQefoN13SyAk+lv9SaHLOU6WW9lUpIMXEg/sZ8
	 Aq3v6tEfuLd4rz8wSK0OeRe3sLWfnLP/hLKWq0txW4q4876kvyJxqAjTBqlDWdHr1C
	 0ClY08UkbWJhF0aXI7Z+lS6Kve2RbQuM9Q49i2De9jBXcVhlQIWCm2xt33NJbFJpSl
	 bC6G2yuNSjriRJu8cEZCo8qytUN6yloWPCKp9jphj6ZBXZHcPCb8Pu15zI41d2rkJi
	 MqgG9ia3f0hMKnBozntPtjhjNcHqSl+LONwWjOQHskpgjA49hgJBO5qoOjyOHrOK7D
	 ZMOE+TINgOteA==
Date: Wed, 11 Sep 2024 08:34:44 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	mengyuanlou@net-swift.com, duanqiangwen@net-swift.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix number of Rx and Tx descriptors
Message-ID: <20240911073444.GL572255@kernel.org>
References: <20240910095629.570674-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910095629.570674-1-jiawenwu@trustnetic.com>

On Tue, Sep 10, 2024 at 05:56:29PM +0800, Jiawen Wu wrote:
> The number of transmit and receive descriptors must be a multiple of 128
> due to the hardware limitation. If it is set to a multiple of 8 instead of
> a multiple 128, the queues will easily be hung.
> 
> Cc: stable@vger.kernel.org
> Fixes: 883b5984a5d2 ("net: wangxun: add ethtool_ops for ring parameters")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


