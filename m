Return-Path: <stable+bounces-211217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA30FnP4cWmvZwAAu9opvQ
	(envelope-from <stable+bounces-211217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:14:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A51F6517F
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 11:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45AE380A177
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCA8362129;
	Thu, 22 Jan 2026 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KKMiHIh0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56F017B418;
	Thu, 22 Jan 2026 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076469; cv=none; b=cg+VtsMjLVlx2RBAtMkXrwwsWB6nin0LMGQyOKkK52dNrzgC3YIEan0sP/lwBvhGOf7MkXBGuIysAH1VMXpdOxwm6nUkGxZIsbNpjJmdV3p0HHtm2M1+CumjRaOO1JBjjVBvt1EBqDpoIsAtrRN0Y2FEtZCX0yTx8HbQ4AMKokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076469; c=relaxed/simple;
	bh=qDFRoSolpCrXVZeKn+ruAlpM5zDryWsQ+UEokS3Y4Kc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TD/v6mibu1bfUA6mhiKE7O/MvOVztj0npLqZantcTP7oI2W+nDFGdBj4nPaC+AZaANT7IL5k9oidg5t2q0yGOQD9N1cFX4ZONrzB+qnZri1kLwegxFIixxgAyFIH0C7JaQMziM/NhxlPem+oGQcX9CMWloQzGhuLSdLbwee76WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KKMiHIh0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769076467; x=1800612467;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qDFRoSolpCrXVZeKn+ruAlpM5zDryWsQ+UEokS3Y4Kc=;
  b=KKMiHIh01+oIiUvFY5aHDeacLncx2ggw3FtNdiHPvr6JjNjdk5HUXJ0R
   L51w/1ysfgEl5PlIwohdvFtRj+yE0ROs6ucg8rOJzSYF9i6w9bYJt26kJ
   eBV5Grn/AjA18g6l/N9Q+C113ZCyPV9f2vFo8wZbJLdc1IVXaOU6kwyve
   +DlbvbOiUKZ8pkNupvI07lhGdVxDw6gk3Bh2PpzJPSEuqrL7gg0MMbgbJ
   jGkmro2M2J2mIZHrZIBfDcrJZPMhDaNo3znOGwoEvNFhISKniRlJey230
   yqceYpsnMlAi/eaYTCkZurm2lGE/yCyYFf8iLcexhDdE6FBMpzAcuGoV6
   Q==;
X-CSE-ConnectionGUID: 4G3cTZ3XRNeMSqWvtEVaDQ==
X-CSE-MsgGUID: zfReiEMmQSi8RwbfYvZqnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="95789151"
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="95789151"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:07:46 -0800
X-CSE-ConnectionGUID: H5pMFzRBQbWYwdxzz4jPWA==
X-CSE-MsgGUID: RnzKkF8CTlePfZXR05rTvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,246,1763452800"; 
   d="scan'208";a="205945594"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 02:07:43 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Jan 2026 12:07:40 +0200 (EET)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, 
    linux-pci@vger.kernel.org, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Fix BAR resize rollback path overwriting ret
In-Reply-To: <20260121131417.9582-2-ilpo.jarvinen@linux.intel.com>
Message-ID: <dd05361e-39a2-b8f4-d30a-38ce96799982@linux.intel.com>
References: <20260121131417.9582-1-ilpo.jarvinen@linux.intel.com> <20260121131417.9582-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-574382717-1769076460=:1059"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-211217-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 3A51F6517F
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-574382717-1769076460=:1059
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 21 Jan 2026, Ilpo J=C3=A4rvinen wrote:

> The commit 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize
> rollback path") added BAR rollback to
> pci_do_resource_release_and_resize() in case of resize failure.
>=20
> On the rollback, pci_claim_resource() is called which can fail and the
> code is prepared for that possibility. pci_claim_resource()'s return
> value, however, overwrites the original value of ret so
> pci_claim_resource() will return incorrect value in the end (as

Hi Bjorn,

I noticed this should have been:

"pci_do_resource_release_and_resize() will return incorrect value in the=20
end ..."

(used a wrong function name).

Could you please adjust the commit message in your tree if it's not too=20
late yet?

I'm sorry about the extra hassle.

--
 i.

> pci_claim_resource() normally succeeds, in practice ret will be 0).
>=20
> Fix the issue by directly calling pci_claim_resource() inside the if ().
>=20
> Fixes: 337b1b566db0 ("PCI: Fix restoring BARs on BAR resize rollback path=
")
> Link: https://lore.kernel.org/linux-pci/aW_w1oFQCzUxGYtu@intel.com/
> Cc: stable@vger.kernel.org
> Reported-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 6e90f46f52af..9c374feafc77 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2556,8 +2556,7 @@ int pci_do_resource_release_and_resize(struct pci_d=
ev *pdev, int resno, int size
> =20
>  =09=09restore_dev_resource(dev_res);
> =20
> -=09=09ret =3D pci_claim_resource(dev, i);
> -=09=09if (ret)
> +=09=09if (pci_claim_resource(dev, i))
>  =09=09=09continue;
> =20
>  =09=09if (i < PCI_BRIDGE_RESOURCES) {
>=20

--8323328-574382717-1769076460=:1059--

