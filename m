Return-Path: <stable+bounces-211759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJfWEC+geGn4rQEAu9opvQ
	(envelope-from <stable+bounces-211759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 12:23:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D468A938D9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D61300F150
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B112346AD5;
	Tue, 27 Jan 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbxOGgW+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B22DC34E;
	Tue, 27 Jan 2026 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512950; cv=none; b=QbYHiDTSF/Wal6jWlbDL9xu9sk5iK2oOn0RG5jcLqC5Xd7rLe2OXQ/uFdGEDM3zN2FtZkaG+4ZSzBOY2Z3I76AamSbTlGQwLnmYRuUVJEw/oqoDkIf3o8KEeFyQ+j2xhE9O1WJz/QXeACYPy+BgPvSYUxcV0IBBb3uIWwyn8elg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512950; c=relaxed/simple;
	bh=ShcIVGVdBHAgRocoZWi0ahxvep2T4ECjaq09D3KhTno=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ApQ1EHOVEHKZB2oDP/zwiVNBbPiG40eSzF3/m4eUAnz5cBWO9WDcIVBwtaCJh+3O4pKvroyBUdyfXsEv5V+K+LeyuvQw3CmjCD0cbrZofK09pNUP8XycP8+DGvsIRmObufTDsEkJsw314R44N69XcpPIllUJByIptDErbsqZ+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbxOGgW+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769512949; x=1801048949;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ShcIVGVdBHAgRocoZWi0ahxvep2T4ECjaq09D3KhTno=;
  b=mbxOGgW+BniFIhs005oY0oG5Wt7Cg0yb/FxJEtvM7rFsxh56rD1BoodE
   ruRTLVdpo/sflkvtaEbljIc8atSicPHu40e8MAXPbQw7+F1RaLDrcqH9i
   z1vBWWcuU9nfp7qG+PYbD4aBKtVGQPF+OUP573HfxO+xictw5tEGXNA68
   3cHgGLeRBAEruZL5uPar8o0qsi76i7k+m0tGkNF+QXDzLliKELnZFtjmU
   SWuhjFn7QJXjqHH3i3uLyWzERDZNgayTVD4mxOpOLHctAo55UTv+0xjzT
   9u+NBZcunpYujf++h+XiloIvxm5OPl9v2VVfFJut+/aYzXbRfYwXYZkDM
   g==;
X-CSE-ConnectionGUID: bD2/kSMKQtafGp9IPFWixA==
X-CSE-MsgGUID: pjbLFmntQ2yAoFC/Tu0Abw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="70607751"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70607751"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:22:28 -0800
X-CSE-ConnectionGUID: ckxK/hzFRcScM7FOaux1PA==
X-CSE-MsgGUID: CSJjxw7dQ1qnjPHodO06zA==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.67])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 03:22:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Jan 2026 13:22:22 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Dominik Brodowski <linux@dominikbrodowski.net>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Malte_Schr=F6der?= <malte+lkml@tnxip.de>, 
    stable@vger.kernel.org
Subject: Re: [PATCH 02/23] PCI: Rewrite bridge window head alignment
 function
In-Reply-To: <20260126221723.GA318550@bhelgaas>
Message-ID: <6405c825-6d8e-043c-38f1-e7e1a4ebf44a@linux.intel.com>
References: <20260126221723.GA318550@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1936482118-1769512942=:1055"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211759-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Queue-Id: D468A938D9
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1936482118-1769512942=:1055
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Jan 2026, Bjorn Helgaas wrote:

> On Fri, Dec 19, 2025 at 07:40:15PM +0200, Ilpo J=C3=A4rvinen wrote:
> > The calculation of bridge window head alignment is done by
> > calculate_mem_align() [*]. With the default bridge window alignment, it
> > is used for both head and tail alignment.
> >=20
> > The selected head alignment does not always result in tight-fitting
> > resources (gap at d4f00000-d4ffffff):
> >=20
> >     d4800000-dbffffff : PCI Bus 0000:06
> >       d4800000-d48fffff : PCI Bus 0000:07
> >         d4800000-d4803fff : 0000:07:00.0
> >           d4800000-d4803fff : nvme
> >       d4900000-d49fffff : PCI Bus 0000:0a
> >         d4900000-d490ffff : 0000:0a:00.0
> >           d4900000-d490ffff : r8169
> >         d4910000-d4913fff : 0000:0a:00.0
> >       d4a00000-d4cfffff : PCI Bus 0000:0b
> >         d4a00000-d4bfffff : 0000:0b:00.0
> >           d4a00000-d4bfffff : 0000:0b:00.0
> >         d4c00000-d4c07fff : 0000:0b:00.0
> >       d4d00000-d4dfffff : PCI Bus 0000:15
> >         d4d00000-d4d07fff : 0000:15:00.0
> >           d4d00000-d4d07fff : xhci-hcd
> >       d4e00000-d4efffff : PCI Bus 0000:16
> >         d4e00000-d4e7ffff : 0000:16:00.0
> >         d4e80000-d4e803ff : 0000:16:00.0
> >           d4e80000-d4e803ff : ahci
> >       d5000000-dbffffff : PCI Bus 0000:0c
> >=20
> > This has not been caused problems (for years) with the default bridge
> > window tail alignment that grossly over-estimates the required tail
> > alignment leaving more tail room than necessary. With the introduction
> > of relaxed tail alignment that leaves no extra tail room whatsoever,
> > any gaps will immediately turn into assignment failures.
> >=20
> > Introduce head alignment calculation that ensures no gaps are left and
> > apply the new approach when using relaxed alignment. We may want to
> > consider using it for the normal alignment eventually, but as the first
> > step, solve only the problem with the relaxed tail alignment.
> >=20
> > ([*] I don't understand the algorithm in calculate_mem_align().)
> >=20
> > Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, a=
rm, parisc) [2/2]")
>=20
> check_commits complains that this SHA1 doesn't exist:
>=20
>   In commit
>=20
>     a21a27a0e893 ("PCI: Rewrite bridge window head alignment function")
>=20
>   Fixes tag
>=20
>     Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha,=
 arm, parisc) [2/2]")
>=20
>   has these problem(s):
>=20
>     - Target SHA1 does not exist
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D5d0a8965aea9
> does find it, but says it's not reachable.
>=20
> It's so old (2002) that I'm not sure it's worth including it as a
> Fixes: tag.

Hi,

The commit is in the history repo, and yes, even the git web ui for some=20
reason says it's not reachable by any branch:

https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/=
?id=3D5d0a8965aea93bd799ebcd671e562d90f3ec2711

=2E..But it's part of a tag for sure:

$ git describe --contains 5d0a8965aea93bd799ebcd671e562d90f3ec2711
v2.5.15~11^2~5^2~10

The composition in the history repo is strange, things don't always appear=
=20
properly linear for some reason there but I've found that commit by going=
=20
backwards with git annotate code-line-shaid^ in a "loop" until I came=20
back to commit that introduced it. Maybe this entire lineage of commits is=
=20
headed only by a tag, dunno.

Many things in the resource fitting and assignment algorithm lead back to=
=20
that same commit BTW (and its commit message isn't very helpful in=20
explaining why things were made the way they were).

If you don't want to put it into a Fixes tag, could you put that history=20
repo URL into a Link tag instead. I do find it relevant where this came=20
from.

--=20
 i.

--8323328-1936482118-1769512942=:1055--

