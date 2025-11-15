Return-Path: <stable+bounces-194835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 875EDC60609
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 14:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D4953476AC
	for <lists+stable@lfdr.de>; Sat, 15 Nov 2025 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D422F39BE;
	Sat, 15 Nov 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+e2xSCS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3327F274B23;
	Sat, 15 Nov 2025 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763213676; cv=none; b=UWro4vdKTLMKRC0eWRS9vNjIK8t2jSuseBa8lCsPy/EBszgmXk968PxYjvdxt9/R4LRBTQjT1MwAG3kwScsndHHhywFIQBcwGbquqqnN3J5AWxcU8c02xWxGG0twGlJQGKzUzCF05KzN917946dq5ME+678g1bpSyJeZWWTm/Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763213676; c=relaxed/simple;
	bh=wvLNTZmnJb48GXk20O4gO4npVSici32GkwEZXNyT7Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOfKBAfDVOhqApjkNxpIsaphPENXc3h7cY0dNwdIyovxTZDOWyTsn/gkF9OEx/XGNK7zpwkxQ3MiFm8BRlZydJ9jvg8lAIqFCAsn7Y0AHcKTn3CHMGFlDwHHCoBfWR9ONHC18wwJ6h+NGMkdmK1oMtoRkm7cJwY4owAXHIJIPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+e2xSCS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707B3C116B1;
	Sat, 15 Nov 2025 13:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763213675;
	bh=wvLNTZmnJb48GXk20O4gO4npVSici32GkwEZXNyT7Xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k+e2xSCSua8Rmmy88brHirb8fsEB59x/9CDrTshVTXF03PaqrE8YrTNvn8ffngLmy
	 mTLdWEOz0RnAeM3CPaCVu5zE4rCmr7icKrQ1hylMF2mRcTzf7KukEpDDLMrchUVaYb
	 kcNfgDdiWzi33iQsTl8BVdZ4Tmj/DiyCJmPpM9fiUyG72nGyTgjOqQlp3lJlsjFHlv
	 XDkU4xoyko3M3plYBRDV4+TXaB1935CVK5pwal2ETFBLjzxB0Iwy8YTrL0ndPyyjwo
	 sZ9106swQMXNK59oopSksMJOsyfJ18Q63BmtWnJUi8wQl1P99FldPsYHCFIe65z3G8
	 3JUocJstAI6OQ==
Date: Sat, 15 Nov 2025 08:34:34 -0500
From: Sasha Levin <sashal@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Howells <dhowells@redhat.com>,
	Bharath SM <bharathsm.hsk@gmail.com>,
	CIFS <linux-cifs@vger.kernel.org>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Stable <stable@vger.kernel.org>
Subject: Re: Request to backport data corruption fix to stable
Message-ID: <aRiBapN8hwCA-zc4@laps>
References: <CANT5p=q22P+zXHW2vH-n+W-zRe7ZWNORgh9gvoUOGpV6VMF8Fg@mail.gmail.com>
 <aRdEB6L0_vYwEsNT@laps>
 <CAH2r5mus4Cp0jH4y=_5LDCiDftVOEZwVaJb1ZOq3Uze2G4Evpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH2r5mus4Cp0jH4y=_5LDCiDftVOEZwVaJb1ZOq3Uze2G4Evpg@mail.gmail.com>

On Fri, Nov 14, 2025 at 12:35:39PM -0600, Steve French wrote:
>Sasha,
>Also wanted to make sure stable gets this patch from David Howells
>that fixes a regression that was mentioned in some of the same email
>threads.
>It fixes an important stable regression in cifs_readv when cache=none.
>  Bharath has also reviewed and tested it with 6.6 stable. See
>attached.

Sure, queued up. Thanks!

-- 
Thanks,
Sasha

