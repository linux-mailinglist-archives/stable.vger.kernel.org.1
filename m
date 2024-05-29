Return-Path: <stable+bounces-47639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494F8D362E
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 14:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 261671C23AA3
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 12:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BDE13FD7D;
	Wed, 29 May 2024 12:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSc2GBZe"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E713B295;
	Wed, 29 May 2024 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985168; cv=none; b=KNZ34SkFhpGesr2yIobdCUurZATLW1fp6et8Gbbr+Vrc79akhaR34UoUkWTMRxQNqNikPUnklJr+j/VyT2ibwc8mTEIhpAXP8HZeHG87H1DfQil89bBU0xgilDaSjLeCx/RbCTks6hUfcNPgA0NiJGLdfEyWqW8fD29GyHVmqmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985168; c=relaxed/simple;
	bh=Q7XR4d5Lrj5pDQVCv/L1AM1PWA6M5lN2V5ijcKX7tCg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Yg1PEYMnW097DD4bapE9KA/CHsfvQxPR9xv29SwV60Jo+3PPXYOqN3jxtTt1Z1rZL8nW/ycyAEKaYwjCB448oMrcgZIH0bexfrJw++HPwrAJvv7cvTtoi8upmPIXbVVaNtS1Vbac8xKPcTrKEgLitbHji6TyfYrKZjIqzmWlR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSc2GBZe; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716985167; x=1748521167;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Q7XR4d5Lrj5pDQVCv/L1AM1PWA6M5lN2V5ijcKX7tCg=;
  b=SSc2GBZe3tD1ysGSaEZ1++uCG8uh/KlXIBCBhASs1QEGLCkAuc18q89k
   Nod3sICHTmQcMrkM1K3iWGvRWhZRK3oIGlAAjs83GQc4EpKYS9vUz2jon
   XtuMvtSOzq5UnODk5OtgzGlJ73kuOqIJh9bxyYQlj27i5FNlipRWCFvyK
   6OcK/0iBxoWyGpybp3OU4icXewoi2FkgMHlaXLlklyT6+T8upBIfDZmpv
   1Uc/dhsBa21BE8oR0EjvmCMxzOGNLmvZdBmba3nVLbXT7hUV/eVRohiKS
   VRFlTI2RMY8cKnMs6tIxaUpiJ5W22ScPNgUC8+qsMNbM7fJj4m2q2sm0I
   w==;
X-CSE-ConnectionGUID: urB02GYuTdGJUmFIdw4iRw==
X-CSE-MsgGUID: 60YbeIiERX2iSYmGBAdpvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="23992696"
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="23992696"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:19:26 -0700
X-CSE-ConnectionGUID: VfQZ4YO9TU60VMKEsiXpDw==
X-CSE-MsgGUID: DKFaagwuRCKQRH+/OEknlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,198,1712646000"; 
   d="scan'208";a="40417159"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.149])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 05:19:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 29 May 2024 15:19:19 +0300 (EEST)
To: Alison Schofield <alison.schofield@intel.com>
cc: Davidlohr Bueso <dave@stgolabs.net>, 
    Jonathan Cameron <jonathan.cameron@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
    Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
    Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/pci: Convert PCIBIOS_* return codes to errnos
In-Reply-To: <ZlZYrsPfzAiFzNLM@aschofie-mobl2>
Message-ID: <78e5690b-832f-3da5-3500-141e9b155c09@linux.intel.com>
References: <20240527123403.13098-1-ilpo.jarvinen@linux.intel.com> <ZlZYrsPfzAiFzNLM@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1595479625-1716984315=:1108"
Content-ID: <bd1af136-005a-4183-897f-28bf7f3ddd1b@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1595479625-1716984315=:1108
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <52392403-976d-88e3-05bc-7ad38cd8884a@linux.intel.com>

On Tue, 28 May 2024, Alison Schofield wrote:

> On Mon, May 27, 2024 at 03:34:02PM +0300, Ilpo J=E4rvinen wrote:
> > pci_{read,write}_config_*word() and pcie_capability_read_word() return
> > PCIBIOS_* codes, not usual errnos.
> >=20
> > Fix return value checks to handle PCIBIOS_* return codes correctly by
> > dropping < 0 from the check and convert the PCIBIOS_* return codes into
> > errnos using pcibios_err_to_errno() before returning them.
>=20
>=20
> Do we ever make a bad decision based on the wrong rc value or is this
> a correction to the emitted dev_*() messaging, or both?

There is potential for bad decision.

Eg. cxl_set_mem_enable() it can return 0, 1 and rc that is currently=20
returning PCIBIOS_* return codes that are > 0).  devm_cxl_enable_mem()=20
then tries to check for >0 and <0 but the <0 condition won't match=20
correctly because PCIBIOS_* is not <0 but >0, devm_cxl_enable_mem() then=20
return 0 where it should have returned an error.

The positive "error code" from wait_for_valid(), cxl_dvsec_rr_decode(),=20
and cxl_pci_ras_unmask leaks out of .probe().

--=20
 i.

> > Fixes: ce17ad0d5498 ("cxl: Wait Memory_Info_Valid before access memory =
related info")
> > Fixes: 34e37b4c432c ("cxl/port: Enable HDM Capability after validating =
DVSEC Ranges")
> > Fixes: 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration =
in the core")
> > Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/cxl/core/pci.c | 30 +++++++++++++++---------------
> >  drivers/cxl/pci.c      |  2 +-
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 8567dd11eaac..9ca67d4e0a89 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -121,7 +121,7 @@ static int cxl_dvsec_mem_range_valid(struct cxl_dev=
_state *cxlds, int id)
> >  =09=09=09=09=09   d + CXL_DVSEC_RANGE_SIZE_LOW(id),
> >  =09=09=09=09=09   &temp);
> >  =09=09if (rc)
> > -=09=09=09return rc;
> > +=09=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09=09valid =3D FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
> >  =09=09if (valid)
> > @@ -155,7 +155,7 @@ static int cxl_dvsec_mem_range_active(struct cxl_de=
v_state *cxlds, int id)
> >  =09=09rc =3D pci_read_config_dword(
> >  =09=09=09pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(id), &temp);
> >  =09=09if (rc)
> > -=09=09=09return rc;
> > +=09=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09=09active =3D FIELD_GET(CXL_DVSEC_MEM_ACTIVE, temp);
> >  =09=09if (active)
> > @@ -188,7 +188,7 @@ int cxl_await_media_ready(struct cxl_dev_state *cxl=
ds)
> >  =09rc =3D pci_read_config_word(pdev,
> >  =09=09=09=09  d + CXL_DVSEC_CAP_OFFSET, &cap);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09hdm_count =3D FIELD_GET(CXL_DVSEC_HDM_COUNT_MASK, cap);
> >  =09for (i =3D 0; i < hdm_count; i++) {
> > @@ -225,7 +225,7 @@ static int wait_for_valid(struct pci_dev *pdev, int=
 d)
> >  =09 */
> >  =09rc =3D pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0),=
 &val);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09if (val & CXL_DVSEC_MEM_INFO_VALID)
> >  =09=09return 0;
> > @@ -234,7 +234,7 @@ static int wait_for_valid(struct pci_dev *pdev, int=
 d)
> > =20
> >  =09rc =3D pci_read_config_dword(pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0),=
 &val);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09if (val & CXL_DVSEC_MEM_INFO_VALID)
> >  =09=09return 0;
> > @@ -250,8 +250,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state =
*cxlds, u16 val)
> >  =09int rc;
> > =20
> >  =09rc =3D pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl)=
;
> > -=09if (rc < 0)
> > -=09=09return rc;
> > +=09if (rc)
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09if ((ctrl & CXL_DVSEC_MEM_ENABLE) =3D=3D val)
> >  =09=09return 1;
> > @@ -259,8 +259,8 @@ static int cxl_set_mem_enable(struct cxl_dev_state =
*cxlds, u16 val)
> >  =09ctrl |=3D val;
> > =20
> >  =09rc =3D pci_write_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, ctrl)=
;
> > -=09if (rc < 0)
> > -=09=09return rc;
> > +=09if (rc)
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09return 0;
> >  }
> > @@ -336,11 +336,11 @@ int cxl_dvsec_rr_decode(struct device *dev, int d=
,
> > =20
> >  =09rc =3D pci_read_config_word(pdev, d + CXL_DVSEC_CAP_OFFSET, &cap);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09rc =3D pci_read_config_word(pdev, d + CXL_DVSEC_CTRL_OFFSET, &ctrl)=
;
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> >  =09=09dev_dbg(dev, "Not MEM Capable\n");
> > @@ -379,14 +379,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d=
,
> >  =09=09rc =3D pci_read_config_dword(
> >  =09=09=09pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
> >  =09=09if (rc)
> > -=09=09=09return rc;
> > +=09=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09=09size =3D (u64)temp << 32;
> > =20
> >  =09=09rc =3D pci_read_config_dword(
> >  =09=09=09pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(i), &temp);
> >  =09=09if (rc)
> > -=09=09=09return rc;
> > +=09=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09=09size |=3D temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> >  =09=09if (!size) {
> > @@ -400,14 +400,14 @@ int cxl_dvsec_rr_decode(struct device *dev, int d=
,
> >  =09=09rc =3D pci_read_config_dword(
> >  =09=09=09pdev, d + CXL_DVSEC_RANGE_BASE_HIGH(i), &temp);
> >  =09=09if (rc)
> > -=09=09=09return rc;
> > +=09=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09=09base =3D (u64)temp << 32;
> > =20
> >  =09=09rc =3D pci_read_config_dword(
> >  =09=09=09pdev, d + CXL_DVSEC_RANGE_BASE_LOW(i), &temp);
> >  =09=09if (rc)
> > -=09=09=09return rc;
> > +=09=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09=09base |=3D temp & CXL_DVSEC_MEM_BASE_LOW_MASK;
> > =20
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index e53646e9f2fb..0ec9cbc64896 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -540,7 +540,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> > =20
> >  =09rc =3D pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> >  =09if (rc)
> > -=09=09return rc;
> > +=09=09return pcibios_err_to_errno(rc);
> > =20
> >  =09if (cap & PCI_EXP_DEVCTL_URRE) {
> >  =09=09addr =3D cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> > --=20
> > 2.39.2
> >=20
>=20
--8323328-1595479625-1716984315=:1108--

