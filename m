Return-Path: <stable+bounces-245574-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL4dJDcrA2oR1QEAu9opvQ
	(envelope-from <stable+bounces-245574-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:29:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073A5212BA
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDC0430471CE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6503911D0;
	Tue, 12 May 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqGiBWlv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23A3905EE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591837; cv=none; b=Xr92oyJmCtWJw7mmkbje/Tx3fVQ8E2RqmjwXY+Yg2W61Bd1KAS0+3GMI3j0xf9RBNN2K9GwXkTgL0mHWHJgUfi+M+u1Dy8vcQcw1FyghKMH/ZUPi+HrJ93fYtv3xoDnELpdjpy/4R+4M87ntcOE5HHx1gkD3gNOuvLBsmryQCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591837; c=relaxed/simple;
	bh=wwNRLIF1JFp5xt9HeapzPaIKxk407Y01fVL/BIECwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V0zUuXNGNlcwdGHvojP+ssoI2DKKmd2i+CDkzsCPmTAcw7gaVJfTkbmnUMrCz6IAv8h5qKz8tjIMUVvhx9VDpfDO5+54G3rVLVw5YrErIbTn1pc8ioc47zIOkgWAesHqJQ/xz5EZLtLSJARELjvceeythSqxJ6sbTSElaGYmevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqGiBWlv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488b150559bso43073155e9.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591833; x=1779196633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSTTjErtCCV7PDluuTX4InQQCaNvPmqczetdbYZrylo=;
        b=KqGiBWlvJ97L0+fCiJN2zFlQUEtHbxwmSSaIiI9BZw0QSZZdWxwf6xfhEoGYFtFqvJ
         MluAmPRVS4y1+rbAk9nlVmf5byTvQHLYsr1+cTlywgRFgfyUQV5Ak4z4ylIQElAkAfbA
         iZkJHoMVX5RgJXfXDI990SZo1g1Lzz5zjCIbV+CDrisEegNQCHuqveQq58KwzrJLWAig
         1ouhNbypuJKjFscYnw0iMAWbAWZ4KIdYBYaBIdJvwDd1L+1bIrF3e+Bt++4QZ5mr6B95
         iBlU0oSzui1Xc2rFJ0J4fCIuYE4mu9+lVbgpbtiJHKCHC2hZv/v54uuiMff9t2lnc27n
         1nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591833; x=1779196633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSTTjErtCCV7PDluuTX4InQQCaNvPmqczetdbYZrylo=;
        b=PonuYP1L9+/uSk+NVHKTtXDsRVhTAxqexip7smhnpRRc7rjjGKDPLpJZ8cCkBZqbwQ
         j7BD9k21xJrvT2Sj5QVhJTjnK8BeMJ405JN1M8hkZ9hDWAKzfHKADJBDovbVJ/3qVRQU
         8yNjOWfeQWmddLQ1TwnRlgy+dqXHyVAXIyuTP3YFdrs+pB+SnecRZqBIlfSS8mLEFzGI
         nwAZRD82rCNFR6woyzomqJkl3XPMG3iGkY4d0VZoAqVGwUclgcVQf9G6muUuyJ6wM45P
         tR+w3KARMk8pfAAKx4DR65MY1ex5snlQkWa8O7F4trOa7qgchzTuyLlFX9cX60p2BSNI
         iLjw==
X-Forwarded-Encrypted: i=1; AFNElJ+YlP5mau0+mKklu0n0JbpVPDZEO/DYh85MCbEsiWacWXX1uhfkZzTddAnyA6sUMRfDD+s5gsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QOeF156O/NLYJQ6ZLWQ8XL0G+HIAU5FDBMY60hnCkiPEaN8n
	lCD9bXL7gQ7FiSZjNDtTxhiw5Xhng4tpattPbj0aYEebMftRB/NJ8wbf
X-Gm-Gg: Acq92OEvGclQNIjLndAVu6n4oKOD4K/7U6GACs2Wy/npUGemAg4+Y7tN/R5k0sj1TGd
	j9Tx4CwNw+LPNdsryxDZsgju0ax7eBjEC9m/PPtwZkc7WOP9V6Mr/3VGZjK26wybzSfb6xoMa/V
	N5S6n3Fna0TnP3+BibUrPnHCpI5+6eNISOKmsuIpsVvrwk/yWSAAjW0QepMM9VXUcm2YUdFcBe1
	nWko/5HPs0OngK8mPhZgsg+HhaCm1EfBbAxHS5vnPq5L9fImmJNuLte7YFMvcvXNsCuNAAvgeJK
	bbhiyHumDoJvhCNIxVYLMLuuxyXVh5qJSkKBMXdSrhgh1/O6QKhqFtPYJctzXpLDQ/WUsUDXYZg
	N/IKsYHcfmnVcsHEItchmVB+Q8cuRfpLQe2BFEa5mEI/BGZHH2XTi4hlU8Pq/8UVSeZxIUXpvAP
	T2hcbMAWetA/rGdClKuvKbuPx9SdqJyFLbnrsURKydeRCeLXiwGpE8GvBxKvRV
X-Received: by 2002:a05:600c:6299:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e706f11d0mr232288505e9.17.1778591832718;
        Tue, 12 May 2026 06:17:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f42a845sm17282245e9.20.2026.05.12.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:17:12 -0700 (PDT)
Date: Tue, 12 May 2026 14:17:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>, Jason
 Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, linux-kernel
 <linux-kernel@vger.kernel.org>, Yishai Hadas <yishaih@nvidia.com>,
 rananta@google.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct
 layout
Message-ID: <20260512141711.70c49471@pumpkin>
In-Reply-To: <20260511221609.3837652-2-alex.williamson@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
	<20260511221609.3837652-2-alex.williamson@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5073A5212BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245574-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 16:16:02 -0600
Alex Williamson <alex.williamson@nvidia.com> wrote:

> Bitfield operations are not atomic, they use a read-modify-write
> pattern, therefore we should be careful not to pack bitfields that
> can be concurrently updated into the same storage unit.
> 
> The split fields (virq_disabled, bardirty, pm_intx_masked,
> pm_runtime_engaged, sriov_pwr_active) are mutated post-init from
> contexts that don't serialize against the other writers in the same
> storage unit, so a bitfield RMW could drop an adjacent field's
> update.  The remaining bitfields are touched only during probe or
> close where no concurrent writer exists, so they stay packed.
> 
> While reordering, place virq_disabled and bardirty earlier to fill
> an existing alignment hole.
> 
> Fixes: 9cd0f6d5cbb6 ("vfio/pci: Use bitfield for struct vfio_pci_core_device flags")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---
>  include/linux/vfio_pci_core.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 2ebba746c18f..24e8db5b1c0d 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -101,6 +101,8 @@ struct vfio_pci_core_device {
>  	const struct vfio_pci_device_ops *pci_ops;
>  	void __iomem		*barmap[PCI_STD_NUM_BARS];
>  	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
> +	bool			virq_disabled;
> +	bool			bardirty;

I'd put those two after the :1 fields to avoid an extra hole.

-- David

>  	u8			*pci_config_map;
>  	u8			*vconfig;
>  	struct perm_bits	*msi_perm;
> @@ -117,16 +119,14 @@ struct vfio_pci_core_device {
>  	u32			rbar[7];
>  	bool			has_dyn_msix:1;
>  	bool			pci_2_3:1;
> -	bool			virq_disabled:1;
>  	bool			reset_works:1;
>  	bool			extended_caps:1;
> -	bool			bardirty:1;
>  	bool			has_vga:1;
>  	bool			needs_reset:1;
>  	bool			nointx:1;
>  	bool			needs_pm_restore:1;
> -	bool			pm_intx_masked:1;
> -	bool			pm_runtime_engaged:1;
> +	bool			pm_intx_masked;
> +	bool			pm_runtime_engaged;
>  	struct pci_saved_state	*pci_saved_state;
>  	struct pci_saved_state	*pm_save;
>  	int			ioeventfds_nr;


