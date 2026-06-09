Return-Path: <stable+bounces-262276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mLUBIn/9J2rt6gIAu9opvQ
	(envelope-from <stable+bounces-262276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 13:48:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854B65FA1B
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 13:48:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=AdKFZVd2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262276-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-262276-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61AC3306691C
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 11:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E5400DFB;
	Tue,  9 Jun 2026 11:46:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBCB402443;
	Tue,  9 Jun 2026 11:46:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005575; cv=none; b=rdEbWm3RrU1clWP5eygnDTu2+OsBha5oTr2eaWLGh8pZX5jsUpNVpIOTl3I/9bTFlCRoUrjr3L3xP0/oNnu85Q6KzlQOya+igXlRPrut+TKKnBwEz4i+a0B+4SKlIXZ6G81WydK+GTx5rhm7Bmc8MGouZg6ArgRkM5Owez68ts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005575; c=relaxed/simple;
	bh=yY6kvALjAuOQ7nkd7bvoQPxOpE1kUa0pwHSpqMdBGAE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ddPiF6jDCjQyYAH5rX2PkhCxTkLpEYzL9yCSvaDzSKQUtZNFVgY0cwWILozj7RpxrcF4trfMuwMOLJSflpLRUTXSHNYH+kS7wBGXUhc5EFBKKheaYWFjJZfWgy9Yc55tD0PsGM0PuvlbTScJGc/dqp4PcLbsTjjxC3DjirHM/lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdKFZVd2; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781005574; x=1812541574;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yY6kvALjAuOQ7nkd7bvoQPxOpE1kUa0pwHSpqMdBGAE=;
  b=AdKFZVd2LHLpKRIQdcrPDXncy90XerMLwP40+vPELacBU5rJlinwK35J
   wLDD47iulbiVi5uncEoL2yBapnLnksp8ct13XQx1iYY8jT+ct7NipLElz
   3HEncRtf7yGlLRr7YAXixtHJ78xvEG0JF2Lj2VCvO6zPdtA0f7ZFClazI
   qaY2DYS1wndS9yg0OGcAq/62Jw4FwAKd81qV48NseP8EJTDaYBy+GUEJY
   AOea8H8J+huIWmfDnsPPvU2rGIzJbSavjllYF4/8T/IwuRouGj+vJ/PxL
   KOwKo2YZzeApPGyVEWIfQrrvzX0TqdqrpTzGEAGz0FmYbv/TuoAJjDV1S
   Q==;
X-CSE-ConnectionGUID: +UOA2qF5SHuhem+1xo9O5w==
X-CSE-MsgGUID: EePDKEBVRnyrBaJ1M7YVvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81808771"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81808771"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 04:46:13 -0700
X-CSE-ConnectionGUID: RJmEw9UnSkG6R9Ral6GVTw==
X-CSE-MsgGUID: kDVNWlOLQp64VmvhwJprDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="249766008"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.81])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 04:46:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 9 Jun 2026 14:46:05 +0300 (EEST)
To: Daniel Gibson <daniel@gibson.sh>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mario Limonciello <superm1@kernel.org>, 
    Sindre Henriksen <sindrehenriksen93@gmail.com>, 
    Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
In-Reply-To: <20260609105756.2813669-3-daniel@gibson.sh>
Message-ID: <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com>
References: <20260609105756.2813669-1-daniel@gibson.sh> <20260609105756.2813669-3-daniel@gibson.sh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-641038138-1781005565=:1206"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,vger.kernel.org,gmail.com,oss.qualcomm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262276-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:daniel@gibson.sh,m:Shyam-sundar.S-k@amd.com,m:hansg@kernel.org,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:superm1@kernel.org,m:sindrehenriksen93@gmail.com,m:johannes.goede@oss.qualcomm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8854B65FA1B

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-641038138-1781005565=:1206
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 9 Jun 2026, Daniel Gibson wrote:

> Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
> nonfunctional keyboard and lid switch after s2idle.
>=20
> It helps to delay suspend by 2.5 seconds so the EC has some time
> to do whatever it needs to get done before suspend - unfortunately
> at least on my 16ABR8 waking it with a timer (wakealarm) still
> triggers the issue, but at least normal resume via keypress or
> lid works fine. On the 14ARP10 wakealarm has been reported to also
> work fine with this patch.
>=20
> This issue has been reported for many different devices, this patch
> has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
> and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
> 15ARP10 (83MM).
>=20
> Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D221383
> Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
> Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org
> ---
>  drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
>  drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
>  drivers/platform/x86/amd/pmc/pmc.h        |  1 +
>  3 files changed, 63 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform=
/x86/amd/pmc/pmc-quirks.c
> index 24506e342943..74ddf1d8289a 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -18,6 +18,7 @@
>  struct quirk_entry {
>  =09u32 s2idle_bug_mmio;
>  =09bool spurious_8042;
> +=09bool need_suspend_delay;
>  };
> =20
>  static struct quirk_entry quirk_s2idle_bug =3D {
> @@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 =
=3D {
>  =09.spurious_8042 =3D true,
>  };
> =20
> +static struct quirk_entry quirk_s2idle_need_suspend_delay =3D {
> +=09.need_suspend_delay =3D true,
> +};
> +
>  static const struct dmi_system_id fwbug_list[] =3D {
>  =09{
>  =09=09.ident =3D "L14 Gen2 AMD",
> @@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] =3D {
>  =09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>  =09=09}
>  =09},
> +=09/* https://bugzilla.kernel.org/show_bug.cgi?id=3D221383 */
> +=09{
> +=09=09.ident =3D "Zen3-based IdeaPad Slim and similar",
> +=09=09.driver_data =3D &quirk_s2idle_need_suspend_delay,

Hi,

One more question.

Sashiko noted, that amd_pmc_quirks_init() can overwrite=20
disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data=20
provides quirks. Is it okay in this case to not have .spurious_8042?

--=20
 i.

> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +=09=09=09/*
> +=09=09=09 * Note: there are also some Zen2-based 82X* devices that
> +=09=09=09 * need different quirks, they're already handled above
> +=09=09=09 */
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "82X"),
> +=09=09}
> +=09},
> +=09{
> +=09=09.ident =3D "Zen3+-based IdeaPad Slim and similar",
> +=09=09.driver_data =3D &quirk_s2idle_need_suspend_delay,
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "83K"),
> +=09=09}
> +=09},
> +=09{
> +=09=09.ident =3D "IdeaPad Slim 3 15ARP10 (83MM)",
> +=09=09.driver_data =3D &quirk_s2idle_need_suspend_delay,
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "83MM"),
> +=09=09}
> +=09},
>  =09/* https://bugzilla.kernel.org/show_bug.cgi?id=3D221273 */
>  =09{
>  =09=09.ident =3D "Thinkpad L14 Gen3",
> @@ -356,6 +390,11 @@ void amd_pmc_process_restore_quirks(struct amd_pmc_d=
ev *dev)
>  =09=09amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
>  }
> =20
> +bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev)
> +{
> +=09return dev->quirks && dev->quirks->need_suspend_delay;
> +}
> +
>  void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
>  {
>  =09const struct dmi_system_id *dmi_id;
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/am=
d/pmc/pmc.c
> index 2b9e5730170a..6bafd8661d68 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -611,6 +611,27 @@ static bool amd_pmc_intermediate_wakeup_need_delay(s=
truct amd_pmc_dev *pdev)
>  =09return get_metrics_table(pdev, &table) =3D=3D 0 && table.s0i3_last_en=
try_status;
>  }
> =20
> +static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
> +{
> +=09/*
> +=09 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
> +=09 * me-time before sleeping or they get uncooperative after waking
> +=09 * up and don't send events for keyboard and lid switch anymore.
> +=09 *
> +=09 * Unfortunately this doesn't entirely fix the problem: It can still
> +=09 * happen when resuming with a timer (wakealarm), but at least the
> +=09 * more common usecases (wakeup by opening lid or pressing a key)
> +=09 * work fine with this workaround.
> +=09 *
> +=09 * See https://bugzilla.kernel.org/show_bug.cgi?id=3D221383
> +=09 */
> +=09if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
> +=09=09dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bu=
g\n");
> +=09=09return true;
> +=09}
> +=09return false;
> +}
> +
>  static void amd_pmc_s2idle_prepare(void)
>  {
>  =09struct amd_pmc_dev *pdev =3D &pmc;
> @@ -647,7 +668,8 @@ static void amd_pmc_s2idle_check(void)
>  =09struct amd_pmc_dev *pdev =3D &pmc;
>  =09int rc;
> =20
> -=09if (amd_pmc_intermediate_wakeup_need_delay(pdev))
> +=09if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
> +=09    amd_pmc_want_suspend_delay(pdev))
>  =09=09msleep(2500);
> =20
>  =09/* Dump the IdleMask before we add to the STB */
> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/am=
d/pmc/pmc.h
> index fe3f53eb5955..f5257e47b8c4 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.h
> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> @@ -147,6 +147,7 @@ enum amd_pmc_def {
>  };
> =20
>  void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
> +bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev);
>  void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
>  void amd_mp2_stb_init(struct amd_pmc_dev *dev);
>  void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);
>=20
--8323328-641038138-1781005565=:1206--

