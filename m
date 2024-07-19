Return-Path: <stable+bounces-60600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9167793759B
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CD70B21604
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37827E0E9;
	Fri, 19 Jul 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ieDns3tY"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503CCB647
	for <stable@vger.kernel.org>; Fri, 19 Jul 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721380779; cv=none; b=pCGjxhA0uhanHQvukFMBRSohhexmROaLZ8erKeLTVre+S5v/M+3bkVa8PWxv58mXnQ5J0boCObFDScZKh3E6OLM8rbxdDyv1imW67kxvf9q2SqIifhsnjqQhaPMA6Xy42aRAInQ/R69M1h3CNCcyjiIdrmlOp4JvZXyueDs3ou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721380779; c=relaxed/simple;
	bh=o2kwGgaG/AZytDFfy9Q1xQTGFvvMz2KClDqfdRfaCpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EP5VpE8Auq3DTv87DBLcAlazoW2ZI+/zQ6sId05+V7HvZjQBkq23VFP4WNNxWhfzAdIf+6TeLUZ3poVhq0txupGLl5fyVQwS1OyWMcyAAYXlZiISgrbGL08Do36agA5vi4299elGsrvGOOMkZjGT93J0Q53JJWZrMCdSECtx6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ieDns3tY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description;
	bh=o2kwGgaG/AZytDFfy9Q1xQTGFvvMz2KClDqfdRfaCpQ=; b=ieDns3tY3kaVHP01xTTdjnwPtp
	xIBiOWA687sENDLT2xajiRdNx6QA+/MbaolFpWk/YZF+yoK0HonXP2k3sgJEDMkiv+YL0oisR8wQ3
	wQqVgE3jnoXxcwMjIzButa5kMX79dewW42jE+tFkleG9KJjSYk65Z9k+wa+jS0RLS3Eh0TjDEwPpa
	sRB7A1jMuI4CyFEQ0F7G5d+RWW4uzIPzbx83PJS9ffe3sZEjCyHVhL6SMAs1ZgisAe1sQvcIF/sFn
	7V46ffi1o97PfUwfuWD/av4T/ow+B8Wcch6m6nXqqJq0ObJ0oUQrkDvh60ADEoxUNM/zIkdDc5c7q
	yO0I0iZQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <corsac@debian.org>)
	id 1sUjlz-002IAc-LC
	for stable@vger.kernel.org; Fri, 19 Jul 2024 09:19:31 +0000
Message-ID: <e4e878901db1336c44ce17939c920119b9912fed.camel@debian.org>
Subject: Re: [PATCH] mm: huge_memory: use !CONFIG_64BIT to relax huge page
 alignment on 32 bit machines
From: Yves-Alexis Perez <corsac@debian.org>
To: Yang Shi <yang@os.amperecomputing.com>, willy@infradead.org, 
	jirislaby@kernel.org, surenb@google.com, riel@surriel.com, cl@linux.com, 
	carnil@debian.org, ben@decadent.org.uk, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Fri, 19 Jul 2024 11:19:24 +0200
In-Reply-To: <20240712155855.1130330-1-yang@os.amperecomputing.com>
References: <20240712155855.1130330-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Debian-User: corsac

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On Fri, 2024-07-12 at 08:58 -0700, Yang Shi wrote:
> Yves-Alexis Perez reported commit 4ef9ad19e176 ("mm: huge_memory: don't
> force huge page alignment on 32 bit") didn't work for x86_32 [1].=C2=A0 I=
t is
> because x86_32 uses CONFIG_X86_32 instead of CONFIG_32BIT.
>=20
> !CONFIG_64BIT should cover all 32 bit machines.

Hi,

I've noticed that the patch was integrated into the -mm tree and next/maste=
r.
It's not yet in the first half of the merge window for 6.11 but do you know=
 if
it's scheduled for rc1?

Regards,
- --=20
Yves-Alexis
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAmaaL5wACgkQ3rYcyPpX
RFtzIQf8Dn0wqm4ZDeAvoxX+xPTn5Qhu5T1tDZfnryL584DRroe5PyYr5uI+BL7W
oMfPc+cNYUmGRPc8qmbAhg5K18xlfmPfUDq4idWzLMjpUnmEZflWgrGFvRgJmTo5
Kq2MRxpLi38M9GTeqG3MKtWxouKilch9n1ukmQhV9H0DUtiiS3EhITt9X7PbJ7Zc
yvPtdRcdHXRXSl0x/0hztQy4xuKSJxGQULGoSL0HyS8R9OCj+0hDFgEz98YkSbYW
6pZ8+iZLc+OXEkjKfC3uwI/q0Dw3eZW1zIyPn7ahYteisBr+HfKwoGz7UNzw3aB4
/BB3VA+A7/ikJ9NIwjgSlGTmZso73A=3D=3D
=3D1puG
-----END PGP SIGNATURE-----

