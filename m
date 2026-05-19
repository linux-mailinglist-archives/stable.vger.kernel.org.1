Return-Path: <stable+bounces-249641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFfmNamSDGrfjAUAu9opvQ
	(envelope-from <stable+bounces-249641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:41:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536F0582879
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5086B30A4E93
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256B83EA953;
	Tue, 19 May 2026 16:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0bQA3Fx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD126FA60;
	Tue, 19 May 2026 16:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208546; cv=none; b=op4P5qDLiytyPrRbMzg+40B2Tzha6iGWzZgnVBgpiOtugfRmUeFmDHG4j2skQ7VZsb31QDmq80cHRZ52DNfm5kYIl9fSIxnQtKpx7OnEmuli1OCdFNFoEeRkFTIcsXGaIHzIA/CWJ9xD2ICNBk/UjTu/b59S20HHng1L4yF6CDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208546; c=relaxed/simple;
	bh=nGSKoZMzIr9BKzFNVz4QVlZQ9FzIPaO4AomP3ItvBho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ud/Te4a7eznVGJpm+HV+HJXaX2qqDTHuckxc7MnaMo/Hu7zuzv8XjzIx5GaZ8MKFQeRVEoVgpxpoGfYv1I2avXO7cwdCLv17lzAj50ZoDM4g1h4tZ+YoAZ2s5PN64W/E0Qo287gMdo42yL1Btj0Jd1+iLTBdJK7HC4qOlqR0wIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0bQA3Fx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779208545; x=1810744545;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=nGSKoZMzIr9BKzFNVz4QVlZQ9FzIPaO4AomP3ItvBho=;
  b=n0bQA3Fx6U3YmeO3dhG7YtNwk1okreVRONvAv91L6zqZMHFcl18MZ1b7
   VrnKHVjeTRWEinaJuZdLCAk3vDbKYhOdgm5fctx28oQ/XJPCXDd01zI0b
   d2qT/pQlsyl9Bc6WjP2uHkgGORZNTcKj0s/zHSs71bLDiH5f1Dqd6s+6B
   OayN+Ervn0EU13b+Go9oT1k9HigbeUxTujSriXP3OaQFBImw/NkqV1hwQ
   GDLltRbENzdXqDnOGajBYzZicZ1PJADMyCJAhYdy22Q1CRA+u7YhEoIrF
   jCYW0AWjrBVNkdXrNrERxquWPR4TUCdHsAGeYj3YCGmI3bn42ZjbB4Nd+
   A==;
X-CSE-ConnectionGUID: hVUBHp0ATW6KhDpXuSqa5w==
X-CSE-MsgGUID: sGFN5TcsS1KLBHs1jDI0+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="90671265"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="90671265"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 09:35:45 -0700
X-CSE-ConnectionGUID: T8vq8c/3Ts+fWuimYi1eYA==
X-CSE-MsgGUID: cInvoIgvRgup/bZMehVkKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263337386"
Received: from unknown (HELO [10.241.243.24]) ([10.241.243.24])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 09:35:45 -0700
Message-ID: <c47199b1f71b1afbeb6fa982c5a71a240e2703ea.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86/intel/tpmi: Fix memory leak in mem_write()
 error path
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: ZhaoJinming <zhaojinming@uniontech.com>, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Tue, 19 May 2026 09:35:43 -0700
In-Reply-To: <20260519082136.2999917-1-zhaojinming@uniontech.com>
References: <20260519082136.2999917-1-zhaojinming@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas.pandruvada@linux.intel.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249641-lists,stable=lfdr.de];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,linux.intel.com:mid,uniontech.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+]
X-Rspamd-Queue-Id: 536F0582879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-05-19 at 16:21 +0800, ZhaoJinming wrote:
> In mem_write(), when the IS_ALIGNED() check fails, the function
> returns
> -EINVAL directly without freeing the 'array' allocated by
> parse_int_array_user(). This causes a memory leak.
>=20
> Other error paths in the same function correctly use 'goto
> exit_write'
> to free the array before returning. Fix this inconsistency by using
> the same pattern for the alignment check.
>=20

Thanks. I see Ilpo suggested using cleanup.h. Let me know if you have
issue in doing that.

-Srinivas

> Fixes: 8e0a2fc68ec3 ("platform/x86/intel/tpmi: Use 32 bit aligned
> address for debugfs mem write")
> Cc: stable@vger.kernel.org
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---
> =C2=A0drivers/platform/x86/intel/vsec_tpmi.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/platform/x86/intel/vsec_tpmi.c
> b/drivers/platform/x86/intel/vsec_tpmi.c
> index 16fd7aa41f20..2a428bfcb209 100644
> --- a/drivers/platform/x86/intel/vsec_tpmi.c
> +++ b/drivers/platform/x86/intel/vsec_tpmi.c
> @@ -495,8 +495,10 @@ static ssize_t mem_write(struct file *file,
> const char __user *userbuf, size_t l
> =C2=A0	addr =3D array[2];
> =C2=A0	value =3D array[3];
> =C2=A0
> -	if (!IS_ALIGNED(addr, sizeof(u32)))
> -		return -EINVAL;
> +	if (!IS_ALIGNED(addr, sizeof(u32))) {
> +		ret =3D -EINVAL;
> +		goto exit_write;
> +	}
> =C2=A0
> =C2=A0	if (punit >=3D pfs->pfs_header.num_entries) {
> =C2=A0		ret =3D -EINVAL;

