Return-Path: <stable+bounces-99017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96D29E6DB6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C66A2832DF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2F31FF61F;
	Fri,  6 Dec 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="maxeOqkS"
X-Original-To: stable@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DFA1DACB4
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486708; cv=none; b=UI2xS86nujn46VnVB7EL8814Dv2b6r4Cx6egyneSxTWayfEoh2UCpoSWeJnXspE2OgviFOFq8AU/LCoTSBQIHT2e7yNLmime+W47YEp9UqQEFYYbu6KZsUlozy46O1+JiqefzI2SXANQYQvbu07bxet/drW4PCEEbrAYAwnnGjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486708; c=relaxed/simple;
	bh=15ZGA/H3waoF9a4W4RKfRvAYTv1FcSPpobCc6GnYdKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrb6Qol1LKElSquRxexJHDfIuBkPKZZdth/lHaURQTCGwcrs2LLpfVpGDgCk93/Q45xRgK/j1otjb/CKq8DMSCNV3sO/I7K6/bS1S7yccHAa56BeRWr8zK59SA4m91BRfid9hs7ig512r6s4Ix/pfKJSzWPWhgwB574GJywgglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=maxeOqkS; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 58DE814C1E1;
	Fri,  6 Dec 2024 13:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1733486697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x11F1HTMcCp9ZHykZGrsIkXnqprWtAytoR7C2HpqSts=;
	b=maxeOqkS9w/ixz7rsuvXuYc0ts4oylsDJ+L0p2t8zgou6gtzsCt6+aLAj5kRQ/wxP53Zoy
	D8dmG5f7WnMu+gV5EQH6f6f3k5SPZZy+TOy3GgYjni4ZByL4LVNrDWUVXZH4bPiipmv0kh
	mBD/0usaH52treeclWryfmoD4zhGTEs4BxdZ8SOEmqzGeAvDdKApcB7FvrTIzpYxbtkk2F
	u5Bp5aoE0pJyorU3yt8m6qvnD1hOrRqOevm/VlCCwwvMkY0+U7wcq54gwMOQpRpeg+XkQY
	m+nsueA8Ogmn22nXOz8vYF+QWwuES9Os0t8BM8woQAG25kYXmCBFRoOBHkyssg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id bdeee390;
	Fri, 6 Dec 2024 12:04:54 +0000 (UTC)
Date: Fri, 6 Dec 2024 21:04:39 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: Re: please revert backport of
 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
Message-ID: <Z1LoVw0ei1rm9MTO@codewreck.org>
References: <202411210628.ECF1B494D7@keescook>
 <4ef74a1c-a261-487b-891c-56c44863daea@tls.msk.ru>
 <Z1FOMMxv8bVt8RC3@eldamar.lan>
 <2024120519-chamber-despise-c179@gregkh>
 <Z1FUxY74Gze-5J3N@eldamar.lan>
 <dbc8f688-46db-427c-8177-ab7c26233eaf@tls.msk.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbc8f688-46db-427c-8177-ab7c26233eaf@tls.msk.ru>

Hi mjt,

Michael Tokarev wrote on Thu, Dec 05, 2024 at 10:35:26AM +0300:
> It would be great to fix this in debian, yes.  It's a debian matter
> anyway, for details there's no need to bother kernel people.
> Please see #1088273.  Fixed qemu release should come together with
> the updated kernel in debian -- if it will be next point release,
> so be it, but if the kernel goes before, we should pick qemu too,
> because else we'll re-introduce #1087822.

The kernel aleady shipped in debian a while ago, hence the bug
reports :)

More precisely, the "bad" commit b0cde867b80 (in 6.1 tree) made it in
6.1.107, and debian stable has been shipping it since the 6.1.112 update
on the 3rd of October[1][2], so we've been here for a while now

[1] https://tracker.debian.org/pkg/linux-signed-amd64
[2] https://tracker.debian.org/news/1571617/accepted-linux-signed-amd64-611121-source-into-stable-security/


Cheers,
-- 
Dominique Martinet | Asmadeus

