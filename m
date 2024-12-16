Return-Path: <stable+bounces-104399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3699F39E8
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8196D1881A0E
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5CB2080F0;
	Mon, 16 Dec 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IUKvP1s6"
X-Original-To: stable@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA528207656
	for <stable@vger.kernel.org>; Mon, 16 Dec 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734377487; cv=none; b=rH4RyzpXpyM2JzifBRA6kYpc7qqnakT0LFvM8VHjvPHSBIzyhquDlVPDIuGAaH01Ue/rZfjjbcw8b5U4P5YtIa59njQ1Pjt0C5ocP8zs1zWePbzdhCGClkUUlslwmsChFGgEmeUaJ2YzE8uLdlZWONaVOAUWKZZxEaKW+Yl2pnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734377487; c=relaxed/simple;
	bh=L9zcMBKeuOwzr9ViOPL0voJBv/TYO3r7K4N5MMWcRUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Isk8E6Mmp3WWiiiB61dXHD04FJjoIEESkGTCBcv3mKfv6APpkzWvYHf/EysDtK85f639O+Q/BHmHdyB3w5sXPnyShWsfcWF3zq0Pv//kndjmNobGRfZiEgTJ1LNPQ2P38cWaeaJRz2ZN9hAOnakx6dcARzTE4C6zzRNtw6saHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IUKvP1s6; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BGJV4D9026272
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Dec 2024 14:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734377468; bh=OdCeftKWAeDpgPElvpYkXATUaHqORDkwR8a8/KHla8A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IUKvP1s6il45paUsNl8EBYMqtNeYEbPsEE7ArF2G3hJjA6mIiifqY8JmkjtxMV+iM
	 kArTsELK3BA/We/M5EC1T4lJox1E509etb5w8171EtFfHmGilAtppFlrnxjdgyzRLp
	 kdyOiwcBA81/sv12XUmaCZx1V7GtLV80RGEqzTCh2XpXBPgfP5oaUXHrnUsnyR/iIY
	 W47fuNFAl6kOi7kgF3tjgemc+Job6wfOA2Vl0X6FGPUoRSY/F520AETOFYWL2vE8TG
	 kXicT6ClPKiaSPw/G9Lf9b0ePR3+fBcJ6jFg6g0fioVyq5iVMjgdLPbWEsXuy1VbWs
	 nuM1t4OpqnDgw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B2BD915C4656; Mon, 16 Dec 2024 14:31:04 -0500 (EST)
Date: Mon, 16 Dec 2024 14:31:04 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Laight <David.Laight@aculab.com>
Cc: "'Nikolai Zhubr'" <zhubr.2@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>
Subject: Re: ext4 damage suspected in between 5.15.167 - 5.15.170
Message-ID: <20241216193104.GB78919@mit.edu>
References: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
 <20241212191603.GA2158320@mit.edu>
 <79af4b93-63a1-da4c-2793-8843c60068f5@gmail.com>
 <20241213161230.GF1265540@mit.edu>
 <ce9055d7-7301-0abe-3609-3a4e2e7b1e5e@gmail.com>
 <229641a5c7f046b282c151cb1c6b9110@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229641a5c7f046b282c151cb1c6b9110@AcuMS.aculab.com>

On Mon, Dec 16, 2024 at 03:16:00PM +0000, David Laight wrote:
> ....
> > > The location of block allocation bitmaps never gets changed, so this
> > > sort of thing only happens due to hardware-induced corruption.
> > 
> > Well, unless e.g. some modified sectors start being flushed to random
> > wrong offsets, like in [1] above, or something similar.

Well in the bug that you referenced in [1], what was happening was
that data could get written to the wrong offset in the file under
certain race conditions.  This would not be the case of data block
getting written over some metadata block like the block group
descriptors.

Sectors getting written to the wrong LBA's do happen; there's a reason
why enterprise databases include a checksum in every 4k database
block.  But the root cause of that generally tends to be a bit getting
flipped in the LBA number when it is being sent from the CPU to the
Controller to the storage device.  It's rare, but when it does happen,
it is more often than not hardware-induced --- and again, one of those
things where RAID won't necessarily save you.

> Or cutting the power in the middle of SSD 'wear levelling'.
> 
> I've seen a completely trashed disk (sectors in completely the
> wrong places) after an unexpected power cut.

Sure, but that falls in the category of hardware-induced corruption.
There have been non-power-fail certified SSD which have their flash
translation metadata so badly corrupted that you lose everything
(there's a reason why professional photographers use dual SDcard
slots, and some may use duct tape to make sure the battery access door
won't fly open if their camera gets dropped).

					- Ted

