Return-Path: <stable+bounces-169710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D15B27D0A
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 11:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38961D229DD
	for <lists+stable@lfdr.de>; Fri, 15 Aug 2025 09:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D023725F973;
	Fri, 15 Aug 2025 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intra2net.com header.i=@intra2net.com header.b="r0Dyl4BA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.intra2net.com (smtp.intra2net.com [193.186.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DCB20B803
	for <stable@vger.kernel.org>; Fri, 15 Aug 2025 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.186.7.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249488; cv=none; b=XknKqZr7juWi8nscU5cfWlGxdVvml/x4iA9C2qeTZF3c833yrAzoA0wflktc7j9lxZ1Y1BLkyFA3P67sdsr82uAwzneEKoPIfkz7wthaiFphyhVLOM1XcHwL3QyD1zpgn8Jo2KBDx1K/gpzNuslhhfIRFNOI/kHzTvLwwBHk/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249488; c=relaxed/simple;
	bh=ZjukBWkX33Zd0Drahy0drCFWzLRXBro57ZoyS2RjzOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpWHFMFe5vu8lF36UQU57yaj1nX6n1+Mur3EroLmvQH9GuURAekNsxFSLgiA/C3gZo99xZ0E0LoS02kQzTuP8c/pOyu+mtuUVZJWQ7NDL1fOjxo9EZTAeRgyJIVFfTTMai6g/+bbKFgx7tVRmr6kpFvzVUvypm9ACCwoYRwXrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intra2net.com; spf=none smtp.mailfrom=intra2net.com; dkim=pass (2048-bit key) header.d=intra2net.com header.i=@intra2net.com header.b=r0Dyl4BA; arc=none smtp.client-ip=193.186.7.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intra2net.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=intra2net.com
Received: from mail.m.i2n (mail.m.i2n [172.17.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.intra2net.com (Postfix) with ESMTPS id CEDEC20073;
	Fri, 15 Aug 2025 11:18:03 +0200 (CEST)
Received: from localhost (mail.m.i2n [127.0.0.1])
	by localhost (Postfix) with ESMTP id C287A317;
	Fri, 15 Aug 2025 11:18:03 +0200 (CEST)
X-Virus-Scanned: by Intra2net Mail Security (AVE=8.3.70.112,VDF=8.20.60.128)
X-Spam-Level: 0
DKIM-Signature: v=1; d=intra2net.com; s=ncc-1701; a=rsa-sha256;
	c=relaxed/relaxed; t=1755249483; x=1756113483; h=Cc:Cc:Content-Disposition:
	Content-Disposition:Content-Type:Content-Type:Date:Date:From:From:
	In-Reply-To:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:
	References:References:To:To; bh=8dY+ZMfn1nOuq2XNiUusBi+/dm59apjnsIhMDFob0KI=;
	b=r0Dyl4BAN1vtTJzNajcu7AeR/tRbQq5LMiQMGaxvEOY89+AnzVih2YJ4KYQJH6bkiYkOV44LsuJ
	iz6PuqUoJGcbW3+znKCUcNWW+AEEkXnoXuXk4N0W4RrDvFB8+8k6zjYIfyI4Cc4XdRJn7VYWF5DzO
	Q47gXrjp9v22B3u5PoNdT5b7I1tDqb0xikO51XVgKfKsy/vIz3a/51GIX2oGPvPgqrM3BKcghEu3O
	OBK1hHg9jm+SwRHNS2pHYdDNHV4u5Z3EkLAuiyO2RuK8MhvwjwJyXN2Tdr2PhuafkNXCBD6zG7lw6
	+aaWp37Ug2aH1Z9TheZ9nKhwBw5Y8nLzLhRw==
Received: from localhost (storm.m.i2n [172.16.1.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.m.i2n (Postfix) with ESMTPS id F3D8DC1;
	Fri, 15 Aug 2025 11:18:02 +0200 (CEST)
Date: Fri, 15 Aug 2025 11:18:02 +0200
From: Thomas Jarosch <thomas.jarosch@intra2net.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Lion Ackermann <nnamrec@gmail.com>,
	regressions@lists.linux.dev,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [REGRESSION] 5.15.181 -> 5.15.189: kernel oops in drr_qlen_notify
Message-ID: <20250815091802.5mqk34hsq5yg74a6@intra2net.com>
References: <20250814211332.lp3ibcp5oopnov46@intra2net.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814211332.lp3ibcp5oopnov46@intra2net.com>
User-Agent: NeoMutt/20180716

Hello again,

You wrote on Thu, Aug 14, 2025 at 11:13:32PM +0200:
> I'm seeing a reproducible kernel oops on my home router updating from 5.15.181 to 5.15.189:
> ..
>
> It seems to be identical to:
> https://lore.kernel.org/stable/bcf9c70e9cf750363782816c21c69792f6c81cd9.1754751592.git.siddh.raman.pant@oracle.com/
> 
> While the kernel didn't oops anymore with the patch applied, the network traffic behaves erratic:
> TCP traffic works, ICMP seems "stuck". tcpdump showed no icmp traffic on the ppp device.

I didn't realize yesterday that the bandwidth management script uses both drr and hfsc.

There is an upcoming patch series proposed for the 5.15 stable queue:

1. "[PATCH 5.15, 5.10 2/6] sch_drr: make drr_qlen_notify() idempotent"
https://lore.kernel.org/stable/bcf9c70e9cf750363782816c21c69792f6c81cd9.1754751592.git.siddh.raman.pant@oracle.com/#t

2. "[PATCH 5.15, 5.10 3/6] sch_hfsc: make hfsc_qlen_notify() idempotent"
https://lore.kernel.org/stable/8f1d425178ad93064465e15c68b38890b10b5814.1754751592.git.siddh.raman.pant@oracle.com/


With those two patches applied, kernel 5.15.189 doesn't oops anymore.
(if I drop the hfsc related patch, ICMP is broken as reported)

Thanks for all the hard work on the stable kernel series! It's highly appreciated.

Cheers,
Thomas

