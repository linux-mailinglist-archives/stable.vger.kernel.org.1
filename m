Return-Path: <stable+bounces-40057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B908A7A9C
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3741C20C36
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 02:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC4F4685;
	Wed, 17 Apr 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnUVkHEm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862608473;
	Wed, 17 Apr 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713321300; cv=none; b=V3PE/DvjH0ysUuCck4wXh0jicRfL1Z8CZUHnm/YbReCzYctLrWwk2thD4OZE7YStm9ZaW+Ei8iOLfY+o0blEdSfJ/tJirka+iN0JG9K9wWxJiDIcCIXHK0Ytqjip0mAU559aM4D5gywuQ4q8J++56Tcutq3OkAzUounolbidxjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713321300; c=relaxed/simple;
	bh=PwtNyAUqYeLA/ZzIZw1/JcXG8Pm9mxj3eHACFz+Ms5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uT6wSHim9JEw/YlnJz1kP3XqYsALyYdVugTRLpE725hv/HTDkFWXKThrb15n3wYevPN6eI+EbtQBSpylqDpzZeK/Wp0ecEvpGzDI10369tTGQFPqr1hmHoEJ+d3znIkl2giFQCDUYilG2C63+mlUbIeiSuYh7kdUwQ489hZtBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnUVkHEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B1BC113CE;
	Wed, 17 Apr 2024 02:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713321300;
	bh=PwtNyAUqYeLA/ZzIZw1/JcXG8Pm9mxj3eHACFz+Ms5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GnUVkHEmpS/s2VNfUMNt95/d0XaI/3UqdvstXdznOgtpcvT+UOzMm8xrbx4VAHtcI
	 bu8kJzyu02Qc+zd+4+tDra68gbK+L2dFAo7oLvRv2WKaumo+7R1WXjbqct2cgRYf2m
	 NJP2P4m/GjeyiYI62OEayYXQT+kGEf1jVaYwi06WMgkYQEs9nuMkB73xLBnNfGH4Kb
	 shL2vLVVZ4KFLseoj20O5Ekazbjwm0FAXPh4Z46vK/tSoLwKd6MatMw2TItTEgtdnS
	 0emKKXttq7OS1OBB69K8Qhk9GFkvMw9RDpIHwFQBNL3nAjmrmA6DIGbGvNzxPny4YM
	 J8wuKUUc2xhUQ==
Date: Tue, 16 Apr 2024 19:34:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <20240416193458.1e2c799d@kernel.org>
In-Reply-To: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
References: <ded9d793-83f8-4f11-87d9-a218d10c2981@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 13:57:17 +0200 Heiner Kallweit wrote:
> Binding devm_led_classdev_register() to the netdev is problematic
> because on module removal we get a RTNL-related deadlock. Fix this
> by avoiding the device-managed LED functions.
> 
> Note: We can safely call led_classdev_unregister() for a LED even
> if registering it failed, because led_classdev_unregister() detects
> this and is a no-op in this case.
> 
> Fixes: 18764b883e15 ("r8169: add support for LED's on RTL8168/RTL8101")
> Cc: <stable@vger.kernel.org> # 6.8.x
> Reported-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks like I already applied one chunk of this as commit 97e176fcbbf3
("r8169: add missing conditional compiling for call to r8169_remove_leds")
Is it worth throwing that in as a Fixes tag?

