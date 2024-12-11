Return-Path: <stable+bounces-100603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF66F9ECA50
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 11:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56750166018
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA51A841B;
	Wed, 11 Dec 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kKcoKMd6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DE236FB0
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733913072; cv=none; b=puZfu8jH23BD1/yvFR/SwLQJBetRnF17STA4aHRK4sQ0gtLk86LAwT40nr78nxKtOhd1BVw6NFcMFVYCEVvzfW5Byg+07ZvyXXhcJAya58ufmTfVwQJsm+20E9Xe9M0ZpD/YaaGOgpA6bSlkMX3gsxYi7CiRp8jbxsjr/dtbSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733913072; c=relaxed/simple;
	bh=QZLwjDBcBDX3OjMKb0X8OcqIRYaEc29LCCMNVplMN5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNp4pATLWRHMLeWYwuJU0V+IQ5T1Xd6hhAa3jObA/ww1L31AqX+SCDeml4E+aOBh07gIDjHvjHzqBIjJ24ZFrF/Q+GPIwgjQfp/gkq418SuF/Mph+qtxb3vx/buyGVaMqZ6PLQW/7PYgXr+Y+pqUEtnRQQZCPxv+torm10+H2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kKcoKMd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08893C4CED2;
	Wed, 11 Dec 2024 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733913071;
	bh=QZLwjDBcBDX3OjMKb0X8OcqIRYaEc29LCCMNVplMN5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kKcoKMd6xbwXjyP9L2l0fXnBGh2bFPK9xby6N/DiNtAk56dclxUvmw8JZLfYaDfZT
	 STqPP0LW0ZmRuhq/jnQe64f3LJ3Ftx/GUTHdv3kDIjluYJnJCEQDvSJQ6zJjzogp2C
	 MpHFym/KJDDIsXVw0/wfQDZa5iihfOCNdvROrQ/0=
Date: Wed, 11 Dec 2024 11:30:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: guocai.he.cn@windriver.com
Cc: mschmidt@redhat.com, selvin.xavier@broadcom.com, leon@kernel.org,
	xiangyu.chen@windriver.com, stable@vger.kernel.org
Subject: Re: [PATCH][5.15.y] bnxt_re: avoid shift undefined behavior in
 bnxt_qplib_alloc_init_hwq
Message-ID: <2024121120-unclothed-relapsing-bdde@gregkh>
References: <20241211101759.3534900-1-guocai.he.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211101759.3534900-1-guocai.he.cn@windriver.com>

On Wed, Dec 11, 2024 at 06:17:59PM +0800, guocai.he.cn@windriver.com wrote:
> From: Michal Schmidt <mschmidt@redhat.com>
> 
> commit 84d2f29152184f0d72ed7c9648c4ee6927df4e59 upstream.

Wrong git id :(

