Return-Path: <stable+bounces-125888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E465A6DA2E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C63416F9B3
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 12:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B125E83B;
	Mon, 24 Mar 2025 12:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCEeFs0k"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8F25D1E0;
	Mon, 24 Mar 2025 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819775; cv=none; b=o+oNUue/S0KCbSVxJ/PhwlNf/phXJltzIDrNewkxohS1l+G3rBoXqShlpZa3DnI5d7NFzmaD53MjNKH+5DL/qo+oAaoC2vL1W6To53ivS8+70yCE/l3wzIafAHSNYgb+Jn5GtB2OaZP9h4vEOKQLJXQpSho3jxkFaPQIeAJE6vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819775; c=relaxed/simple;
	bh=lD2QrR4jBho1I+YBuwsNAka+Uakp6QQa6Y/2YEYwP+Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FA2mpzMIMnJkRgxEEtBgSPpn12ijldPgLvs4h+WyUnL+yajzXER/5rgND7TGJnLJkgL3ULsUVRb/fuNKqRDLK7RIiHwHe46cdD6tDGlJr3xX4rBudGr6Pyxz2ohLSeULz2Ff+KZE7C/tWn7DWxUP8yaUTDNUjuCLpAoOFXalbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCEeFs0k; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742819773; x=1774355773;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lD2QrR4jBho1I+YBuwsNAka+Uakp6QQa6Y/2YEYwP+Q=;
  b=WCEeFs0kBrNxQmLpNozUiPWB50C9uTsJGj7X67xD4fd8RIiZH7AA30J7
   303PVnob63qHO0qytITmeTcyumcidrLox9OcQZmMtWThA7Md1TVgne8oZ
   uaWS56CA8JEXt88+KjJwPH8rhpO4E+moRC9A80lczq9DdrUeYAlh6dJ5O
   cEvnrsuvFSx6/Lf3kRZtdawQnOyGHDN6XV9aObqkD3E6kYhn2krVFDvyS
   R4iHTTSp5w801e+EbP7uJRJLjZp9ueVNoFy7s6CtFdEt5CA9YGLRXHrb1
   zgFmxfmszmUko5NL6vB1EkdHT0Flrw5km9zDPYFK7OK9EMW5ksldwkwTt
   w==;
X-CSE-ConnectionGUID: 25k21ZTbRGC7HspSZPFqoQ==
X-CSE-MsgGUID: aQW2Hp9RRmOImSFOvk0dBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11383"; a="43176803"
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="43176803"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:36:12 -0700
X-CSE-ConnectionGUID: YCO7vppuSO+/zxdZRAr5zA==
X-CSE-MsgGUID: DsKtSZY2TlS+HOTugdosbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,272,1736841600"; 
   d="scan'208";a="147238892"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.251])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2025 05:36:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Mar 2025 14:36:05 +0200 (EET)
To: Seyediman Seyedarab <imandevel@gmail.com>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Vlastimil Holer <vlastimil.holer@gmail.com>, crok <crok.bic@gmail.com>, 
    Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>, 
    Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: disable ACPI fan access
 for T495* and E560
In-Reply-To: <20250324012911.68343-1-ImanDevel@gmail.com>
Message-ID: <f4567e02-8478-682f-0947-765ef9258ab5@linux.intel.com>
References: <20250324012911.68343-1-ImanDevel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 23 Mar 2025, Seyediman Seyedarab wrote:

Hi,

Thanks for looking into reaching conclusion for this issue.

> From: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
> 
> The bug was introduced in commit 57d0557dfa49 ("platform/x86:

the commit

> thinkpad_acpi: Add Thinkpad Edge E531 fan support") which adds a new
> fan control method via the FANG and FANW ACPI methods.
> 
> T945, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
> fang_handle and fanw_handle are not NULL) but they do not actually work,
> which results in the dreaded "No such device or address" error. 

Please put the first paragraph about the commit 57d0557dfa49 here now that 
you've state what the problem/bug is first. You can make them to be one 
joined paragraph.

> Fan access
> and control is restored after forcing the legacy non-ACPI fan control
> method by setting both fang_handle and fanw_handle to NULL.
> 
> The DSDT table code for the FANG+FANW methods doesn't seem to do anything
> special regarding the fan being secondary.
> 
> This patch adds a quirk for T495, T495s, and E560 to make them avoid the
> FANG/FANW methods.

We avoid phrases like "This patch ...", so start with "Add a quirk ..."
Also, this should be before "Fan access ..." sentence to make this 
description more logical (again make them to be part of a same paragraph).

> Cc: stable@vger.kernel.org
> Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support")
> Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219643

I'd prefer these tags to be in this order:

Reported-by:
Fixes:
Closes:
Cc: stable@vger.kernel.org

ss it's a bit more logical.

> Tested-by: crok <crok.bic@gmail.com>
> Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>

Did these two person either give you those Tested-by tags or gave 
you green light to add theirs Tested-by tags? I don't see the tags given 
in the bugzilla entry. If they didn't yet, please ask if they're fine with 
you adding their Tested-by tags.

In kernel development, in general, we're more than happy credit people who 
invested their time in testing changes but that being said, we don't 
invent Tested-by tags just from the fact that we know somebody has tested 
a patch.

When respinning v3, please remember to add Kurt's Reviewed-by tag too as 
maintainer's tools only automatically collect them for the most recent 
version so when sending the next version, you need to add them into the 
submission.

> Signed-off-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
> Co-developed-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
> ---
> Changes in v2:
> - Added the From: tag for the original author
> - Replaced the Co-authored-by tag with Co-developed-by
> - Cc'd stable@vger.kernel.org
> - Removed the extra space inside the comment
> - Dropped nullification of sfan/gfan_handle, as it's unrelated to
>   the current fix
> 
> Kindest Regards,
> Seyediman
> 
>  drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d8df1405edfa..27fd67a2f2d1 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr_group = {
>  #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
>  #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
>  #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
> +#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
>  
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
> @@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
>  	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
>  	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
> +	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
> +	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
> +	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
>  };
>  
>  static int __init fan_init(struct ibm_init_struct *iibm)
> @@ -8874,6 +8878,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
>  		tp_features.fan_ctrl_status_undef = 1;
>  	}
>  
> +	if (quirks & TPACPI_FAN_NOACPI) {
> +		/* E560, T495, T495s */
> +		pr_info("Ignoring buggy ACPI fan access method\n");
> +		fang_handle = NULL;
> +		fanw_handle = NULL;
> +	}
> +
>  	if (gfan_handle) {
>  		/* 570, 600e/x, 770e, 770x */
>  		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
> 

The code change itself looks fine.

-- 
 i.



