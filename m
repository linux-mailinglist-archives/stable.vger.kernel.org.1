Return-Path: <stable+bounces-214469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eK99Ba6lhGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:14:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D14F3D67
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 794E53003607
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07CF3EF0CE;
	Thu,  5 Feb 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dSbbnZuM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3039FD9;
	Thu,  5 Feb 2026 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300612; cv=none; b=Fdavrjje+ULLj/CzM0vIDHxqIgtMss+EKP/YJKQfV+XMWi2iy2ub+8BEeB0v3GZH99nP2hxFMUng03vS8g6xubRYcKZRallsLk2PdbSD1VkPq8C+xUd0q7YgTP8szaRpSPX1blzzBHl4zx/OUG/JHTc8hX/vjefmGIrEpOrm47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300612; c=relaxed/simple;
	bh=upcWJHRr9VayWqaBIlRnAg1C0EK87qXHi0lM9DXESJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLLKO3BKyCDRWHNEq7nCGy83AMcZFrAWbUwndjiyTaEO1AzKVnmSXHGhY11aYOWVCNt0foIOc2Xd+BE54fHPKgwbpHjrDFiz3DpUCcPVW0fMinVBswnK9J7FcyX9RV2OQDaafa02d7r7VgS3FsxYmsLlk+YDMAeU3fvprzYoxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dSbbnZuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6BBC4CEF7;
	Thu,  5 Feb 2026 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770300612;
	bh=upcWJHRr9VayWqaBIlRnAg1C0EK87qXHi0lM9DXESJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSbbnZuMQDJLC8CULEXx2UbdVRFfmdBJ4lFYkr0zjvK4FFBCwXIMpbOeSD3/arw2p
	 t7H7I8ok4I+hM+xroCOeRKTs+SSV98m/5PF9HRX4iag0yo2cFQLL7kPO/lWtRHN8ud
	 6l/KDjnNOQVxtq141eaWTxK4SjG3XNHvxlwCGXZY=
Date: Thu, 5 Feb 2026 15:10:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, kent.russell@amd.com,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1 062/280] drm/amd: Clean up kfd node on surprise
 disconnect
Message-ID: <2026020559-frivolous-imprint-657e@gregkh>
References: <20260204143909.614719725@linuxfoundation.org>
 <20260204143911.886376244@linuxfoundation.org>
 <91b2c3d1-02b7-4ef6-bca0-4ae9c375ccbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b2c3d1-02b7-4ef6-bca0-4ae9c375ccbe@kernel.org>
X-Rspamd-Server: lfdr
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
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214469-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,frame.work:url]
X-Rspamd-Queue-Id: 62D14F3D67
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 09:31:48AM -0600, Mario Limonciello wrote:
> On 2/4/26 8:37 AM, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Mario Limonciello (AMD) <superm1@kernel.org>
> > 
> > commit 28695ca09d326461f8078332aa01db516983e8a2 upstream.
> > 
> > When an eGPU is unplugged the KFD topology should also be destroyed
> > for that GPU. This never happens because the fini_sw callbacks never
> > get to run. Run them manually before calling amdgpu_device_ip_fini_early()
> > when a device has already been disconnected.
> > 
> > This location is intentionally chosen to make sure that the kfd locking
> > refcount doesn't get incremented unintentionally.
> > 
> > Cc: kent.russell@amd.com
> > Closes: https://community.frame.work/t/amd-egpu-on-linux/8691/33
> > Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Reviewed-by: Kent Russell <kent.russell@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > (cherry picked from commit 6a23e7b4332c10f8b56c33a9c5431b52ecff9aab)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    8 ++++++++
> >   1 file changed, 8 insertions(+)
> > 
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4102,6 +4102,14 @@ void amdgpu_device_fini_hw(struct amdgpu
> >   	/* disable ras feature must before hw fini */
> >   	amdgpu_ras_pre_fini(adev);
> > +	/*
> > +	 * device went through surprise hotplug; we need to destroy topology
> > +	 * before ip_fini_early to prevent kfd locking refcount issues by calling
> > +	 * amdgpu_amdkfd_suspend()
> > +	 */
> > +	if (drm_dev_is_unplugged(adev_to_drm(adev)))
> > +		amdgpu_amdkfd_device_fini_sw(adev);
> > +
> >   	amdgpu_device_ip_fini_early(adev);
> >   	amdgpu_irq_fini_hw(adev);
> > 
> > 
> 
> There was a regression [1] reported on this patch yesterday.
> 
> I haven't had time to dig into it; but I think we should hold off letting it
> go to any more stable kernels until it's understood.
> 
> https://lore.kernel.org/all/b0c22deb-c0fa-3343-33cf-fd9a77d7db99@absolutedigital.net/

Ok, dropping it from all queues now, thanks.

greg k-h

