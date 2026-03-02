Return-Path: <stable+bounces-222616-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIvOJfehpWmuCAAAu9opvQ
	(envelope-from <stable+bounces-222616-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:43:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C24AF1DB134
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE9B1300B05B
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997883FFAD4;
	Mon,  2 Mar 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Nh6+hRf5"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485BA3FD14E;
	Mon,  2 Mar 2026 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772461926; cv=none; b=YfK3g2I2WNodG6xrkcshoHpcOQouYPQ3G4wT8QJPzr2qqp7G1+tDMvRIbGKhW7C7P6ElxtN3SqiqoZqUWTO/FMCkKdhVM7SR0Oqj/h/TPy7CTWYVtlcIgkXFiCfQFs/nWsYN/gJ1CwJK/05XtvDN8zhan8DKs1xMoPOLiShgZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772461926; c=relaxed/simple;
	bh=RU6ADDQCWw9AqJWY7O9Xmi+qzrISzyhMbDLzqU8hxZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FroR3UU0icxZ7bZJ6pdcIgzmAxCAGpvzXNr1x6061gAEK6ZqhXGCCWCCam3G1WC1ufmx65rOAMXC4hOkvb8wMSDPhyGLS2DXsE1FK+zrMHaH/pgsESQci2JSAnj1Vc5L7pVK3bKehlfvNYJYdEh6nZm3+KOKt4/7YAr5h4fvcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Nh6+hRf5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lFgga5pMyKixQV6g2/gV369lulPdGdBB62IXlFA+EKg=; b=Nh6+hRf5JuMU25fEP0FSWuWZ6e
	qrSY7jf4gWVYH3jRaxu5PqrFsjoew2JHoLHUtClBPbkr5B0LXnd8zbKM1ilCq/bdbVRgwVzrAuvAa
	8w/L4Tx8o/A12IdEnmReLOKjIYTY4Y58EQhUVrLY9fyvQcHQw+M1h0bd5/XzzyLeguYrp73Zq6d+D
	ZGlDaJ8W4AZclP5LugepV2ySRB+GMRPwp9w2ye9zoK+I1huQTaOTHNqLrI2YUIZGlPDg/bg6l5CTt
	ifZbk/9W7P4cQfr2n8upaPb26Ej5H8+oFXmT/b61NC7F9JJ1JptW5hjM5yh7Tq4uB9wMSD1WHKnGr
	NTQ+wnYw==;
Received: from 179-125-79-229-dinamico.pombonet.net.br ([179.125.79.229] helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vx4JR-007vb6-Ja; Mon, 02 Mar 2026 15:31:58 +0100
Date: Mon, 2 Mar 2026 11:31:52 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linux-fpga@vger.kernel.org
Subject: Re: FAILED: Patch "fpga: dfl: use subsys_initcall to allow built-in
 drivers to be added" failed to apply to 6.12-stable tree
Message-ID: <aaWfWF0rgwddPQ7f@quatroqueijos.cascardo.eti.br>
References: <20260301011822.1672726-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301011822.1672726-1-sashal@kernel.org>
X-Rspamd-Queue-Id: C24AF1DB134
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222616-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[cascardo@igalia.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.913];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quatroqueijos.cascardo.eti.br:mid]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 08:18:22PM -0500, Sasha Levin wrote:
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha

Hi, Sasha!

I grabbed queue-6.12/fpga-dfl-use-subsys_initcall-to-allow-built-in-drive.patch
from https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git,
and applied it on top of v6.12.74 with git-am and it does apply just fine.

Was this message triggered accidentally, given the patch is still on the queue?
Or how should I verify that it applies (or doesn't)?

Thanks.
Cascardo.

> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 267f53140c9d0bf270bbe0148082e9b8e5011273 Mon Sep 17 00:00:00 2001
> From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Date: Mon, 15 Dec 2025 16:05:50 -0300
> Subject: [PATCH] fpga: dfl: use subsys_initcall to allow built-in drivers to
>  be added
> 
> The dfl code adds a bus. If it is built-in and there is a built-in driver
> as well, the dfl module_init may be called after the driver module_init,
> leading to a failure to register the driver as the bus has not been added
> yet.
> 
> Use subsys_initcall, which guarantees it will be called before the drivers
> init code.
> 
> Without the fix, we see failures like this:
> 
> [    0.479475] Driver 'intel-m10-bmc' was unable to register with bus_type 'dfl' because the bus was not initialized.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9ba3a0aa09fe ("fpga: dfl: create a dfl bus type to support DFL devices")
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> Link: https://lore.kernel.org/r/20251215-dfl_subsys-v1-1-21807bad6b10@igalia.com
> Reviewed-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  drivers/fpga/dfl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 7022657243c0a..449c3a082e232 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -2018,7 +2018,7 @@ static void __exit dfl_fpga_exit(void)
>  	bus_unregister(&dfl_bus_type);
>  }
>  
> -module_init(dfl_fpga_init);
> +subsys_initcall(dfl_fpga_init);
>  module_exit(dfl_fpga_exit);
>  
>  MODULE_DESCRIPTION("FPGA Device Feature List (DFL) Support");
> -- 
> 2.51.0
> 
> 
> 
> 

