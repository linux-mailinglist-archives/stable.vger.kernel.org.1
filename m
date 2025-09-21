Return-Path: <stable+bounces-180833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EA0B8E23F
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE518189B1BB
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 17:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DDC248F47;
	Sun, 21 Sep 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jkmyUG55"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF2249E5
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476190; cv=none; b=eyUNdNUNM392S4m4GAWyCGmttF6wruOoVp/fbZGp4lV9OZVyGFUJ/B7Ah7rHBI1xQfo47piM0cEJam0RV3LSlLHahoAejdiprXCBn4AL9jfRTExxztf5kcLg9o/Y72ugjt7oJAUPBYr3Fx7TdkQHGdN4RK448O7T+Ok7nw/rdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476190; c=relaxed/simple;
	bh=xucAq5C1NWLec4wAIDctsLryX0FUXJf31EkSqaRLTvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG8M4n8wlwyKEV2+iKQ8moWy+wHvgSeW+wAcCegDnJQlP8B6ilXqQrfJPpJ/Dydgx8vKXEHtRIPVC972i/a+0nabp0Juvt4n7ocQUoOeFe11gqO+AfkB/r9+huhveeSYUyMlgpdsnLDb+HEWXoWMHFkin7zG3EsPJJvwsBK9DGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jkmyUG55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAA2C4CEE7;
	Sun, 21 Sep 2025 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758476189;
	bh=xucAq5C1NWLec4wAIDctsLryX0FUXJf31EkSqaRLTvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkmyUG55FF4dhW1unUVn/8OIA4kxGcY8PCfP3O4wpMSDYhbfl3QXr2l3ovykBMmzC
	 2+MDS9gZ2p2Js1l4dWUrJ0Ktq8C+RTEmL9JcXkL4CEP8ERKu5O7G9YNPw02FUw7qEc
	 oq7dKIQ/7tJMt9ARUrjmypXRbP2TYrjcwnhFZi20=
Date: Sun, 21 Sep 2025 19:36:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf2127: fix SPI command byte for PCF2131 backport
Message-ID: <2025092110-rented-follicle-03d8@gregkh>
References: <20250820193016.7987-1-bruno.thomsen@gmail.com>
 <2025091422353715503104@mail.local>
 <CAH+2xPDx2R17zv_FbUx8+vWbshqHV9Z89yJP-1HchB=HiNWqgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+2xPDx2R17zv_FbUx8+vWbshqHV9Z89yJP-1HchB=HiNWqgQ@mail.gmail.com>

On Sun, Sep 21, 2025 at 06:52:17PM +0200, Bruno Thomsen wrote:
> Hi Greg,
> 
> I have not tried to report issues with stable branches before,
> so my email did reach you[1]. A backported rtc fix was applied
> incorrectly to linux-6.12.y and linux-6.6.y. Patch message
> got both incorrect backport commits.

Ah, missed this, sorry about that, now queued up, thanks for pointing it
out again.

greg k-h

