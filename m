Return-Path: <stable+bounces-177639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CB1B42645
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AD47201BDE
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0582BD58C;
	Wed,  3 Sep 2025 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVjQVsTX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0825C296BCF
	for <stable@vger.kernel.org>; Wed,  3 Sep 2025 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915859; cv=none; b=NXey8GC+U8a3G8P6GqqcIKViNWjWR7MXc+hyuNtHpZgN5/NGOqEtdusB5Tp/1pCLn5FZNELd6/d/XKlDF8RoWz4/JHPwQtZs23WEBn71OkBV0ATVtyBD4ma6PxTden+UNqMwdDgXzwv9d+NTD35v5VyX2b90PgXtsO225HhqwDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915859; c=relaxed/simple;
	bh=mFZxFpjnHcFLVMkAbXDY4kDtUk8cmpCdtfA2GDa0gGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1WPfwKMaJjSAnWqdaj+7/eddVK8WABVI7rL0OITs0rhnfeaI7kUV5EiVP2FEruJ1reGmb0tp+60PHYB5V03mN87f/cT92HVjUGph/6RAwiGzEgsZhuvTQUvpVIPoajLQAU2Lfs/+nxumsK3x3BAku6K7BUfM+1E+xMnMQ58A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVjQVsTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E00C4CEE7;
	Wed,  3 Sep 2025 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756915858;
	bh=mFZxFpjnHcFLVMkAbXDY4kDtUk8cmpCdtfA2GDa0gGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVjQVsTX0YGo6t20cO1yEfP2hf+xYO7vqbTv8EEtO9e6QSF1axf7muc4xEX9x/fM+
	 kbbsoyDbDXkTlxaInZKJeouGssl7cgjHCTVdBnu68gtnxIhZ8knvW+Pog1egMzwAUD
	 eoPpd/YERzFuIeBjMkTWSqFi/E8+2DFMcYrxrJeDvDZzJxIOkmrSNBKoFzAaYRvGNq
	 Ua/3eeBeD/zBi892rgFYhfooepMPU7ao6ZJcMcL9ZlvfWAz4HTxvfVIfBojpoxudVt
	 9nAOoE22LMTvoLoFdNzB4cZ0a2yuHftYzOnQFcex65r8mjKB1EhCUvdaOvC6KWf4/P
	 0j/qaikonf4IQ==
Date: Wed, 3 Sep 2025 12:10:57 -0400
From: Sasha Levin <sashal@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: Sedat Dilek <sedat.dilek@gmail.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, Oscar Maes <oscmaes92@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Subject: Re: [stable-6.16|lts-6.12] net: ipv4: fix regression in
 local-broadcast routes
Message-ID: <aLhokYGMkEGhQ85Y@laps>
References: <CA+icZUWXiz1kqR6omufFwByQ9dD9m=-UYY9JghVQnbGD2NMy1w@mail.gmail.com>
 <aLH1M-F001Nfzs7m@eldamar.lan>
 <CA+icZUXo-C9sSvqZ9nmZhyZvPtJmE8wgzTm2y+k0P6=mynWZcg@mail.gmail.com>
 <aLhVHLbqFCB6BoB2@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLhVHLbqFCB6BoB2@karahi.gladserv.com>

On Wed, Sep 03, 2025 at 04:47:56PM +0200, Brett A C Sheffield wrote:
>On 2025-09-03 16:42, Sedat Dilek wrote:
>> On Fri, Aug 29, 2025 at 8:45 PM Salvatore Bonaccorso <carnil@debian.org> wrote:
>> >
>> > On Fri, Aug 29, 2025 at 06:56:52PM +0200, Sedat Dilek wrote:
>> > > Hi Sasha and Greg,
>> > >
>> > > Salvatore Bonaccorso <carnil@debian.org> from Debian Kernel Team
>> > > included this regression-fix already.
>> > >
>> > > Upstream commit 5189446ba995556eaa3755a6e875bc06675b88bd
>> > > "net: ipv4: fix regression in local-broadcast routes"
>> > >
>> > > As far as I have seen this should be included in stable-6.16 and
>> > > LTS-6.12 (for other stable branches I simply have no interest - please
>> > > double-check).
>> > >
>> > > I am sure Sasha's new kernel-patch-AI tool has catched this - just
>> > > kindly inform you.
>> >
>> > As 9e30ecf23b1b ("net: ipv4: fix incorrect MTU in broadcast routes")
>> > has been backported to all stable series in  v5.4.297, v5.10.241,
>> > v5.15.190, v6.1.149, v6.6.103, v6.12.43, v6.15.11 and v6.16.2 the fix
>> > fixiing commit 5189446ba995 ("net: ipv4: fix regression in
>> > local-broadcast routes") would need to go as well to all of those
>> > series IMHO.
>> >
>>
>> Looks like next stable releases will include this bugfix - checked
>> stable-6.x only.
>
>Yes, the patch has been backported to all stable RCs.

Sorry, I forgot to reply - it was properly tagged for stable, so Greg would
have picked it up at some point, but I just did so manually to address the
regression.

-- 
Thanks,
Sasha

