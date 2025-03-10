Return-Path: <stable+bounces-121728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF7BA59AE4
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D157A65C1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3410A22FDFF;
	Mon, 10 Mar 2025 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luj2N4m5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ED21D79BE;
	Mon, 10 Mar 2025 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623899; cv=none; b=FkZMFqE0HhPg4isjSHaDF+ZFSP9GoeApS8npyTqMErLLCBpjj7TQFNbIujmmL0kq5VjXtfbQzBY+0JLmxjW7Awfi1GGfWC4v6lSbgipFT7pYMQ56Kqypoa7sKSocjEHtrWicgdfojZwHDks3e7qVl/4cE2Kw86+C9+diBy6tB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623899; c=relaxed/simple;
	bh=8AeJKXf7KBo0Et5UVJ9a3z/GKSyc6SeP17c6nUihQ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er6BCsP3awHCo4uT6VIMRQ1CE1089lKknWG2xpNhhElCmqkI3oVrpeIFG6MnBpWSquL3rvIcqwZQbKDriS0anNSI54rLuiKdWXT5+/rmOvL+vVGjlQHuNmpif8jOFAFnjdaT7u2eUZ1/II+xNSsmCOj49SxUpM5Kzfvrc6FtPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luj2N4m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEFBC4CEE5;
	Mon, 10 Mar 2025 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741623898;
	bh=8AeJKXf7KBo0Et5UVJ9a3z/GKSyc6SeP17c6nUihQ0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luj2N4m5kv14o7Yc2i/DxNa04kIC73dVLVdrjuO1dq0Idwa6PZ0GbB5Xvunkaz2Iv
	 Vn6sSCN++sH9UiX6hRwFOPqcOUlSG3qt4kTfz9JzHrsINkdBpCANzE4YS6CHPZiGD2
	 ruMrJu/GTla4DpIHm3FjS6/WHvxEy9JtmqBH4uD3PtUBwSSwnY5N1R5T7oXPqNHyFn
	 vjrPPjznzrrsmOiSAST96Bs+T2P0+K1udNGpjzL4FSSlwZl4Iqe5dJVDQ4Bi5hiB26
	 GuehJwjDXGNcA/2XENy8zI1PWuJksYdPbQx5ieem8Hdlax7V3DTb+TE3WULliAJReJ
	 4Wb0OzhoGlEfQ==
Date: Mon, 10 Mar 2025 17:24:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Eric <eric.4.debian@grabatoulnz.fr>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Christoph Hellwig <hch@infradead.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jian-Hong Pan <jhp@endlessos.org>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	linux-ide@vger.kernel.org,
	Dieter Mummenschanz <dmummenschanz@web.de>
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
Message-ID: <Z88SVcH28cEEingS@ryzen>
References: <Z8SBZMBjvVXA7OAK@eldamar.lan>
 <Z8SyVnXZ4IPZtgGN@ryzen>
 <8763ed79-991a-4a19-abb6-599c47a35514@grabatoulnz.fr>
 <Z8VLZERz0FpvpchM@x1-carbon>
 <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen>
 <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen>
 <6d33dbf2-d514-4a45-aa50-861c5f06f747@grabatoulnz.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d33dbf2-d514-4a45-aa50-861c5f06f747@grabatoulnz.fr>

On Sat, Mar 08, 2025 at 11:05:36AM +0100, Eric wrote:
> > $ sudo lspci -nns 0000:00:11.0
> 00:11.0 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD/ATI]
> SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] [1002:4391] (rev 40)

Ok, so some old ATI controller that seems to have a bunch of
workarounds.

Mario, do you know anything about this AHCI controller?


"""
3.1.4 Offset 0Ch: PI – Ports Implemented

This register indicates which ports are exposed by the HBA.
It is loaded by the BIOS. It indicates which ports that the HBA supports are
available for software to use. For example, on an HBA that supports 6 ports
as indicated in CAP.NP, only ports 1 and 3 could be available, with ports
0, 2, 4, and 5 being unavailable.

Software must not read or write to registers within unavailable ports.

The intent of this register is to allow system vendors to build platforms
that support less than the full number of ports implemented on the HBA
silicon.
"""


It seems quite clear that it is a BIOS bug.
It is understandable that HBA vendors reuse the same silicon, but I would
expect BIOS to always write the same value to the PI register.



Kind regards,
Niklas

