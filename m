Return-Path: <stable+bounces-106609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5AA9FEE70
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 10:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E06216200C
	for <lists+stable@lfdr.de>; Tue, 31 Dec 2024 09:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F2A191489;
	Tue, 31 Dec 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="2Qbg0BlB"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844E513B7AE;
	Tue, 31 Dec 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735638172; cv=none; b=QGZW56C9F2lHWjWYdzsM75leLb12ozJkriFr2miWBLwlBZaASLHgaVugT/JdXjB1bohURxYQH/iuh9/yMXOvoIGF52zZoH/0qFlxSHEHnaPsU8IYmgfA+8O2/FyrK4h0Ldtl1nMIyxt5G322fwSU/6/M7Xeqbn6sW5UUxkfzpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735638172; c=relaxed/simple;
	bh=VeQfEuGI07f4Rxz+aAf0Qdj5MMWl9Z735y4Y8f7Dv14=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al58R2aihwExiasjPGpn6G+q0f6INMO4fRUujjXLfM8h9Tq3c/JbkwDmwNhKy5SQ8I/W367PKZ9meSRYp4X0uA28QloiRSoc1u5w3uUVQi7pG2Y+znVZKwQG7UbKo0hdCfzqo7I8mj0DmrB3xLa36LYFMCPZEHUr4BkktrQjEd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=2Qbg0BlB; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 31 Dec 2024 10:42:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1735638162;
	bh=VeQfEuGI07f4Rxz+aAf0Qdj5MMWl9Z735y4Y8f7Dv14=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=2Qbg0BlBXo9IVaVTZnmMGtKFEW6EZp7CNnqmHeIcUA56r2yHQc3A8dX8MfNHWHj61
	 rpFPLggGOmPYOmiDhNSH/vzLnQdOR1ddqwJ2dat9hVJ9JavD+0pd4J0CzWoMUpktaG
	 4HkyM+LWQrVuAhnFSRlPcniHzSIGb8X1FIwcfHweV/FnIT6vEKYeVRQSdGwF8XFZOr
	 jNJ67Pf+WD8Hf3udbaGaqrk1fxQt7DuRF82ek/XaGH40uTvZm06akL4cbekP/O3vNS
	 DKzHPkr5ZgEpKv1sgM2qZ9+9xzz5M2Z8KPYCk5ZXxlujD+Cl9j56W6AQZSo2NC5eSc
	 4jB03CdQ6JOpg==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/114] 6.12.8-rc1 review
Message-ID: <20241231094242.GC17604@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241230154218.044787220@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241230154218.044787220@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.8 release.
> There are 114 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Jan 2025 15:41:48 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.8-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

