Return-Path: <stable+bounces-238246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAlbMoNo4GllgQAAu9opvQ
	(envelope-from <stable+bounces-238246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:41:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501340A34E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D990F30A4A8C
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3CC331A7E;
	Thu, 16 Apr 2026 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KzcjidpC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A70248F64;
	Thu, 16 Apr 2026 04:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776314490; cv=none; b=XcG7vgcop9Vxvm0urBhVoivlYshj7oPAIbVC9FzvAyurA5LOWAcGjaDnj4lUtq3gPMhv0wca4CnJ6s1tUck5NrbssSZj1xchYkkTVLkJAikbv/Qw02/X5eCd9J7JK29Rx7j+xfxq4SWB4uiaZiwM7mJoJ0W3+yEqDuJXO8kAkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776314490; c=relaxed/simple;
	bh=Nx3FPp307bRF+OmCf8vNAag4l0D0r7KGIDqlOm4AOTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjxesWgLqvBEyP2z1TfGi+xmEfugE8CrtfsRUNs2GKVcSIkAZ2smY5Bz5ZnRudLMXYWeG61Eqx6cCTGttG4Jt5U7XU9G2ADVtXB1oRiVYywseeIM2i0XcdbcDgJ/mQ0pTVEFMflFpFQ/9eoQCyoSkR8D/w7+egzSCNWGuvU5wkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KzcjidpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66387C2BCAF;
	Thu, 16 Apr 2026 04:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776314490;
	bh=Nx3FPp307bRF+OmCf8vNAag4l0D0r7KGIDqlOm4AOTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzcjidpCjKSDvmec513yuSootriZjtm3YAi7IRphMf4UD9s9ybxcIuebVzRmpN7CN
	 zcdoRJMDXZn5TW8iAmlQS/054jjinA8ZE1kd59n1a2iJod+IIAx33jeYK27xonYGXw
	 wZIMPl1V6o8bSof9jOvHOADwOCzrPJBG56yt8edY=
Date: Thu, 16 Apr 2026 06:40:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Will Deacon <will@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm_pmu: acpi: fix reference leak on failed device
 registration
Message-ID: <2026041603-guts-crested-ef76@gregkh>
References: <20260415174159.3625777-1-lgs201920130244@gmail.com>
 <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_WmuauLJ3xDKqh@J2N7QTR9R3>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238246-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,arm.com,lists.infradead.org,vger.kernel.org];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 7501340A34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 07:19:06PM +0100, Mark Rutland wrote:
> Hi,
> 
> Thanks for the patch, but from a quick skim, I don't think this is the right
> fix.
> 
> Greg, I think we might want to rework the core API here; question for
> you at the end.
> 
> On Thu, Apr 16, 2026 at 01:41:59AM +0800, Guangshuo Li wrote:
> > When platform_device_register() fails in arm_acpi_register_pmu_device(),
> > the embedded struct device in pdev has already been initialized by
> > device_initialize(), but the failure path only unregisters the GSI and
> > does not drop the device reference for the current platform device:
> > 
> >   arm_acpi_register_pmu_device()
> >     -> platform_device_register(pdev)
> >        -> device_initialize(&pdev->dev)
> >        -> setup_pdev_dma_masks(pdev)
> >        -> platform_device_add(pdev)
> > 
> > This leads to a reference leak when platform_device_register() fails.
> 
> AFAICT you're saying that the reference was taken *within*
> platform_device_register(), and then platform_device_register() itself
> has failed. I think it's surprising that platform_device_register()
> doesn't clean that up itself in the case of an error.
> 
> There are *tonnes* of calls to platform_device_register() throughout the
> kernel that don't even bother to check the return value, and many that
> just pass the return onto a caller that can't possibly know to call
> platform_device_put().
> 
> Code in the same file as platform_device_register() expects it to clean up
> after itself, e.g.
> 
> | int platform_add_devices(struct platform_device **devs, int num) 
> | {
> |         int i, ret = 0; 
> | 
> |         for (i = 0; i < num; i++) {
> |                 ret = platform_device_register(devs[i]);
> |                 if (ret) {
> |                         while (--i >= 0)
> |                                 platform_device_unregister(devs[i]);
> |                         break;
> |                 }    
> |         }    
> | 
> |         return ret; 
> | }
> 
> That's been there since the initial git commit, and back then,
> platform_device_register() didn't mention that callers needed to perform
> any cleanup.
> 
> I see a comment was added to platform_device_register() in commit:
> 
>   67e532a42cf4 ("driver core: platform: document registration-failure requirement")
> 
> ... and that copied the commend added for device_register() in commit:
> 
>   5739411acbaa ("Driver core: Clarify device cleanup.")
> 
> ... but the potential brokenness is so widespread, and the behaviour is
> so surprising, that I'd argue the real but is that device_register()
> doesn't clean up in case of error. I don't think it's worth changing
> this single instance given the prevalance and churn fixing all of that
> would involve.
> 
> I think it would be far better to fix the core driver API such that when
> those functions return an error, they've already cleaned up for
> themselves.
> 
> Greg, am I missing some functional reason why we can't rework
> device_register() and friends to handle cleanup themselves? I appreciate
> that'll involve churn for some callers, but AFAICT the majority of
> callers don't have the required cleanup.

Yes, we should fix the platform core code here, this should not be
required to do everywhere as obviously we all got it wrong.

Guangshuo, can you submit a patch to do that instead and ask for all of
your other patches to not be applied as well?

thanks,

greg k-h

