Return-Path: <stable+bounces-40108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB698A852B
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 15:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE291C20F9B
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 13:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C74B1411C3;
	Wed, 17 Apr 2024 13:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khYE0Yz5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FC140E46;
	Wed, 17 Apr 2024 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361551; cv=none; b=PALo7O0FNVktoG00JTPAdHjlC3O7/VW4yBMaxmOJTJ32VCObFB61c+rQP6HLBmpkirp0GHPypkIs48n0mW0Q65idz3fCGc0aaXFyoyW44uX4uyOF75gAEYz+zfHckXT/sMopuQDFs1VZetggPxYWLMx30fUuLV0VuluQC/sIYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361551; c=relaxed/simple;
	bh=mTuRb29PJruHaneu87Xz2mpD+05AIxrJJUP9rmuaKYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMEoHKtk/DQz7Gp/W0TwLYKncwyfmCk7FM2sOfqUcx/y/6JGTTXoIGUyQKGsl/961ft0e9m0t0ec7/8EVjFKH5+JTnhv+0L3buPz4Bs9NpIi+CbPGfZbKareGBIosEIGwSYIVmZfLUgHkeSgJLHcS42J2Emg69uyaxtkoMBMH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khYE0Yz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A42C072AA;
	Wed, 17 Apr 2024 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713361550;
	bh=mTuRb29PJruHaneu87Xz2mpD+05AIxrJJUP9rmuaKYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=khYE0Yz5QCQ5jMeS9MXJqYG10IlzoaJ2QxzLH/zTw9crbM/9tSi7f7+44+MSgkiOC
	 Otg5BpA5zrhfgw4xmq2+w8WUo7OFhRbsuoYDaoFqFI5SJIXcjI3U4JOLZFZC/xEcNy
	 2XL77018Iz2qgSopcpMgd2ZvvZM9kW+5bAkmonLW+5OYM4XnsZumHpriP8LiyzJXKT
	 mRvqnllv++xNo9IWEvSg/uFmMTbAAxCfRwyFnbgC15FhoQtD6llfnKxq3yJKPMA9Hu
	 cAHUtBY2tuX6AhZcgIy3qRl6TSneBZwoacRMPzHGHvcxgonwGekZDMAC2J8l7N+A8I
	 Gh8f12Hjl0Fvw==
Date: Wed, 17 Apr 2024 06:45:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <20240417064549.10ed50d8@kernel.org>
In-Reply-To: <4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
	<20240416193458.1e2c799d@kernel.org>
	<4b0495fd-fab5-4341-9b06-2f48613ee921@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 08:02:31 +0200 Heiner Kallweit wrote:
> > Looks like I already applied one chunk of this as commit 97e176fcbbf3
> > ("r8169: add missing conditional compiling for call to r8169_remove_leds")
> > Is it worth throwing that in as a Fixes tag?  
> 
> This is a version of the fix modified to apply on 6.8.
> It's not supposed to be applied on net / net-next.
> Should I have sent it to stable@vger.kernel.org only?

Ah! I'm not sure what the right way is, either, TBH, but I'd have
put [PATCH 6.8] rather than [PATCH net] in that case.

