Return-Path: <stable+bounces-124273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF713A5F286
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 12:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C693AAD43
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF581F151E;
	Thu, 13 Mar 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KzNC/Sa6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A241F12F2
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741865652; cv=none; b=Q4fuRc6KgLnfBisLrGjWWG2L7nPH66ZnyHWj6E0Nsg3mJPdR+tZQK0cThilxX5+nc8DUWr/NyrFlUcb8pvbujRybnCPjvuChTGkyqb063+LQ5aDDAOL8IPuyVvfY9xFtqUesZDsWBzgBD4FjC1lNWCjHQvjBV9AwIACMLONqZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741865652; c=relaxed/simple;
	bh=wh2IgGrQFmDHpQ5RChgOkJNJKSZhBgVnl3recOvnaiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFqxJI9PKKo3wgehPRbVz/ilz/VuQ0CBZGTFUUOjPLnAE8zciyDrROxMpTfw/rdcZ0U9ri77rSlQusF2KSupJZwUxlVKpRMQJR3QlVxgRxhmle2lV+rx4NsomNfaBqlgDmcW6yCMh3us8VRMsU27uGo3adqFo5cd3gdxlAFY/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KzNC/Sa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAD8C4CEDD;
	Thu, 13 Mar 2025 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741865651;
	bh=wh2IgGrQFmDHpQ5RChgOkJNJKSZhBgVnl3recOvnaiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzNC/Sa6yh+9B5NS2UZ8rkSc3h6MV+z/VOfImmob2TR3LdA+lvZSkJOjqGmrMZNYL
	 dQpk+9h/jrqYiikjCBOqdnp6tYL9Oq8/YJ+9Y5QdJZKdYvaaJy+dPw5MZAakU52Ntp
	 /3ULF70lDd3RZXkOsfPGMJ5Gu86J3qjvXvEpr+8s=
Date: Thu, 13 Mar 2025 12:34:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.13.y] virt: sev-guest: Move SNP Guest Request data
 pages handling under snp_cmd_mutex
Message-ID: <2025031300-unstamped-devalue-ceff@gregkh>
References: <20250312223932-352a4f3bf0ca25bb@stable.kernel.org>
 <4b8da939-7985-43b8-b0c6-12e5871be632@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b8da939-7985-43b8-b0c6-12e5871be632@amd.com>

On Thu, Mar 13, 2025 at 10:09:25PM +1100, Alexey Kardashevskiy wrote:
> What does the tool not like in particular? The fact they are different? Or
> the backported commit log must have started with "commit xxx upstream." and
> "(cherry picked from commit xxx)" is not good enough? Thanks,

This is showing that the diff is totally different from what is
upstream.  Why is it so different?  Why did you not list your changes?

Are you sure you got the git commit id correct?

thanks,

greg k-h

