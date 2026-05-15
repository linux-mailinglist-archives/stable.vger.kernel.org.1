Return-Path: <stable+bounces-247806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOHABmg1B2rftQIAu9opvQ
	(envelope-from <stable+bounces-247806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:02:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAEF551D1D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96AB730071E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD203B7751;
	Fri, 15 May 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2SEGkpU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E33932D1
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857255; cv=none; b=YZZLsB4ThkDCvrQYemBTJE+z0O2ZQWtqAv0fQbWp7dI3sHdOD7G3nIC/rTO39pTOzOch4efL9PqCBU3B25LV69SFoCRSNUA4ChGca0ZLShh4jJkcdy7KrjO7OVYfCvge9fqJL3687YzsQvBLBE8gigJ3QgfIdM5GsNUuL8fC+r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857255; c=relaxed/simple;
	bh=8nxNrU1gNTSmIMPvlDCTy3ug7wlIEoDHuFVBbkkM/VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmrYCkMXP9wiJWcxtL0SZ8v3HxVWejRQKOYnkoPalCeGh3PGW22wUyFYrw0NaeCcDwwRbQj6PVxxDn3PiYuK14LwnYOwbwBnZJkIZWneGLnxigy2n8QCmOC83DcQkhC4crI8GdKPlwVk0jODReohugt1OdDZM5Dnzz6CBJytRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2SEGkpU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEAFC2BCB0;
	Fri, 15 May 2026 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778857254;
	bh=8nxNrU1gNTSmIMPvlDCTy3ug7wlIEoDHuFVBbkkM/VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=v2SEGkpUdAoSiCX9FpYTE/xAOBYj6gBv9KPaQkIj71c5UyUQV5hoL3jfN/vFQ+mD3
	 RKBaQEIByw/qQ7TPgY9L0GdSvKQ5lQf7FeWSl8y5F2yAVrU2a/wQbsbc7CZDh06d0a
	 XVXFb6v258hrondpgQC5DjDHbWzJydMQa9My3Nco=
Date: Fri, 15 May 2026 17:00:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hendrik Donner <hd@os-cillation.de>
Cc: sanjaikumar.vs@dicortech.com, pratyush@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mtd: spi-nor: sst: Fix write enable
 before AAI sequence" failed to apply to 6.6-stable tree
Message-ID: <2026051542-gnat-legislate-e5ad@gregkh>
References: <2026050405-manly-surplus-9d27@gregkh>
 <de0ac6cc-453c-46a6-8c6c-9be33720e516@os-cillation.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0ac6cc-453c-46a6-8c6c-9be33720e516@os-cillation.de>
X-Rspamd-Queue-Id: EEAEF551D1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247806-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_URIBL_FAIL(0.00)[os-cillation.de:query timed out,gregkh:query timed out,dicortech.com:query timed out];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[sanjaikumar.vs.dicortech.com:query timed out,hd.os-cillation.de:query timed out,2026050405-manly-surplus-9d27.gregkh:query timed out,pratyush.kernel.org:query timed out];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,os-cillation.de:email,dicortech.com:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 07:31:43PM +0200, Hendrik Donner wrote:
> Hello,
> 
> On 5/4/26 10:38, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x a0f64241d3566a49c0a9b33ba7ae458ae22003a9
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050405-manly-surplus-9d27@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> >  From a0f64241d3566a49c0a9b33ba7ae458ae22003a9 Mon Sep 17 00:00:00 2001
> > From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> > Date: Wed, 11 Mar 2026 10:30:56 +0000
> > Subject: [PATCH] mtd: spi-nor: sst: Fix write enable before AAI sequence
> > 
> > When writing to SST flash starting at an odd address, a single byte is
> > first programmed using the byte program (BP) command. After this
> > operation completes, the flash hardware automatically clears the Write
> > Enable Latch (WEL) bit.
> > 
> > If an AAI (Auto Address Increment) word program sequence follows, it
> > requires WEL to be set. Without re-enabling writes, the AAI sequence
> > fails.
> > 
> > Add spi_nor_write_enable() after the odd-address byte program when more
> > data needs to be written. Use a local boolean for clarity.
> > 
> > Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
> > Tested-by: Hendrik Donner <hd@os-cillation.de>
> > Reviewed-by: Hendrik Donner <hd@os-cillation.de>
> > Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> > 
> > diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
> > index 175211fe6a5e..db02c14ba16f 100644
> > --- a/drivers/mtd/spi-nor/sst.c
> > +++ b/drivers/mtd/spi-nor/sst.c
> > @@ -203,6 +203,8 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
> >   	/* Start write from odd address. */
> >   	if (to % 2) {
> > +		bool needs_write_enable = (len > 1);
> > +
> >   		/* write one byte. */
> >   		ret = sst_nor_write_data(nor, to, 1, buf);
> >   		if (ret < 0)
> > @@ -210,6 +212,17 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
> >   		to++;
> >   		actual++;
> > +
> > +		/*
> > +		 * Byte program clears the write enable latch. If more
> > +		 * data needs to be written using the AAI sequence,
> > +		 * re-enable writes.
> > +		 */
> > +		if (needs_write_enable) {
> > +			ret = spi_nor_write_enable(nor);
> > +			if (ret)
> > +				goto out;
> > +		}
> >   	}
> >   	/* Write out most of the data here. */
> > 
> 
> it doesn't apply because of changes made in
> 18bcb4aa54eab75dce41e5c176a1c2bff94f0f79.
> 
> That commit was never backported and is not in any stable tree older
> than 6.12.y. So it needs to be applied first to 5.10.y, 5.15.y, 6.1.y
> and 6.6.y. It's a refactor commit that should not change behaviour at all.

The refactor commit worked for 6.1.y and 6.6.y, but not the others.

thanks,

greg k-h

