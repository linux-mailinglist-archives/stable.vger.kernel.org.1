Return-Path: <stable+bounces-87000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B92A9A5D61
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7BB1C220A8
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2023C1E0DE9;
	Mon, 21 Oct 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cdUIg4em"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B721E0DD4;
	Mon, 21 Oct 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496654; cv=none; b=XSSqYGhWhMg+1622uLc0411jvDUscAhfMVQU2kCny+QsFB49emuyEU5cY8CjFMYz7lEmEPI0wYZqGivFZQpSaKpe8ert+bM6aPLZRk1UJXeZsAef/rL2Fq7SELKUiovCIAWyj+FJlagj8+j927DY7k6EmQvS9DZZLAqKaVzAzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496654; c=relaxed/simple;
	bh=dmEkpj1SX2e3mHQUhOKtpvrPvJet0vNsLVPj9d+IIGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoD5JOQduKijBnH8WerH/3x1RkcAGxMrI6T6RybSLUwRx+SrQfS3ULNFLRR4bQ3h76zSk9FiKcSnNJRMhqbsZDQg/gr4qonHu+aji17a6JO2WdDPZwdj6QT7CGW8i3iSGNPJWICvo9GW/i80xfOXk3Y1biLHR/iN5K0J/ap0+vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cdUIg4em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C041BC4CEC3;
	Mon, 21 Oct 2024 07:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729496654;
	bh=dmEkpj1SX2e3mHQUhOKtpvrPvJet0vNsLVPj9d+IIGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cdUIg4emr5YXIh+f3xr5HDRub4+1C+zEb6YP7bg9qG9t/RYh6BfGLFtrnnw8s18/l
	 CQ/e5Ex/ebMSaMtO6xFM/5fv9w4D9uSVuYQ8UDXTKAyPqPmpkKbavrQKR2xeLlc8ak
	 S86PAlvWrebXu7QbPEe8z9HVlkYnk0JaoN/tSOf8=
Date: Mon, 21 Oct 2024 09:44:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: Pls pick up two bluetooth fixes
Message-ID: <2024102100-spongy-etching-0695@gregkh>
References: <2fad9d09-c328-4353-be0b-cfcfef33ed01@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fad9d09-c328-4353-be0b-cfcfef33ed01@leemhuis.info>

On Mon, Oct 21, 2024 at 05:28:25AM +0200, Thorsten Leemhuis wrote:
> Hi Greg! Please consider picking up the following two bluetooth fixes
> for the next round of stable updates, they fix problems quite a few
> users hit in various stable series due to backports:
> 
> 4084286151fc91 ("Bluetooth: btusb: Fix not being able to reconnect after
> suspend") [v6.12-rc4] for 6.11.y
> 
> and
> 
> 2c1dda2acc4192 ("Bluetooth: btusb: Fix regression with fake CSR
> controllers 0a12:0001") [v6.12-rc4] for 5.10.y and later
> 
> For details see also:
> https://lore.kernel.org/all/CABBYNZL0_j4EDWzDS=kXc1Vy0D6ToU+oYnP_uBWTKoXbEagHhw@mail.gmail.com/

Now picked up, thanks!  Hopefully this fixes the bluetooth regression on
my new laptop, I haven't had the time to bisect it yet...

greg k-h

