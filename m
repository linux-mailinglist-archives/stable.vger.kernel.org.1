Return-Path: <stable+bounces-50327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69750905B73
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 20:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50FF21C2289F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4C53F9D9;
	Wed, 12 Jun 2024 18:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vBtY5t+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE202F3B
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218198; cv=none; b=NWMxl5yFvf5m45fZZhJIliyCk3SRU25JG/3V79VBggfBp5w66nC1invtxvU4/U5R4J1IM7ow0BOvdMu2gsN8H7CZo9DNhC0tBYM9P2Uinhpq9cF0R+Xd0MHRabfXWdiumuleg4li9lYF2t8OxsLaAhR+FxILtnkf8tv9/G8mjr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218198; c=relaxed/simple;
	bh=5cqqrEtUCEY0Yc5ek54KC7e09wajHxelaNfwhyWhtM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+Tq0Q5iflmC3ffQa5jkxz83tW+EUJ2h1yNiqIeGfUR2kdBYS05sPuK6iPJzeEN6fR9i6/h6pvYmwSNYecXqqlmOEryko63Lb/1iY3S94LdnhJv6+InW5ut/9QRc4e7uqo0dLXS0OagBjcrCCRe9K7cV/hwsJfD/CgU4bUxV1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vBtY5t+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6546BC116B1;
	Wed, 12 Jun 2024 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718218195;
	bh=5cqqrEtUCEY0Yc5ek54KC7e09wajHxelaNfwhyWhtM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vBtY5t+L/gOK+HRJWRGeCZ7YnK5/sulKCUlzdXbL0ye2bPVcsSiasvDn++GqBbxKp
	 r71eb1QqtZgjIt5aXFlsoeyk5lrOrsegYFC2d5OF8jmWPNz0W6vp4dHXQOv2ipVj+U
	 VUZCaPEui4LAGTexBz5WGz+HNpRk0E8Rb0sCdfoU=
Date: Wed, 12 Jun 2024 20:49:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: stable@vger.kernel.org
Subject: Re: Regression Impact from Commit dceb683ab87c on Kubernetes Hairpin
 Tests
Message-ID: <2024061212-reliance-cycling-66e4@gregkh>
References: <AD9EB3AD-7A36-4E54-9BEC-02584A4DF11E@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AD9EB3AD-7A36-4E54-9BEC-02584A4DF11E@linux.microsoft.com>

On Wed, Jun 12, 2024 at 10:57:03AM -0700, Allen Pais wrote:
> Hi Greg,
> 
> I hope this message finds you well. I'm reaching out to report a regression issue linked
> to the commit dceb683ab87c(v5.15.158), which addresses the netfilter subsystem by skipping
> the conntrack input hook for promiscuous packets. 
> 
> [dceb683ab87c 2024-04-09 netfilter: br_netfilter: skip conntrack input hook for promiscuous packets.]
> 
> Unfortunately, this update appears to be breaking Kubernetes hairpin tests, impacting the normal
> functionality expected in Kubernetes environments.
> 
> Additionally, it's worth noting that this specific commit is associated with a security vulnerability,
> as detailed in the NVD: CVE-2024-27018. 
> 
> We have bisected the issue to the specific commit dceb683ab87c. By reverting this commit,
> we confirmed that the Kubernetes hairpin test issues are resolved. However, given that this commit 
> addresses the security vulnerability CVE-2024-27018, directly reverting it is not a viable option. We’re 
> in a tricky position and would greatly appreciate your advice on how we might approach this problem.
> 
> Thank you for your attention to this matter. I look forward to your guidance on how we might proceed.

Is this issue also in newer kernel versions (like 6.1.y, 6.6.y, and
Linus's tree)?  If not, then we might have missed something.  If so,
then please work with the netfilter developers to work this out.

thanks,

greg k-h

