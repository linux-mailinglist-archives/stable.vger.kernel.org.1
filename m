Return-Path: <stable+bounces-220073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB+jB18Go2l+9AQAu9opvQ
	(envelope-from <stable+bounces-220073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 16:14:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC471C3D82
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80A4A303AB61
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7114534BF;
	Sat, 28 Feb 2026 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5KON5P6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55324534B1;
	Sat, 28 Feb 2026 15:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291626; cv=none; b=TEb5CJTrXRbWg9s14Rv4waRNQpx5hvV8AKeSGcq+ByTq2sTa5McKWb6h2dUFbOlFZDSFSNHGLLeKAIrkoKHoNx79PWIled/Cpusyja78Gi08xU9nnCLByVzqIWR1u28DoJEUiwXweHKKXZBUHhGth8VydJe8Y6D4nDg+bj9ZtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291626; c=relaxed/simple;
	bh=5XBA28YFrH2MgLu5UMocW1pTudSFbGiCQXSre8BeW4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqJhGaTzimmfIAjW90OYcT9X/kcEJAWsyN80UZ5gj+4Wdq2/1ERnm8IIL9YDx05lMbck2lrFcn14+tt/hs790WcwCoPF/H1XO5LfI9zCH6xFdxduB5eXbKcXxdqyESC7q4KmBDumEzTVXsQQFZYkdzZBgyOh3JL82gPCBeiEp4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W5KON5P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696D1C19421;
	Sat, 28 Feb 2026 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291626;
	bh=5XBA28YFrH2MgLu5UMocW1pTudSFbGiCQXSre8BeW4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5KON5P6KW9xYNdRZnsKBfuZVK/Toy7F5xBy+tZufVttQ5e1NzrLwlIhSk+9wc0c/
	 55OAQqjzfBU6CrPZByay2IMdNiqxs6R9HF1EUizwWRwL6fJKvfzyL+0LlImTbpq7Kf
	 f6is+klbroLEWw17VHuZr2/gYtXlhMxX/cZkORVpFLm6iLD/8XbEBj4kdybhLks3xw
	 zBtZYhpce4xb183UAxAqnvl5bzZKrsL2uTuS6PiybTvnT4RBFlK2yOoLMVJxoTVHMd
	 eAfFsMKJ+wq8nHTDAykc/PuMrv0l6Tqwh9wQDvEYkVq+ErrkIyAp9D+Aae8IV0HdkN
	 wjzW2a4gm3aZg==
Date: Sat, 28 Feb 2026 20:43:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, sebott@linux.ibm.com, 
	schnelle@linux.ibm.com, bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com, 
	dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in
 sriov_add_vfs/sriov_del_vfs for complete serialization
Message-ID: <mvhrbhqxnxeitx4incfykvlgtcfs2jcrlje2warhujzvbyns4e@7eyme5xdea7g>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
 <20260228120138.51197-4-ionut.nechita@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260228120138.51197-4-ionut.nechita@windriver.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220073-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 6DC471C3D82
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 02:01:40PM +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
> locking when enabling/disabling SR-IOV") and moving the lock to
> sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
> or manual unbind) that calls pci_disable_sriov() directly remains
> unprotected against concurrent hotplug events. This affects any SR-IOV
> capable driver that calls pci_disable_sriov() from its .remove()
> callback (i40e, ice, mlx5, bnxt, etc.).
> 
> On s390, platform-generated hot-unplug events for VFs can race with
> sriov_del_vfs() when a PF driver is being unloaded. The platform event
> handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
> leading to double removal and list corruption.
> 
> We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
> be called from paths that already hold pci_rescan_remove_lock (e.g.
> remove_store -> pci_stop_and_remove_bus_device_locked, or
> sriov_numvfs_store with the lock taken by the previous patch). Using
> mutex_lock() in those cases would deadlock.
> 
> Instead, introduce owner tracking for pci_rescan_remove_lock via a new
> pci_lock_rescan_remove_reentrant() helper. This function checks if the
> current task already holds the lock:
>  - If the lock is not held: acquires it and returns true, providing
>    full serialization against concurrent hotplug events (including
>    platform-generated events on s390).
>  - If the lock is already held by the current task (reentrant call from
>    remove_store or sriov_numvfs_store paths): returns false without
>    re-acquiring, avoiding deadlock while the caller already provides
>    the necessary serialization.
>  - If the lock is held by another task (concurrent hotplug): blocks
>    until the lock is released, then acquires it, providing complete
>    serialization. This is the key improvement over a trylock approach.
> 

Just curious. Why can't you use mutex_trylock() here?

- Mani

> A matching pci_unlock_rescan_remove_reentrant() helper takes the return
> value of the lock function as argument, so callers don't need to
> open-code the conditional unlock.
> 
> The "reentrant" naming is chosen to avoid confusion with existing
> mutex_lock_nested() which is a lockdep annotation concept, not actual
> reentrant locking.
> 
> Note: owner-tracking patterns for reentrant lock behavior exist elsewhere
> in the kernel, for example in the regulator core (drivers/regulator/core.c)
> with rdev->mutex_owner, and in the PPP subsystem (drivers/net/ppp/
> ppp_generic.c) with xmit_recursion->owner.
> 
> The declarations are placed in include/linux/pci.h alongside the existing
> pci_lock_rescan_remove()/pci_unlock_rescan_remove() declarations to
> maintain API consistency and allow use by external drivers if needed.
> 
> Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
> Cc: stable@vger.kernel.org
> Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
> Tested-by: Benjamin Block <bblock@linux.ibm.com>
> Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
> Changes in v4:
>  - Rebased on linux-next (next-20260227)
>  - Declared pci_rescan_remove_owner as const pointer
>    (const struct task_struct *) to make clear it is not meant to
>    modify the task (Benjamin Block)
>  - Added Reviewed-by and Tested-by from Benjamin Block (IBM)
> 
> Changes in v3:
>  - Rebased on linux-next (next-20260225)
>  - Added Tested-by from Dragos Tatulea (NVIDIA)
>  - No code changes from v2
> 
> Changes in v2:
>  - Renamed from pci_lock_rescan_remove_nested() to
>    pci_lock_rescan_remove_reentrant() to avoid confusion with
>    mutex_lock_nested() lockdep annotations (Benjamin Block)
>  - Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
>    to avoid open-coding conditional unlock at each call site
>    (Benjamin Block)
>  - Moved declarations from drivers/pci/pci.h to include/linux/pci.h
>    alongside existing lock/unlock declarations (Benjamin Block)
>  - Simplified callers: removed negation of return value and manual
>    conditional unlock in favor of the paired lock/unlock helpers
> 
>  drivers/pci/iov.c   |  7 +++++++
>  drivers/pci/probe.c | 19 +++++++++++++++++++
>  include/linux/pci.h |  2 ++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 91ac4e37ecb9c..adbe4ecc587c9 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -629,19 +629,23 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
>  {
>  	unsigned int i;
>  	int rc;
> +	bool locked;
>  
>  	if (dev->no_vf_scan)
>  		return 0;
>  
> +	locked = pci_lock_rescan_remove_reentrant();
>  	for (i = 0; i < num_vfs; i++) {
>  		rc = pci_iov_add_virtfn(dev, i);
>  		if (rc)
>  			goto failed;
>  	}
> +	pci_unlock_rescan_remove_reentrant(locked);
>  	return 0;
>  failed:
>  	while (i--)
>  		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove_reentrant(locked);
>  
>  	return rc;
>  }
> @@ -764,10 +768,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  static void sriov_del_vfs(struct pci_dev *dev)
>  {
>  	struct pci_sriov *iov = dev->sriov;
> +	bool locked;
>  	int i;
>  
> +	locked = pci_lock_rescan_remove_reentrant();
>  	for (i = 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i);
> +	pci_unlock_rescan_remove_reentrant(locked);
>  }
>  
>  static void sriov_disable(struct pci_dev *dev)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd794..c7f672eac0698 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3509,19 +3509,38 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
>   * routines should always be executed under this mutex.
>   */
>  DEFINE_MUTEX(pci_rescan_remove_lock);
> +static const struct task_struct *pci_rescan_remove_owner;
>  
>  void pci_lock_rescan_remove(void)
>  {
>  	mutex_lock(&pci_rescan_remove_lock);
> +	pci_rescan_remove_owner = current;
>  }
>  EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
>  
>  void pci_unlock_rescan_remove(void)
>  {
> +	pci_rescan_remove_owner = NULL;
>  	mutex_unlock(&pci_rescan_remove_lock);
>  }
>  EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
>  
> +bool pci_lock_rescan_remove_reentrant(void)
> +{
> +	if (pci_rescan_remove_owner == current)
> +		return false;
> +	pci_lock_rescan_remove();
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_reentrant);
> +
> +void pci_unlock_rescan_remove_reentrant(const bool locked)
> +{
> +	if (locked)
> +		pci_unlock_rescan_remove();
> +}
> +EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove_reentrant);
> +
>  static int __init pci_sort_bf_cmp(const struct device *d_a,
>  				  const struct device *d_b)
>  {
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d51230..080950f0bab33 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1535,6 +1535,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
>  unsigned int pci_rescan_bus(struct pci_bus *bus);
>  void pci_lock_rescan_remove(void);
>  void pci_unlock_rescan_remove(void);
> +bool pci_lock_rescan_remove_reentrant(void);
> +void pci_unlock_rescan_remove_reentrant(const bool locked);
>  
>  /* Vital Product Data routines */
>  ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
> -- 
> 2.53.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

