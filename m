Return-Path: <stable+bounces-225394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id m01jLn2LtGlUpgAAu9opvQ
	(envelope-from <stable+bounces-225394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:11:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A6228A465
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04EA300E482
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2F33689D;
	Fri, 13 Mar 2026 22:11:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4592DF707;
	Fri, 13 Mar 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439863; cv=none; b=CuKZDn3/ZKQ7A2i/sKdVlWFWZbmGGk18HNPUkASysEsDKLmLq2fkW5iYoFKgp8kSIBkQsaxSuQkV73bZBVqemEY8gEC184zkGIJphGQ3DrSjOpwU25hrQU9Q9CEktDZyDjDlcDDBLWroWo/2uRE6bIuGvZagTdsOwfLdiZVLCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439863; c=relaxed/simple;
	bh=iB3FvdL1/ak7SaRE+09pl8/n1ufE21vz+EeoB662cIM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F/TxendUO2CUSnjVNydGrOElXqNRj8O6TRMXo+tkPGZU2RNRuX+u1R43gcBzNdle1urED36We0iIlccab57xgtgtaS70az3hUUv3XDHs3BocHkk1M4Yu6TajNEOTjQ0o6JE2keFDgoryTG1vCF6ONpX7Aekc0NV9XNIqQsxMTkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id a2d8674c;
	Fri, 13 Mar 2026 15:04:21 -0700 (PDT)
Date: Fri, 13 Mar 2026 15:04:21 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Sasha Levin <sashal@kernel.org>
cc: Cal Peake <cp@absolutedigital.net>, 
    Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux stable <stable@vger.kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Patrick Volkerding <volkerdi@gmail.com>
Subject: Re: Linux 6.18.17 -- build regression
In-Reply-To: <abNdx_cQR_BqMm3z@laps>
Message-ID: <358262e8-70ca-9db3-1774-9170cc69dae7@aaazen.com>
References: <20260312112454.940017-1-sashal@kernel.org> <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net> <abNdx_cQR_BqMm3z@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225394-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[absolutedigital.net,vger.kernel.org,linux-foundation.org,suse.cz,linuxfoundation.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[aaazen.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard@aaazen.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,aaazen.com:mid]
X-Rspamd-Queue-Id: B3A6228A465
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026, Sasha Levin wrote:

> On Thu, Mar 12, 2026 at 06:24:19PM -0400, Cal Peake wrote:
> > On Thu, 12 Mar 2026, Sasha Levin wrote:
> >
> > > I'm announcing the release of the 6.18.17 kernel.
> > >
> > > All users of the 6.18 kernel series must upgrade.
> > >
> >
> > Hi,
> >
> > This release breaks my build with the following output:
> >
> >  LD      .tmp_vmlinux1
> > ld: drivers/cxl/acpi.o: in function `add_root_nvdimm_bridge':
> > acpi.c:(.text+0x16f): undefined reference to `devm_cxl_add_nvdimm_bridge'
> > make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
> > make[1]: *** [/home/cal/linux/kernel/build/linux-6.18.17/Makefile:1242:
> > vmlinux] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> >
> > I've attached my gzipped config. Commit af9bf9889663 looks possibly
> > guilty, but I don't have time at the moment to fully verify.
> >
> > Please let me know if I can provide anything else.
>
> Hey,
>
> Thanks for the report!
>
> Could you please confirm that cherry-picking 93d0fcdddc9e ("cxl/acpi: Fix
> CXL_ACPI and CXL_PMEM Kconfig tristate mismatch") fixes the issue you're
> seeing?
>
Hello Sasha,

   Patrick Volkerding found a patch that worked for me:

https://lore.kernel.org/lkml/20260302200429.803417-1-gourry@gourry.net/

   In drivers/cxl/acpi.c
    static int cxl_acpi_probe(struct platform_device *pdev)
    it changes IS_ENABLED(CONFIG_CXL_PMEM)
            to IS_REACHABLE(CONFIG_CXL_PMEM)

Richard Narron

