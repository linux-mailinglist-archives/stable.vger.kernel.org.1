Return-Path: <stable+bounces-246836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFJWO5VqBGprIQIAu9opvQ
	(envelope-from <stable+bounces-246836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:12:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD0B532D6A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0A6E304225A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DD93FF8AF;
	Wed, 13 May 2026 12:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gntlgRt6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oe+9Tev7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E173FB055
	for <stable@vger.kernel.org>; Wed, 13 May 2026 12:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674258; cv=none; b=IjEmkeGz1tMtYtIcZHIojnaz/fPgNMx/7Ong0+tyfXF5lN85M2BMKWYAcojYs4Yv6ARX/n0dU8Zx87+M2NzTXaR6la5eVR+lS3FX+Lwa7K0l/BdF/iH0g47EeLhbMG9tY3gKMvxXPTAazjf5Aju1Q+LV2k9yU+QJuuHEGHq+ZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674258; c=relaxed/simple;
	bh=qag4HZBEbOWMfveLQJydGBeg4Xk2bclkDFncWGVkdvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unsFH8vI//qGCu1MHRl4Z0+dPh9z34Fp4LGYcNsQQiJ+GhDooLiNDDL3e2ND7D6I0ASXGr3mqiHBx1UMCkvKeJQmqp2V7gUVlbg7kH7zXX5nXdgekrqmVHHTiNIZVp9Gck83e2gXgp5mWlqV3ClQxgHyqDfMqHK9LhSv2BzTYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gntlgRt6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oe+9Tev7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778674256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvNsaPUwi394bBOCZmbGOFCLqPIJOdPpc1dHADKfuI8=;
	b=gntlgRt66zhea31DsN45b28zVrrkqZeEdrahCJ9LSNQC029gLYtW03o0deAbN4OCmNUOZz
	Z/mX3FaoPA/xXgRWo5WQTOmPhpxPfwPMN3avrufh2QWYPTEo8C+ZyUJ/FkbXMTTCBsxjkY
	kvF+98enlDs/y8FkMcrsWM6W3/oy/Vs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-R-WqeKSzOVScC4t_RN-3SQ-1; Wed, 13 May 2026 08:10:55 -0400
X-MC-Unique: R-WqeKSzOVScC4t_RN-3SQ-1
X-Mimecast-MFC-AGG-ID: R-WqeKSzOVScC4t_RN-3SQ_1778674254
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4411a2c034fso6065139f8f.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778674254; x=1779279054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tvNsaPUwi394bBOCZmbGOFCLqPIJOdPpc1dHADKfuI8=;
        b=oe+9Tev7IuBa4ON3PfN8GnlyrezRpEPJXjBIroa4GHjMCgmS/wGm9sMdJFRM6LMqBW
         HRIY+b+idpiEyuJSCqa6A4tZyhfkXxRSdiLFC9DD5CFQ8Yn6BORRgfwC358BbJrIO5zU
         OU5fiZaS2BXnNX/WFgN2YzTa3WcRomKc2XgfA1owQ9xU5+7IZI32q2e/qqoes+MdL3FN
         zCBCbvQ87Mzse6DKg+TeOtyucC+YJlGs/INNJt4IwiUnGeGumgbajdUsvvfgtrt3Ol8e
         j9coCHhZ/XOmuSWQPh5FBPILRBQXbOsSrvI7ZGlvIfu9STZw1SBGgu6VUaFrlB5M4n4b
         fDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674254; x=1779279054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvNsaPUwi394bBOCZmbGOFCLqPIJOdPpc1dHADKfuI8=;
        b=HIZ9SonW+i3c9bkuH7qpj1BkD9A9yVX0zyeGeqnDqTB1dwlZ7TSstTCIFZDUlL63rq
         UDtg1K1PChuF+UW/lxAb1IXPyxoqq8M3NWJiMwGVzobpJZVkZ1JESXuEq8YmE4eWYuPN
         Ff/TmugZYySVus0iPq2q000xwnHac7P4UtKHIrvH0qjQbLR0Kv3ZJgODvVHO51Q00cij
         Iavu4NU50yEgPaFFHs3pg/7pucorpQmN1fvtNQhG8ejbRDkZISN29sBqiv9swRi3iYXA
         TSESlTVszo4g+3j9jlq10MsvcQL/KfqVhFmXzVy8p9gmw+m0FmmY/JgmIs/VOUJdH30u
         OuNw==
X-Forwarded-Encrypted: i=1; AFNElJ+YB+Ct5clxBxIBF3lRjYyG6uL2I0AJyY9XXBmwfioJgg/IuXo8zosxUnaVQabbVznqPY2rsYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCMVKG0yjWHL7EF46lb7yrNTAQk/KsuLkjTefsfg8k+Asvgbt
	vz1phl9v2d9n6VE5VnJzUuNXp13aZ17wXI+c19u/J1hMthV0mI6CbL5PUkYTfbOwMmhhxof4HLy
	L+fgymrcu4cJAnjKUA/K0VS63utevcnpRCYQBVEACIcnCXua9akxDJS09RQ==
X-Gm-Gg: Acq92OELqs+OR8ondNO0GgtXxrLVEkjklR1mbOaALhthxDxa674g/1jvLnCrcUV5YXw
	Tozkj52P47RY7aBdKmTswCZibZaAYmsyGQG1z8U8pqyFB/f6KT1qzz136tNGR5xkYDdiHDbvLYK
	Zm7BKGz86IvVAh862UBsA+V5e13xNsGOzM9XqjIRQUbrfHt92ZbxcI36mPUy7aR84wRMgGfdboY
	vYeprhtSBnT9hjG2zGi8CuiIVOkt+LFB7H9+ch+EzAKBILTvhSnhcSIClKuSYs9DmSc832jD+Ui
	nnK/GH78RJde80ucIFf/3zojzoejI76LiAcxD+pDaFinkPdy8uoiFg1k68yF4jeH8O7PjyGywAK
	k/Cdd7XkzR4CaPgJLyoYCSQKXyHDcDbVCLomlbLSS
X-Received: by 2002:a05:6000:1847:b0:455:4288:6c34 with SMTP id ffacd0b85a97d-45c5a0b17bfmr4742595f8f.24.1778674253703;
        Wed, 13 May 2026 05:10:53 -0700 (PDT)
X-Received: by 2002:a05:6000:1847:b0:455:4288:6c34 with SMTP id ffacd0b85a97d-45c5a0b17bfmr4742485f8f.24.1778674252920;
        Wed, 13 May 2026 05:10:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45cb1489594sm3997592f8f.5.2026.05.13.05.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:10:52 -0700 (PDT)
Date: Wed, 13 May 2026 08:10:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave
 held in virtqueue_exec_admin_cmd()
Message-ID: <20260513080456-mutt-send-email-mst@kernel.org>
References: <20260413034046-mutt-send-email-mst@kernel.org>
 <20260413100013.32399-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413100013.32399-1-guojinhui.liam@bytedance.com>
X-Rspamd-Queue-Id: 1DD0B532D6A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246836-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, Apr 13, 2026 at 06:00:13PM +0800, Jinhui Guo wrote:
> On Mon, Apr 13, 2026 at 03:45:20 -0400, "Michael S. Tsirkin" wrote:
> > GFP_ATOMIC allocations can and will fail. If using them, one must
> > retry, not just propagate failures.
> > Or just switch admin_vq->lock to a mutex?
> 
> Hi Michael,
> 
> Thank you for the review.
> 
> Regarding the suggestion to switch admin_vq->lock to a mutex:
> 
> The virtqueue callback vp_modern_avq_done() holds admin_vq->lock and
> runs in an interrupt handler context, making it impractical to replace
> the spinlock with a mutex directly.
> 
> I considered deferring the completion to a workqueue so we could safely
> use a mutex, but since this is a bug fix destined for stable@vger.kernel.org,
> doing so would introduce significant code churn (e.g., handling INIT_WORK,
> cancel_work_sync during cleanup, etc.) and increase the risk for backports.



This is not how we do kernel development here. Please fix the bug
upstream first then we will consider backporting strategies.



> Therefore, using GFP_ATOMIC with the existing spinlock seems to be the most
> minimal and safest approach for a fix.
> 
> However, just replacing GFP_KERNEL with GFP_ATOMIC isn't entirely safe
> because of how virtqueue_add_sgs() handles allocation failures. If kmalloc()
> fails under memory pressure with GFP_ATOMIC, the function falls back to using
> direct descriptors. If there are not enough free direct descriptors, it
> ultimately returns -ENOSPC.
> 
> In the current code, -ENOSPC is handled with a busy loop:
> 
> if (ret == -ENOSPC) {
> 	spin_unlock_irqrestore(&admin_vq->lock, flags);
> 	cpu_relax();
> 	goto again;
> }
> 
> If the -ENOSPC is actually caused by a GFP_ATOMIC allocation failure under
> memory pressure, this cpu_relax() loop will never yield the CPU to memory
> reclaim mechanisms (like kswapd), potentially leading to a soft lockup.
> 
> To properly handle both actual queue-full conditions and GFP_ATOMIC failures,
> I propose replacing cpu_relax() with a sleep (e.g., usleep_range(10, 100)).
> This allows memory reclaim to run while we wait.
> 
> I plan to send out a v2 patch with this modification:
> 
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -101,11 +101,11 @@ static int virtqueue_exec_admin_cmd(struct virtio_pci_admin_vq *admin_vq,
>                 return -EIO;
> 
>         spin_lock_irqsave(&admin_vq->lock, flags);
> -       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_KERNEL);
> +       ret = virtqueue_add_sgs(vq, sgs, out_num, in_num, cmd, GFP_ATOMIC);
>         if (ret < 0) {
>                 if (ret == -ENOSPC) {
>                         spin_unlock_irqrestore(&admin_vq->lock, flags);
> -                       cpu_relax();
> +                       usleep_range(10, 100);
>                         goto again;
>                 }
>                 goto unlock_err;
> 
> Does this approach align with your expectations for the fix?
> 
> Thanks,
> Jinhui

Nope.

I think we need to get out of peephole mode where we are just looking
at the warnings and "fix" them by 1 line tweaks and actually analyze the
codepaths. GFP is just for indirect allocations and VQ already
falls back to using direct when that fails.

The question is:
- what is going on with VQ ring state, can we actually get into a situation
  where indirect would succeed but direct fails?
- how can callers either prevent failures or get notified when buffers
  have been used?

And it is quite possible that the fix in the end is exactly your v1 but
with the analysis in the commit log explaining why this fixes the
problem and does not paper over it.

-- 
MST


