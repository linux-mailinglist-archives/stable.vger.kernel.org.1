Return-Path: <stable+bounces-83362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5549988D6
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 993F9B2B987
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08051CB511;
	Thu, 10 Oct 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC7CfwzX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908431CB515
	for <stable@vger.kernel.org>; Thu, 10 Oct 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569314; cv=none; b=ZT4BI6jxEyWLa9dQgqKWYUEsVTaq0ZzPicQnCfOAmo0JHvLv1E4u/rcxavw09/435NPPWcLDvsLJT6uL5nW48BSWlpCSgpvG3z88e9imEVEfvYhgy0r0Owjw9px1bw56X6AZkT42j8KfeO11QyluSnW99b2lThzR9VC7b2k62QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569314; c=relaxed/simple;
	bh=xSCZX1TBWIItjzLN5OOkULJXKlmgSXHuWkvbuKZsiqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXuXH5cFYCKcURR8ieuAUeSZxeMvDVD3ZY7bnF7PUV5fGC26V0mcX15rjCH7O8ZYEzlM8ofa1X4ewWA06BQtqY0a1oMq6QrXtgAMe1cpu1Um51ARyT/XODSNfhVRvkJgn9diiCibdcm5QCZBDhc1Z3dD+gK/qKtQDjBpt/2fbxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC7CfwzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC65FC4CEC5;
	Thu, 10 Oct 2024 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728569314;
	bh=xSCZX1TBWIItjzLN5OOkULJXKlmgSXHuWkvbuKZsiqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jC7CfwzXRt9w224byL1+xLviFIGHuXUSaqrP45XPB7h14TZcqPrhPfS6Jfx7OWLmh
	 NGxpd9VJqU+mvoyW/i2UcEKm0eW0O9MxGcJzFxZ2+B71Ba+qpYtbnJRbtVZRPrdHxk
	 zHYZfe5yawltJTUKXqRcXDvfC4o7KRbLEx7nYj9rW1zVJa6+sFGiFTHz6k99TRn6Or
	 rCtGyt28BEm6fZ9PuhyPymjyU9kfnG/7PnJQJE9VsKhS1ps51IlzygN0c9pKNy27Uv
	 gHLUR4F8oEl8udSJ2+mIyqGI9NrFTdA+/mIsgSBzyUZJx2CAH+Oqs1rd2B8WL8hUMz
	 W+X3e0VJ+AksQ==
Date: Thu, 10 Oct 2024 10:08:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, jiri@nvidia.com,
	gregkh@linuxfoundation.org, vkarri@nvidia.com
Subject: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering a
 devlink instance
Message-ID: <Zwff4AQe7irl4KZu@sashalap>
References: <20241001112035.973187-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241001112035.973187-1-idosch@nvidia.com>

On Tue, Oct 01, 2024 at 02:20:35PM +0300, Ido Schimmel wrote:
>I read the stable rules and I am not providing an "upstream commit ID"
>since the code in upstream has been reworked, making this fix
>irrelevant. The only affected stable kernel is 6.1.y.

Could you please add some information about *how* the code has changed
so backporting became infeasible? In our experience, custom backports
tend to cause more pain than what they fix, so at least our
future-selves could use some pointers around what happened here.

-- 
Thanks,
Sasha

