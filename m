Return-Path: <stable+bounces-225399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEchOHSStGkNqgAAu9opvQ
	(envelope-from <stable+bounces-225399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:40:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A36028A807
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7BC330E34C9
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F70E386573;
	Fri, 13 Mar 2026 22:40:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.absolutedigital.net (mx2.absolutedigital.net [50.242.207.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35656379ECF;
	Fri, 13 Mar 2026 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.242.207.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773441647; cv=none; b=VgGTLGR5+e8d7g+Gpr39MyIpQHoIlS9H55aiEqC5/fOxuycillkgpYLeZw88I0EpsHo9Tu77NFJQpGurnFb7lRRp3d84GvmQSNk94LDMDlqRRbmmHTFBDSJRO4wJv4lpPhoGiGfItrlZ20YTOebkpYmg65NR0oOI5lSEFgSJmb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773441647; c=relaxed/simple;
	bh=v08IWYo5ZfV5z58CO7g6CnYE3/LD4JFd0NwT77Iioqc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OZ+/Up2J6QhySc/OW1BMAKQcq8EX8r6jIk4Ri53tKSyWxJEMUMCUw9XJvB7WBGHzsot8kv2RO8ECw7zi9pP06L4zyx8hAyTWrKsWdufc/oER1VMxs1q0psNSaMe+G4JN/Rcnc7E8V7NWISJItzh22nC7eMPbvyqdx+ftJZEjMEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net; spf=pass smtp.mailfrom=absolutedigital.net; arc=none smtp.client-ip=50.242.207.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=absolutedigital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=absolutedigital.net
Received: from lancer.cnet.absolutedigital.net (lancer.cnet.absolutedigital.net [10.7.5.10])
	by luxor.inet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62DMeHmU005607
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 18:40:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by lancer.cnet.absolutedigital.net (8.18.2/8.18.1) with ESMTPS id 62DMeHvU002695
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 13 Mar 2026 18:40:17 -0400
Date: Fri, 13 Mar 2026 18:40:17 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Richard Narron <richard@aaazen.com>
cc: Sasha Levin <sashal@kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Patrick Volkerding <volkerdi@gmail.com>
Subject: Re: Linux 6.18.17 -- build regression
In-Reply-To: <358262e8-70ca-9db3-1774-9170cc69dae7@aaazen.com>
Message-ID: <403d62bf-e375-4bf5-a5be-f1792a52010@absolutedigital.net>
References: <20260312112454.940017-1-sashal@kernel.org> <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net> <abNdx_cQR_BqMm3z@laps> <358262e8-70ca-9db3-1774-9170cc69dae7@aaazen.com>
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
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux-foundation.org,suse.cz,linuxfoundation.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-225399-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[absolutedigital.net];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cp@absolutedigital.net,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,huawei.com:email,absolutedigital.net:mid]
X-Rspamd-Queue-Id: 1A36028A807
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026, Richard Narron wrote:

> On Thu, 12 Mar 2026, Sasha Levin wrote:
> 
> > Could you please confirm that cherry-picking 93d0fcdddc9e ("cxl/acpi: Fix
> > CXL_ACPI and CXL_PMEM Kconfig tristate mismatch") fixes the issue you're
> > seeing?
> >
> Hello Sasha,
> 
>    Patrick Volkerding found a patch that worked for me:
> 
> https://lore.kernel.org/lkml/20260302200429.803417-1-gourry@gourry.net/
> 
>    In drivers/cxl/acpi.c
>     static int cxl_acpi_probe(struct platform_device *pdev)
>     it changes IS_ENABLED(CONFIG_CXL_PMEM)
>             to IS_REACHABLE(CONFIG_CXL_PMEM)
> 

Hi Richard, Pat,

Below is the commit that Sasha pointed me to that fixes the issue for me 
if you'd like to have a look.

-- 
Cal Peake

From 93d0fcdddc9e7be9d4f42acbe57bc90dbb0fe75d Mon Sep 17 00:00:00 2001
From: Keith Busch <kbusch@kernel.org>
Date: Thu, 5 Mar 2026 12:40:56 -0800
Subject: cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch

Commit e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to
cxl_pmem.ko") moves devm_cxl_add_nvdimm_bridge() into the cxl_pmem file,
which has independent config compile options for built-in or module. The
call from cxl_acpi_probe() is guarded by IS_ENABLED(CONFIG_CXL_PMEM),
which evaluates to true for both =y and =m.

When CONFIG_CXL_PMEM=m, a built-in cxl_acpi attempts to reference a
symbol exported by a module, which fails to link. CXL_PMEM cannot simply
be promoted to =y in this configuration because it depends on LIBNVDIMM,
which may itself be =m.

Add a Kconfig dependency to prevent CXL_ACPI from being built-in when
CXL_PMEM is a module. This contrains CXL_ACPI to =m when CXL_PMEM=m,
while still allowing CXL_ACPI to be freely configured when CXL_PMEM is
either built-in or disabled.

[ dj: Fix up commit reference formatting. ]

Fixes: e7e222ad73d9 ("cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko")
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://patch.msgid.link/20260305204057.1516948-1-kbusch@meta.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 4589bf11d3fe00..80aeb0d556bd76 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -59,6 +59,7 @@ config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
 	depends on ACPI_NUMA
+	depends on CXL_PMEM || !CXL_PMEM
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT
-- 
cgit 1.2.3-korg


