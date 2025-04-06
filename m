Return-Path: <stable+bounces-128417-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7F2A7CD8B
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 12:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8050188C61E
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 10:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44414375D;
	Sun,  6 Apr 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JxtRS5C8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YX0OPukI"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5172BB15;
	Sun,  6 Apr 2025 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743934701; cv=none; b=XD3bV+2BZ5gfhrAYEDBtb6+OfEO+BWR6KMr1+/wIOokIF+iC2sOaPNf4QnBzG+GvLNRtXPIzPVcswiyhLH5No9MsH6wbpjEqlYG6CH528UFmHugXSIV69nZCgr+tENTNE8EiIeIGepvX6+4w6ievm3wHeOXePr9d58YVXTR3Lzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743934701; c=relaxed/simple;
	bh=I0l1AmLBc20P2Qs7xhg6QQCPseNDpCqJ8XhUkOVhZPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uo68xkFndkD1N+k9zhaFII0V11PlR8GAvNGudIZosW4cbvh1NvYbsD+b1NqnvllW5/+0cQe/KYIEgx6m+G/7wdDrD2j38paf+P1xDOinyLb8kLlICjiUOWfM2TEPfLeTMsQZ41ZkWYyDbDpQzoG4B4VRgWId4VEw14ha7AXVVBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JxtRS5C8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YX0OPukI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743934697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSOsfnzRMy9D9w4s2M+rmjytWyJ+cG8fZzYT24ApcBE=;
	b=JxtRS5C85HXMWumVICNO7yBH/gRNHQRbJgTCdUPtVteK3HkBvULi/zsI28lE94jbsmRmo+
	nwEwarRJfKeem++VAN8zcXhUDnOioTTgMfwga7k4Q98K3tpwzCIs3gywUdolFAPR1xlgg5
	V/p0Vq+Kgn5yLVZdiOSy0HwSUQd3XGN8T4NdgSVc/KXGiEP73kp4K7WNeGRQ5AojSohfmK
	Heve5T34UCuTrAQT0KYD8kTNC1pxtGEBUM49Jz6xaremwJD+64u2RcR5vOR4r62hUKlhVR
	RI9uIoAi2DWFHUpVvUUEmGTRNhmi7KWDeDUn55j1T7UKEUzAyuyz+UBTPGOlmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743934697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hSOsfnzRMy9D9w4s2M+rmjytWyJ+cG8fZzYT24ApcBE=;
	b=YX0OPukIJZZjIzW75+eW5DK+hqZUsQPkGlRwG+LEuDPQ4LOFMRUJf6u7cpKuaEa6B3uqPi
	MJ9mAJBUNv92uoBw==
To: Huacai Chen <chenhuacai@gmail.com>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, Yinbo Zhu
 <zhuyinbo@loongson.cn>
Subject: Re: [PATCH] irqchip/loongson-liointc: Support to set
 IRQ_TYPE_EDGE_BOTH
In-Reply-To: <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
References: <20250402092500.514305-1-chenhuacai@loongson.cn>
 <87jz81uty3.ffs@tglx>
 <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
Date: Sun, 06 Apr 2025 12:18:16 +0200
Message-ID: <87bjt9wq3b.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06 2025 at 17:46, Huacai Chen wrote:
> On Thu, Apr 3, 2025 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> But it won't trigger on both. So no, you cannot claim that this fixes
>> anything.
> Yes, it won't trigger on both (not perfect), but it allows drivers
> that request "both" work (better than fail to request), and there are

By some definition of 'work'. There is probably a good technical reason
why those drivers expect EDGE_BOTH to work correctly and otherwise fail
to load.

You completely fail to explain, why this hack actually 'works' and what
the implications are for such drivers.

> other irqchip drivers that do similar things.

Justifying bogosity with already existing bogosity is not a technical
argument.

Thanks,

        tglx

