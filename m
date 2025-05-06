Return-Path: <stable+bounces-141766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843B1AABCF3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 199223A9882
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020622D78A;
	Tue,  6 May 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqXrgYeB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A523920B813;
	Tue,  6 May 2025 08:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746519165; cv=none; b=EAt0qqXCAAKzlB4SFo1ij4D9FKzy+SKoqnX11/kg3tFsS8OeDoCSe5Y0WMqc3KCY8zy45T3CCEr7CQ4Njt2t3lKJOCyb/5oSZSX3ECLMj49S16+2ZbYKHdeSdGjlva6ptcVtVh6n8/0cybykNouumjB19GCfMFCGN7v4uRsfAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746519165; c=relaxed/simple;
	bh=Dwa3QWbDLaa1znidOxpzcDmlFBh6Y0Lv5/zlS8U7y5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoen4GoFGKR3cBMQb10WclbpT9gOTjmgEcbYyT7JCNva64RXgVV90igpMSaK8PHt+lAvG3JjQxpbv6Fo2XoYiVxDp/B6EpSqbqmZmdFjnCqQvKkQfqUH/IOGoRvHZ9RYr4Kw68REVC2M7ssCJIxfaNbT2zXi+OzwRIpS4L+8l8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqXrgYeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C806C4CEE4;
	Tue,  6 May 2025 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746519164;
	bh=Dwa3QWbDLaa1znidOxpzcDmlFBh6Y0Lv5/zlS8U7y5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eqXrgYeBWApfF9s2tt7aYo6K1a9Ko2WC/i5aOj4CaV3KOoDe3nqTq2HPDi6GU4HIX
	 W3LXJG3YT8SrcU3FN+lYs0gItOyvBDbERqgrT6nwyqgho7F8kRSR18dLqvjB7m7dsU
	 iig0FRpfIjJQik9ICUTt8qr5mTac3d+V3mqcVbsphOXehrs957EOZxaECZ+QCbdtCf
	 ZJEzH7gxTtG5dXLbdWRVjahJmUqaImA/3ZhRz8qoxqoCTAvIanR3GFArWYnutQhbdl
	 LrVmkiypcHhtGFCcPW3EUYnufPnzQZp1tJpZxmGfGtKGgHgoataLyI4qHEH3sM9grH
	 qME1BVA8om5og==
Date: Tue, 6 May 2025 10:12:40 +0200
From: Antoine Tenart <atenart@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Antoine Tenart <atenart@kernel.org>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, sdf@fomichev.me, jdamato@fastly.com, 
	aleksander.lobakin@intel.com, kuniyu@amazon.com, shaw.leon@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 554/642] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <jj7nizvkfuas57zcfkkbdaqnxzjdlgwtgzlkgzpazbrdnzhlc3@6ohz5cfz3tds>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-554-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505221419.2672473-554-sashal@kernel.org>

Hello,

On Mon, May 05, 2025 at 06:12:50PM -0400, Sasha Levin wrote:
> From: Antoine Tenart <atenart@kernel.org>
> 
> [ Upstream commit 79c61899b5eee317907efd1b0d06a1ada0cc00d8 ]
> 
> There is an ABBA deadlock between net device unregistration and sysfs
> files being accessed[1][2]. To prevent this from happening all paths
> taking the rtnl lock after the sysfs one (actually kn->active refcount)
> use rtnl_trylock and return early (using restart_syscall)[3], which can
> make syscalls to spin for a long time when there is contention on the
> rtnl lock[4].
> 
> There are not many possibilities to improve the above:
> - Rework the entire net/ locking logic.
> - Invert two locks in one of the paths — not possible.
> 
> But here it's actually possible to drop one of the locks safely: the
> kernfs_node refcount. More details in the code itself, which comes with
> lots of comments.
> 
> Note that we check the device is alive in the added sysfs_rtnl_lock
> helper to disallow sysfs operations to run after device dismantle has
> started. This also help keeping the same behavior as before. Because of
> this calls to dev_isalive in sysfs ops were removed.
> 
> [1] https://lore.kernel.org/netdev/49A4D5D5.5090602@trash.net/
> [2] https://lore.kernel.org/netdev/m14oyhis31.fsf@fess.ebiederm.org/
> [3] https://lore.kernel.org/netdev/20090226084924.16cb3e08@nehalam/
> [4] https://lore.kernel.org/all/20210928125500.167943-1-atenart@kernel.org/T/
> 
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> Link: https://patch.msgid.link/20250204170314.146022-2-atenart@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I'm not sure why commits from this series were flagged for stable trees,
but I would not advise to take them. They are not fixing a bug, only
improving performances by reducing lock contention.

The commits are:

79c61899b5ee  net-sysfs: remove rtnl_trylock from device attributes
b7ecc1de51ca  net-sysfs: move queue attribute groups outside the default groups
[It seems this one was missed?]
7e54f85c6082  net-sysfs: prevent uncleared queues from being re-added
[My guess is this looks like a real fix, but it's only preventing an
issue after the changes made in the series]
b0b6fcfa6ad8  net-sysfs: remove rtnl_trylock from queue attributes

Same applies for the other stable backport requests.

Thanks,
Antoine

> ---
>  include/linux/rtnetlink.h |   1 +
>  net/core/net-sysfs.c      | 186 +++++++++++++++++++++++++++-----------
>  net/core/rtnetlink.c      |   5 +
>  3 files changed, 139 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
> index 4bc2ee0b10b05..ccaaf4c7d5f6a 100644
> --- a/include/linux/rtnetlink.h
> +++ b/include/linux/rtnetlink.h
> @@ -43,6 +43,7 @@ extern void rtnl_lock(void);
>  extern void rtnl_unlock(void);
>  extern int rtnl_trylock(void);
>  extern int rtnl_is_locked(void);
> +extern int rtnl_lock_interruptible(void);
>  extern int rtnl_lock_killable(void);
>  extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
>  
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 87b2456aef08a..cedbe7d9ae670 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -42,6 +42,87 @@ static inline int dev_isalive(const struct net_device *dev)
>  	return READ_ONCE(dev->reg_state) <= NETREG_REGISTERED;
>  }
>  
> +/* There is a possible ABBA deadlock between rtnl_lock and kernfs_node->active,
> + * when unregistering a net device and accessing associated sysfs files. The
> + * potential deadlock is as follow:
> + *
> + *         CPU 0                                         CPU 1
> + *
> + *    rtnl_lock                                   vfs_read
> + *    unregister_netdevice_many                   kernfs_seq_start
> + *    device_del / kobject_put                      kernfs_get_active (kn->active++)
> + *    kernfs_drain                                sysfs_kf_seq_show
> + *    wait_event(                                 rtnl_lock
> + *       kn->active == KN_DEACTIVATED_BIAS)       -> waits on CPU 0 to release
> + *    -> waits on CPU 1 to decrease kn->active       the rtnl lock.
> + *
> + * The historical fix was to use rtnl_trylock with restart_syscall to bail out
> + * of sysfs operations when the lock couldn't be taken. This fixed the above
> + * issue as it allowed CPU 1 to bail out of the ABBA situation.
> + *
> + * But it came with performances issues, as syscalls are being restarted in
> + * loops when there was contention on the rtnl lock, with huge slow downs in
> + * specific scenarios (e.g. lots of virtual interfaces created and userspace
> + * daemons querying their attributes).
> + *
> + * The idea below is to bail out of the active kernfs_node protection
> + * (kn->active) while trying to take the rtnl lock.
> + *
> + * This replaces rtnl_lock() and still has to be used with rtnl_unlock(). The
> + * net device is guaranteed to be alive if this returns successfully.
> + */
> +static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
> +			   struct net_device *ndev)
> +{
> +	struct kernfs_node *kn;
> +	int ret = 0;
> +
> +	/* First, we hold a reference to the net device as the unregistration
> +	 * path might run in parallel. This will ensure the net device and the
> +	 * associated sysfs objects won't be freed while we try to take the rtnl
> +	 * lock.
> +	 */
> +	dev_hold(ndev);
> +	/* sysfs_break_active_protection was introduced to allow self-removal of
> +	 * devices and their associated sysfs files by bailing out of the
> +	 * sysfs/kernfs protection. We do this here to allow the unregistration
> +	 * path to complete in parallel. The following takes a reference on the
> +	 * kobject and the kernfs_node being accessed.
> +	 *
> +	 * This works because we hold a reference onto the net device and the
> +	 * unregistration path will wait for us eventually in netdev_run_todo
> +	 * (outside an rtnl lock section).
> +	 */
> +	kn = sysfs_break_active_protection(kobj, attr);
> +	/* We can now try to take the rtnl lock. This can't deadlock us as the
> +	 * unregistration path is able to drain sysfs files (kernfs_node) thanks
> +	 * to the above dance.
> +	 */
> +	if (rtnl_lock_interruptible()) {
> +		ret = -ERESTARTSYS;
> +		goto unbreak;
> +	}
> +	/* Check dismantle on the device hasn't started, otherwise deny the
> +	 * operation.
> +	 */
> +	if (!dev_isalive(ndev)) {
> +		rtnl_unlock();
> +		ret = -ENODEV;
> +		goto unbreak;
> +	}
> +	/* We are now sure the device dismantle hasn't started nor that it can
> +	 * start before we exit the locking section as we hold the rtnl lock.
> +	 * There's no need to keep unbreaking the sysfs protection nor to hold
> +	 * a net device reference from that point; that was only needed to take
> +	 * the rtnl lock.
> +	 */
> +unbreak:
> +	sysfs_unbreak_active_protection(kn);
> +	dev_put(ndev);
> +
> +	return ret;
> +}
> +
>  /* use same locking rules as GIF* ioctl's */
>  static ssize_t netdev_show(const struct device *dev,
>  			   struct device_attribute *attr, char *buf,
> @@ -95,14 +176,14 @@ static ssize_t netdev_store(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		goto err;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		goto err;
> +
> +	ret = (*set)(netdev, new);
> +	if (ret == 0)
> +		ret = len;
>  
> -	if (dev_isalive(netdev)) {
> -		ret = (*set)(netdev, new);
> -		if (ret == 0)
> -			ret = len;
> -	}
>  	rtnl_unlock();
>   err:
>  	return ret;
> @@ -220,7 +301,7 @@ static ssize_t carrier_store(struct device *dev, struct device_attribute *attr,
>  	struct net_device *netdev = to_net_dev(dev);
>  
>  	/* The check is also done in change_carrier; this helps returning early
> -	 * without hitting the trylock/restart in netdev_store.
> +	 * without hitting the locking section in netdev_store.
>  	 */
>  	if (!netdev->netdev_ops->ndo_change_carrier)
>  		return -EOPNOTSUPP;
> @@ -234,8 +315,9 @@ static ssize_t carrier_show(struct device *dev,
>  	struct net_device *netdev = to_net_dev(dev);
>  	int ret = -EINVAL;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
>  	if (netif_running(netdev)) {
>  		/* Synchronize carrier state with link watch,
> @@ -245,8 +327,8 @@ static ssize_t carrier_show(struct device *dev,
>  
>  		ret = sysfs_emit(buf, fmt_dec, !!netif_carrier_ok(netdev));
>  	}
> -	rtnl_unlock();
>  
> +	rtnl_unlock();
>  	return ret;
>  }
>  static DEVICE_ATTR_RW(carrier);
> @@ -258,13 +340,14 @@ static ssize_t speed_show(struct device *dev,
>  	int ret = -EINVAL;
>  
>  	/* The check is also done in __ethtool_get_link_ksettings; this helps
> -	 * returning early without hitting the trylock/restart below.
> +	 * returning early without hitting the locking section below.
>  	 */
>  	if (!netdev->ethtool_ops->get_link_ksettings)
>  		return ret;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
>  	if (netif_running(netdev)) {
>  		struct ethtool_link_ksettings cmd;
> @@ -284,13 +367,14 @@ static ssize_t duplex_show(struct device *dev,
>  	int ret = -EINVAL;
>  
>  	/* The check is also done in __ethtool_get_link_ksettings; this helps
> -	 * returning early without hitting the trylock/restart below.
> +	 * returning early without hitting the locking section below.
>  	 */
>  	if (!netdev->ethtool_ops->get_link_ksettings)
>  		return ret;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
>  	if (netif_running(netdev)) {
>  		struct ethtool_link_ksettings cmd;
> @@ -490,16 +574,15 @@ static ssize_t ifalias_store(struct device *dev, struct device_attribute *attr,
>  	if (len >  0 && buf[len - 1] == '\n')
>  		--count;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
> -	if (dev_isalive(netdev)) {
> -		ret = dev_set_alias(netdev, buf, count);
> -		if (ret < 0)
> -			goto err;
> -		ret = len;
> -		netdev_state_change(netdev);
> -	}
> +	ret = dev_set_alias(netdev, buf, count);
> +	if (ret < 0)
> +		goto err;
> +	ret = len;
> +	netdev_state_change(netdev);
>  err:
>  	rtnl_unlock();
>  
> @@ -551,24 +634,23 @@ static ssize_t phys_port_id_show(struct device *dev,
>  				 struct device_attribute *attr, char *buf)
>  {
>  	struct net_device *netdev = to_net_dev(dev);
> +	struct netdev_phys_item_id ppid;
>  	ssize_t ret = -EINVAL;
>  
>  	/* The check is also done in dev_get_phys_port_id; this helps returning
> -	 * early without hitting the trylock/restart below.
> +	 * early without hitting the locking section below.
>  	 */
>  	if (!netdev->netdev_ops->ndo_get_phys_port_id)
>  		return -EOPNOTSUPP;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
> -	if (dev_isalive(netdev)) {
> -		struct netdev_phys_item_id ppid;
> +	ret = dev_get_phys_port_id(netdev, &ppid);
> +	if (!ret)
> +		ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
>  
> -		ret = dev_get_phys_port_id(netdev, &ppid);
> -		if (!ret)
> -			ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
> -	}
>  	rtnl_unlock();
>  
>  	return ret;
> @@ -580,24 +662,23 @@ static ssize_t phys_port_name_show(struct device *dev,
>  {
>  	struct net_device *netdev = to_net_dev(dev);
>  	ssize_t ret = -EINVAL;
> +	char name[IFNAMSIZ];
>  
>  	/* The checks are also done in dev_get_phys_port_name; this helps
> -	 * returning early without hitting the trylock/restart below.
> +	 * returning early without hitting the locking section below.
>  	 */
>  	if (!netdev->netdev_ops->ndo_get_phys_port_name &&
>  	    !netdev->devlink_port)
>  		return -EOPNOTSUPP;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
> -	if (dev_isalive(netdev)) {
> -		char name[IFNAMSIZ];
> +	ret = dev_get_phys_port_name(netdev, name, sizeof(name));
> +	if (!ret)
> +		ret = sysfs_emit(buf, "%s\n", name);
>  
> -		ret = dev_get_phys_port_name(netdev, name, sizeof(name));
> -		if (!ret)
> -			ret = sysfs_emit(buf, "%s\n", name);
> -	}
>  	rtnl_unlock();
>  
>  	return ret;
> @@ -608,26 +689,25 @@ static ssize_t phys_switch_id_show(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct net_device *netdev = to_net_dev(dev);
> +	struct netdev_phys_item_id ppid = { };
>  	ssize_t ret = -EINVAL;
>  
>  	/* The checks are also done in dev_get_phys_port_name; this helps
> -	 * returning early without hitting the trylock/restart below. This works
> +	 * returning early without hitting the locking section below. This works
>  	 * because recurse is false when calling dev_get_port_parent_id.
>  	 */
>  	if (!netdev->netdev_ops->ndo_get_port_parent_id &&
>  	    !netdev->devlink_port)
>  		return -EOPNOTSUPP;
>  
> -	if (!rtnl_trylock())
> -		return restart_syscall();
> +	ret = sysfs_rtnl_lock(&dev->kobj, &attr->attr, netdev);
> +	if (ret)
> +		return ret;
>  
> -	if (dev_isalive(netdev)) {
> -		struct netdev_phys_item_id ppid = { };
> +	ret = dev_get_port_parent_id(netdev, &ppid, false);
> +	if (!ret)
> +		ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
>  
> -		ret = dev_get_port_parent_id(netdev, &ppid, false);
> -		if (!ret)
> -			ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
> -	}
>  	rtnl_unlock();
>  
>  	return ret;
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index ab7041150f295..e1f9af1d75a50 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -80,6 +80,11 @@ void rtnl_lock(void)
>  }
>  EXPORT_SYMBOL(rtnl_lock);
>  
> +int rtnl_lock_interruptible(void)
> +{
> +	return mutex_lock_interruptible(&rtnl_mutex);
> +}
> +
>  int rtnl_lock_killable(void)
>  {
>  	return mutex_lock_killable(&rtnl_mutex);
> -- 
> 2.39.5
> 

