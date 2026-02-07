Return-Path: <stable+bounces-214753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN58Ol7uhmnwSAQAu9opvQ
	(envelope-from <stable+bounces-214753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 08:48:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 957A510527E
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 08:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC1323020D62
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6C2E0901;
	Sat,  7 Feb 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZdoIbJs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D523F9FB;
	Sat,  7 Feb 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770450518; cv=none; b=YV8ysOzPv0HiWSGlOlwUQZB2YuLWnFxcaRAojbun+XCDSHHwDU0fjjbTlaD11E/Orjrp41EVfkpqhkSE2AADWn8ryyBzPJoVIztGwJKRXd0Jwu4YQrHJF9XMzNfaAczxq9yxQgDXxHz1BFoaiKJ101KXlFazKmSPH0bCHZ6psuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770450518; c=relaxed/simple;
	bh=pIrG+JsSkTz4RATJTcSOOAJU96LAD9vvrCc2FrYiDXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGbiJ3rN1J8MxBavrs+UiyBYt3/FVBYZRCUNcx+5HNub/hrKKEh4LZ6rclCmL4dSc4ihUQhGk2ZjgvYP7Hm3zCPhaM/JYvpDwNpkmI654sNM08J/89XoyXautxMgFWTJCK0m4aAL4XrWwmistofl8jguIIy/srY/GXOxL4AAwYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZdoIbJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418D4C116D0;
	Sat,  7 Feb 2026 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770450517;
	bh=pIrG+JsSkTz4RATJTcSOOAJU96LAD9vvrCc2FrYiDXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZdoIbJsUzEWLhy2SyV7Wz6sKO/O+vod+MtlCxEFDb15mYNdeoL4qdAKSC6KyGPqg
	 dXX0I42SJIp96QyubG5DXNtBOG0q/cx/WvyuSKRWEzLfJcmewiPUoRUquHGGstEmv9
	 7OR4pIeD0LnWmtBAmy5YjCHgZ3ELo9BPQQQvOezw=
Date: Sat, 7 Feb 2026 08:48:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Hodges <git@danielhodges.dev>
Cc: Prasanth Ksr <prasanth.ksr@dell.com>, Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@dell.com>,
	Divya Bharathi <divya.bharathi@dell.com>,
	Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: fix kobject leak on
 populate failure
Message-ID: <2026020715-spilt-cupped-aeab@gregkh>
References: <20260206231642.30051-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206231642.30051-1-git@danielhodges.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,danielhodges.dev:email]
X-Rspamd-Queue-Id: 957A510527E
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 06:16:42PM -0500, Daniel Hodges wrote:
> When populate_enum_data(), populate_int_data(), populate_str_data(),
> or populate_po_data() fails after a successful kobject_init_and_add(),
> the code jumps to err_attr_init without calling kobject_put() on
> attr_name_kobj, leaking the kobject and its associated memory.
> 
> Add the missing kobject_put() call before the goto to properly release
> the kobject on error.
> 
> Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> index f5402b714657..d9f6d24c84d6 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -497,6 +497,7 @@ static int init_bios_attributes(int attr_type, const char *guid)
>  		if (retval) {
>  			pr_debug("failed to populate %s\n",
>  				elements[ATTR_NAME].string.pointer);
> +			kobject_put(attr_name_kobj);
>  			goto err_attr_init;
>  		}
>  

The "larger" problem with this driver is its use of raw kobjects.  No
driver should be doing that, it is hiding all of this information from
userspace tools by doing so, and there's loads of race conditions
happening with the creation of these files.  It should be fixed by just
using normal device attributes and not attempting to custom create
kobjects by hand like this (as it is very easy to get things wrong, as
this patch shows.)

thanks,

greg k-h

