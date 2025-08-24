Return-Path: <stable+bounces-172712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F9EB32EA0
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26C2445A68
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA323C511;
	Sun, 24 Aug 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="asG/3YHS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CC1C2E0
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026658; cv=none; b=lkpIA4pSXlWwrkF6Bn979GhRspsUY43ae9ecfFiWSuVliOgTwpGOgV1N8vTJtNA6VQlvAZZNEs7sztKdK88/FRKdFFgvHXaluYMlRVwXjXOQ/2ddVVJvtpY55rOd2hoOVOBrtu6PwFbJujD+fmLrsGuroZVeTYW8ykINtKeY1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026658; c=relaxed/simple;
	bh=6nmOzGhkvTdd4b4cvZSdBIgIgGn0AdIp9o8wddMXs1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyJM8tJRUIvBBazQ4IYCgOKrJFrOh+t0v4Ge5Am/UhqmzjShzt6rn7KJ0l20cPPFxxIj7Yhab1q/gzVd8JnfTEQE7T/0TOeSJYoY9rnmR1/4onzgr6U8E7G6DDBCyp2YwRH+Q3seTCRtoIgWgBc/yZD9sqViBMnlAQCfp0qIdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=asG/3YHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03CDC4CEEB;
	Sun, 24 Aug 2025 09:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756026658;
	bh=6nmOzGhkvTdd4b4cvZSdBIgIgGn0AdIp9o8wddMXs1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=asG/3YHSsOUcRagEvykj4JvPSA7ps6Wc9L/SvdS1xr6Obf+rF1jYTjEnMzrg9cneT
	 o9cR+DWhsqoz9dmqVG9HMh4mCrrOXYyX/naE49TQPIjUWfCE4sqKw+7AMhWfiYBjFM
	 +vxomR9k+WZlqLcL/L9F4EC2WkKCaR8I4pSpPrpE=
Date: Sun, 24 Aug 2025 11:10:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: PPC GPU hangs patch
Message-ID: <2025082435-tuition-suffice-d462@gregkh>
References: <96f62b2d-4d26-42ed-8528-e48b2d385341@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f62b2d-4d26-42ed-8528-e48b2d385341@kernel.org>

On Mon, Aug 18, 2025 at 10:52:29AM -0500, Mario Limonciello wrote:
> Hi,
> 
> Some GPU hangs are reported on PowerPC with some dGPUs.  This patch is
> reported [1] to improve them:
> 
> commit 0ef2803173f1 ("drm/amdgpu/vcn1: read back register after written")
> 
> The other VCN versions are already in 6.15.9, this one didn't come back
> though AFAICT.
> 
> Can you take it back to remaining stable trees?

What specific ones?  5.15.y is end-of-life, and this didn't apply to
5.12.y :(

thanks,

greg k-h

