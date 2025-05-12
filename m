Return-Path: <stable+bounces-143134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326E5AB3218
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD4A188E694
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949E25B1DD;
	Mon, 12 May 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Cpjqn/hY"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7320925A2AC;
	Mon, 12 May 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747039609; cv=none; b=Bv4FzX4tiHOfE2608ryzxOHkvtokfW00yECFPkiNHUe2tGGTS16xUS5SJCpuf7u5h+96VYMJpYfgeEWYJWVr8HnaOpTerjCzNNwRrrSkKWOTMQvdPO9wzIIJS2k7circeOjw97BjdxXkZHvCV+QgRp/Rbf6bxpOpe2C2pU2Svx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747039609; c=relaxed/simple;
	bh=5E/bA1eM2wU2BC0VCWGwxexEaGR0i3e1NdalK4z2Pfs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qKToz5cXXF5+V8LgjEHaHjM1FwffL6IN6LO1nJw9AKT4eg8WPYs6iSoV/i9e1xV3njIotY5cDNVMST1+s8R9sHboyJGBT2Ui8ZqEN5IH1pgXnvYXiksC11bFLU7cZgGlY6tc2347Mk0a2ozORwnZSMd7DeZTQog0ZGWEN12SOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Cpjqn/hY; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 523DD40E023F;
	Mon, 12 May 2025 08:46:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SKF5IAOxcAli; Mon, 12 May 2025 08:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747039599; bh=r4yiL2NeUjVIZT9U2eVGSesDcYIgjx9AlbTxXhhyCFI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Cpjqn/hYUk3g50RPTmdKe6Y9brQGhDLwfq277OQSG8zEXOXuVJ56UjP5KjOsjse51
	 tJam1vlG77V6OMpwJ7hmXGJRR5gNRDeUt4hbBILM7QU91bkNptWJOPJW7WkWx1y6KS
	 8n5DGbSs0e4DBxbHfmMjP81JBCy256J+OcIOV9xsS0ED6apa41dULHEeYz4v/zZtJl
	 YZGtk5JVtkGmyjuvajZuGCC2o4hfpG4ZS+otH4TQzQ7z8Mn6J12yEYei+b6NpCnT6z
	 pNK1orFZjtb5rC1VJNPXKDTN9LfPPbXrp3tDLE/3HVbTOtqNSJnK1J0elySRmh9MOf
	 M1fpEIb8EEaL21awp+oUcknC0C+h5ns2gLsKUH5kz7srlnvyhr11V7NFMzvG/FoyVI
	 X7wcHwvWmaSEHYujNFLVr3kGd3v4zaiq+NG3UIiehqgmy6GMspaDOb52MHxvQTbg86
	 NCYpJHJ9sf/CU3eo5gCNq//NAxd/t0LkGV6DsfSdFZIfiac53qMbKZBKIfhBOUzKgj
	 KGw/07LxcnpyBXUKIif/Dwe7GxY+zvNezo/y+0c5edizJKD6Wnvq/DbwkEIIR3tVE5
	 fwODnHffjSxHH4DJL9y+GQyPlJ9kX1Oi3AyHHbc/1SHMAPSMvYWCgqBdw3WTOwQoS8
	 A4VScONipcpSorRfULnP/UM0=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3038:204:a05a:7dcf:8efb:5016:7f05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 387A440E023B;
	Mon, 12 May 2025 08:46:28 +0000 (UTC)
Date: Mon, 12 May 2025 10:46:22 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jiaqing Zhao <jiaqing.zhao@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Bernhard Kaindl <bk@suse.de>,
 Andi Kleen <ak@linux.intel.com>, Li Fei <fei1.li@intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/mtrr=3A_Check_if_fixed-ra?=
 =?US-ASCII?Q?nge_MTRR_exists_in_mtrr=5Fsave=5Ffixed=5Franges=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0ec52e49-3996-48e2-a16b-5d7eb0a4c8a6@linux.intel.com>
References: <20250509170633.3411169-2-jiaqing.zhao@linux.intel.com> <20250509173225.GDaB48KZvZSA9QLUaR@fat_crate.local> <0ec52e49-3996-48e2-a16b-5d7eb0a4c8a6@linux.intel.com>
Message-ID: <FFB8ACEC-7208-40D0-8B57-EBB2A57DF65F@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 12, 2025 10:31:23 AM GMT+02:00, Jiaqing Zhao <jiaqing=2Ezhao@linux=
=2Eintel=2Ecom> wrote:
>This fixes unchecked MSR access error on platform without fixed-range
>MTRRs when doing ACPI S3 suspend=2E

Is this happening on hw which is shipping now and users will see it or is =
this some new platform which is yet to see the light of day in the future?

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

