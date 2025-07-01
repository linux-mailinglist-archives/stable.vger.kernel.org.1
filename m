Return-Path: <stable+bounces-159108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F51AEEC8B
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 04:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D8A43BED73
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D0B19ABAC;
	Tue,  1 Jul 2025 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="tyrfv7QB"
X-Original-To: stable@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DFA47;
	Tue,  1 Jul 2025 02:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751338032; cv=none; b=piVacwq5+d9rJIIlkDfoC6duQ8yicRVI/cSZRlNOj/zCOu00ANyA616l7ED8VJ0WEmj2N3bo0IDoPhYn5fQBguegtdAf4fYfg1QnTKuTLEFFk/ydRcCVS4JnFb5aUUfW6BowWwUI/f+BPSp5eNxd0oK/y3Uw1NX4awgzpQ/Xxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751338032; c=relaxed/simple;
	bh=DkG2aaHUWHfi5yLVXDRdljJw7ma6mEP8Bd7Kuu8sGN8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=eUGkeeC+tcoTC1EPMXkyNkSZrrwHtiZzwcVITPmThhEdRiL5x65jR3Uy00EeVFsRZ+QNQFEFAhYPy1Nl4F8h0AlUgO/oRCnZ0SsfqdCqOEbaaQ8a0jpn4pChkMq6un4ey+9ZE9YBhP/Gg3GDeksFFe2cEOQu9nGpvVTtj6+wQSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=tyrfv7QB; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Date:References:In-Reply-To:Subject:Cc:To:From:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=Q7gZI+6aYsSICM1KaklLGjt/CHuu9Nr7jOaDeOPViBo=; b=tyrfv7QBeLA56ONN19R1VVZSYb
	BQDbSLMyOdJmXEsnvVaiY68bXzFUZ1D1E/dAlSkeD3TLsiRXltsscYzb3rduKd2ArHqH330C8mR3g
	nPmz9LegpZic1fCZ0oNGa8lz/X5XITjj4u+LyhLuPNurMe6PPtWioHzDTJH6gg0AjwUSnMhXXbTGI
	AT6TqMRQD143c/F7XDHkzEwQRrZTFiVxu9+S1AE5ucLq/xvm8RrWajCtR66WI757WfwGJ7nIeXZYy
	LbDcXOGpPe9uox6L/BC+ZSBkqq1Ytu41fDC8Z3IxI0dafJnLfmcqrZkTj5qK7gOfXNlxBDiTpB6+F
	Aeege8ug==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1uWR1V-00000000tCg-2Dm1;
	Mon, 30 Jun 2025 23:47:05 -0300
Message-ID: <4c85a34838de199e09e68c1eff3c46c6@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: smfrench@gmail.com, linux-cifs@vger.kernel.org, dhowells@redhat.com,
 Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCH] cifs: all initializations for tcon should happen in
 tcon_info_alloc
In-Reply-To: <CANT5p=rEUppfa5E_ySYnXtB8cq5x=V-Yhia6c+1W8a9b7ctLWg@mail.gmail.com>
References: <20250630174049.887492-1-sprasad@microsoft.com>
 <87104723045d2e07849384ba8e3b4cc0@manguebit.org>
 <CANT5p=rEUppfa5E_ySYnXtB8cq5x=V-Yhia6c+1W8a9b7ctLWg@mail.gmail.com>
Date: Mon, 30 Jun 2025 23:47:04 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shyam Prasad N <nspmangalore@gmail.com> writes:

> On Tue, Jul 1, 2025 at 1:06=E2=80=AFAM Paulo Alcantara <pc@manguebit.org>=
 wrote:
>>
>> nspmangalore@gmail.com writes:
>>
>> > From: Shyam Prasad N <sprasad@microsoft.com>
>> >
>> > Today, a few work structs inside tcon are initialized inside
>> > cifs_get_tcon and not in tcon_info_alloc. As a result, if a tcon
>> > is obtained from tcon_info_alloc, but not called as a part of
>> > cifs_get_tcon, we may trip over.
>> >
>> > Cc: <stable@vger.kernel.org>
>>
>> stable?  Makes no sense.
>
> I feel this is a serious one. If some code were to use
> tcon_info_alloc, they'd expect that it's fully initialized, but they'd
> end up with the problem that you and David saw.

Yes, I understand you want to be safe.  But you're not fixing any
existing problem with this patch, hence Cc stable didn't make sense to
me.

> I feel that this is the correct fix to that problem (although that
> addresses the problem of unnecessary scheduling of work).

You'd just mask the real problem with this.  Without the WARN_ON() on
the uninitialized delayed worker we wouldn't have found the actual bug,
though.

