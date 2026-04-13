Return-Path: <stable+bounces-237651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIUPG3lT3WkFcQkAu9opvQ
	(envelope-from <stable+bounces-237651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:35:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23AA3F3209
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DF5A3023503
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2509C347BA5;
	Mon, 13 Apr 2026 20:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlRkrghO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B011DFF7
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776112419; cv=none; b=KZL5NFVNZof2Na4y4nbiuQBEorx3U+PoInJz+YOVPNeAOaOA/TLNXQAhe/674/0QGval9SRkColgsWCEmqwhMxCBMbbsCb8LtgHggxKzTBjQ8nSb8iQJjknS7Fq0shRPJXXeTWcuQqMzXDVri2hiWIb1o8EJsO0Mo5P9eqABbeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776112419; c=relaxed/simple;
	bh=wCqaI7WVpGD8I/LJUMoulVK455m9fusXv6dkUgKAC9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ee4GHX7IOJnA8p3upi/KEVoXiLJBNf1nE6prF/wOBUen4iH5TcWHozOOzZ46Vwe67BN3rfBWCBNn1MgEnWbOAg/FndJm+Y2erN5+MT6J9trBoWMUaxoe1l6lc2LfIP6esXAzHtABuKMWiKlEYch8cBGfNqa0wIc8UZt8Pb5vnag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlRkrghO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43d43e09de5so2853756f8f.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776112417; x=1776717217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPkPEzfI7VUAH2K97iljvYM+ya7M355aVFHm/wT39nw=;
        b=DlRkrghO8S9EA5bIcigTBdgRXUPpW0eGzEROQZ8ZeSLBbazSMwVzLxjm77mE8zNQCs
         Jr/TKc3uQhgqcFR6AeF7IUlzPm1tRINyJe34do4WxDVqvfidvTScpL2m+BNpOdokfwPk
         AmvpoXKtgwPFyG5AMcAVVj/1XV84rjbhjPXdErYKMdkDFc27WKIEwckKvhgQFq77Y37C
         +zgQZprMLWcxlUhPG3YErmvGMGLvEaMonNGm681Aad6X5wLsZyK0QREdka/aZa4hgoRF
         /mNicJvhqjnk3bFKYYRVvjL+Jwl0V2/WUVzcr++Cd7fiT7844I2nMF7rymoGNVqYcTE1
         dbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776112417; x=1776717217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPkPEzfI7VUAH2K97iljvYM+ya7M355aVFHm/wT39nw=;
        b=hvap6JleXL0IUsMRKt/si7de2n+eCT0TyACJkMyyKcA4G2k73HawaM6+CcomXdk7UN
         mGKUVVPyAHQpGIDpRYFDgsLHiYc6x8FIbvi6TiK8p6cdAAEe1S8ZHtLrmAu3DViema3i
         NNMJyiuqDIwcjkw3daCX/RkRZNYXX+drnwulbMRYnYt0b3Wom7ClbeHIKXsYBw0N7dg+
         q6pgPMdJUfJDCeMOz0+ezvMphd8or+zdkAMkMptRNpvpYP+bi0uZdur1r6DNm4YtEnyp
         cdIf+IoN/CB4H2JK1MsUZQo3Dfzug0sJB9iYtPtosugaKLK06ngpIf19PQ2lkeRyrj4q
         09TA==
X-Forwarded-Encrypted: i=1; AFNElJ/6XWn9y3sNi0b5X+G7wFBdoYsdLcJ78Wg8+zBkdDbo7a1inGxnECINNYWRJcCDJ6ycZuuwO/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM+cd2IqzuK6aXClwM8rUzdjv+tNWkKDoXqTLxAXV8IPVIpnrF
	oHWdUBeak86hPRB8MG3J87yXY8506dkQqPddJgwcvJ/sAAfU73acXCrq
X-Gm-Gg: AeBDieuxynAc2PkDOtwF8p+D7cYgl/hNL+GBmomtNosSooNmBUyjNJMh/DUfXlYkY4R
	JjzQY2ESybED5yJXB+FrTZvAvUw73F6F9uxtx07y+4bGgRahNxZDELshcre6R9bfg1oqu78Rdqi
	YQxMR/ZFU9aAE8eL4lJBLij20XWmvJaCU+N9q421dtjr4846YmZgFCLJNvfWhVDhOnoYXu/9cPj
	Uh09Xzwrvyn32govama7+uea1OB1tZkJhhFOCEKfLkIJXLk4OuEfeLqkM7hdCZydE+Mq+ANZMUa
	tA1teWHCS3wntgd2bXzS1mHZ+HflS1VZ5RKF1C6exLhDgCmofjEly8t1qD4WMGwzkQQ4wc/xNNY
	zzMQGmQp5bFjtGbaIIzB0Fy9YiobyJSt7pYHhLcNPcBCrZZwjT1s426wMsAvMUOIz2DAGMb4v2A
	K4jsNH8sYh+tfmYFk2Av9uhANGCShJqabMEP6QaHYVx+oW5yUaWRWyWJ0FyvgMEWK3
X-Received: by 2002:a5d:5d83:0:b0:43d:30af:a173 with SMTP id ffacd0b85a97d-43d64259b7emr21409425f8f.5.1776112416875;
        Mon, 13 Apr 2026 13:33:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5062fsm34336337f8f.31.2026.04.13.13.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 13:33:36 -0700 (PDT)
Date: Mon, 13 Apr 2026 21:33:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ranjan Kumar <ranjan.kumar@broadcom.com>
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 sathya.prakash@broadcom.com, chandrakanth.patil@broadcom.com,
 dlemoal@kernel.org, stable@vger.kernel.org, Mira Limbeck
 <m.limbeck@proxmox.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3] mpt3sas: Limit NVMe request size to 2 MiB
Message-ID: <20260413213335.4010d8f2@pumpkin>
In-Reply-To: <20260413180003.76489-1-ranjan.kumar@broadcom.com>
References: <20260413180003.76489-1-ranjan.kumar@broadcom.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237651-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,proxmox.com:email]
X-Rspamd-Queue-Id: C23AA3F3209
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 23:30:03 +0530
Ranjan Kumar <ranjan.kumar@broadcom.com> wrote:

> The HBA firmware reports NVMe MDTS values based on the underlying drive
> capability. However, due to the 4K PRP page size and a limit of
> 512 entries, the driver supports a maximum I/O transfer size of 2 MiB.
> 
> Limit max_hw_sectors to the smaller of the reported MDTS and the
> 2 MiB driver limit to prevent issuing oversized I/O that may lead
> to a kernel oops.
> 
> Cc: stable@vger.kernel.org
> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
> Closes: https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9b8b84879d4a
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> index 6ff788557294..44dd439e6f17 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> @@ -2738,8 +2738,20 @@ scsih_sdev_configure(struct scsi_device *sdev, struct queue_limits *lim)
>  				pcie_device->enclosure_level,
>  				pcie_device->connector_name);
>  
> +		/*
> +		 * The HBA firmware passes the NVMe drive's MDTS
> +		 * (Maximum Data Transfer Size) up to the driver. However,
> +		 * the driver hardcodes a 4K page size for the PRP list,
                                             ^ buffer ? 
> +		 * accommodating at most 512 entries. This strictly limits
> +		 * the maximum supported NVMe I/O transfer to 2 MiB.

Doesn't that make max_fw_entries 4096/8.
Assuming 4096 byte sectors the longest transfer is then 4096/8*4096.
So none of this has anything to to with SECTOR_SHIFT.

> +		 *
> +		 * Cap max_hw_sectors to the smaller of the drive's reported
> +		 * MDTS or the 2 MiB driver limit to prevent kernel oopses.
> +		 */
> +		lim->max_hw_sectors = SZ_2M >> SECTOR_SHIFT;
>  		if (pcie_device->nvme_mdts)
> -			lim->max_hw_sectors = pcie_device->nvme_mdts / 512;
> +			lim->max_hw_sectors = min_t(u32, lim->max_hw_sectors,
> +					pcie_device->nvme_mdts >> SECTOR_SHIFT);

Why min_t() ?

David

>  
>  		pcie_device_put(pcie_device);
>  		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);


