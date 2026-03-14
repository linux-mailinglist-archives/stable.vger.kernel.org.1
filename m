Return-Path: <stable+bounces-225425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LO8CjJ4tWln0wAAu9opvQ
	(envelope-from <stable+bounces-225425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:01:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604B28D986
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 16:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E14BC301AD25
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 15:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA4A366548;
	Sat, 14 Mar 2026 15:01:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.aaazen.com (99-33-87-210.lightspeed.sntcca.sbcglobal.net [99.33.87.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF64D26AAAB;
	Sat, 14 Mar 2026 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.33.87.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500460; cv=none; b=f8QmZFt1dW8BvdvgEkYAMA5tAC/VtxnMowy3AWNuCQZVu1ZqFpgWWAnQgaZCl2S/rdTKeT+kFbZLUYMJ3gWwdRIm4R/vdSCvCScelyh1kYflAOITbhoK5UIRqG4r1HXOcW8NtcFFDutKztJ44AOjLjCav0TSjzp9cARPmXo4tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500460; c=relaxed/simple;
	bh=2pU54HCPZnv78c96M8Vd4vM7vortapSFQYle0mPNuwk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=q00Gip151eXcmZJkV5ZlWxqdfyqZv6ELqSF70wYBFdp0GBsCMSy57+ZPIAbDM5dK6QmoKqyLDci2ipY2Zg1mC7i2rdVNoqfHEfXmo6vTMbmLn01QKB9gxkZhda35kHKehJYr2v5vqF9zykZKx6R5MIrJ4lff8A0DJDDwXnmKwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com; spf=pass smtp.mailfrom=aaazen.com; arc=none smtp.client-ip=99.33.87.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aaazen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaazen.com
Received: from localhost (localhost [127.0.0.1])
	by thursday.test (OpenSMTPD) with ESMTP id 21360fc3;
	Sat, 14 Mar 2026 08:00:57 -0700 (PDT)
Date: Sat, 14 Mar 2026 08:00:57 -0700 (PDT)
From: Richard Narron <richard@aaazen.com>
X-X-Sender: richard@thursday.test
To: Cal Peake <cp@absolutedigital.net>
cc: Sasha Levin <sashal@kernel.org>, 
    Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux stable <stable@vger.kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Patrick Volkerding <volkerdi@gmail.com>
Subject: Re: Linux 6.18.17 -- build regression
In-Reply-To: <403d62bf-e375-4bf5-a5be-f1792a52010@absolutedigital.net>
Message-ID: <f7968de1-ecf0-e0f4-2a39-957b4dc7f35@aaazen.com>
References: <20260312112454.940017-1-sashal@kernel.org> <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net> <abNdx_cQR_BqMm3z@laps> <358262e8-70ca-9db3-1774-9170cc69dae7@aaazen.com> <403d62bf-e375-4bf5-a5be-f1792a52010@absolutedigital.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225425-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux-foundation.org,suse.cz,linuxfoundation.org,gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[aaazen.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard@aaazen.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,aaazen.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 5604B28D986
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026, Cal Peake wrote:

> On Fri, 13 Mar 2026, Richard Narron wrote:
>
> > On Thu, 12 Mar 2026, Sasha Levin wrote:
> >
> > > Could you please confirm that cherry-picking 93d0fcdddc9e ("cxl/acpi: Fix
> > > CXL_ACPI and CXL_PMEM Kconfig tristate mismatch") fixes the issue you're
> > > seeing?
> > >
> > Hello Sasha,
> >
> >    Patrick Volkerding found a patch that worked for me:
> >
> > https://lore.kernel.org/lkml/20260302200429.803417-1-gourry@gourry.net/
> >
> >    In drivers/cxl/acpi.c
> >     static int cxl_acpi_probe(struct platform_device *pdev)
> >     it changes IS_ENABLED(CONFIG_CXL_PMEM)
> >             to IS_REACHABLE(CONFIG_CXL_PMEM)
> >
>
> Hi Richard, Pat,
>
> Below is the commit that Sasha pointed me to that fixes the issue for me
> if you'd like to have a look.
>
> --
> Cal Peake
>
> >From 93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d Mon Sep 17 00:00:00 2001
> From: Keith Busch <kbusch@kernel.org>
> Date: Thu, 5 Mar 2026 12:40:56 -0800
> Subject: cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch
>
> Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
> cxl_pmem.ko") moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem file,
> which has independent config compile options for built-in or module. The
> call from cxl_acpi_probe() is guarded by IS_ENABLED(CONFIG_CXL_PMEM),
> which evaluates to true for both =y and =m.
>
> When CONFIG_CXL_PMEM=m, a built-in cxl_acpi attempts to reference a
> symbol exported by a module, which fails to link. CXL_PMEM cannot simply
> be promoted to =y in this configuration because it depends on LIBNVDIMM,
> which may itself be =m.
>
> Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
> CXL_PMEM is a module. This contrains CXL_ACPI to =m when CXL_PMEM=m,
> while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
> either built-in or disabled.
>
> [ dj: Fix up commit reference formatting. ]
>
> Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Link: https://patch.msgid.link/20260305204057.1516948-1-kbusch@meta.com
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 4589bf11d3fe00..80aeb0d556bd76 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -59,6 +59,7 @@ config CXL_ACPI
>  	tristate "CXL ACPI: Platform Support"
>  	depends on ACPI
>  	depends on ACPI_NUMA
> +	depends on CXL_PMEM || !CXL_PMEM
>  	default CXL_BUS
>  	select ACPI_TABLE_LIB
>  	select ACPI_HMAT
> --
> cgit 1.2.3-korg
>
>
Hi Cal and Sasha,

I tested the patch and it gave me a clean build.

Patrick found a "no-patch" configuration solution:

   Change CXL_ACPI=y to CXL_ACPI=m

which I also tested and it also gave me a clean build.

