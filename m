Return-Path: <stable+bounces-212706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFnPIYGTemmC8AEAu9opvQ
	(envelope-from <stable+bounces-212706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:53:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E190FA9C4D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9484830210DF
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE133E37A;
	Wed, 28 Jan 2026 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz04z1O7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C024CEEA;
	Wed, 28 Jan 2026 22:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640826; cv=none; b=KVmIRDkBso5gnG9TXLN4aAdA0dYLosf6eqoM+OFMMQQ6wTJb1Eugfg5zI4/a2603HTTSGSVbAnizwCV30BorZZ1GXhDHs/QGP5sUUd0V1apmWscmdvpA9Wer5LSsC2bO9Fygzm344gPaoIFXs6x/jzGUx2QsyYCSs7qF7rJRBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640826; c=relaxed/simple;
	bh=KcsvWA0YiI+8GYIBTcfSP9bLGpCrdo8NUA4mcpugtuM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J+jbluQE6u4FdJFwHs2OdX+nocoPRxpxoDKAPjblKK06aDkcXShIhUCt6DYV/jMoyoKfJ8chiihuvIgSeLphzl6YZTtwRczbQXyWa5AAaitVRAYn0Yb6vnem5740zgrGtKX0iPqRO7w+dgreXJFDY6R2amnCAzu3N/uv+/uApZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz04z1O7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E2EC4CEF1;
	Wed, 28 Jan 2026 22:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769640825;
	bh=KcsvWA0YiI+8GYIBTcfSP9bLGpCrdo8NUA4mcpugtuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Wz04z1O705LToKOfkqlIOCeC4jYfaW5k+vP3IhGTyLup6TDx5IT2qLo+OX/o2Wvub
	 VqLDBFSfYYDnqiEteJ02OzZembEuN9ag0fIbNlDNp6R/W7pt4S41ZgO1GfP3KvEDrz
	 IVycB5ltTyixrViDgXcU/W8HzB3z+I6ef3/mHpoAr+QVA6VFNDJfPHKuO8075DfJD6
	 ewOcPF+pzX0AEhFF0CsgoJ5khBU6iRozI0ssWnKessjAyjIsjbPIomc3JD5RqkiQBU
	 IZ9RRzOCDSDfwIPJl6HAabTfazpAX/xbf8wE2ZfapktMry56sTufYc9mWcNCI+Z9oH
	 a+SzT+aTn17ww==
Date: Wed, 28 Jan 2026 16:53:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: bhelgaas@google.com, dan.j.williams@intel.com, dave.jiang@intel.com,
	ilpo.jarvinen@linux.intel.com, kbusch@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org, Keith Busch <kbusch@meta.com>,
	Alex Williamson <alex@shazbot.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [RESEND PATCH v2] PCI: Fix incorrect unlocking in
 pci_slot_trylock()
Message-ID: <20260128225344.GA422463@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251212145528.2555-1-guojinhui.liam@bytedance.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212706-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E190FA9C4D
X-Rspamd-Action: no action

[+cc Keith, Alex, Lukas]

On Fri, Dec 12, 2025 at 10:55:28PM +0800, Jinhui Guo wrote:
> Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
> pci_slot_trylock(), but it forgets to remove the corresponding
> pci_dev_unlock() when pci_bus_trylock() fails.
> 
> Before the commit, the code did:
> 
>   if (!pci_dev_trylock(dev)) /* <- lock bridge device */
>     goto unlock;
>   if (dev->subordinate) {
>     if (!pci_bus_trylock(dev->subordinate)) {
>       pci_dev_unlock(dev);   /* <- unlock bridge device */
>       goto unlock;
>     }
>   }
> 
> After the commit the bridge-device lock is no longer taken, but the
> pci_dev_unlock(dev) on the failure path was left in place, leading to
> the bug.
> 
> This yields one of two errors:
> 1. A warning that the lock is being unlocked when no one holds it.
> 2. An incorrect unlock of a lock that belongs to another thread.
> 
> Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
> path.
> 
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>

Applied to pci/virtualization for v6.20, thanks!

> ---
> 
> Hi, all
> 
> Resent v2 to drop the Acked-by tag; no code changes. Sorry for the noise again.
> 
> v1: https://lore.kernel.org/all/20251211123635.2215-1-guojinhui.liam@bytedance.com/
> 
> Changelog in v1 -> v2
>  - The v1 commit message was too brief, so I’ve sent v2 with more detail.
>  - Remove the braces from the if (!pci_bus_trylock(dev->subordinate)) statement.
> 
> Best Regards,
> Jinhui
> 
>  drivers/pci/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..59319e08fca6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  		if (!dev->slot || dev->slot != slot)
>  			continue;
>  		if (dev->subordinate) {
> -			if (!pci_bus_trylock(dev->subordinate)) {
> -				pci_dev_unlock(dev);
> +			if (!pci_bus_trylock(dev->subordinate))
>  				goto unlock;
> -			}
>  		} else if (!pci_dev_trylock(dev))
>  			goto unlock;
>  	}
> -- 
> 2.20.1

