Return-Path: <stable+bounces-151736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74EBAD08D8
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 21:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70903172384
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 19:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B55215073;
	Fri,  6 Jun 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m1GcmQ1c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF2323D;
	Fri,  6 Jun 2025 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749239694; cv=none; b=ba8k3FZkVliW+er5ll50rT1A3SQkRk0dVcFQBh3KGh/WVmmBBxNqh8dOwWDXmJY1FWxMaogJOk/hPBX0tteGjbvFfyPJCzAVg2cqaS48Pla9UcAPVVa8FWoddJ6jkiwhfuYqChGXPHQZczXFTs+hP/hyDnfab3Hvv393cHh9ZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749239694; c=relaxed/simple;
	bh=M2U7m45XzX5ma0cIa1VZzGqbw8q13+6NTCkBPcrGIf0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZLEjZdlXVT2Sca3nvIr/7XCfdM2pgbLuHskQMeJuB8+1Pe0wyqhnTWZ3nZHQNFtpbm6aOLAgKyC+uGHL3ZqLuVguE+BWmRETS9MM0lSB8B/qz5rcRpN0FKokKXkeP/CQPypx4srYAHQOuYK2XCW8GY/xAGAVByZ0S5ufVtmFOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m1GcmQ1c; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749239692; x=1780775692;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=M2U7m45XzX5ma0cIa1VZzGqbw8q13+6NTCkBPcrGIf0=;
  b=m1GcmQ1cdGyeZWNTWnYqqZ2/6BG8ncqglfUYYhbnAMHxMf/XmrQLEjY0
   6/RMRcNru7AtBgt1n2VZUUwWmrLSIRaBnkzzgs2DzJr4o9+EhiTAYMT1i
   +Br9gP1piQsRXs0XPmj/CyhEcit6fEaOu8wPaU8o0unNeg2Kjn3+qqkP7
   EINbH/owxXAU977h1U8YIdWLMb0e3q40LTh0oDAX/8d5ew2ANJcMhznLf
   pSlUMDGZcyF3JU7u/xOwQxNksfZbDXoP61ZBEAeP20WwCVKza9HELhrWs
   6gweSEXqXtaTSjxiEy8dmA+xgrq7w+ba+t/nMJM9zU0Qd3xZn22gu0Br5
   A==;
X-CSE-ConnectionGUID: qicOaq4FRhaI6wF+ddjTlQ==
X-CSE-MsgGUID: HP928RFPTbqaHGh+/JkISA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="50510229"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="50510229"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 12:54:51 -0700
X-CSE-ConnectionGUID: ZYCPfifOQXyBmXDLu+48CQ==
X-CSE-MsgGUID: G8XK7oUiQQqSuBsF/p3fVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="150747948"
Received: from aschofie-mobl2.amr.corp.intel.com ([10.124.222.251])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 12:54:50 -0700
Message-ID: <b98363d420ec1862ce5a30b49d4d094bebd847b1.camel@linux.intel.com>
Subject: Re: [PATCH v3 02/11] platform/x86/intel/pmt: crashlog binary file
 endpoint
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>, 
 platform-driver-x86@vger.kernel.org, intel-xe@lists.freedesktop.org, 
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 lucas.demarchi@intel.com,  rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com,  simona@ffwll.ch
Cc: stable@vger.kernel.org
Date: Fri, 06 Jun 2025 12:54:49 -0700
In-Reply-To: <20250605184444.515556-3-michael.j.ruhl@intel.com>
References: <20250605184444.515556-1-michael.j.ruhl@intel.com>
	 <20250605184444.515556-3-michael.j.ruhl@intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 14:44 -0400, Michael J. Ruhl wrote:
> Usage of the intel_pmt_read() for binary sysfs, requires an allocated
> endpoint struct. The crashlog driver does not allocate the endpoint.
>=20
> Without the ep, the crashlog usage causes the following NULL pointer
> exception:
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000000

Okay, there it is. I'll still review the rest to see if the endpoint is eve=
n
needed, but if not then you could drop this patch too.

David

> Oops: Oops: 0000 [#1] SMP NOPTI
> RIP: 0010:intel_pmt_read+0x3b/0x70 [pmt_class]
> Code:
> Call Trace:
> =C2=A0<TASK>
> =C2=A0? sysfs_kf_bin_read+0xc0/0xe0
> =C2=A0kernfs_fop_read_iter+0xac/0x1a0
> =C2=A0vfs_read+0x26d/0x350
> =C2=A0ksys_read+0x6b/0xe0
> =C2=A0__x64_sys_read+0x1d/0x30
> =C2=A0x64_sys_call+0x1bc8/0x1d70
> =C2=A0do_syscall_64+0x6d/0x110
>=20
> Add the endpoint information to the crashlog driver to avoid the NULL
> pointer exception.
>=20
> Fixes: 416eeb2e1fc7 ("platform/x86/intel/pmt: telemetry: Export API to re=
ad
> telemetry")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
> =C2=A0drivers/platform/x86/intel/pmt/crashlog.c | 9 +++++++--
> =C2=A01 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/pmt/crashlog.c
> b/drivers/platform/x86/intel/pmt/crashlog.c
> index 6a9eb3c4b313..74ce199e59f0 100644
> --- a/drivers/platform/x86/intel/pmt/crashlog.c
> +++ b/drivers/platform/x86/intel/pmt/crashlog.c
> @@ -252,6 +252,7 @@ static struct intel_pmt_namespace pmt_crashlog_ns =3D=
 {
> =C2=A0	.xa =3D &crashlog_array,
> =C2=A0	.attr_grp =3D &pmt_crashlog_group,
> =C2=A0	.pmt_header_decode =3D pmt_crashlog_header_decode,
> +	.pmt_add_endpoint =3D intel_pmt_add_endpoint,
> =C2=A0};
> =C2=A0
> =C2=A0/*
> @@ -262,8 +263,12 @@ static void pmt_crashlog_remove(struct auxiliary_dev=
ice
> *auxdev)
> =C2=A0	struct pmt_crashlog_priv *priv =3D auxiliary_get_drvdata(auxdev);
> =C2=A0	int i;
> =C2=A0
> -	for (i =3D 0; i < priv->num_entries; i++)
> -		intel_pmt_dev_destroy(&priv->entry[i].entry,
> &pmt_crashlog_ns);
> +	for (i =3D 0; i < priv->num_entries; i++) {
> +		struct intel_pmt_entry *entry =3D &priv->entry[i].entry;
> +
> +		intel_pmt_release_endpoint(entry->ep);
> +		intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static int pmt_crashlog_probe(struct auxiliary_device *auxdev,


