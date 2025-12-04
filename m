Return-Path: <stable+bounces-200070-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEFCA5505
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 21:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7443194FC1
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 20:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA7C3191AD;
	Thu,  4 Dec 2025 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uplinklabs.net header.i=@uplinklabs.net header.b="R2wV5md6"
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A83176F2
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764879424; cv=none; b=Sswuo5zrfnH+IPwJt0+GOVfg8OBblWIDu7jICXw1MIfAzxS94qzpYE212iPw3y2fwTMjW90KAUjFmemzW+d+PSVo9MCVf0ktpTgQ3ntot6tnRSN9VQOLNLZ8Yco21jPfpzbI+qIvHc81SUuPXv0oQ7wvnUSutn4Qvxl3gCWkit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764879424; c=relaxed/simple;
	bh=qwx51AemYPLNn6aR5GjaOYwEeZnFsmdcPJyJ/R1FqYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYWDtVi+GGW++8pK2i8Vjd+2V8uG4ukIjFGooH3ycyMENz/T4G3Ck/uvElKVXAADaUWglAUTRsDb3feT60JrdKLDc3MLteYyKl9b9l6qJpYKFNud/w0N6rf8C+E+uwk+BAmkZxtUGoUK/BBXG1v/8/k3quY/k7KROqcSP8HSJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uplinklabs.net; spf=pass smtp.mailfrom=uplinklabs.net; dkim=pass (2048-bit key) header.d=uplinklabs.net header.i=@uplinklabs.net header.b=R2wV5md6; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=uplinklabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uplinklabs.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uplinklabs.net;
	s=protonmail3; t=1764879404; x=1765138604;
	bh=qwx51AemYPLNn6aR5GjaOYwEeZnFsmdcPJyJ/R1FqYc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=R2wV5md61WCY4uR0ClQpQTDo0Uo+22dzeaCzqfMH0AcTqjPwiG/wfGEv/7Qif7crb
	 KH7hjFv+eESF4df14iwiqcbv7MsFmN7iJDwJkNqlVy8qHmWblKLSpPuRwD1YXafrc9
	 VbuPU3I21xWkRvckqUhRa9OXKMJ0bB3tnk3i9poXDKB/467vIM04MI0sYm83d1WpPs
	 OOWUs1lPS56iPFR2BVC477tf4MX/ZSEQiBRMF3vINFN+5hnMnSm41plnosuXh/PkXP
	 fzPmOvnNzqRoa9CIEwszietAPrRmR9UIMhyuf7R5cYG6m1OlYGt4/giwSzw8Z45lpD
	 UKAXl9m3OE4Hg==
Date: Thu, 04 Dec 2025 20:16:36 +0000
To: Yazen Ghannam <yazen.ghannam@amd.com>
From: Steven Noonan <steven@uplinklabs.net>
Cc: linux-kernel@vger.kernel.org, Ariadne Conill <ariadne@ariadne.space>, x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/amd_node: fix integer divide by zero during init
Message-ID: <77LRvZMtvNz9KxSX1LGsh_VparNGAmJL2gYXBH7oY_3de_ka2avlfbuHE_BL3OgtGHyVMU34Ln2TSLrT1l1rTpBvUUtI9QUTH1je0jFFlkM=@uplinklabs.net>
In-Reply-To: <20251203204519.GA741246@yaz-khff2.amd.com>
References: <20251114195730.1503879-1-steven@uplinklabs.net> <20251203204519.GA741246@yaz-khff2.amd.com>
Feedback-ID: 10620438:user:proton
X-Pm-Message-ID: d97e1d41dd64f47bb8c45b2238e219ff2b96c802
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------acfee3fc240a7c5f5b7ba374ff1d38b0ae3a3151d6f3a29c1457c0a2939087ef"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------acfee3fc240a7c5f5b7ba374ff1d38b0ae3a3151d6f3a29c1457c0a2939087ef
Content-Type: multipart/mixed;boundary=---------------------9e2f95d9d5536c3e16057210da24934a

-----------------------9e2f95d9d5536c3e16057210da24934a
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

(I apologize in advance if my email comes out formatted strangely, I haven=
't used ProtonMail for LKML before. I don't think it is line-wrapping prop=
erly.)

On Wednesday, December 3rd, 2025 at 12:45 PM, Yazen Ghannam <yazen.ghannam=
@amd.com> wrote:
> On Fri, Nov 14, 2025 at 07:57:35PM +0000, Steven Noonan wrote:
> =


> Thanks Steven for the patch.
> =


> > On a Xen dom0 boot, this feature does not behave, and we end up
> > calculating:
> > =


> > num_roots =3D 1
> > num_nodes =3D 2
> > roots_per_node =3D 0
> > =


> > This causes a divide-by-zero in the modulus inside the loop.
> =


> =


> Can you please share more details of the system topology?
> =


> I think the list of PCI devices is a good start.

Sure, but it's running as the paravirtual control domain for Xen. The `lsp=
ci` topology output won't differ between bare-metal and dom0, but dom0's a=
ccesses to certain MSRs and PCI registers may be masked and manipulated, w=
hich is probably why this is breaking.

I've attached `lspci -nn` and a CPUID dump from CPU0 -- both of these are =
while running under Xen.
 =


> > This change adds a couple of guards for invalid states where we might
> > get a divide-by-zero.
> =


> =


> This statement should be imperative, ex. "Add a couple of guards...".
> =


> Also, the commit message should generally be in a passive voice (no
> "we"), ex. "...where a divide-by-zero may result."

Ack. I can fix these and the subsequent suggestions for version 2.

> > Signed-off-by: Steven Noonan steven@uplinklabs.net
> > Signed-off-by: Ariadne Conill ariadne@ariadne.space
> =


> =


> The Signed-off-by lines should be in the order of handling. If you are
> sending the patch, then your line should be last. If there are other
> contributors, then they should have a Co-developed-by tag in addition to
> Signed-off-by.
> =


> > CC: Yazen Ghannam yazen.ghannam@amd.com
> > CC: x86@vger.kernel.org
> > CC: stable@vger.kernel.org
> =


> =


> There should be a Fixes tag along with "Cc: stable", if possible.

Ack.

> > ---
> > arch/x86/kernel/amd_node.c | 11 +++++++++++
> > 1 file changed, 11 insertions(+)
> > =


> > diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> > index 3d0a4768d603c..cdc6ba224d4ad 100644
> > --- a/arch/x86/kernel/amd_node.c
> > +++ b/arch/x86/kernel/amd_node.c
> > @@ -282,6 +282,17 @@ static int __init amd_smn_init(void)
> > return -ENODEV;
> > =


> > num_nodes =3D amd_num_nodes();
> > +
> > + if (!num_nodes)
> > + return -ENODEV;
> =


> =


> This is generally a good check. But I think it is unnecessary in this
> case, since the minimum value is '1'. The topology init code initializes
> the factors used in amd_num_nodes() to '1' before trying to find the
> true values from CPUID, etc.
> =


> > +
> > + /* Possibly a virtualized environment (e.g. Xen) where we wi
> =


> =


> Multi-line comments should start on the next line according to kernel
> coding style.
> =


> /*
> * Comment
> * Info
> */
> =


> > ll get
> > + * roots_per_node=3D0 if the number of roots is fewer than number of
> > + * nodes
> > + */
> > + if (num_roots < num_nodes)
> > + return -ENODEV;
> =


> =


> I think this is a fair check. But I'd like to understand how the
> topology looks in this case.
> =


> Thanks,
> Yazen
-----------------------9e2f95d9d5536c3e16057210da24934a
Content-Type: text/plain; filename="dom0-cpuid.txt"; name="dom0-cpuid.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dom0-cpuid.txt"; name="dom0-cpuid.txt"

Q1BVIDA6CkNQVUlEIDAwMDAwMDAwOjAwID0gMDAwMDAwMTAgNjg3NDc1NDEgNDQ0ZDQxNjMgNjk3
NDZlNjUgfCAuLi4uQXV0aGNBTURlbnRpCkNQVUlEIDAwMDAwMDAxOjAwID0gMDBhMjBmMTIgMDAy
MDA4MDAgZmVmODMyMDMgMTc4OWMzZjUgfCAuLi4uLi4gLi4yLi4uLi4uCkNQVUlEIDAwMDAwMDAy
OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4u
Li4uCkNQVUlEIDAwMDAwMDAzOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDA0OjAwID0gMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDA1OjAw
ID0gMDAwMDAwNDAgMDAwMDAwNDAgMDAwMDAwMDMgMDAwMDAwMTEgfCBALi4uQC4uLi4uLi4uLi4u
CkNQVUlEIDAwMDAwMDA2OjAwID0gMDAwMDAwMDQgMDAwMDAwMDAgMDAwMDAwMDEgMDAwMDAwMDAg
fCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDA3OjAwID0gMDAwMDAwMDAgMjE4YzAzMjkg
MDA0MDA2OGMgMDAwMDAwMTAgfCAuLi4uKS4uIS4uQC4uLi4uCkNQVUlEIDAwMDAwMDA4OjAwID0g
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQ
VUlEIDAwMDAwMDA5OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAu
Li4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDBhOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDBiOjAwID0gMDAw
MDAwMDEgMDAwMDAwMDIgMDAwMDAxMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlE
IDAwMDAwMDBiOjAxID0gMDAwMDAwMDUgMDAwMDAwMjAgMDAwMDAyMDEgMDAwMDAwMDAgfCAuLi4u
IC4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDBjOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDBkOjAwID0gMDAwMDAy
MDcgMDAwMDAzNDAgMDAwMDA5ODggMDAwMDAwMDAgfCAuLi4uQC4uLi4uLi4uLi4uCkNQVUlEIDAw
MDAwMDBkOjAxID0gMDAwMDAwMGYgMDAwMDAzNDAgMDAwMDE4MDAgMDAwMDAwMDAgfCAuLi4uQC4u
Li4uLi4uLi4uCkNQVUlEIDAwMDAwMDBkOjAyID0gMDAwMDAxMDAgMDAwMDAyNDAgMDAwMDAwMDAg
MDAwMDAwMDAgfCAuLi4uQC4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDBlOjAwID0gMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAw
MDBmOjAwID0gMDAwMDAwMDAgMDAwMDAwZmYgMDAwMDAwMDAgMDAwMDAwMDIgfCAuLi4uLi4uLi4u
Li4uLi4uCkNQVUlEIDAwMDAwMDBmOjAxID0gMDAwMDAwMDAgMDAwMDAwNDAgMDAwMDAwZmYgMDAw
MDAwMDcgfCAuLi4uQC4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDEwOjAwID0gMDAwMDAwMDAgMDAw
MDAwMDIgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDAwMDAwMDEw
OjAxID0gMDAwMDAwMGYgMDAwMDAwMDAgMDAwMDAwMDQgMDAwMDAwMGYgfCAuLi4uLi4uLi4uLi4u
Li4uCkNQVUlEIDQwMDAwMDAwOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDAwOjAwID0gODAwMDAwMjMgNjg3NDc1
NDEgNDQ0ZDQxNjMgNjk3NDZlNjUgfCAjLi4uQXV0aGNBTURlbnRpCkNQVUlEIDgwMDAwMDAxOjAw
ID0gMDBhMjBmMTIgMjAwMDAwMDAgNDQwMDAxZTMgMmJkMWNiZjUgfCAuLi4uLi4uIC4uLkQuLi4r
CkNQVUlEIDgwMDAwMDAyOjAwID0gMjA0NDRkNDEgNjU3YTc5NTIgMjAzOTIwNmUgMzAzNTM5MzUg
fCBBTUQgUnl6ZW4gOSA1OTUwCkNQVUlEIDgwMDAwMDAzOjAwID0gMzYzMTIwNTggNzI2ZjQzMmQg
NzI1MDIwNjUgNzM2NTYzNmYgfCBYIDE2LUNvcmUgUHJvY2VzCkNQVUlEIDgwMDAwMDA0OjAwID0g
MjA3MjZmNzMgMjAyMDIwMjAgMjAyMDIwMjAgMDAyMDIwMjAgfCBzb3IgICAgICAgICAgICAuCkNQ
VUlEIDgwMDAwMDA1OjAwID0gZmY0MGZmNDAgZmY0MGZmNDAgMjAwODAxNDAgMjAwODAxNDAgfCBA
LkAuQC5ALkAuLiBALi4gCkNQVUlEIDgwMDAwMDA2OjAwID0gNDgwMDIyMDAgNjgwMDQyMDAgMDIw
MDYxNDAgMDIwMDkxNDAgfCAuIi5ILkIuaEBhLi5ALi4uCkNQVUlEIDgwMDAwMDA3OjAwID0gMDAw
MDAwMDAgMDAwMDAwM2IgMDAwMDAwMDAgMDAwMDY3OTkgfCAuLi4uOy4uLi4uLi4uZy4uCkNQVUlE
IDgwMDAwMDA4OjAwID0gMDAwMDMwMzAgMTExZWY2NTcgMDAwMDUwMWYgMDAwMTAwMDAgfCAwMC4u
Vy4uLi5QLi4uLi4uCkNQVUlEIDgwMDAwMDA5OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDBhOjAwID0gMDAwMDAw
MDEgMDAwMDgwMDAgMDAwMDAwMDAgMTAxYmJjZmYgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgw
MDAwMDBiOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4u
Li4uLi4uLi4uCkNQVUlEIDgwMDAwMDBjOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDBkOjAwID0gMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAw
MDBlOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4u
Li4uLi4uCkNQVUlEIDgwMDAwMDBmOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDEwOjAwID0gMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDEx
OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4u
Li4uCkNQVUlEIDgwMDAwMDEyOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDEzOjAwID0gMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDE0OjAw
ID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4u
CkNQVUlEIDgwMDAwMDE1OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAg
fCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDE2OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAg
MDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDE3OjAwID0g
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQ
VUlEIDgwMDAwMDE4OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAu
Li4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDE5OjAwID0gZjA0MGYwNDAgZjA0MDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgfCBALkAuLi5ALi4uLi4uLi4uCkNQVUlEIDgwMDAwMDFhOjAwID0gMDAw
MDAwMDYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlE
IDgwMDAwMDFiOjAwID0gMDAwMDAzZmYgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4u
Li4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDFjOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDAxOjAwID0gMDAwMDQx
MjEgMDFjMDAwM2YgMDAwMDAwM2YgMDAwMDAwMDAgfCAhQS4uPy4uLj8uLi4uLi4uCkNQVUlEIDgw
MDAwMDFlOjAwID0gMDAwMDAwMDAgMDAwMDAxMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4u
Li4uLi4uLi4uCkNQVUlEIDgwMDAwMDFmOjAwID0gMDAwMTc4MGYgMDAwMDAxNzMgMDAwMDAxZmQg
MDAwMDAwMDEgfCAueC4ucy4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDIwOjAwID0gMDAwMDAwMDAg
MDAwMDAwMDIgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAw
MDIwOjAxID0gMDAwMDAwMGIgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMGYgfCAuLi4uLi4uLi4u
Li4uLi4uCkNQVUlEIDgwMDAwMDIxOjAwID0gMDAwMDAwNGQgMDAwMDAwMDAgMDAwMDAwMDAgMDAw
MDAwMDAgfCBNLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDIyOjAwID0gMDAwMDAwMDAgMDAw
MDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIDgwMDAwMDIz
OjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4u
Li4uCkNQVUlEIDgwODYwMDAwOjAwID0gMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgfCAuLi4uLi4uLi4uLi4uLi4uCkNQVUlEIGMwMDAwMDAwOjAwID0gMDAwMDAwMDAgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgfCAuLi4uLi4uLi4uLi4uLi4uCg==
-----------------------9e2f95d9d5536c3e16057210da24934a
Content-Type: text/plain; filename="dom0-lspci.txt"; name="dom0-lspci.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dom0-lspci.txt"; name="dom0-lspci.txt"

MDA6MDAuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4g
W0FNRF0gU3RhcnNoaXAvTWF0aXNzZSBSb290IENvbXBsZXggWzEwMjI6MTQ4MF0KMDA6MDAuMiBJ
T01NVSBbMDgwNl06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gU3RhcnNoaXAv
TWF0aXNzZSBJT01NVSBbMTAyMjoxNDgxXQowMDowMS4wIEhvc3QgYnJpZGdlIFswNjAwXTogQWR2
YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBTdGFyc2hpcC9NYXRpc3NlIFBDSWUgRHVt
bXkgSG9zdCBCcmlkZ2UgWzEwMjI6MTQ4Ml0KMDA6MDEuMSBQQ0kgYnJpZGdlIFswNjA0XTogQWR2
YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBTdGFyc2hpcC9NYXRpc3NlIEdQUCBCcmlk
Z2UgWzEwMjI6MTQ4M10KMDA6MDEuMiBQQ0kgYnJpZGdlIFswNjA0XTogQWR2YW5jZWQgTWljcm8g
RGV2aWNlcywgSW5jLiBbQU1EXSBTdGFyc2hpcC9NYXRpc3NlIEdQUCBCcmlkZ2UgWzEwMjI6MTQ4
M10KMDA6MDIuMCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIElu
Yy4gW0FNRF0gU3RhcnNoaXAvTWF0aXNzZSBQQ0llIER1bW15IEhvc3QgQnJpZGdlIFsxMDIyOjE0
ODJdCjAwOjAzLjAgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuIFtBTURdIFN0YXJzaGlwL01hdGlzc2UgUENJZSBEdW1teSBIb3N0IEJyaWRnZSBbMTAyMjox
NDgyXQowMDowMy4xIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuIFtBTURdIFN0YXJzaGlwL01hdGlzc2UgR1BQIEJyaWRnZSBbMTAyMjoxNDgzXQowMDowNC4w
IEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBT
dGFyc2hpcC9NYXRpc3NlIFBDSWUgRHVtbXkgSG9zdCBCcmlkZ2UgWzEwMjI6MTQ4Ml0KMDA6MDUu
MCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0g
U3RhcnNoaXAvTWF0aXNzZSBQQ0llIER1bW15IEhvc3QgQnJpZGdlIFsxMDIyOjE0ODJdCjAwOjA3
LjAgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURd
IFN0YXJzaGlwL01hdGlzc2UgUENJZSBEdW1teSBIb3N0IEJyaWRnZSBbMTAyMjoxNDgyXQowMDow
Ny4xIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURd
IFN0YXJzaGlwL01hdGlzc2UgSW50ZXJuYWwgUENJZSBHUFAgQnJpZGdlIDAgdG8gYnVzW0U6Ql0g
WzEwMjI6MTQ4NF0KMDA6MDguMCBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4gW0FNRF0gU3RhcnNoaXAvTWF0aXNzZSBQQ0llIER1bW15IEhvc3QgQnJpZGdl
IFsxMDIyOjE0ODJdCjAwOjA4LjEgUENJIGJyaWRnZSBbMDYwNF06IEFkdmFuY2VkIE1pY3JvIERl
dmljZXMsIEluYy4gW0FNRF0gU3RhcnNoaXAvTWF0aXNzZSBJbnRlcm5hbCBQQ0llIEdQUCBCcmlk
Z2UgMCB0byBidXNbRTpCXSBbMTAyMjoxNDg0XQowMDoxNC4wIFNNQnVzIFswYzA1XTogQWR2YW5j
ZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBGQ0ggU01CdXMgQ29udHJvbGxlciBbMTAyMjo3
OTBiXSAocmV2IDYxKQowMDoxNC4zIElTQSBicmlkZ2UgWzA2MDFdOiBBZHZhbmNlZCBNaWNybyBE
ZXZpY2VzLCBJbmMuIFtBTURdIEZDSCBMUEMgQnJpZGdlIFsxMDIyOjc5MGVdIChyZXYgNTEpCjAw
OjE4LjAgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtB
TURdIE1hdGlzc2UvVmVybWVlciBEYXRhIEZhYnJpYzogRGV2aWNlIDE4aDsgRnVuY3Rpb24gMCBb
MTAyMjoxNDQwXQowMDoxOC4xIEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8gRGV2
aWNlcywgSW5jLiBbQU1EXSBNYXRpc3NlL1Zlcm1lZXIgRGF0YSBGYWJyaWM6IERldmljZSAxOGg7
IEZ1bmN0aW9uIDEgWzEwMjI6MTQ0MV0KMDA6MTguMiBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFu
Y2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gTWF0aXNzZS9WZXJtZWVyIERhdGEgRmFicmlj
OiBEZXZpY2UgMThoOyBGdW5jdGlvbiAyIFsxMDIyOjE0NDJdCjAwOjE4LjMgSG9zdCBicmlkZ2Ug
WzA2MDBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIE1hdGlzc2UvVmVybWVl
ciBEYXRhIEZhYnJpYzogRGV2aWNlIDE4aDsgRnVuY3Rpb24gMyBbMTAyMjoxNDQzXQowMDoxOC40
IEhvc3QgYnJpZGdlIFswNjAwXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBN
YXRpc3NlL1Zlcm1lZXIgRGF0YSBGYWJyaWM6IERldmljZSAxOGg7IEZ1bmN0aW9uIDQgWzEwMjI6
MTQ0NF0KMDA6MTguNSBIb3N0IGJyaWRnZSBbMDYwMF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMs
IEluYy4gW0FNRF0gTWF0aXNzZS9WZXJtZWVyIERhdGEgRmFicmljOiBEZXZpY2UgMThoOyBGdW5j
dGlvbiA1IFsxMDIyOjE0NDVdCjAwOjE4LjYgSG9zdCBicmlkZ2UgWzA2MDBdOiBBZHZhbmNlZCBN
aWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIE1hdGlzc2UvVmVybWVlciBEYXRhIEZhYnJpYzogRGV2
aWNlIDE4aDsgRnVuY3Rpb24gNiBbMTAyMjoxNDQ2XQowMDoxOC43IEhvc3QgYnJpZGdlIFswNjAw
XTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBNYXRpc3NlL1Zlcm1lZXIgRGF0
YSBGYWJyaWM6IERldmljZSAxOGg7IEZ1bmN0aW9uIDcgWzEwMjI6MTQ0N10KMDE6MDAuMCBOb24t
Vm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXIgWzAxMDhdOiBTYW1zdW5nIEVsZWN0cm9uaWNzIENv
IEx0ZCBOVk1lIFNTRCBDb250cm9sbGVyIFM0TFYwMDhbUGFzY2FsXSBbMTQ0ZDphODBjXQoyMDow
MC4wIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURd
IE1hdGlzc2UgU3dpdGNoIFVwc3RyZWFtIFsxMDIyOjU3YWRdCjIxOjAyLjAgUENJIGJyaWRnZSBb
MDYwNF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gTWF0aXNzZSBQQ0llIEdQ
UCBCcmlkZ2UgWzEwMjI6NTdhM10KMjE6MDQuMCBQQ0kgYnJpZGdlIFswNjA0XTogQWR2YW5jZWQg
TWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBNYXRpc3NlIFBDSWUgR1BQIEJyaWRnZSBbMTAyMjo1
N2EzXQoyMTowNS4wIFBDSSBicmlkZ2UgWzA2MDRdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJ
bmMuIFtBTURdIE1hdGlzc2UgUENJZSBHUFAgQnJpZGdlIFsxMDIyOjU3YTNdCjIxOjA2LjAgUENJ
IGJyaWRnZSBbMDYwNF06IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gTWF0aXNz
ZSBQQ0llIEdQUCBCcmlkZ2UgWzEwMjI6NTdhM10KMjE6MDguMCBQQ0kgYnJpZGdlIFswNjA0XTog
QWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBNYXRpc3NlIFBDSWUgR1BQIEJyaWRn
ZSBbMTAyMjo1N2E0XQoyNDowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBJbnRlbCBD
b3Jwb3JhdGlvbiBFdGhlcm5ldCBDb250cm9sbGVyIFg1NTAgWzgwODY6MTU2M10gKHJldiAwMSkK
MjQ6MDAuMSBFdGhlcm5ldCBjb250cm9sbGVyIFswMjAwXTogSW50ZWwgQ29ycG9yYXRpb24gRXRo
ZXJuZXQgQ29udHJvbGxlciBYNTUwIFs4MDg2OjE1NjNdIChyZXYgMDEpCjI1OjEwLjAgRXRoZXJu
ZXQgY29udHJvbGxlciBbMDIwMF06IEludGVsIENvcnBvcmF0aW9uIFg1NTAgVmlydHVhbCBGdW5j
dGlvbiBbODA4NjoxNTY1XQoyNToxMC4yIEV0aGVybmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBJbnRl
bCBDb3Jwb3JhdGlvbiBYNTUwIFZpcnR1YWwgRnVuY3Rpb24gWzgwODY6MTU2NV0KMjY6MDAuMCBF
dGhlcm5ldCBjb250cm9sbGVyIFswMjAwXTogSW50ZWwgQ29ycG9yYXRpb24gSTIxMCBHaWdhYml0
IE5ldHdvcmsgQ29ubmVjdGlvbiBbODA4NjoxNTMzXSAocmV2IDAzKQoyNzowMC4wIEV0aGVybmV0
IGNvbnRyb2xsZXIgWzAyMDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBJMjEwIEdpZ2FiaXQgTmV0d29y
ayBDb25uZWN0aW9uIFs4MDg2OjE1MzNdIChyZXYgMDMpCjI4OjAwLjAgUENJIGJyaWRnZSBbMDYw
NF06IEFTUEVFRCBUZWNobm9sb2d5LCBJbmMuIEFTVDExNTAgUENJLXRvLVBDSSBCcmlkZ2UgWzFh
MDM6MTE1MF0gKHJldiAwNCkKMjk6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyIFswMzAw
XTogQVNQRUVEIFRlY2hub2xvZ3ksIEluYy4gQVNQRUVEIEdyYXBoaWNzIEZhbWlseSBbMWEwMzoy
MDAwXSAocmV2IDQxKQoyYTowMC4wIE5vbi1Fc3NlbnRpYWwgSW5zdHJ1bWVudGF0aW9uIFsxMzAw
XTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBTdGFyc2hpcC9NYXRpc3NlIFJl
c2VydmVkIFNQUCBbMTAyMjoxNDg1XQoyYTowMC4xIFVTQiBjb250cm9sbGVyIFswYzAzXTogQWR2
YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBNYXRpc3NlIFVTQiAzLjAgSG9zdCBDb250
cm9sbGVyIFsxMDIyOjE0OWNdCjJhOjAwLjMgVVNCIGNvbnRyb2xsZXIgWzBjMDNdOiBBZHZhbmNl
ZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIE1hdGlzc2UgVVNCIDMuMCBIb3N0IENvbnRyb2xs
ZXIgWzEwMjI6MTQ5Y10KMmI6MDAuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyIFswMzAwXTog
TlZJRElBIENvcnBvcmF0aW9uIFRVMTAyIFtHZUZvcmNlIFJUWCAyMDgwIFRpIFJldi4gQV0gWzEw
ZGU6MWUwN10gKHJldiBhMSkKMmI6MDAuMSBBdWRpbyBkZXZpY2UgWzA0MDNdOiBOVklESUEgQ29y
cG9yYXRpb24gVFUxMDIgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgWzEwZGU6MTBm
N10gKHJldiBhMSkKMmI6MDAuMiBVU0IgY29udHJvbGxlciBbMGMwM106IE5WSURJQSBDb3Jwb3Jh
dGlvbiBUVTEwMiBVU0IgMy4xIEhvc3QgQ29udHJvbGxlciBbMTBkZToxYWQ2XSAocmV2IGExKQoy
YjowMC4zIFNlcmlhbCBidXMgY29udHJvbGxlciBbMGM4MF06IE5WSURJQSBDb3Jwb3JhdGlvbiBU
VTEwMiBVU0IgVHlwZS1DIFVDU0kgQ29udHJvbGxlciBbMTBkZToxYWQ3XSAocmV2IGExKQoyYzow
MC4wIE5vbi1Fc3NlbnRpYWwgSW5zdHJ1bWVudGF0aW9uIFsxMzAwXTogQWR2YW5jZWQgTWljcm8g
RGV2aWNlcywgSW5jLiBbQU1EXSBTdGFyc2hpcC9NYXRpc3NlIFBDSWUgRHVtbXkgRnVuY3Rpb24g
WzEwMjI6MTQ4YV0KMmQ6MDAuMCBOb24tRXNzZW50aWFsIEluc3RydW1lbnRhdGlvbiBbMTMwMF06
IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gU3RhcnNoaXAvTWF0aXNzZSBSZXNl
cnZlZCBTUFAgWzEwMjI6MTQ4NV0KMmQ6MDAuMSBFbmNyeXB0aW9uIGNvbnRyb2xsZXIgWzEwODBd
OiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURdIFN0YXJzaGlwL01hdGlzc2UgQ3J5
cHRvZ3JhcGhpYyBDb3Byb2Nlc3NvciBQU1BDUFAgWzEwMjI6MTQ4Nl0KMmQ6MDAuMyBVU0IgY29u
dHJvbGxlciBbMGMwM106IEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4gW0FNRF0gTWF0aXNz
ZSBVU0IgMy4wIEhvc3QgQ29udHJvbGxlciBbMTAyMjoxNDljXQo=
-----------------------9e2f95d9d5536c3e16057210da24934a--

--------acfee3fc240a7c5f5b7ba374ff1d38b0ae3a3151d6f3a29c1457c0a2939087ef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0Fgmkx7BcJEAi2TYeeRSZQRRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmen9h380RP1bihY7vCvGJKtc7vedL0jsXJ2R6iQ
2bz0PRYhBO9O8zsukynWrUnkzwi2TYeeRSZQAAB7ewEApfYHh6lJylTekghj
ORViJ09C+aBVr8YJ/3KeLmBquDQBAJc0U2/z8QZGQWWCFRpCKXL3oBU+2N91
quCRabPFwzoF
=lQU1
-----END PGP SIGNATURE-----


--------acfee3fc240a7c5f5b7ba374ff1d38b0ae3a3151d6f3a29c1457c0a2939087ef--


