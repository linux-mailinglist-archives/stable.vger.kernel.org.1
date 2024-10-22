Return-Path: <stable+bounces-87715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC479AA1EC
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DECC1F22E86
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 12:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0419CC32;
	Tue, 22 Oct 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b="bJb+vR+c"
X-Original-To: stable@vger.kernel.org
Received: from mail.581238.xyz (86-95-37-93.fixed.kpn.net [86.95.37.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AF199246;
	Tue, 22 Oct 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=86.95.37.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729599219; cv=none; b=SjBN7CojmdlO3sDy19qdt0vcJUH69cQCrmfWFBPzCXAsIaE9kpHcBGwf2gQ8PFLpyEVcMRcQhCqMPPzNXOnT/LoM6q1EGp8kJfUuk2/UBF3xCjGBfq7C/agKMdmQDP+vBaGTgiWGAdFsBl2GDM+z0+msDr3x83g9oDe+dHWLA6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729599219; c=relaxed/simple;
	bh=lCky3Di3m4lYMAlpEuMx18kgHzOCT36dhjVGA5GWJ/Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=DyhjOLuQP6+VNosZ9IjTCRnO8E/NoGXQqvJljzRnPX5s1/ac8lPFS5EzbITFDEFTSOGbFH3ryTmlrJGWjh1JYZSpiBO9caAa7IfGgM0dWGxEi1mL141NeWu0+la16Y0tIzKwHlwn3thXyPgqNR7UP/yZr5nu7eIa73c6plffAsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz; spf=pass smtp.mailfrom=581238.xyz; dkim=pass (1024-bit key) header.d=581238.xyz header.i=@581238.xyz header.b=bJb+vR+c; arc=none smtp.client-ip=86.95.37.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=581238.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=581238.xyz
Received: from PC (pc.internal [192.168.1.10])
	by mail.581238.xyz (Postfix) with ESMTPSA id 89A5543088FB;
	Tue, 22 Oct 2024 14:13:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=581238.xyz; s=dkim;
	t=1729599214; bh=lCky3Di3m4lYMAlpEuMx18kgHzOCT36dhjVGA5GWJ/Y=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date;
	b=bJb+vR+cquFV4dAEemyokErGy4PwyUI1t+YXwzxAz0ZMO9qf12qPIDnCs0UvgFojR
	 1HPucDlGNLCGntytURaFXucAy8g4wB8EVsYkTBFWthH8+BdDASuZNVQsDlJjfVGmbG
	 3aqiS4up8z2PNHwh0N1qFsMrAeYPu4LZReXSwPZM=
From: <rick@581238.xyz>
To: <mika.westerberg@linux.intel.com>
Cc: <Sanath.S@amd.com>,
	<christian@heusel.eu>,
	<fabian@fstab.de>,
	<gregkh@linuxfoundation.org>,
	<linux-usb@vger.kernel.org>,
	<mario.limonciello@amd.com>,
	<regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: 
In-Reply-To: 
Subject: Re: Dell WD19TB Thunderbolt Dock not working with kernel > 6.6.28-1
Date: Tue, 22 Oct 2024 14:13:34 +0200
Message-ID: <000f01db247b$d10e1520$732a3f60$@581238.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adske5XwB29EbUf4QzmLPMDmlYiH4Q==
Content-Language: en-gb

Hi all,

I am having the exact same issue.=20

linux-lts-6.6.28-1 works, anything above doesn=92t.

When kernel above linux-lts-6.6.28-1:
- Boltctl does not show anything
- thunderbolt.host_reset=3D0 had no impact
- triggers following errors:
  [=A0=A0 50.627948] ucsi_acpi USBC000:00: unknown error 0
  [=A0=A0 50.627957] ucsi_acpi USBC000:00: UCSI_GET_PDOS failed (-5)

Gists:
- https://gist.github.com/ricklahaye/83695df8c8273c30d2403da97a353e15 =
dmesg
with =93Linux system 6.11.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 17 Oct =
2024
20:53:41 +0000 x86_64 GNU/Linux=94 where thunderbolt dock does not work
- https://gist.github.com/ricklahaye/79e4040abcd368524633e86addec1833 =
dmesg
with =93Linux system 6.6.28-1-lts #1 SMP PREEMPT_DYNAMIC Wed, 17 Apr =
2024
10:11:09 +0000 x86_64 GNU/Linux=94 where thunderbolt does work
- https://gist.github.com/ricklahaye/c9a7b4a7eeba5e7900194eecf9fce454
boltctl with =93Linux system 6.6.28-1-lts #1 SMP PREEMPT_DYNAMIC Wed, 17 =
Apr
2024 10:11:09 +0000 x86_64 GNU/Linux=94 where thunderbolt does work


Kind regards,
Rick

Ps: sorry for resend; this time with plain text format



