Return-Path: <stable+bounces-216651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHYFOIuTkmmSuwEAu9opvQ
	(envelope-from <stable+bounces-216651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 04:48:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB4140C91
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 04:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B2283016270
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 03:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCE2273D6D;
	Mon, 16 Feb 2026 03:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL3XD3fb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C91C1A3154;
	Mon, 16 Feb 2026 03:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771213689; cv=none; b=piz2nQvg55aizTXnaFvi3DrNExzebbdC+gRhf0v0ybCgjsXZFbic9cPd6tLCy+oa8HyY4R3c9rml96kgOuEMrg1I2O3m/ieogDKt4uvUBB5GthSrqogWYFUW4lsZTEY8bct+to8XZ7Cu9121Pyax5bRNPBmHyQM/MHumxhGQlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771213689; c=relaxed/simple;
	bh=/NPRv+JQITdsPcw91sGKoR3MwuItH/IfrV7CAXxvdLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU7t/yvFoUc9KfTm1WTDwdjJkwPLJZdwRXnZO1gEJYPSRdZ+sHasKkti0lO0f2zGvK4YivaZ5OlA64V5kol2w/VMrY5/BWJJBmSoXgcHD+uiJtQnbBNLMhvALsH613TzXT9fMYQl+RNetnhx/6Jq0uDTAEyDEdQKu5/tiTNxrhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VL3XD3fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B08C116C6;
	Mon, 16 Feb 2026 03:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771213688;
	bh=/NPRv+JQITdsPcw91sGKoR3MwuItH/IfrV7CAXxvdLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VL3XD3fbyw22MhDDqOFJdA+5mYO6/roW15CItSAIEQLzhRtQfPbWE7ul+2/9BjBL7
	 Ww9lnvmAgWCjAv8G1Oar+k8JAyRBS5g+Wd20y3uPKWkBK4ZaYeEjpNNmh15TSg5vhy
	 p4YXKpHsFbMfPadGW3yY6kHZMG9J/nCdCsN10TBeMaGSAvc2G8CsH5pfJCO68XJSJk
	 Iu7fP+5f0SUWSj28PrWyoR+IPnb+4WEjMa9R74QByK64ZoTxsMjytkuDeOIq9xGNql
	 WB/aO3tT4pddNr7qYP9svlNInez/SxOOfFlANHtOsei1dzdJKntdyVsZyH2OtbrKEy
	 Yyr/hx/6vlEwA==
Date: Sun, 15 Feb 2026 19:48:08 -0800
From: Kees Cook <kees@kernel.org>
To: Finn Thain <fthain@linux-m68k.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Miguel Ojeda <ojeda@kernel.org>, stable@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Avoid boot crash in RedBoot partition table parser
Message-ID: <202602151911.AD092DFFCD@keescook>
References: <92af570970aadee773f2b0b18179efef0f34be93.1771114891.git.fthain@linux-m68k.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92af570970aadee773f2b0b18179efef0f34be93.1771114891.git.fthain@linux-m68k.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216651-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77BB4140C91
X-Rspamd-Action: no action

On Sun, Feb 15, 2026 at 11:21:31AM +1100, Finn Thain wrote:
>     memcmp: detected buffer overflow: 15 byte read of buffer size 14
> [...]
> -		    !memcmp(names, "RedBoot config", 15) ||

The warning is saying that "names" is detected to be 14 bytes in size. It
is allocated here, and nulllen can be ignored (it is fixed size, either 0
or sizeof(nullstring), and skipped over):

        parts = kzalloc(sizeof(*parts) * nrparts + nulllen + namelen, GFP_KERNEL);
	...
        nullname = (char *)&parts[nrparts];
	...
        names = nullname + nulllen;

so "names" is pointing to the final "namelen" many bytes of the
allocation. Calculating "namelen" happens via an earlier for loop:

        buf = vmalloc(master->erasesize);
	...
        ret = mtd_read(master, offset, master->erasesize, &retlen,
                       (void *)buf);
	...
        numslots = (master->erasesize / sizeof(struct fis_image_desc));
	...
        for (i = 0; i < numslots; i++) {
		...
                namelen += strlen(buf[i].name) + 1;

So namelen could be basically any length at all. This fortify warning
looks legit to me -- this code used to be reading beyond the end of
the allocation.

Your patch looks technically correct, but why not just use strcmp? Both
arguments are NUL-terminated. The memcmp() calls were all including the
NUL byte, so they're effectively doing strcmp except that they weren't
stopping at the first NUL byte. So probably just better to do:

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3b55b676ca6b..c06ba7a2a34b 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -270,9 +270,9 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 		strcpy(names, fl->img->name);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
-		if (!memcmp(names, "RedBoot", 8) ||
-		    !memcmp(names, "RedBoot config", 15) ||
-		    !memcmp(names, "FIS directory", 14)) {
+		if (!strcmp(names, "RedBoot") ||
+		    !strcmp(names, "RedBoot config") ||
+		    !strcmp(names, "FIS directory")) {
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif


-- 
Kees Cook

