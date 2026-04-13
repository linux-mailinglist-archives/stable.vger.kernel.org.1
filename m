Return-Path: <stable+bounces-236085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCSPKkDy3GnZYQkAu9opvQ
	(envelope-from <stable+bounces-236085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:40:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E7A3ECA4A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F172306688F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0353CD8B7;
	Mon, 13 Apr 2026 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMjqkzVD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECD3CCFD4
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087186; cv=none; b=OORcnracWiOyR8YWQKw4U6oExKXY6bHe6YCA5EzTyTbkM6A+klS2cel4WKuLPOTtYZu4WPKfQ52UagSuJkVoiL8W/fM4b0VLiP/+pqDt0i4SbYBQAU/dSKJA1EbGrYsngHBPzQ1sHsB6g+KSVtkoNjowpJ5fptyEztmS0BjWjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087186; c=relaxed/simple;
	bh=cNzldwXv7EEzDpZRh1GYW+jmgvH87VS+HrKz6Gcd/no=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jFC/PQ9ez2udijiBW0rXuioUMlflD2MzKT0GwDKZlWVzpSgG7B6G/dilKpipo1l2PA/p5X9+DULW87ncbyXw6+6b8kxOupCwJUxiSn95odYg3cwy1bEFr3AKxP+5Fs5yAcAB4KlrtoN/dABMk06A2Hlj8q+fg/7U4KpM2go3+Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMjqkzVD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso75221265e9.0
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087183; x=1776691983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAr+JGO4ktVEFi2tj7VFYFMXV+IisACoZSycsDEBlws=;
        b=tMjqkzVDXVZtpAI2IyByfhpXzYWKB/56awuVFz6yaze3Lzwyro9XLAb2eKpZAWMAdi
         mvVE8rcNUZbuzkfS5TN9WKnEPn+yIhkoSY5dtgIE0MwiCYqCo3Wl320Tu0EH4EXwtn4V
         3Jtlo9K1sa/5RYX/yIbzAauJX24YFEI8xp7wDsyYtLFmG+CmMz6Ov1UYSw93UEFqvRdR
         XsYm7+HT8ecIK+2mJEOFcn0K/Pqa4/0l1p/CGkf1DSFN0rASSt2HZ+afNpfDPbSSMGQJ
         PEtWdgJTozBBeTwnfAG9SBOIo4HAiAJp3QTiWxLu0Hr0/DGSEcoxheL3nNALkKpZwZjF
         o9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087183; x=1776691983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NAr+JGO4ktVEFi2tj7VFYFMXV+IisACoZSycsDEBlws=;
        b=g6SERQvSGYy1mOWG7NxWEGAAeM9lG05bOTVsq2E7XNj4oX0gybZ2QfTlBX4QCwAKfe
         9/phD6UKZikqhsOBvbY2ZAV2tepv+SUQanVvZxrDcbFlRfHOH1xGfMP3v+Sw2cPUaoZI
         q92Md8YtyPHeFzbnSRVIH3j3QgcpDy5zqMYWTK/+xWkFCy5SCNZpevu+m+gowl1eEmJI
         N40JO4m+OcKmsTtYbbxZPInoxX3zicjemfx493mW4vKGH2R7ePOG5Z2bVmqJlV6WBZXf
         SQMykAk8RDTl4+pYZdKynNE0PjjMTKRi6EQV37GyttpaQJIOQOD9Bgc5XIvZJCjXvD+F
         f4ew==
X-Forwarded-Encrypted: i=1; AFNElJ9E/eyztGR0gL+2m0zysA5fTHX3Xfd9PNphf6IvM0D86GvDlZ9cdd9sN61wc3Lxoo4ccEJkU6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZlAa2toqmQEtKlyMLE0WRx3s/Ad4ib2HZT8YzI6+xPJ017+1
	mGBaY+wgM+t05BjMAj+bWIrJ0VU+m3264ace01u6Ji3w/rdCn2QStVRP
X-Gm-Gg: AeBDieszLjOP46i+BpgjUltLtewCYeZHiDEbnkEa+rheRDWLiLpLGtqpBjvVUXyTMlh
	6l/FwXAg6qderwO7pE6JwwIponCctePvhXXapBge+qT9JPFGlmMDQBu6a9Y2hp1bWXouHjkzEUQ
	3cvgYKIcj7MKY4mTMxa0XBl8XZXxdrZKy9GbeYyeC+ywTWBXIz9gx+7r8G15EyQzSY7nY9wube5
	l+3S+KtyONWRSsjNby/MY0ueWM6XWjP+v0S6Ekl5MF3RhopcwZHHz7z4OX/Dii0/1MFIuL4r3da
	eY2uzrG3ubujW1dMj1M5bulyMmx3LOtN3zAQeKPRwHA+oMezJL0lCRn1CpoA81EBv/Jhf3Kz2Iu
	5OUrMcOYcKDenvNOavlthncZtT9GgGdCT4hU+vU7tcdwt1LS53ra3WOYSkL4PwgjVvx9VDNHnDY
	t7ufyMnAmcakgrX+8tJFH0MlRgHVDt38u6zr9eEIab40pD7eIy3kooCM0DVYQbxVaA
X-Received: by 2002:a05:600c:4443:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-488d686c044mr182576135e9.23.1776087183006;
        Mon, 13 Apr 2026 06:33:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d762decf6sm18410380f8f.8.2026.04.13.06.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:33:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:33:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Jiri Pirko"
 <jiri@resnulli.us>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
 <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with
 spin_lock_irqsave held in virtqueue_exec_admin_cmd()
Message-ID: <20260413143300.16922e4f@pumpkin>
In-Reply-To: <20260413122244.534-1-guojinhui.liam@bytedance.com>
References: <20260413101759.6323fb68@pumpkin>
	<20260413122244.534-1-guojinhui.liam@bytedance.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236085-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 15E7A3ECA4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 20:22:44 +0800
"Jinhui Guo" <guojinhui.liam@bytedance.com> wrote:

> On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> > Or do the allocate before acquiring the lock (and free it not used
> > in the error path).  
> 
> Hi David,
> 
> Thanks for the suggestion.
> 
> Pre-allocating the memory outside the lock is indeed a good practice,
> but unfortunately it doesn't work in this specific virtqueue context.
> 
> The kmalloc() in question is not happening at the virtqueue_exec_admin_cmd()
> level. Instead, it is deeply embedded inside virtqueue_add_sgs()
> (specifically, in functions like alloc_indirect_split() or
> virtqueue_add_indirect_packed()) to allocate indirect descriptors when
> multiple SG elements are provided.
> 
> As a caller, we have no mechanism to pre-allocate this indirect descriptor
> memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_add_sgs()
> needs to atomically check the queue's num_free status, allocate the indirect
> table if necessary, and update the queue pointers. All these operations
> must be protected by admin_vq->lock to prevent concurrent admin command
> submissions from corrupting the virtqueue state.

It just sounds non-trivial...

> 
> Therefore, allocating before acquiring the lock isn't feasible here, and
> replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
> failure) seems to be the more viable fix.

The sleep-retry isn't really ideal - and may not make progress.

An 'interesting' solution would be to return the size of the kmalloc()
that failed, kmalloc() and kfree() a buffer of that size and hope
it is still available for the retry.
For a quick read of the code it is always a constant multiplied by the
number of fragments.

Although I only found kmalloc() in the 'indirect' paths.
I didn't spot what happens if the ring itself is full.

	David

> 
> Does this make sense?
> 
> Thanks,
> Jinhui


