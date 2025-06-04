Return-Path: <stable+bounces-151408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98111ACDEDC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 15:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960A71671E5
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034628F50C;
	Wed,  4 Jun 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3Id9F6T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278928F94F
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043186; cv=none; b=ori19K73GXMTDW/yskvvBwAOpx5AUYG8tF+Gpl6kNQmPUG0Z0nSJYRbXy6m+hrlUQ0aUALp2zJMBH0s5WJs/0maXVLzL5thwIYMAn9mwXU5afP26ag1G3hG0JHn+XogzW7uLZgEEyT5RDnR1WrvtV3+MMxzGVtHzEnF1R4gEzLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043186; c=relaxed/simple;
	bh=LhX1nGEIFpqqQAtJWLOHYp6jxZz8kEpS0fc5qnrh7Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W28g1WYzLeumL4v/Htkre/FQ9LhMmkfyQCpN2dhm6PCOUZSeeXgB/rt66dRMkAq4e6PwNJ7ZyUBZfBwGuLH/Ei98eeZE8Nyp9X9W3dZXYZeGPYZhXltu373BJor/5oAIvGo0bYmCUp1fobRtH/6V8DjiGxCxITA4SN5Y3P6YRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3Id9F6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0826DC4CEEF;
	Wed,  4 Jun 2025 13:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749043186;
	bh=LhX1nGEIFpqqQAtJWLOHYp6jxZz8kEpS0fc5qnrh7Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L3Id9F6T1HY8lnCm/Xis6W9FqXbLVDpF14LmByoL5xB4+ajfTeXQIXZvqFqwT0oc1
	 e0bDz/4hBRdV48mIU1WYoPVFTCyKLefyPCQYjlSRHejschprYZVhwN+KhA/A6cDA5q
	 LKhTfWfEu50W3mXaCsNZ4zhcapZZ1PTBetxJ4eGU=
Date: Wed, 4 Jun 2025 15:19:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Stable <stable@vger.kernel.org>
Subject: Re: 6.15 bug fix to backport
Message-ID: <2025060409-theme-computer-fc9e@gregkh>
References: <CAJZ5v0hMdbP_ZHY3t4FKSXfoBmXi_gh0Yp4Mdy-Uuk4Vti6ZGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hMdbP_ZHY3t4FKSXfoBmXi_gh0Yp4Mdy-Uuk4Vti6ZGg@mail.gmail.com>

On Wed, Jun 04, 2025 at 11:46:45AM +0200, Rafael J. Wysocki wrote:
> Hi Greg et al,
> 
> Please pick up the following commit:
> 
> commit 70523f335734b0b42f97647556d331edf684c7dc
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Thu May 29 15:40:43 2025 +0200
> 
>    Revert "x86/smp: Eliminate mwait_play_dead_cpuid_hint()"
> 
> for the closest 6.15.y.
> 
> The bug fixed by it is kind of nasty.

Now queued up, thanks

greg k-h

