Return-Path: <stable+bounces-249388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JBFIDdnC2rmHAUAu9opvQ
	(envelope-from <stable+bounces-249388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:23:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E9572D6D
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714F5302EA80
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14568383C7C;
	Mon, 18 May 2026 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/Cm/JV4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F1381AFA;
	Mon, 18 May 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132199; cv=none; b=IXNYGfrgJDvtGreN3Gmccb0KZjcQHRxyk6/ZiwXM/8kKml2G1FumIB4C/WASL3+oPQJ8987tYi2vE7PIcsM7Teg5WkiaHWjeP04J8Awc2b26WpKnoG3nFBm9gg8hrgFyHfwvDwpcs+5vijotJ8pONNYxVQ4xXIv9ldNz4rDtlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132199; c=relaxed/simple;
	bh=YH4nu/12Er9fpJ5EGzk3UetLfoGZNCOH+QXK+VHEjAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1qCFusEK/4XlkYj18//N0MleQm2eBVgibExTBa7Umzlxtaj610OGuIcnzie6nfEUU2DfcPjD/ig73tYj3GutNpoQY8UzldfslbbFttAGjOX1UcYVORK4lEYJthoxf3ZzHX6pE3Jdn/xG3V1dajH2HzDINAluOudDImDS0ZEZMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/Cm/JV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A3CC2BCB7;
	Mon, 18 May 2026 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132199;
	bh=YH4nu/12Er9fpJ5EGzk3UetLfoGZNCOH+QXK+VHEjAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/Cm/JV4svOkZT2PAuIcH1Uf/NhGI3JV6zXPuOUXFXpkqtWktw6076FFWVntMxaeJ
	 zsLbjp3MidWODCbo0PAW+yun3KiOFTX3hOssgL14d5RTnziesPNbV78tYy4+uu2nbz
	 QI1mZOLz487wG3uwJ7iYKl41JQF0bE+a6iiVV7MS8KELABw+WatMEAe2eYgf96rRW4
	 iM8/xEwDtjcM+VA14HGvb74a58gnqvWUP00cuSUEwKpRnP87ocbq9DRuO9sfFJvkT2
	 AzJE06Q7ux0VZzlVGC4I3OdX6JvStUN1ch+KodDouQdj+XfKUfKAlmmdQoECMj/dyu
	 VRAG5dOoOIxuQ==
Date: Mon, 18 May 2026 13:23:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <agtnJb5a5uIqH-65@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-249388-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E93E9572D6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 02:52:56PM +0000, Achkinazi, Igor wrote:
> @@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>         ns = nvme_find_path(head);
>         if (likely(ns)) {
>                 bio_set_dev(bio, ns->disk->part0);
> +               /*
> +                * Mark the bio as remapped to the per-path namespace disk so
> +                * that bio_check_eod() is skipped on resubmission (e.g. from
> +                * bio splitting in blk_mq_submit_bio).  The EOD check already
> +                * passed on the multipath head disk.
> +                */
> +               bio_set_flag(bio, BIO_REMAPPED);

Any reason nvme multipath can't call submit_bio_noacct_nocheck()
directly instead? If it's safe to skip the eod check here, then it
looks safe to skip everything else too.

