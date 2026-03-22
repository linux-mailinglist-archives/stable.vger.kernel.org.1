Return-Path: <stable+bounces-227841-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP8eLBcSwGnMDQQAu9opvQ
	(envelope-from <stable+bounces-227841-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:00:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BD62E9DEF
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 17:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAF10300C268
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D4366077;
	Sun, 22 Mar 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jl1sRMqS"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AD35949;
	Sun, 22 Mar 2026 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774195216; cv=none; b=hgaPleRRA/vfmIzvNNSfWJLW+MN9QX+4xGKLbaD/oc4WyNr6xoophg48Y75/osKLQsQb/yHY1AgKUpY3aVQUdR6/9V1BxepUBNCKM7yaOUIn1Ks/3ScBPiLvUvuc/eq3c9IwbdNanRLDDpAkRTm5E1QKGoQAkAJeRUI9ieo5G7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774195216; c=relaxed/simple;
	bh=ApCESnigxH0goBD3RU+0/3TO7ANuTmTE8kJNXL69mtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jmhsn37e5VI1YRIfCEDFMTQW+xM1SBUxsNH33jqFqKVTRRl2T6FNE/ckpulvh/IF1tJzKe+O7VXyU0EDsTVELHE8sMgVRc7H5wjsKpk99ZnGujmplTUxbZXTp+MbtMgnx2LYCPiYzI9ehL8R/KeI2BTwvZpdieec9Pvr1yDkOx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Jl1sRMqS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AA4F440E0194;
	Sun, 22 Mar 2026 16:00:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QfoaoZurdJ5w; Sun, 22 Mar 2026 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1774195201; bh=PX3YdSPDhhzBUTeimujvOfeWkEHH4ix9GRctWDiB740=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jl1sRMqSD/+k5aIosWQqgesBOru83CG9ptoRZN6rFBQe8kLf/xw84uvyHAlfba55d
	 MHRVFgUeA1djUTkHAZjwTh4EDOXXTvAA7pxLRofvCwcTet8VJN9wgyTjyKxJTqPgNB
	 D2Ya6qW3+j1SrHdEjLKVKxR9/z7VPNwVlfGFNIhv3cg7PlUitKocOFd78hiXCfM56S
	 eodDCy7InE9o+Wxtr+Uxj3/pBS0trxO+fyL5V4fYl5BIz6PkwqUMRthLhjyWCoZfb5
	 ZSfXf7pJHslWkyIyQq3cefvSvdFAQ2CHBZqRFgEUWseEsv1b3Q98Wrj1BnoLvQyUSX
	 +6f+aFW8d8gGTq3hv58cSfWMZqGM7pPjzBELc2jZGeS+iUSGnOUbBzPXZfk/AXU5Bg
	 TE+X+5ViLc9d78nSNsK5Ouv1mGIS64+euMga958DeUaXPxh37bxuCf5Ss8KktxYK7p
	 rvsO9LQoCOKagrHYbmxGS0kuRPAuqu/Kc0uy0B1ZOs0Fi/6XZCEOAW6kyH7VTuzlUE
	 FNdPEvdl+Lvs610Sman4W4LWcu3cI+v+avGItFCVlc5+QmIPLaM2rsB8asrQO0geOB
	 eVXrjpk1esl9GK29wOXMTbTV2arou1FlcB6GtMm34eI4BUCzm9Fzr4W+vweEhZlgBt
	 GGVIWPK7eIDrEOkKDbj7odOs=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 0FB7D40E0140;
	Sun, 22 Mar 2026 15:59:55 +0000 (UTC)
Date: Sun, 22 Mar 2026 16:59:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] EDAC/versalnet: Release reference to remoteproc
 device in remove
Message-ID: <20260322155947.GAacAR8z1cKR7pG1it@fat_crate.local>
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131134.1684691-1-ptsm@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260322131134.1684691-1-ptsm@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227841-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fat_crate.local:mid]
X-Rspamd-Queue-Id: 28BD62E9DEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 06:11:34AM -0700, Prasanna Kumar T S M wrote:
> The rproc reference acquired via rproc_get_by_phandle() during probe
> is not released in mc_remove(), causing a reference count leak. Add
> the missing rproc_put() call.
> 
> Fixes: d5fe2fec6c40d ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
> ---
>  drivers/edac/versalnet_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index f70243bc8a7a..28f5036f381c 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -958,6 +958,7 @@ static void mc_remove(struct platform_device *pdev)
>  	cdx_mcdi_finish(priv->mcdi);
>  	unregister_rpmsg_driver(&amd_rpmsg_driver);
>  	rproc_shutdown(priv->mcdi->r5_rproc);
> +	rproc_put(priv->mcdi->r5_rproc);
>  }
>  
>  static const struct of_device_id amd_edac_match[] = {
> -- 

Why is this a separate patch and not part of patch 1?

Also, do you have the hardware to test this on? IOW, have you tested those
patches?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

