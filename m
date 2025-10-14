Return-Path: <stable+bounces-185654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24628BD9799
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06FF401E62
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F42E313530;
	Tue, 14 Oct 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0kqeqk4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553AA20296A;
	Tue, 14 Oct 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446573; cv=none; b=PJSaArew0qXavXAJcQ2NXjlIVPZol4GTtEoPkfCR2pq+i2H0xSzLuO3PBX4ACjbQIopd5IA9RsOx+23+XW7Qe3eQ/8L7qycfTMpMj9wZ6tudln3PdZi6IKSx3TKbiQzk47jx13cd/r63uA7nfZc0U3Rn59HBuwaKlI+Tef8O7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446573; c=relaxed/simple;
	bh=jVQUGnJkT132sqqUC4K2V431C09qQ1EnlNkzaiHH5s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fhk5+pgbIY7q3eJ0zRLPZGQZFOQnwk6oCxIeMpgVQKiaDvIkqfFboev/FzxRFbQoykS4zb9uHZWCv22j5tSUuuE/WquY7bf0zKL4n7eVK59OEg2LJhSSSsaRUxqhbNdDbfQGR/k5eM55ENx0ZovYJuXyMrUtVAiB7p0KG/4/SbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0kqeqk4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D49C4CEE7;
	Tue, 14 Oct 2025 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760446570;
	bh=jVQUGnJkT132sqqUC4K2V431C09qQ1EnlNkzaiHH5s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0kqeqk46jGWaHFooZ5s3lITr7eDBWe9DATV1EUJnDMbXkm/9WSGVuVrP9XWw0P9e
	 RUzCOm3dANljAq/iNOH7kmEjRLs1gzt1jTiGkZ5tafnl/DHYunGgMlU8QIh1YMbKL0
	 ckwMsxHtP1xWL9TwPjCDu6mzX8oTK6SjXspcd/J2JJ09NoRrgnL4TpNsNf//7GFWQQ
	 ADxcF1aWBLDie2t9lfY7JLzK2StnOFlRLkLD97a5+/ZkiFuov7FTWOAaF2KMY6guUO
	 5aG4gik+ghrn8qGC+o6ULwgAjvPqLM5LIBj0wCHyDzdhOGSZh2KP2RfrbCcn8myecu
	 uh+Q8iMtRTR/g==
Date: Tue, 14 Oct 2025 13:56:05 +0100
From: Simon Horman <horms@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, willemb@google.com, pkaligineedi@google.com,
	jfraker@google.com, ziweixiao@google.com, thostet@google.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gve: Check valid ts bit on RX descriptor before hw
 timestamping
Message-ID: <aO5IZYjGHe3xpzPK@horms.kernel.org>
References: <20251014004740.2775957-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014004740.2775957-1-hramamurthy@google.com>

On Tue, Oct 14, 2025 at 12:47:39AM +0000, Harshitha Ramamurthy wrote:
> From: Tim Hostetler <thostet@google.com>
> 
> The device returns a valid bit in the LSB of the low timestamp byte in
> the completion descriptor that the driver should check before
> setting the SKB's hardware timestamp. If the timestamp is not valid, do not
> hardware timestamp the SKB.
> 
> Cc: stable@vger.kernel.org
> Fixes: b2c7aeb49056 ("gve: Implement ndo_hwtstamp_get/set for RX timestamping")
> Reviewed-by: Joshua Washington <joshwash@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


