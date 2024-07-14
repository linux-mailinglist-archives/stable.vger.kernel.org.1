Return-Path: <stable+bounces-59242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1397A9308DC
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495D51F21710
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD615ACB;
	Sun, 14 Jul 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rJde2r67"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ABB1755B;
	Sun, 14 Jul 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720941470; cv=none; b=pamhzOMdYj3wQyZoVWenq+RPBawUBH6VBIXH85BesT2cqfZjcQ3TmgsudouD8FOoR14KytBEJ9vzNWWLELkq5yIC0lLYt75xXflDBQZ3CkQ8+I/K3mW4gK/ryfXDd59LyNtn3Y/jc7wy/eC/ebGag7NWpKIQtsJaHJedXljt5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720941470; c=relaxed/simple;
	bh=ioMRz+Lm4SFBaMuTqAHdAqZFIxJWs68Xh1hJmi0Nstg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U78bZEoE14ApGpq/dSmZWEzgxjK61zdQyjI/TGRCOdk4bs+ERNvAoHupzBUHeRFk44MOoS3DvmoB6jxLW70NnvVTrBX7udFKWR1xccE7bPHftFhGEg/q4Bx7pJafC/iWCke0On+2XbcRCclJhMQC01f0kby3h2R+g9uuLsparVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rJde2r67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5EEC116B1;
	Sun, 14 Jul 2024 07:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720941469;
	bh=ioMRz+Lm4SFBaMuTqAHdAqZFIxJWs68Xh1hJmi0Nstg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJde2r67PfeTliz3CEkynFL/EvGmMsig0YSf3jnIdcX3ZsDwxW9BPVwoX7emlaAOI
	 +dV0ZK8/edPGj8FFOX2SK/7jMBL8SA/6Qoqe6fPv4bwEj0A7JXSKkUUFNAMWR0csAi
	 p6NLKyo2HV8aXxfpaxC8smGhQN33TrBhOG66THaI=
Date: Sun, 14 Jul 2024 09:17:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	stable@vger.kernel.org, Ashish Sangwan <a.sangwan@samsung.com>,
	Namjae Jeon <namjae.jeon@samsung.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix uevent_show() vs driver detach race
Message-ID: <2024071438-perceive-earache-db11@gregkh>
References: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172081332794.577428.9738802016494057132.stgit@dwillia2-xfh.jf.intel.com>

On Fri, Jul 12, 2024 at 12:42:09PM -0700, Dan Williams wrote:
> uevent_show() wants to de-reference dev->driver->name. There is no clean
> way for a device attribute to de-reference dev->driver unless that
> attribute is defined via (struct device_driver).dev_groups. Instead, the
> anti-pattern of taking the device_lock() in the attribute handler risks
> deadlocks with code paths that remove device attributes while holding
> the lock.
> 
> This deadlock is typically invisible to lockdep given the device_lock()
> is marked lockdep_set_novalidate_class(), but some subsystems allocate a
> local lockdep key for @dev->mutex to reveal reports of the form:
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  6.10.0-rc7+ #275 Tainted: G           OE    N
>  ------------------------------------------------------
>  modprobe/2374 is trying to acquire lock:
>  ffff8c2270070de0 (kn->active#6){++++}-{0:0}, at: __kernfs_remove+0xde/0x220
> 
>  but task is already holding lock:
>  ffff8c22016e88f8 (&cxl_root_key){+.+.}-{3:3}, at: device_release_driver_internal+0x39/0x210
> 
>  which lock already depends on the new lock.
> 
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (&cxl_root_key){+.+.}-{3:3}:
>         __mutex_lock+0x99/0xc30
>         uevent_show+0xac/0x130
>         dev_attr_show+0x18/0x40
>         sysfs_kf_seq_show+0xac/0xf0
>         seq_read_iter+0x110/0x450
>         vfs_read+0x25b/0x340
>         ksys_read+0x67/0xf0
>         do_syscall_64+0x75/0x190
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>  -> #0 (kn->active#6){++++}-{0:0}:
>         __lock_acquire+0x121a/0x1fa0
>         lock_acquire+0xd6/0x2e0
>         kernfs_drain+0x1e9/0x200
>         __kernfs_remove+0xde/0x220
>         kernfs_remove_by_name_ns+0x5e/0xa0
>         device_del+0x168/0x410
>         device_unregister+0x13/0x60
>         devres_release_all+0xb8/0x110
>         device_unbind_cleanup+0xe/0x70
>         device_release_driver_internal+0x1c7/0x210
>         driver_detach+0x47/0x90
>         bus_remove_driver+0x6c/0xf0
>         cxl_acpi_exit+0xc/0x11 [cxl_acpi]
>         __do_sys_delete_module.isra.0+0x181/0x260
>         do_syscall_64+0x75/0x190
>         entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The observation though is that driver objects are typically much longer
> lived than device objects. It is reasonable to perform lockless
> de-reference of a @driver pointer even if it is racing detach from a
> device. Given the infrequency of driver unregistration, use
> synchronize_rcu() in module_remove_driver() to close any potential
> races.  It is potentially overkill to suffer synchronize_rcu() just to
> handle the rare module removal racing uevent_show() event.
> 
> Thanks to Tetsuo Handa for the debug analysis of the syzbot report [1].
> 
> Fixes: c0a40097f0bc ("drivers: core: synchronize really_probe() and dev_uevent()")
> Reported-by: syzbot+4762dd74e32532cda5ff@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Closes: http://lore.kernel.org/5aa5558f-90a4-4864-b1b1-5d6784c5607d@I-love.SAKURA.ne.jp [1]
> Link: http://lore.kernel.org/669073b8ea479_5fffa294c1@dwillia2-xfh.jf.intel.com.notmuch
> Cc: stable@vger.kernel.org
> Cc: Ashish Sangwan <a.sangwan@samsung.com>
> Cc: Namjae Jeon <namjae.jeon@samsung.com>
> Cc: Dirk Behme <dirk.behme@de.bosch.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/base/core.c   |   13 ++++++++-----
>  drivers/base/module.c |    4 ++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..b5399262198a 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -25,6 +25,7 @@
>  #include <linux/mutex.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/netdevice.h>
> +#include <linux/rcupdate.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/string_helpers.h>
> @@ -2640,6 +2641,7 @@ static const char *dev_uevent_name(const struct kobject *kobj)
>  static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  {
>  	const struct device *dev = kobj_to_dev(kobj);
> +	struct device_driver *driver;
>  	int retval = 0;
>  
>  	/* add device node properties if present */
> @@ -2668,8 +2670,12 @@ static int dev_uevent(const struct kobject *kobj, struct kobj_uevent_env *env)
>  	if (dev->type && dev->type->name)
>  		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
>  
> -	if (dev->driver)
> -		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
> +	/* Synchronize with module_remove_driver() */
> +	rcu_read_lock();
> +	driver = READ_ONCE(dev->driver);
> +	if (driver)
> +		add_uevent_var(env, "DRIVER=%s", driver->name);
> +	rcu_read_unlock();

It's a lot of work for a "simple" thing of just "tell userspace what
happened" type of thing.  But it makes sense.

I'll queue this up after -rc1 is out, there's no rush before then as
it's only lockdep warnings happening now, right?

thanks,

greg k-h

