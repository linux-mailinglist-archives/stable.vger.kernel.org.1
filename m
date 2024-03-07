Return-Path: <stable+bounces-27098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025FD8754FA
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951C51F22F6F
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3A412FF9B;
	Thu,  7 Mar 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAi4/UKe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078D101D5
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831662; cv=none; b=AHjQY39R092LL2eFXpN33+wGr6AHCnbVoXeqQ25ihMEymhgOpUqHGxKZYDz+bhPzGO6YBwm2+XKTiQcFpTgomdAgOD8z4xSYiNioHtPEhpvN+lwUg9PFdB7GeIptoXYul4H3oyvlIWgMNQ3kJ/AeDQDh1j+OGGAwn0htkAueYMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831662; c=relaxed/simple;
	bh=Lu6nfXUi0tTkWZIxx/Rim8qOQ4DLRIn/2cQGTUkykBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6NVse+0P5NkR341jqbh5ld9OtvEfAbk0qwJTubd5cCyeGu6ryKPrGdIKv8qwTA8w3hPSIM3D2wmEJEjdUGZBjLyI9HAIMlLbWuhn3t+yG7hPKVJ/z445ocDn/yHuwj+k/4AL7xfUWBLarR6rCPtVAmeBshjA4w0JVV++AcOzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAi4/UKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F86CC433F1;
	Thu,  7 Mar 2024 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709831661;
	bh=Lu6nfXUi0tTkWZIxx/Rim8qOQ4DLRIn/2cQGTUkykBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAi4/UKeH+g63JcOp6vz7CReLhl8QRDNT2OVwSmcc8iTaIUwJMrD1b8RByhcmnpm3
	 eh7H+pRlZGRnv6+yW3z6muRmv/wlBxLwgIvCcG50BZ52VHUTWUPkt2ZqIzhs4PLW4R
	 o3AmF5xiUCrqkrjLQ4yFAsEc4IrKFij2+6tbB0RG9aCwVbjIclEnK4H5P98OM6wEe4
	 85xJ9zMAc3Iq3Fjp9qT6SyHMNmKFomRPexJ6x/Mz1obRfkiV8QAPL8b1PkfwkH3YcM
	 YD6rE0+OtHxmZ3apdNUrKSXp6H4A0uytEqwtzyh8pgF3X0G4kK0pKL88OL32YeeNDP
	 jDnMTc0YU183g==
Date: Thu, 7 Mar 2024 09:14:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, valis <sec@valis.email>, Simon Horman
 <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, "David S .
 Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and
 socket close
Message-ID: <20240307091420.1c09dd0e@kernel.org>
In-Reply-To: <20240307170959.GO86322@google.com>
References: <20240307155930.913525-1-lee@kernel.org>
	<20240307090815.2ab158ed@kernel.org>
	<20240307170959.GO86322@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 17:09:59 +0000 Lee Jones wrote:
> > The 5.15 / 5.10 / 5.4 fixes won't be effective, tho. I don't see
> > commit aec7961916f3f9e88766 in the other LTS branches. Without that
> > (it's still correct but) it doesn't fix the problem, because we still
> > touch the context after releasing the reference (unlocking the spin
> > lock).  
> 
> No problem.
> 
> Should I accompany aec7961916f3 with this fix into the aforementioned
> branches then?  Would that then be effective?

Yes, (and c57ca512f3b68d, that's all the pre-req, I think.)
Tho, it may be a more tedious backport.
FWIW tools/testing/selftests/net/tls.c should be relatively solid.

