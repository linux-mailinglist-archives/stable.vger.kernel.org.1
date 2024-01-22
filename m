Return-Path: <stable+bounces-12714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB30F836F79
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F29A1F26C45
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 18:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BEA3D979;
	Mon, 22 Jan 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UYU+LOM7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CBC5B5A2
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945331; cv=none; b=Vic67eQE4R/2UDhYqziw6MFDyKjWdh1zUk2raZtoge2pYoANtlp01LVywRiqV2z6K1FGvseI3SDfxU+Wm2Tb1hA6gs/aC5oDbAdoBA5KnEY33rTgGx1bkFdqVgA77/YR4SSIcCSWnc4lEQ4C8XlA2/PRNMJkhw56I5x5QJdsF/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945331; c=relaxed/simple;
	bh=yBEg1LEC7VYmOzRbG/GOfngqrlA+/1lphbz5Y3CwqW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6XqJeUtEbBBlmp3K5Z4DaL0amV1BvZYzmxWr/RAI29zP3GC7DOMNzZyndTfMbhs8SqyGXnmeJdEG4KUqmBGwHGxvYcpOV7+9L6aKbT0Z5FRX2Zt5BdQJU0d1KdHsBp0VpQk6g7lv3YridEeXIQvGUTRvPWE6noZUVSa6EKa4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UYU+LOM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A5CC433F1;
	Mon, 22 Jan 2024 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705945330;
	bh=yBEg1LEC7VYmOzRbG/GOfngqrlA+/1lphbz5Y3CwqW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UYU+LOM7BX2Q4y4d8pWaZo1QstxGmwwc3B+EUavHh5VcQbNEsUgjfipQOjsKjOemP
	 Yy+71GHJ/MHRX+hUAh5+Ixbl3K5VX6h1fcNDKWEu3cpbDx4S6GKX/dhucaWBGWUFL2
	 WfN7suLo4VqFPMKbmx9MJsKYkRVMV+A6w7nBgGCY=
Date: Mon, 22 Jan 2024 09:42:09 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole"
Message-ID: <2024012204-grasp-studied-b6f6@gregkh>
References: <CADnq5_MYFeuVtaCMVo6wuy8tXn6iui1sGRLANfc5FTmcaHW8Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_MYFeuVtaCMVo6wuy8tXn6iui1sGRLANfc5FTmcaHW8Lw@mail.gmail.com>

On Thu, Jan 18, 2024 at 10:30:32AM -0500, Alex Deucher wrote:
> Hi Greg, Sasha,
> 
> Please cherry pick upstream commit 0f35b0a7b8fa ("Revert "drm/amdkfd:
> Relocate TBA/TMA to opposite side of VM hole"") to stable kernel 6.6.x
> and newer.
> 
> This fixes a segfault in mixed graphics and compute workloads.

Now queued up, thanks.

greg k-h

