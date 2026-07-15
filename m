Return-Path: <stable+bounces-274744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CRmAI8wpV2rgGQEAu9opvQ
	(envelope-from <stable+bounces-274744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:33:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABA475B16F
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:33:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=h7SotpCX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274744-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274744-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4C477300A30B
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C33265CA8;
	Wed, 15 Jul 2026 06:33:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A32931F2;
	Wed, 15 Jul 2026 06:33:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097225; cv=none; b=pvJkDBtsAz98ekIXGZ+MsOJ+T9/WpHKHPl2l9T/0ai8RpkJiyWEG3Z47QEcb6Nfcj4EkpYcK8kYQCR8sOZmjCYlOczVQRasjCOxe5xvx4Y7cKys4ac/Joar8TSBhQekcet8HeJT2ipdyA1v3IRX0qjr82zeRvXHmpZHxkQCFYOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097225; c=relaxed/simple;
	bh=f0Iq/AILXA6H2H/vCrM3FJlZo9QmgFtxt6nMJEUz7kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRY2d8Q6zvz1wCR0WcJyoNOgJiKCFfcLp1g4yvFM5kdHzGf6j69epFwe3uiJ4rjlDsw73XkzRykReMGtKoTMmCClWgYS0yafxMr2qSOmtV4wgqVG9uIWF/6cPwFPKdNTL+27h1oIlDxovOCXD7yjUktk3TfCspHctxkweKWim7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h7SotpCX; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784097223; x=1815633223;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f0Iq/AILXA6H2H/vCrM3FJlZo9QmgFtxt6nMJEUz7kY=;
  b=h7SotpCXHNRt4xZl62Jt6nVDXtYZQTApjuMyzz3KWqHeRGp9C72h2LDc
   4v0+00v78z5f9BZy7FiwAP4oTgHVx1He6SHVrmD0wpies0+dG8BHlnx13
   EXCASy+LGsZNAWJl2brFPBFPeNeEHq8nTu9wDXlb36XHbYsftSmc2M1O/
   w5cByx+OPLs5/rxcTBA4Y2Z1ZoXzd1gQg40SslZI8RaMLapfjHeABmMST
   pgxsgEGOdqZt9fJYAfwcZADFDE1m0DahmdTIdnHRTEzpIG+nrZGnXRY61
   MNvZ2UELZYFUrcgGWeMF5NZcZU2t8MnHyPVoRr4QjU8ybh7B4yUSibToi
   A==;
X-CSE-ConnectionGUID: N7MhtMYlRQG/2E73tlBwKg==
X-CSE-MsgGUID: K2honHDtQxmkV0UL3SrGqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96091308"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96091308"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:33:43 -0700
X-CSE-ConnectionGUID: 9oqahBNtTeeqjGo2r0ceXQ==
X-CSE-MsgGUID: 5cBjdVtmQZOlv2MoS4MSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="256120908"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:33:34 -0700
Date: Wed, 15 Jul 2026 08:33:31 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Message-ID: <alcpuxJktaVwrIaa@black.igk.intel.com>
References: <20260713155601.711389-1-heikki.krogerus@linux.intel.com>
 <20260713155601.711389-4-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713155601.711389-4-heikki.krogerus@linux.intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274744-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:heikki.krogerus@linux.intel.com,m:matthew.brost@intel.com,m:thomas.hellstrom@linux.intel.com,m:rodrigo.vivi@intel.com,m:mika.westerberg@linux.intel.com,m:andriy.shevchenko@linux.intel.com,m:andi.shyti@kernel.org,m:ramesh.babu.b@intel.com,m:michael.j.ruhl@intel.com,m:linux-kernel@vger.kernel.org,m:intel-xe@lists.freedesktop.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:from_mime,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2ABA475B16F

On Mon, Jul 13, 2026 at 05:56:01PM +0200, Heikki Krogerus wrote:
> Some platforms make an assumption that the i2c controller's
> enabled state indicates also the power state of the
> controller. This can create a problem when the controller is
> in disabled state, because the hardware may assume
> incorrectly that it is then also in low-power state.
> 
> To fix this, the controller is kept enabled by taking over
> the IC_ENABLE register. The controller has to be disabled
> when the configuration is updated and when the target
> address or the slave address are assigned, so disabling it
> when IC_CON, IC_TAR or IC_SAR registers are programmed, and
> then re-enabling it again.

...

> +/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
> +static void xe_i2c_disable(struct xe_i2c *i2c)
> +{
> +	int timeout = 100;
> +	u32 status;
> +
> +	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 1, 0);

Can we use DW_IC_ENABLE_* defines?

> +	do {
> +		status = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
> +		if (!(status & 1))

Ditto for DW_IC_STATUS_*.

> +			return;
> +		/* Can't sleep here. */
> +		udelay(25);
> +	} while (timeout--);
> +
> +	dev_warn(&i2c->adapter->dev, "timeout in disabling adapter\n");
> +}

...

> @@ -230,7 +260,28 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
>  {
>  	struct xe_i2c *i2c = context;
>  
> -	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
> +	switch (reg) {
> +	case DW_IC_CON:
> +	case DW_IC_TAR:
> +	case DW_IC_SAR:
> +		/* Disable the controller. */
> +		xe_i2c_disable(i2c);
> +
> +		/* Write the register. */
> +		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
> +
> +		/* Enable the controller. */
> +		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, 1);

Ditto.

Raag

> +		break;
> +	case DW_IC_ENABLE:
> +		i2c->ic_enable = val;
> +		/* Other fields can be updated except the enable bit. */
> +		val |= DW_IC_ENABLE_ENABLE;
> +		fallthrough;
> +	default:
> +		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
> +		break;
> +	}
>  
>  	return 0;
>  }

