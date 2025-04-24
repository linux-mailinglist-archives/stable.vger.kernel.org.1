Return-Path: <stable+bounces-136615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F357A9B5D8
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F6E1BA6DA0
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A7B28DF11;
	Thu, 24 Apr 2025 17:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="Gy8bZ2RU"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABD280CCE;
	Thu, 24 Apr 2025 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745517508; cv=none; b=Wj3mC2RxM8f5svANljDM8D3rRKNkSlGYAgOtagQDvsbEkTv6FfjIf2jy+7+FdvjtkVVlLr0g//Nt4cRM2zh0l63+T77/rYZx9/xL08e0DoRlrJsOp33VoUXo6GiKVTOwtwixld4qn/ht4x7JujRCw31kto72/1ZNZflbRCJLs84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745517508; c=relaxed/simple;
	bh=AR5JKdIo+O0YR1XsiQaFGrOTyAaUZ9rKxU2HHu5lKfA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EcBohm7EPJNk0F7zRIkkVOK0uDEhVDbhy7u0lhgNTva7AvEXtXDKPm9Rz7/+avgkORLiut0XNxR02ZRYYPtH4jlcEZ2SI+qLzzej+sEI+sGqdvBHdvz2y2F41IAoy66ykfHPcKYVEXf2Rk+S8seNuLAzpwMOQ5vEtNrh8togeTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=Gy8bZ2RU; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Thu, 24 Apr 2025 19:58:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1745517499;
	bh=AR5JKdIo+O0YR1XsiQaFGrOTyAaUZ9rKxU2HHu5lKfA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=Gy8bZ2RUvXROCsWo/6kkoWYEs8KNOFylD16In2E/H8XvxGaaVLpOfzbsZ722heReQ
	 DXyVT+zdXp917ZbSE7MBF00tknM0v3Tg0LxVKjTozYwI3IDNiVI8FTb+TwL4ln9nfx
	 Bn/Xl/GkUCzMGjFhnI8BuaNQCRplSBsM7aY9iYd1tYPksryroRX37WNKIwDHKry3UM
	 LAKDoTmmEzf9mQB30tyBdOLD9l+Z7YSdNeSfIExqD86FhR7THr+N3uEPgMeNruHlOs
	 hiDO78qpfUyYOlXD6GPdihj9lIBYZRclgGmwuuuEe7tispHs5uHuVzSA3aQEB0sssq
	 HH4bpLEaPdL8g==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.12 000/223] 6.12.25-rc1 review
Message-ID: <20250424175818.GA3374@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250423142617.120834124@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423142617.120834124@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.12.25 release.
> There are 223 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.

Hi Greg

6.12.25-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current).

I noticed that in 2 of 3 reboots X is slow to start (but is usable) and in dmesg I found this:

[Thu Apr 24 19:34:11 2025] amdgpu 0000:03:00.0: amdgpu: Dumping IP State
[Thu Apr 24 19:34:11 2025] amdgpu 0000:03:00.0: amdgpu: Dumping IP State Completed
[Thu Apr 24 19:34:11 2025] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled seq=4, emitted seq=5
[Thu Apr 24 19:34:11 2025] amdgpu 0000:03:00.0: amdgpu: Process information: process Xorg pid 1733 thread Xorg:cs0 pid 1734
[Thu Apr 24 19:34:11 2025] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: MODE2 reset
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, trying to resume
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: PSP is resuming...
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: reserve 0xa00000 from 0xf41e000000 for PSP TMR
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode is not available
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucode is not available
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
[Thu Apr 24 19:34:12 2025] amdgpu 0000:03:00.0: amdgpu: SMU is resumed successfully!
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 8
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 8
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 8
[Thu Apr 24 19:34:13 2025] amdgpu 0000:03:00.0: amdgpu: GPU reset(2) succeeded!
[Thu Apr 24 19:34:14 2025] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!


Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

