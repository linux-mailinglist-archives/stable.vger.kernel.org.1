Return-Path: <stable+bounces-203141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA13CD30AA
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 15:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 647E830161AB
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 14:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176127CCF0;
	Sat, 20 Dec 2025 14:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Sz9mcQw6"
X-Original-To: stable@vger.kernel.org
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109AD279324;
	Sat, 20 Dec 2025 14:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766240064; cv=none; b=n5ops74SjzwsONDpN7AxBMz8dgqRAaBhbatW+2mVrFJWzN3xqxUAzhD446EYaToyzQ/kwPTvNwjoieblXl2/DsZHIhKrHvCSK3MUsIVCSIWYBtvaZwU10n5Is+jehsIurs/XabNSG9O/QES5GZCPEopfTezRMdBV1WpDdc7qqsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766240064; c=relaxed/simple;
	bh=YEzxeLIX/V3itJEthvnOKudLOVJDuP5doFkX8lvuW30=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awtt9NEucKczWf/bZ8ZlmqvBbco2gGaGLFJqingnqo8DvAW9zscDG/4WxyxhQjKtVd2gnTnbqyTVTPcnElQ4uAtJE8VWUAH4BczjruCnrdprU5JJdiVznNy/NBPfKfqMEAfQN47sjHZtho9pVP89BDZORjk5yv1WxxKFjQQmdEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Sz9mcQw6; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lauU+5688IX3I5PXOmeuDmru+LUy7bDpIBynxGOgDIo=; t=1766240061;
	x=1766844861; b=Sz9mcQw6ZJwhb7Hm3udixrD27auaGxriI1+P2f7DydUI5o6bWi4/Q2tELtxet
	n0Os7HNlONp3QKNLtsd5u/eNaYc0VVIhIwtzRcBNEmQZwld0XF4w1YiMK91x1TK26o9vFOAqcZEgd
	Mee7s2wdLwPR2HTfaaVq22jBzinuuqnUagiyXl9FBt7bNrZvv+xnqv377KDsfAdJAyCCsDYKLkz2w
	MDGcop1lXSm/kMYiT26zSYTIHnh7tor+Rqss9pfpGPpmnz1AVoqKQAm2J/D7FjwkXTiQuB2bRDIiA
	5kRw2kSUBJN4DjjlUy2YscpWZ+B/pFOmOOknGr5Il96/+qI9LA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vWxfn-00000002ekv-3PHl; Sat, 20 Dec 2025 15:11:07 +0100
Received: from dynamic-089-012-116-231.89.12.pool.telefonica.de ([89.12.116.231] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vWxfn-00000000wKT-2LfJ; Sat, 20 Dec 2025 15:11:07 +0100
Message-ID: <8e412a9834ced553c4eb757362a122d26f16213f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: dma-sysfs: add missing put_device() in
 dma_create_sysfs_files()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Markus Elfring <Markus.Elfring@web.de>, Haoxiang Li	
 <lihaoxiang@isrc.iscas.ac.cn>, linux-sh@vger.kernel.org, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Kay Sievers <kay.sievers@vrfy.org>, Rich
 Felker	 <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date: Sat, 20 Dec 2025 15:11:06 +0100
In-Reply-To: <8552e5b2-16ea-42d9-978e-5d26ad0b1f15@web.de>
References: <20251220062836.683611-1-lihaoxiang@isrc.iscas.ac.cn>
	 <8552e5b2-16ea-42d9-978e-5d26ad0b1f15@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Markus,

On Sat, 2025-12-20 at 14:56 +0100, Markus Elfring wrote:
> > If device_register() fails, call put_device() to drop the device
> > reference. Also, call device_unregister() if device_create_file()
> > fails.
>=20
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.19-rc1#n659
>=20
>=20
> You propose to complete the exception handling for two cases.
> Is there a need to indicate such a detail in the summary phrase according=
ly?

Maybe I'm completely missing something here, but I find the description sho=
rt
and reasonable. As the SH maintainer, I haven't started reviewing these pat=
ches
themselves yet, I definitely interested to understand what the problem is.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

