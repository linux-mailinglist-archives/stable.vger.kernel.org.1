Return-Path: <stable+bounces-177512-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03072B40A7B
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 18:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F591BA268F
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC231281D;
	Tue,  2 Sep 2025 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b="BaRzmsxV";
	dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b="IbWIhlRo"
X-Original-To: stable@vger.kernel.org
Received: from mail180-6.suw31.mandrillapp.com (mail180-6.suw31.mandrillapp.com [198.2.180.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94F2877FC
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.2.180.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830276; cv=none; b=Jjvp4UmqMiJsJB9ajhcrZR62Tu3sw8wyZE61bV/3HWBmZ4OpbrZnqnxRELuzHHKWPOvzmLszVKpJMZMbFvfg+PT2FdBQvSbJE/V52Ky9m47X1mQW84EsQy0MDce5BCUgotW9gY9lL55xVcCHUqOlOto78BjCAkbOrYOQk/vyLBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830276; c=relaxed/simple;
	bh=l+WTHRF8Tyv5W+s6LG5/5c16Hz0r1heuBfwZhWVNT+s=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Date:
	 MIME-Version:Content-Type; b=NNHXd/cW8ki+TDy3yMqSjlC8nS3wYK8j9GsLGn4NaWyshyqrG1ZltjUoAK+6/9Dn3z0zp1YgxFXUdvnlmlkHzr8DFmERXAtW8qSBZtKvrTGqWlBxouqutuDknpBZRaN8ZoZA5B5G9RTYKcxBcBUXUMr70lYW2BNBXnCKOhktiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech; spf=pass smtp.mailfrom=bounce.vates.tech; dkim=pass (2048-bit key) header.d=mandrillapp.com header.i=@mandrillapp.com header.b=BaRzmsxV; dkim=pass (2048-bit key) header.d=vates.tech header.i=teddy.astie@vates.tech header.b=IbWIhlRo; arc=none smtp.client-ip=198.2.180.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vates.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.vates.tech
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
	s=mte1; t=1756830273; x=1757100273;
	bh=n5RkPVqtiuLNefJ34qS3+Xaj6pVCICTdq8QdOKNDxko=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=BaRzmsxVfNT0PUnlLiZj1effKpU2J2TxpASa9e5JiMGuL9aGT2wQJnu1RWqRZapoX
	 Mrg5U6Pg/7J6tSXTJqrkvsyiVXFnMCH8+tbsPT/+ZlEH//ZBYNYBZo0mS5NZ3R7Odu
	 jSCr8faiRym3RRYngyquLc4e+/dj3g4MahyrK0oWfu6MMqJhT/OMRfDN/h/YaiojRn
	 taZDFpbHg4y8JlzMWI46EuYKLVwknI50gOlQkWEzUW8j0+viagSk1rFqz0A0RhgHQl
	 HQEKgX0JC0qMLIRuNwa6O5hKoe4ZZsl80qys8U/NebKE3LBR8arr8Ah0jp/SuFrS+p
	 HOpTcBQUo483Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
	t=1756830273; x=1757090773; i=teddy.astie@vates.tech;
	bh=n5RkPVqtiuLNefJ34qS3+Xaj6pVCICTdq8QdOKNDxko=;
	h=From:Subject:Message-Id:To:Cc:References:In-Reply-To:Feedback-ID:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
	 Subject:From;
	b=IbWIhlRoXmjgsF5v14FGx7YF169HqVdLnYEeC46vThPPW1fQamZ6rrPgRj5v7hpLx
	 A6Okj3wp+kmU1j/vz3e2hA2OQkQYfVzwSa7ue/qz8GKc+fwux0yI/3UuehhZb0YRq3
	 X9hA8CQWSwNKupZk8/3fCLtaiBTW3g8zwqaP+7sVpVzQwES1C2yNXi4GDfohxzDd9J
	 9sc20NNytAbo4yjMHMw1R2qByzcnUcISyPoaRpFvxgZDAfxHiKn9Ej/xs0QYottQzG
	 X9egkAv7U6+MfNfRaP99B3CuS8GGPGRDpCz464cYlXtDz/Ys1EyqhdGyhPFUDC4DhX
	 EgSa0zqKR8ytg==
Received: from pmta11.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
	by mail180-6.suw31.mandrillapp.com (Mailchimp) with ESMTP id 4cGWKY53SCz2K1xdJ
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 16:24:33 +0000 (GMT)
From: "Teddy Astie" <teddy.astie@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v5.10.y]=20xen:=20replace=20xen=5Fremap()=20with=20memremap()?=
Received: from [37.26.189.201] by mandrillapp.com id 235d36f9c6a844dea387233b7ebaea8d; Tue, 02 Sep 2025 16:24:33 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1756830272879
Message-Id: <d4d5ce1f-8bcf-46c3-a1a5-f509375e80e9@vates.tech>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: xen-devel@lists.xenproject.org, stable@vger.kernel.org, "Juergen Gross" <jgross@suse.com>, "kernel test robot" <lkp@intel.com>, "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, "Stefano Stabellini" <sstabellini@kernel.org>, "Anthoine Bourgeois" <anthoine.bourgeois@vates.tech>, "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Jiri Slaby" <jirislaby@kernel.org>
References: <4cc9c1f583fb4bfca02ff7050b9b01cb9abb7e7f.1756803599.git.teddy.astie@vates.tech> <2025090203-clothes-bullish-a21f@gregkh>
In-Reply-To: <2025090203-clothes-bullish-a21f@gregkh>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,=20including=20all=20headers,=20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.235d36f9c6a844dea387233b7ebaea8d?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250902:md
Date: Tue, 02 Sep 2025 16:24:33 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 02/09/2025 =C3=A0 13:18, Greg Kroah-Hartman a =C3=A9crit=C2=A0:
> On Tue, Sep 02, 2025 at 09:28:32AM +0000, Teddy Astie wrote:
>> From: Juergen Gross <jgross@suse.com>
>>
>> From: Juergen Gross <jgross@suse.com>
>>
>> [ upstream commit 41925b105e345ebc84cedb64f59d20cb14a62613 ]
>>
>> xen_remap() is used to establish mappings for frames not under direct
>> control of the kernel: for Xenstore and console ring pages, and for
>> grant pages of non-PV guests.
>>
>> Today xen_remap() is defined to use ioremap() on x86 (doing uncached
>> mappings), and ioremap_cache() on Arm (doing cached mappings).
>>
>> Uncached mappings for those use cases are bad for performance, so they
>> should be avoided if possible. As all use cases of xen_remap() don't
>> require uncached mappings (the mapped area is always physical RAM),
>> a mapping using the standard WB cache mode is fine.
>>
>> As sparse is flagging some of the xen_remap() use cases to be not
>> appropriate for iomem(), as the result is not annotated with the
>> __iomem modifier, eliminate xen_remap() completely and replace all
>> use cases with memremap() specifying the MEMREMAP_WB caching mode.
>>
>> xen_unmap() can be replaced with memunmap().
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Acked-by: Stefano Stabellini <sstabellini@kernel.org>
>> Link: https://lore.kernel.org/r/20220530082634.6339-1-jgross@suse.com
>> Signed-off-by: Juergen Gross <jgross@suse.com>
>> Signed-off-by: Teddy Astie <teddy.astie@vates.tech> [backport to 5.10.y]
>> ---
> 
> Why is this needed for 5.10.y at all?  What bug does it fix?  And why
> are you still using Xen on a 5.10.y kernel?  What prevents you from
> moving to a newer one?
> 

This patch is only useful for virtual machines (DomU) that runs this 
Linux version (a notable Linux distribution with this kernel branch is 
Debian 11); it's not useful for Dom0 kernels.

On AMD platforms (and future Intel ones with TME); this patch along with 
[1] makes the caching attribute for access as WB instead of falling back 
to UC due to ioremap (within xen_remap) being used improving the 
performance as explained in the commit.

[1] x86/hvmloader: select xen platform pci MMIO BAR UC or WB MTRR cache 
attribute
https://xenbits.xen.org/gitweb/?p=3Dxen.git;a=3Dcommit;h=3D22650d6054625be1=
0172fe0c78b9cadd1a39bd63

> thanks,
> 
> greg k-h
> 

Teddy


--
Teddy Astie | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



