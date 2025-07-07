Return-Path: <stable+bounces-160346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDAAFAE4B
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 10:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3613A6FC4
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 08:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6415028A415;
	Mon,  7 Jul 2025 08:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MJL2yO/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1929428A1FB;
	Mon,  7 Jul 2025 08:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875897; cv=none; b=jaCjAIaSlGHOR6cPwvxkQw2Sn7NFSBdVX8ja0wxo2XSUutjLg1stBIheMbQ6dhmU9j2Mrr2O13Cy1Z3gSiGOMlPtVeIjjMv7aLf2toFPVjWijtxuYbdhgWEbgy1lj4PG27PJHSX81S9BoV5dP3f3OI2qDlGopSWPedHmMt3O5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875897; c=relaxed/simple;
	bh=AuS4Y0RphuaNbDqlc4DmWzN/ObzZ4oMxIshG6yLIb0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc3yg8kFflZ0RV0qvdh9kAHb5cYsko/B74A4B/YK840S3T+lIh3SG6PAozDp8FoVtld++ULhQGG3AfsPBESx/YFOxk+XdtksjfVHi6vRdJBpQX7duZJmtllCMxmCoGWGDGMDsy39FNS3MIt7YaJIjZ9XE80mk7JwxgyNZUr+42o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MJL2yO/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDE0C4CEE3;
	Mon,  7 Jul 2025 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751875896;
	bh=AuS4Y0RphuaNbDqlc4DmWzN/ObzZ4oMxIshG6yLIb0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJL2yO/KVgQhhysmSI9JWHyYX0CZoYwbOB8fo3I7Brr3RAotmgRUPJvJIoMrovvBY
	 j3joE6Fhd/3qpbmddVi0+XLAcFuRxmsMu3PeqXhTu3EjgJj7yggEvx/uwlCYt9N4ek
	 W054dzcji1MixhOmI3AFt4xDBxauuKrJ/1csqjDg=
Date: Mon, 7 Jul 2025 10:11:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Eggers <ceggers@arri.de>
Cc: stable@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH 6.6.y] Bluetooth: HCI: Set extended advertising data
 synchronously
Message-ID: <2025070719-kerchief-framing-0e14@gregkh>
References: <2025070625-wafer-speed-20c1@gregkh>
 <20250707080204.21335-2-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707080204.21335-2-ceggers@arri.de>

On Mon, Jul 07, 2025 at 10:02:05AM +0200, Christian Eggers wrote:
> Currently, for controllers with extended advertising, the advertising
> data is set in the asynchronous response handler for extended
> adverstising params. As most advertising settings are performed in a
> synchronous context, the (asynchronous) setting of the advertising data
> is done too late (after enabling the advertising).
> 
> Move setting of adverstising data from asynchronous response handler
> into synchronous context to fix ordering of HCI commands.
> 
> Signed-off-by: Christian Eggers <ceggers@arri.de>
> Fixes: a0fb3726ba55 ("Bluetooth: Use Set ext adv/scan rsp data if controller supports")
> Cc: stable@vger.kernel.org
> v2: https://lore.kernel.org/linux-bluetooth/20250626115209.17839-1-ceggers@arri.de/
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c |  36 -------
>  net/bluetooth/hci_sync.c  | 213 ++++++++++++++++++++++++--------------
>  2 files changed, 133 insertions(+), 116 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

