Return-Path: <stable+bounces-160396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662CEAFBB38
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 21:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5B44A07F6
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 19:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5E4D8CE;
	Mon,  7 Jul 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UdH1bQ+P"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BA1266573
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914826; cv=none; b=d2WDA1BSNxWjTtltOX4LkqTKrYsw+ugnzaW30kooEDhdByt30zXygF1svZyEJsipH95diaLOoTHCyalktvm3QePrOiAg03ktf8dZ73gC6OWyk+fvETaeiSINHlUN1u8dLwkPiQfVTNJkpAFBcLSSGJdrk9vqPekeKWulyRYYmTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914826; c=relaxed/simple;
	bh=5My8NSMSGHra6K+ufqbvF/rzsNceAsuNssVS7PAubp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5zfUhJ2nDpkzHaZxe3eoHbMNhmwS6nBBETS0l4+BUHycyy+rwqc9DNEsQq5A7LkclseD/be6i5NmwWCV0kPS8v8o3TVXWSFmjN49QXhBNAT/Q2CK1uYOoM5DPdEaQVCkxarpWfcZgK5q/9lWsbs7VyDIW5OqhfqTX3pCDUoTxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UdH1bQ+P; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1ACFA40E0208;
	Mon,  7 Jul 2025 19:00:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TvITbPN3ySpD; Mon,  7 Jul 2025 19:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1751914805; bh=Hbp+Xrxo0dqSWdgXLUiCWz71bQ1+/FdiAGDhokVoR4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdH1bQ+P9U3rd6ZUsbOqHHOCCQnvCRhHyGDdzbdXg6TA0iQYXl8twqPDCMBXMdQn8
	 GejciGG3bvQ2fS6li7kL2w+e5d85bWADm/W2f+jNHQSWmFQ0hMqwoHGT0rANZ2Fd4S
	 XNTtvLbSNtMvuzrOfCzhNNue9IBINtcF3ZCMDFIowvsWz6Xj7N7LfcTSZQFAUFKwwU
	 YW3FFBZpPBNHg8k1zzZknFIVsCPyejE9dMs5mW/QGOTnPcQWJcPPYuFm6wpLH+1/1M
	 LJD2H7nhqB/dQn+LA6ae/D2+D28/w9kMQISDb2lV/HNF7Vqf/ulBNWKh9z9rX9utmZ
	 BCIbg90IwPNP+Ajbk9El4o59NvF5QNmo+WT49xmzUuxalRLgSHFFBu7pZQtN1qme+d
	 jMVdvcKG/yI0lUYY9/l9XVmTpRJMV5B6V+a9wjZqO0WvNakOwDGbek1q1fwRmFIOsV
	 V7ot3WTufFx85W06VmTDzjednqDcc/IOZAVAfMOTozZdVvEdt3R4fxr8u4NlxQynPO
	 tioSiOU449a/86DLuf2Zvh2cT49YS3b0ozEjmoj56MBYZ/1++KfdFTqnb5HIaPRDtC
	 YiJwmdC3UvxecYHxXqUCpBTQAfxzuNCo/kygSIwary2os6etdYGiAN6YiU4D4QmJ7H
	 qyXk1k6388Ej+CJnJ8PsfgdI=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B156440E01FE;
	Mon,  7 Jul 2025 18:59:59 +0000 (UTC)
Date: Mon, 7 Jul 2025 20:59:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	=?utf-8?Q?=C5=BDilvinas_=C5=BDaltiena?= <zilvinas@natrix.lt>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 6.1.y] EDAC/amd64: Fix size calculation for
 Non-Power-of-Two DIMMs
Message-ID: <20250707185952.GEaGwZKJGYiLHvONQe@fat_crate.local>
References: <2025063022-frail-ceremony-f06e@gregkh>
 <20250701171032.2470518-1-avadhut.naik@amd.com>
 <2025070258-panic-unaligned-0dee@gregkh>
 <8b274e68-29e4-436a-9bb1-457653edaa2e@amd.com>
 <2025070319-oyster-unpinned-ec29@gregkh>
 <3d2a2121-4a5d-445f-8db0-8f1850a72769@amd.com>
 <2025070750-lapel-bunkmate-672f@gregkh>
 <54b5d8af-980c-40c0-bed1-1cb91cfaeb50@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <54b5d8af-980c-40c0-bed1-1cb91cfaeb50@amd.com>

On Mon, Jul 07, 2025 at 12:57:39PM -0500, Naik, Avadhut wrote:
> I just mentioned the above commits because I think they modify the code
> in question for this backport.
> But these commits have been merged in as part of larger patchsets (links
> below):
> 
> 9c42edd571aa: https://lore.kernel.org/all/20230515113537.1052146-5-muralimk@amd.com/
> ed623d55eef4: https://lore.kernel.org/all/20230127170419.1824692-11-yazen.ghannam@amd.com/
> a2e59ab8e933: https://lore.kernel.org/all/20230127170419.1824692-9-yazen.ghannam@amd.com/
> 
> Backporting these commits might require us to backport these entire
> sets to 6.1.
> Wasn't completely sure if this is the road we want to take.
> Hence, asked the question in my earlier mail.

Seems like this is getting too complicated and I don't see the gain from it.

I'd say you leave 6.1 be for now unless someone comes with a persuasive reason
to backport this patch to it.

IMNSVHO.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

