Return-Path: <stable+bounces-199960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DFCA2816
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 07:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F9B0309D875
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 06:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156F25334B;
	Thu,  4 Dec 2025 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tlc7BWdE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EC11F2BA4
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 06:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764829142; cv=none; b=pmOZu8Swh2bzTmXj6uVpKH5FejDlaI28xV+by6UTtl0YaRCPbkqSIklSsfT7GP1hBtIVl7dc+CupupKxYKCKDVysnT5Jmu7hX+LmTi2t3oV5DzYLHZoHjMoHHm5MzRmmFUdpQ9XeM6wlIclZo+irEjlNLfL5ujAlzQZGhRPaK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764829142; c=relaxed/simple;
	bh=YBTP/QijRC5bX1m6tRcN4bOdAgClgytyHMAm+XtlcfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUwiGyobxD/mmjsR/XE0DEW083Qpjx1Eu9+lfaOgW7liFaiCSzZEnF3tjSIkPYW4aEvwMIxTjXJfJW8Z1ETl2kqCTNo/VENST98fcPH8OF4emWczOOIYEF57tZWzUR6MjzQg1wt3B9AqbmxftACUHmSKHAgrSeqm+okjivH54UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tlc7BWdE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91531C113D0;
	Thu,  4 Dec 2025 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764829141;
	bh=YBTP/QijRC5bX1m6tRcN4bOdAgClgytyHMAm+XtlcfQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tlc7BWdE3Qjc2RRcXSL9tqJxOl3sW5qS8ax3ZYAVd9s3SHOvBxCRHWsiXr8Ojv0Bo
	 rZvY1IY9zrlAsE1fWgrKz5BiPTQVFYRKEvV2cbntmD0JM5/ARj5Z/B1rvyzB+E593i
	 veSUKJsBWN3vLudKumO8/GtHpGhhIMNBc6ZSd+3E=
Date: Thu, 4 Dec 2025 07:18:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: kernel crash when use zstd compress 256gb qemu raw image file
Message-ID: <2025120420-headache-tumble-c5aa@gregkh>
References: <CAE2XoE88ptwc9cG8U18gMPOd1nx8LfMtWn8Urtuu892LRJ8CFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2XoE88ptwc9cG8U18gMPOd1nx8LfMtWn8Urtuu892LRJ8CFQ@mail.gmail.com>

On Thu, Dec 04, 2025 at 04:47:07AM +0800, 罗勇刚(Yonggang Luo) wrote:
> Dec 04 03:29:29 32core systemd-modules-load[916]: Inserted module 'zfs'

Please contact the zfs developers, nothing we can do about this issue
here, sorry.

greg k-h

