Return-Path: <stable+bounces-56257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6140991E2A4
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD28B23817
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7F616A942;
	Mon,  1 Jul 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E5ejJY6d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0B168C3F
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844545; cv=none; b=uk8wv77PtOJKp7lmazZHOZiPx81broGO+vumkbzlbRw6YR6mm0PmoqQyZEH+Ph5IWGjfOx6Gun20LXQ45LOhD+8a1efbWS19YNe1xv3Vp+PpzzxpxWDmssAKvB6Pigqn3yPTdn68D3uAeyTlAUN1JDyj0heQUm6u/eEQdlryAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844545; c=relaxed/simple;
	bh=FfmhaNUFopkEViYyFlj/x/X/Gcz4eKjkdOt5E/w/v6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iD/ngOVlTTcvDd45iT4G9D2/iwgIMEpUA4uOM7xrxyi4wlLEJQpxqOiWpatw5aHQ7C5ZShq49oxFCRVYV6EGA8/vPG1risV5S2PpNkKtOIW9hl4oJZYskfycsKCvjSchgAOBL3j4vjcgjbYYhQM9TX+r/Is2olau7r1URYlFal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E5ejJY6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952BC116B1;
	Mon,  1 Jul 2024 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719844544;
	bh=FfmhaNUFopkEViYyFlj/x/X/Gcz4eKjkdOt5E/w/v6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E5ejJY6dUDuUSfowSkEH26O1wthFE3BwSJni9KU7ZwPyxJ4MAKCepezYluN7tvCeF
	 qPVhqy1K1kqHVrzgGJksk90RE4yjZ+FrjPMsu7aPeqiriXuZiLB7MB0iaDAtQfRs+m
	 1EWRTkBqZK38AxiM601U/8A+Fs4iHwN5seiwcveA=
Date: Mon, 1 Jul 2024 16:33:14 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Aditya Garg <gargaditya08@live.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [BACKPORT]  HID: apple: remove unused members from struct
 apple_sc_backlight
Message-ID: <2024070140-daydream-peddling-986e@gregkh>
References: <6919952F-1AF6-4D16-BE61-686C5D8F5A87@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6919952F-1AF6-4D16-BE61-686C5D8F5A87@live.com>

On Mon, Jul 01, 2024 at 02:18:55PM +0000, Aditya Garg wrote:
> Commit f740106aedd3 (HID: apple: remove unused members from struct apple_sc_backlight) in Linus’ tree imo should be back ported to:
> 
> 1. Linux 6.6
> 2. Linux 6.1
> 
> since there hasn't been any change to the backlight code in the driver ever since it has been upstreamed. So it should be safe to remove the unused members from struct apple_sc_backlight

Why?  What bug does this fix?

Have you read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

for what is relevant for stable kernel trees?

thanks,

greg k-h

