Return-Path: <stable+bounces-213259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOv+NlUIgmmCOQMAu9opvQ
	(envelope-from <stable+bounces-213259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:38:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956BDAAF9
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 464133079A56
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F1E3A4F55;
	Tue,  3 Feb 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQfEhumb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557A3164D6
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129489; cv=none; b=t3FeFydMgAGczc7JuPJKoo6NbKqx4/dxCf4cUHL5irDFM6X8qyFbtTWt7YrOusG3q3MZ9BlvnN3KeOF5c5/e2KUdvOO3suFGWewOVPeKu7itsl8oqMDGQPyOgLPu1UE4LQlDUcXnjv/2k32KNKPOJFe09ukwq137GWWQLpklAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129489; c=relaxed/simple;
	bh=WReFpPHX/vOfyDdWwl+g6030jPg0rzk3MFrbuFVJL+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vn9Jl0o0HEQspOSMfeSif2fGIJ+sOgIPyYCQpRTNKjC74HZB6+bre+9sR+hONIecJQkvdCH+9pVHUGHRi2SozmEFY2MGRpl26tdA2g7vL286Wa256rl34HYPA9KPh3IZdOw6Z4WxH2XaKDkfdITeWXKjEighkFbU5Cx7+iUbTj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IQfEhumb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FF7C116D0;
	Tue,  3 Feb 2026 14:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770129489;
	bh=WReFpPHX/vOfyDdWwl+g6030jPg0rzk3MFrbuFVJL+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQfEhumb/ciC1MHWGF+rAc1S2omrVYW18Z/irQOhTrpBbTDSFmYWZnMXijVTH8fQZ
	 NxjEGhodBbtAAEgIHNZ/gdh3tMp2qGW4ydV5WG4M9EVBs0OP6JMCjkVflmQdXaqFkz
	 fl8DOOty7IFV7xgiqHkETccXNawdkLUtMUC+uVak=
Date: Tue, 3 Feb 2026 15:38:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@sysophe.eu>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>, stable@vger.kernel.org,
	Dave Airlie <airlied@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: NV04, 6.18.8 crashes on NULL pointer dereference
Message-ID: <2026020353-running-unhelpful-fbd2@gregkh>
References: <20260201185705.0c5364f1@hemera.lan.sysophe.eu>
 <20260201231451.1ef0128c@hemera.lan.sysophe.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201231451.1ef0128c@hemera.lan.sysophe.eu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-213259-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 5956BDAAF9
X-Rspamd-Action: no action

On Sun, Feb 01, 2026 at 11:14:51PM +0100, Bruno Prémont wrote:
> Bisect completed.
> 
> The offending patch is:
> commit 448a2071a843831fe5fa71545cbfa7e15ee8966d (HEAD)
> Author: Lyude Paul <lyude@redhat.com>
> Date:   Wed Jan 21 14:13:10 2026 -0500
> 
>     drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit)
>     
>     commit 604826acb3f53c6648a7ee99a3914ead680ab7fb upstream.
>     
>     Apparently we never actually filled these in, despite the fact that we do
>     in fact technically support atomic modesetting.
>     
>     Since not having these filled in causes us to potentially forget to disable
>     fbdev and friends during suspend/resume, let's fix it.
>     
>     Signed-off-by: Lyude Paul <lyude@redhat.com>
>     Cc: stable@vger.kernel.org
>     Reviewed-by: Dave Airlie <airlied@redhat.com>
>     Link: https://patch.msgid.link/20260121191320.210342-1-lyude@redhat.com
>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
>  drivers/gpu/drm/nouveau/nouveau_display.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> 
> It landed in 6.18.8. Seems like not all chip generations are ready for
> atomic modesetting.

Is this also a problem in 6.19-rc?

thanks,

greg k-h

