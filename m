Return-Path: <stable+bounces-118339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7773A3CB85
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D396C18985CB
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 21:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21B0257AEC;
	Wed, 19 Feb 2025 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY8wC7Ht"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF0F2147E4;
	Wed, 19 Feb 2025 21:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000894; cv=none; b=kvDTxznoC4STrH9+yD7W3ggod0SCR7ovFI0fQCTvWeMfOcq+hFPl7bT4d13HvTGopK9S2n55y6dsaHEbkhQ3A+oxToHBlozdaSCTsfBK7SLzVOvWUYRDa227RXL5mKuD3PTJzOE4oUR50337dWmdlVJejmXoKCwJhu1hRafxvSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000894; c=relaxed/simple;
	bh=HBXTtTA7xUXflTeT130vM1iT0i7s6QLv9KxPZn7oWC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dhv63isr3WnNfjupdrXn8rvUt1uDb4U6UDcwucutMC2qZtqWwk187kE7ea5eGtNLjHrfKAdov2xjkNlVqCg9+B1uHGs5FwSiZ2mj9fE65WqrsO86dE7XIRJ0PQMxtLF0Hkl8Do/H9WPJx+3QMVFrFsU4TDGO2l+1Qzff5xRBsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY8wC7Ht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EBBC4CEDD;
	Wed, 19 Feb 2025 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740000894;
	bh=HBXTtTA7xUXflTeT130vM1iT0i7s6QLv9KxPZn7oWC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nY8wC7Htfc0MnAppEd6qFEiuEYcAUNbhm4OesmGart9uUXdZBJwio4/F8xULZ89eI
	 AlaDiIIgfBcPYJlMJbk+1eHbgVPfrT3Vd4KeZmW78xQTYaFPHPgRqxtBRdExqhoCTu
	 wmazQ/dmBPq9Z1L1FROhVbNQ6C79WQ0Hq82Pn0qjjMxLx+8OT2RzZjZJQsAuYp1BjK
	 tzBIV0bfdFcM2GxsJMil47LVQ5QSp2UWMf1e5uXGjMVHLWP7mMYS3jS2VNJmjj/aNQ
	 mJfZCzzrEdM5a/jAPA/qAtldWexeRYMj7HeFR7TNPLyl9NHgcgeC1j4OJh1YgKmH33
	 CsEu6LymEktJQ==
Date: Wed, 19 Feb 2025 13:34:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH 6.13 230/274] eth: iavf: extend the netdev_lock usage
Message-ID: <20250219133453.0550fb92@kernel.org>
In-Reply-To: <20250219082618.582615972@linuxfoundation.org>
References: <20250219082609.533585153@linuxfoundation.org>
	<20250219082618.582615972@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 09:28:04 +0100 Greg Kroah-Hartman wrote:
> iavf uses the netdev->lock already to protect shapers.
> In an upcoming series we'll try to protect NAPI instances
> with netdev->lock.

Please drop from all branches, waaay too risky

