Return-Path: <stable+bounces-196485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB7C7A2C1
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 962CB35847
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73AA33CEAF;
	Fri, 21 Nov 2025 14:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGOnGR7M"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4230CDB4;
	Fri, 21 Nov 2025 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763734703; cv=none; b=WcD74i3R+erWOLeSb6ewlshYkjzdq45zncHDu/Hg5mTcjHIJZv8ffaf6z4pmZiEJvRHt+AkPOq4+hHEaqc6K2ZbhCXhaiKdPRVNHq3Gwp2V5191cY3316m8w9Iv6Uu0aNtKtON19rsPbWMTkPEnC1Q4ucLyhqn6CcOJF5LsNwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763734703; c=relaxed/simple;
	bh=kxBmWcmhJtaDG0WBcO4wUAVDVRgE5RVxv2S8mslpLnA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=siiwyOFiMw3DzKtuiW9Q3TZa2jn25IRmGP6rv2AnQYh7HD/+lf9be0gP7y7ZgFYEMhQt8DeCjumdgEPKEb7uyiX8f95CTzY4cG74FOCuP+ShTDFfxj46y15vA6UHQ4ClnfvsWwWsJW7x4RuC8Dpe1EQO1xtEvtfTLZpQRy3fKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGOnGR7M; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763734701; x=1795270701;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kxBmWcmhJtaDG0WBcO4wUAVDVRgE5RVxv2S8mslpLnA=;
  b=jGOnGR7Mm0B8kxhetizzx+PjfNYwfCr2QQ1o3XfeDwxetQ/Ajk0eXpmr
   Fl15+q2HQjYztYdOvGbvmcn/9RXpNX9LOZOUgDoLnwq9rJtK3hHH3kZf6
   6QpjufsMg1Tz7a5HtVyUXRpSIaVvOE2LyW2/A3HbJ2SeCtm5Bs4oQHbcD
   bdJjZxlgcXDibZtdT3mCIB4Pxd7EL58t2z7aTzFfYH48qcnLd+6G5u9QT
   Ci8AUio+afFinDRy1IshiCWSfLHz5HUT00StsvMoy+GSoSLa8jcz0E+XK
   V1D22mpqlLGvFN/KjnQQe5F0mcSfraFEkfNrtcrbkfz/oSjYHBREYDpi5
   A==;
X-CSE-ConnectionGUID: g/orokb4RGqcrTcBAVz2Lw==
X-CSE-MsgGUID: v9QYoZCjQYqXVoDqVeBe3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11620"; a="65867440"
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="65867440"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 06:18:20 -0800
X-CSE-ConnectionGUID: m7YFLqdZRhKNOadJO2RYqg==
X-CSE-MsgGUID: 20IuvnKGRsqruBQSFnwyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,216,1758610800"; 
   d="scan'208";a="191951351"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 06:18:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Nov 2025 16:18:11 +0200 (EET)
To: Hans de Goede <hansg@kernel.org>
cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Sakari Ailus <sakari.ailus@linux.intel.com>, 
    Philipp Zabel <p.zabel@pengutronix.de>, 
    Linus Walleij <linus.walleij@linaro.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
    Charles Keepax <ckeepax@opensource.cirrus.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
    stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] platform/x86: intel: chtwc_int33fe: don't dereference
 swnode args
In-Reply-To: <58fdb603-6d42-443d-8ae6-57aced9eb104@kernel.org>
Message-ID: <c116bb9d-1c56-abf3-a9b7-c87dbcc63523@linux.intel.com>
References: <20251121-int33fe-swnode-fix-v1-1-713e7b7c6046@linaro.org> <58fdb603-6d42-443d-8ae6-57aced9eb104@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2040322464-1763734691=:965"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2040322464-1763734691=:965
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 21 Nov 2025, Hans de Goede wrote:

> Hi,
>=20
> On 21-Nov-25 11:04 AM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >=20
> > Members of struct software_node_ref_args should not be dereferenced
> > directly but set using the provided macros. Commit d7cdbbc93c56
> > ("software node: allow referencing firmware nodes") changed the name of
> > the software node member and caused a build failure. Remove all direct
> > dereferences of the ref struct as a fix.
> >=20
> > However, this driver also seems to abuse the software node interface by
> > waiting for a node with an arbitrary name "intel-xhci-usb-sw" to appear
> > in the system before setting up the reference for the I2C device, while
> > the actual software node already exists in the intel-xhci-usb-role-swit=
ch
> > module and should be used to set up a static reference. Add a FIXME for
> > a future improvement.
> >=20
> > Fixes: d7cdbbc93c56 ("software node: allow referencing firmware nodes")
> > Fixes: 53c24c2932e5 ("platform/x86: intel_cht_int33fe: use inline refer=
ence properties")
> > Cc: stable@vger.kernel.org
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/all/20251121111534.7cdbfe5c@canb.auug.o=
rg.au/
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > This should go into the reset tree as a fix to the regression introduce=
d
> > by the reset-gpio driver rework.
>=20
> Thanks, patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>=20
> Also ack for merging this through the reset tree.
>=20
> Ilpo please do *not* pick this one up as it will be merged
> through the reset tree.

Fine,

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

>=20
> Regards,
>=20
> Hans
>=20
>=20
>=20
>=20
> > ---
> >  drivers/platform/x86/intel/chtwc_int33fe.c | 29 ++++++++++++++++++++--=
-------
> >  1 file changed, 20 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platf=
orm/x86/intel/chtwc_int33fe.c
> > index 29e8b5432f4c9eea7dc45b83d94c0e00373f901b..d183aa53c318ba8d57c7124=
c38506e6956b3ee36 100644
> > --- a/drivers/platform/x86/intel/chtwc_int33fe.c
> > +++ b/drivers/platform/x86/intel/chtwc_int33fe.c
> > @@ -77,7 +77,7 @@ static const struct software_node max17047_node =3D {
> >   * software node.
> >   */
> >  static struct software_node_ref_args fusb302_mux_refs[] =3D {
> > -=09{ .node =3D NULL },
> > +=09SOFTWARE_NODE_REFERENCE(NULL),
> >  };
> > =20
> >  static const struct property_entry fusb302_properties[] =3D {
> > @@ -190,11 +190,6 @@ static void cht_int33fe_remove_nodes(struct cht_in=
t33fe_data *data)
> >  {
> >  =09software_node_unregister_node_group(node_group);
> > =20
> > -=09if (fusb302_mux_refs[0].node) {
> > -=09=09fwnode_handle_put(software_node_fwnode(fusb302_mux_refs[0].node)=
);
> > -=09=09fusb302_mux_refs[0].node =3D NULL;
> > -=09}
> > -
> >  =09if (data->dp) {
> >  =09=09data->dp->secondary =3D NULL;
> >  =09=09fwnode_handle_put(data->dp);
> > @@ -202,7 +197,15 @@ static void cht_int33fe_remove_nodes(struct cht_in=
t33fe_data *data)
> >  =09}
> >  }
> > =20
> > -static int cht_int33fe_add_nodes(struct cht_int33fe_data *data)
> > +static void cht_int33fe_put_swnode(void *data)
> > +{
> > +=09struct fwnode_handle *fwnode =3D data;
> > +
> > +=09fwnode_handle_put(fwnode);
> > +=09fusb302_mux_refs[0] =3D SOFTWARE_NODE_REFERENCE(NULL);
> > +}
> > +
> > +static int cht_int33fe_add_nodes(struct device *dev, struct cht_int33f=
e_data *data)
> >  {
> >  =09const struct software_node *mux_ref_node;
> >  =09int ret;
> > @@ -212,17 +215,25 @@ static int cht_int33fe_add_nodes(struct cht_int33=
fe_data *data)
> >  =09 * until the mux driver has created software node for the mux devic=
e.
> >  =09 * It means we depend on the mux driver. This function will return
> >  =09 * -EPROBE_DEFER until the mux device is registered.
> > +=09 *
> > +=09 * FIXME: the relevant software node exists in intel-xhci-usb-role-=
switch
> > +=09 * and - if exported - could be used to set up a static reference.
> >  =09 */
> >  =09mux_ref_node =3D software_node_find_by_name(NULL, "intel-xhci-usb-s=
w");
> >  =09if (!mux_ref_node)
> >  =09=09return -EPROBE_DEFER;
> > =20
> > +=09ret =3D devm_add_action_or_reset(dev, cht_int33fe_put_swnode,
> > +=09=09=09=09       software_node_fwnode(mux_ref_node));
> > +=09if (ret)
> > +=09=09return ret;
> > +
> >  =09/*
> >  =09 * Update node used in "usb-role-switch" property. Note that we
> >  =09 * rely on software_node_register_node_group() to use the original
> >  =09 * instance of properties instead of copying them.
> >  =09 */
> > -=09fusb302_mux_refs[0].node =3D mux_ref_node;
> > +=09fusb302_mux_refs[0] =3D SOFTWARE_NODE_REFERENCE(mux_ref_node);
> > =20
> >  =09ret =3D software_node_register_node_group(node_group);
> >  =09if (ret)
> > @@ -345,7 +356,7 @@ static int cht_int33fe_typec_probe(struct platform_=
device *pdev)
> >  =09=09return fusb302_irq;
> >  =09}
> > =20
> > -=09ret =3D cht_int33fe_add_nodes(data);
> > +=09ret =3D cht_int33fe_add_nodes(dev, data);
> >  =09if (ret)
> >  =09=09return ret;
> > =20
> >=20
> > ---
> > base-commit: cba510406ba76569782ead6007a0e4eb5d34a7ab
> > change-id: 20251121-int33fe-swnode-fix-e896da458560
> >=20
> > Best regards,
>=20
--8323328-2040322464-1763734691=:965--

