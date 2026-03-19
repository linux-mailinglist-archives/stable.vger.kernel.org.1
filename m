Return-Path: <stable+bounces-227353-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK1HDKoxvGnxuQIAu9opvQ
	(envelope-from <stable+bounces-227353-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:26:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9202CFF01
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 18:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA26B3008983
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB803803CD;
	Thu, 19 Mar 2026 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rG5ccpfu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00973E0C42
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 17:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941141; cv=none; b=rGTdTU3WO0DEdN1ToVs9iuk6eq6bt27gHygGuBBxkzeUhS30qz2KS+CZySD/9e6WgDQ8wMRHxx6JKL5XNF/lvJNHKOYiYxbw53L7TBwI0HtteLu78k26wmuRAGLSAmRfxZ4rwTP8DdyT9ct4oAZ/D2N3HKXp2Nn2G/ZCnuxDU8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941141; c=relaxed/simple;
	bh=PheR7bnWRvNqOXZVWOZja4PgxItdOa1aeIc8SwrBgLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7u5bxlhjg3FUL7QZqhpb/aZmXaJeDKlnQsahTg26AuT+GQjXeqRquQmtxquRCsSRHecSw1rg/hY396sX6DYHc0fcpC6rpem0+whe/I31W6ceeUt0SPRwRocPGvO7jwvGyfq3QATCYIhxdzXUrKZ+7C0uinUPKQcsDJs0muP+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rG5ccpfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885B5C2BCF4
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941141;
	bh=PheR7bnWRvNqOXZVWOZja4PgxItdOa1aeIc8SwrBgLg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rG5ccpfuTAf4aevEd1/xjUOSQOLvucc0byPCiqFCls/tUsZ78QdNSF5JLoX8N4/Ko
	 PMxSWAS6J8QyDe7pyKEn4LZ81wgsBn7sDmsjJQZ4FLxWtZ/cxLi6rc8Az+rqw5MYSP
	 83SP+SUI1HuTNqf5soWPtBkCbwLI7sCTBjYDAa7AppasRqe0brUv4wQEP1oP+44k9g
	 rXuuO9WwsycTrH4uMe+5AJ7KMFhbvoggooZL2SU1W1/2CK2bqqknAzqOpEUIq3ua7e
	 PdIinenTQLcgatE6wR0Rzwm4ejYzwi7BMqE2AjDvMf3Bxd5Qm81a3RsnDhwcfKvjVI
	 cRV3HOsqKI5nA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b982a80317fso56708966b.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 10:25:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRhqe72+Rx2K9n8h3027OGS9EAryXgTcK32irCcFj9FPrZRwYchhPvl5FRV9pdu54X+6CFeMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZSmIkJWieCxLjQqlH9oRZhlSA0aNCSVnT6KkPH/WqCy/oJmcb
	DqKcQU4Kq6SUt2mNIl8w+9vuwjqFPzwqwp1roEHHtTZ6TYmDo9ZMj1dTm9xXE+wgC9fDuyFTyMT
	ShyoC6NB8KSYB+nukgLTaJDGayTvvrV8=
X-Received: by 2002:a17:907:c281:b0:b98:a49:a237 with SMTP id
 a640c23a62f3a-b982f0c0082mr14213766b.6.1773941139816; Thu, 19 Mar 2026
 10:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
In-Reply-To: <20260317090112.v2.1.I0a4d03104ecd5103df3d76f66c8d21b1d15a2e38@changeid>
From: Saravana Kannan <saravanak@kernel.org>
Date: Thu, 19 Mar 2026 10:25:28 -0700
X-Gmail-Original-Message-ID: <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
X-Gm-Features: AaiRm507X2Rm_esTeDGefTbMHDE2ymhPZQynsWD2e2kEHWMaRTcbSREIEVA2ZRI
Message-ID: <CACRMN=euZzwDpCQupzth-J1z9qWXPenmy_bu727+R-kt97zexw@mail.gmail.com>
Subject: Re: [PATCH v2] device property: Make modifications of fwnode "flags"
 thread safe
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, stable@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Brown <broonie@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, Andrew Lunn <andrew@lunn.ch>, 
	Daniel Scally <djrscally@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, imx@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227353-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,sang-engineering.com,lunn.ch,gmail.com,davemloft.net,google.com,nxp.com,redhat.com,pengutronix.de,armlinux.org.uk,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saravanak@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.926];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0C9202CFF01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 9:04=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> In various places in the kernel, we modify the fwnode "flags" member
> by doing either:
>   fwnode->flags |=3D SOME_FLAG;
>   fwnode->flags &=3D ~SOME_FLAG;
>
> This type of modification is not thread-safe. If two threads are both
> mucking with the flags at the same time then one can clobber the
> other.
>
> While flags are often modified while under the "fwnode_link_lock",
> this is not universally true.
>
> Create some accessor functions for setting, clearing, and testing the
> FWNODE flags and move all users to these accessor functions. New
> accessor functions use set_bit() and clear_bit(), which are
> thread-safe.
>
> Cc: stable@vger.kernel.org
> Fixes: c2c724c868c4 ("driver core: Add fw_devlink_parse_fwtree()")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> While this patch is not known for sure to fix any specific issues, it
> seems possible that it could fix some rare problems. I'm currently
> trying to track down a hard-to-reproduce heisenbug and one (currently
> unproven) theory I had was that the fwnode flags could be getting
> messed up like this. Even if turns out not to fix my heisenbug,
> though, this seems like a worthwhile change to take.

Reviewed-by: Saravana Kannan <saravanak@kernel.org>

Thanks Doug. Hope this isn't the cause of the hisenbug. If you report
it here, I might be able to take a look at it too (no promises).


-Saravana

>
> Changes in v2:
> - Add/use fwnode_assign_flag() (Andy).
>
>  drivers/base/core.c                 | 24 +++++++--------
>  drivers/bus/imx-weim.c              |  2 +-
>  drivers/i2c/i2c-core-of.c           |  2 +-
>  drivers/net/phy/mdio_bus_provider.c |  4 +--
>  drivers/of/base.c                   |  2 +-
>  drivers/of/dynamic.c                |  2 +-
>  drivers/of/platform.c               |  2 +-
>  drivers/spi/spi.c                   |  2 +-
>  include/linux/fwnode.h              | 45 +++++++++++++++++++++--------
>  9 files changed, 53 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 791f9e444df8..f65492a4afc8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -182,7 +182,7 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_=
handle *fwnode)
>         if (fwnode->dev)
>                 return;
>
> -       fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
> +       fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
>         fwnode_links_purge_consumers(fwnode);
>
>         fwnode_for_each_available_child_node(fwnode, child)
> @@ -228,7 +228,7 @@ static void __fw_devlink_pickup_dangling_consumers(st=
ruct fwnode_handle *fwnode,
>         if (fwnode->dev && fwnode->dev->bus)
>                 return;
>
> -       fwnode->flags |=3D FWNODE_FLAG_NOT_DEVICE;
> +       fwnode_set_flag(fwnode, FWNODE_FLAG_NOT_DEVICE);
>         __fwnode_links_move_consumers(fwnode, new_sup);
>
>         fwnode_for_each_available_child_node(fwnode, child)
> @@ -1012,7 +1012,7 @@ static void device_links_missing_supplier(struct de=
vice *dev)
>  static bool dev_is_best_effort(struct device *dev)
>  {
>         return (fw_devlink_best_effort && dev->can_match) ||
> -               (dev->fwnode && (dev->fwnode->flags & FWNODE_FLAG_BEST_EF=
FORT));
> +               (dev->fwnode && (fwnode_test_flag(dev->fwnode, FWNODE_FLA=
G_BEST_EFFORT)));
>  }
>
>  static struct fwnode_handle *fwnode_links_check_suppliers(
> @@ -1723,11 +1723,11 @@ bool fw_devlink_is_strict(void)
>
>  static void fw_devlink_parse_fwnode(struct fwnode_handle *fwnode)
>  {
> -       if (fwnode->flags & FWNODE_FLAG_LINKS_ADDED)
> +       if (fwnode_test_flag(fwnode, FWNODE_FLAG_LINKS_ADDED))
>                 return;
>
>         fwnode_call_int_op(fwnode, add_links);
> -       fwnode->flags |=3D FWNODE_FLAG_LINKS_ADDED;
> +       fwnode_set_flag(fwnode, FWNODE_FLAG_LINKS_ADDED);
>  }
>
>  static void fw_devlink_parse_fwtree(struct fwnode_handle *fwnode)
> @@ -1885,7 +1885,7 @@ static bool fwnode_init_without_drv(struct fwnode_h=
andle *fwnode)
>         struct device *dev;
>         bool ret;
>
> -       if (!(fwnode->flags & FWNODE_FLAG_INITIALIZED))
> +       if (!(fwnode_test_flag(fwnode, FWNODE_FLAG_INITIALIZED)))
>                 return false;
>
>         dev =3D get_dev_from_fwnode(fwnode);
> @@ -2001,10 +2001,10 @@ static bool __fw_devlink_relax_cycles(struct fwno=
de_handle *con_handle,
>          * We aren't trying to find all cycles. Just a cycle between con =
and
>          * sup_handle.
>          */
> -       if (sup_handle->flags & FWNODE_FLAG_VISITED)
> +       if (fwnode_test_flag(sup_handle, FWNODE_FLAG_VISITED))
>                 return false;
>
> -       sup_handle->flags |=3D FWNODE_FLAG_VISITED;
> +       fwnode_set_flag(sup_handle, FWNODE_FLAG_VISITED);
>
>         /* Termination condition. */
>         if (sup_handle =3D=3D con_handle) {
> @@ -2074,7 +2074,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode=
_handle *con_handle,
>         }
>
>  out:
> -       sup_handle->flags &=3D ~FWNODE_FLAG_VISITED;
> +       fwnode_clear_flag(sup_handle, FWNODE_FLAG_VISITED);
>         put_device(sup_dev);
>         put_device(con_dev);
>         put_device(par_dev);
> @@ -2127,7 +2127,7 @@ static int fw_devlink_create_devlink(struct device =
*con,
>          * When such a flag is set, we can't create device links where P =
is the
>          * supplier of C as that would delay the probe of C.
>          */
> -       if (sup_handle->flags & FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD &&
> +       if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NEEDS_CHILD_BOUND_ON=
_ADD) &&
>             fwnode_is_ancestor_of(sup_handle, con->fwnode))
>                 return -EINVAL;
>
> @@ -2150,7 +2150,7 @@ static int fw_devlink_create_devlink(struct device =
*con,
>         else
>                 flags =3D FW_DEVLINK_FLAGS_PERMISSIVE;
>
> -       if (sup_handle->flags & FWNODE_FLAG_NOT_DEVICE)
> +       if (fwnode_test_flag(sup_handle, FWNODE_FLAG_NOT_DEVICE))
>                 sup_dev =3D fwnode_get_next_parent_dev(sup_handle);
>         else
>                 sup_dev =3D get_dev_from_fwnode(sup_handle);
> @@ -2162,7 +2162,7 @@ static int fw_devlink_create_devlink(struct device =
*con,
>                  * supplier device indefinitely.
>                  */
>                 if (sup_dev->links.status =3D=3D DL_DEV_NO_DRIVER &&
> -                   sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
> +                   fwnode_test_flag(sup_handle, FWNODE_FLAG_INITIALIZED)=
) {
>                         dev_dbg(con,
>                                 "Not linking %pfwf - dev might never prob=
e\n",
>                                 sup_handle);
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index 83d623d97f5f..f735e0462c55 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -332,7 +332,7 @@ static int of_weim_notify(struct notifier_block *nb, =
unsigned long action,
>                          * fw_devlink doesn't skip adding consumers to th=
is
>                          * device.
>                          */
> -                       rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE=
;
> +                       fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NO=
T_DEVICE);
>                         if (!of_platform_device_create(rd->dn, NULL, &pde=
v->dev)) {
>                                 dev_err(&pdev->dev,
>                                         "Failed to create child device '%=
pOF'\n",
> diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
> index eb7fb202355f..354a88d0599e 100644
> --- a/drivers/i2c/i2c-core-of.c
> +++ b/drivers/i2c/i2c-core-of.c
> @@ -180,7 +180,7 @@ static int of_i2c_notify(struct notifier_block *nb, u=
nsigned long action,
>                  * Clear the flag before adding the device so that fw_dev=
link
>                  * doesn't skip adding consumers to this device.
>                  */
> -               rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> +               fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE=
);
>                 client =3D of_i2c_register_device(adap, rd->dn);
>                 if (IS_ERR(client)) {
>                         dev_err(&adap->dev, "failed to create client for =
'%pOF'\n",
> diff --git a/drivers/net/phy/mdio_bus_provider.c b/drivers/net/phy/mdio_b=
us_provider.c
> index 4b0637405740..fd691c5424ea 100644
> --- a/drivers/net/phy/mdio_bus_provider.c
> +++ b/drivers/net/phy/mdio_bus_provider.c
> @@ -294,8 +294,8 @@ int __mdiobus_register(struct mii_bus *bus, struct mo=
dule *owner)
>                 return -EINVAL;
>
>         if (bus->parent && bus->parent->of_node)
> -               bus->parent->of_node->fwnode.flags |=3D
> -                                       FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_=
ADD;
> +               fwnode_set_flag(&bus->parent->of_node->fwnode,
> +                               FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD);
>
>         WARN(bus->state !=3D MDIOBUS_ALLOCATED &&
>              bus->state !=3D MDIOBUS_UNREGISTERED,
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 57420806c1a2..8d1972e18161 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -1915,7 +1915,7 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64=
 align))
>                 if (name)
>                         of_stdout =3D of_find_node_opts_by_path(name, &of=
_stdout_options);
>                 if (of_stdout)
> -                       of_stdout->fwnode.flags |=3D FWNODE_FLAG_BEST_EFF=
ORT;
> +                       fwnode_set_flag(&of_stdout->fwnode, FWNODE_FLAG_B=
EST_EFFORT);
>         }
>
>         if (!of_aliases)
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 1a06175def37..ade288372101 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -225,7 +225,7 @@ static void __of_attach_node(struct device_node *np)
>         np->sibling =3D np->parent->child;
>         np->parent->child =3D np;
>         of_node_clear_flag(np, OF_DETACHED);
> -       np->fwnode.flags |=3D FWNODE_FLAG_NOT_DEVICE;
> +       fwnode_set_flag(&np->fwnode, FWNODE_FLAG_NOT_DEVICE);
>
>         raw_spin_unlock_irqrestore(&devtree_lock, flags);
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index ba591fbceb56..7eeaf8e27b5b 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -742,7 +742,7 @@ static int of_platform_notify(struct notifier_block *=
nb,
>                  * Clear the flag before adding the device so that fw_dev=
link
>                  * doesn't skip adding consumers to this device.
>                  */
> -               rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> +               fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE=
);
>                 /* pdev_parent may be NULL when no bus platform device */
>                 pdev_parent =3D of_find_device_by_node(parent);
>                 pdev =3D of_platform_device_create(rd->dn, NULL,
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 61f7bde8c7fb..ba8098f1a88c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4938,7 +4938,7 @@ static int of_spi_notify(struct notifier_block *nb,=
 unsigned long action,
>                  * Clear the flag before adding the device so that fw_dev=
link
>                  * doesn't skip adding consumers to this device.
>                  */
> -               rd->dn->fwnode.flags &=3D ~FWNODE_FLAG_NOT_DEVICE;
> +               fwnode_clear_flag(&rd->dn->fwnode, FWNODE_FLAG_NOT_DEVICE=
);
>                 spi =3D of_register_spi_device(ctlr, rd->dn);
>                 put_device(&ctlr->dev);
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 097be89487bf..c1ebcc6fd896 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -15,6 +15,7 @@
>  #define _LINUX_FWNODE_H_
>
>  #include <linux/bits.h>
> +#include <linux/bitops.h>
>  #include <linux/err.h>
>  #include <linux/list.h>
>  #include <linux/types.h>
> @@ -42,12 +43,12 @@ struct device;
>   *             suppliers. Only enforce ordering with suppliers that have
>   *             drivers.
>   */
> -#define FWNODE_FLAG_LINKS_ADDED                        BIT(0)
> -#define FWNODE_FLAG_NOT_DEVICE                 BIT(1)
> -#define FWNODE_FLAG_INITIALIZED                        BIT(2)
> -#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD   BIT(3)
> -#define FWNODE_FLAG_BEST_EFFORT                        BIT(4)
> -#define FWNODE_FLAG_VISITED                    BIT(5)
> +#define FWNODE_FLAG_LINKS_ADDED                        0
> +#define FWNODE_FLAG_NOT_DEVICE                 1
> +#define FWNODE_FLAG_INITIALIZED                        2
> +#define FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD   3
> +#define FWNODE_FLAG_BEST_EFFORT                        4
> +#define FWNODE_FLAG_VISITED                    5
>
>  struct fwnode_handle {
>         struct fwnode_handle *secondary;
> @@ -57,7 +58,7 @@ struct fwnode_handle {
>         struct device *dev;
>         struct list_head suppliers;
>         struct list_head consumers;
> -       u8 flags;
> +       unsigned long flags;
>  };
>
>  /*
> @@ -212,16 +213,36 @@ static inline void fwnode_init(struct fwnode_handle=
 *fwnode,
>         INIT_LIST_HEAD(&fwnode->suppliers);
>  }
>
> +static inline void fwnode_set_flag(struct fwnode_handle *fwnode,
> +                                  unsigned int bit)
> +{
> +       set_bit(bit, &fwnode->flags);
> +}
> +
> +static inline void fwnode_clear_flag(struct fwnode_handle *fwnode,
> +                                  unsigned int bit)
> +{
> +       clear_bit(bit, &fwnode->flags);
> +}
> +
> +static inline void fwnode_assign_flag(struct fwnode_handle *fwnode,
> +                                     unsigned int bit, bool value)
> +{
> +       assign_bit(bit, &fwnode->flags, value);
> +}
> +
> +static inline bool fwnode_test_flag(struct fwnode_handle *fwnode,
> +                                   unsigned int bit)
> +{
> +       return test_bit(bit, &fwnode->flags);
> +}
> +
>  static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
>                                           bool initialized)
>  {
>         if (IS_ERR_OR_NULL(fwnode))
>                 return;
> -
> -       if (initialized)
> -               fwnode->flags |=3D FWNODE_FLAG_INITIALIZED;
> -       else
> -               fwnode->flags &=3D ~FWNODE_FLAG_INITIALIZED;
> +       fwnode_assign_flag(fwnode, FWNODE_FLAG_INITIALIZED, initialized);
>  }
>
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup=
,
> --
> 2.53.0.851.ga537e3e6e9-goog
>

