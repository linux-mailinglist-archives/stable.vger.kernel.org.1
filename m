Return-Path: <stable+bounces-273088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0YZQLQArUGoxugIAu9opvQ
	(envelope-from <stable+bounces-273088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 01:13:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C343C736365
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 01:13:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=Xc1VO2lC;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273088-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273088-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0972B301C8BB
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 23:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CC83B14D0;
	Thu,  9 Jul 2026 23:12:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F08C32BF41;
	Thu,  9 Jul 2026 23:12:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638775; cv=none; b=TgZE9w1Ql3I7TYBIs54yxMDMQ24XiHiOQay8Nnkxq8IvOgvPa12CuDYPJe9c5ue7OkgEDd3x/mFlsJlVre5KxJPDyGOl53AVVxRMOfBcs9SWI3nrealC76BHdyPrgSzUDEo3byunsBU3fa/uXKkVrk+CSsWte9IexeKWYvFowjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638775; c=relaxed/simple;
	bh=pnGf7fn0bLcsg36Rj408QnXmTYdR22xOseTddY+aLm0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Mt9SpFpfSTi4d7Na8SKFCtmpDy9H4wOJ6DhaefWG7fG2yh9ut8BPcs8QS7zJBCFcV6E5Pts4neWw1rmUMR8h1CrcY6z2tbhOKUmCs45/kXn2jlCtv/V0uDktnCAe5Rgj1ft07sUWIvboaM8/8boQR5F9UcV+S/fLQeB7QiavHXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xc1VO2lC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F7D1F000E9;
	Thu,  9 Jul 2026 23:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783638774;
	bh=I84lwClwr7WKYOtvw97IHdoAVdLHDfgnUPPS12fE478=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Xc1VO2lCqZ5yuD9RWJpNxpTLtDTt2YkmCIqYyXQ9lHeRvQmc+zjFTyG+pBIQVqPIo
	 l4auJZD9bWfgu77dxmLyRua39oGNL+sHbTtvsd7SRiup4JiREXagXOOxGffAnahqmF
	 ph8ZsdIfgIwOLcqBIsKUk36EjN1T1YtYuC4XyGy8=
Date: Thu, 9 Jul 2026 16:12:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Link Lin <linkl@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, David Hildenbrand <david@kernel.org>,
 virtualization@lists.linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com,
 duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, Ammar
 Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com,
 ahwilkins@google.com, Greg Thelen <gthelen@google.com>, Alexander Duyck
 <alexander.duyck@gmail.com>, stable@vger.kernel.org
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting
 during PM freeze
Message-Id: <20260709161253.6b5e9ba349f70a3ebfb8180f@linux-foundation.org>
In-Reply-To: <20260709224330.946683-1-linkl@google.com>
References: <20260709224330.946683-1-linkl@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linkl@google.com,m:vbabka@kernel.org,m:mst@redhat.com,m:david@kernel.org,m:virtualization@lists.linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:prasin@google.com,m:rientjes@google.com,m:duenwen@google.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:ammarfaizi2@openresty.com,m:jiaqiyan@google.com,m:ahwilkins@google.com,m:gthelen@google.com,m:alexander.duyck@gmail.com,m:stable@vger.kernel.org,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273088-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,lists.linux.dev,kvack.org,vger.kernel.org,google.com,linux.alibaba.com,openresty.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C343C736365

On Thu,  9 Jul 2026 22:43:30 +0000 Link Lin <linkl@google.com> wrote:

> During system power management freeze (e.g. ACPI S3 suspend or S4
> hibernation), virtballoon_freeze() calls remove_common() to reset the
> virtio device and delete all virtqueues via vdev->config->del_vqs().
> However, unlike virtballoon_remove(), virtballoon_freeze() fails to call
> page_reporting_unregister(&vb->pr_dev_info).
> 
> ...
>
> If memory is freed into the buddy allocator or a delayed work timer
> expires while the device is being frozen, page_reporting_process() fires
> on system_wq and calls virtballoon_free_page_report(). This function
> passes vb->reporting_vq into virtqueue_add_inbuf() / virtqueue_add_split().
> Because the virtqueues were already destroyed by del_vqs(), this results
> in a Use-After-Free / General Protection Fault:
> 
>     [  250.709271] general protection fault, probably for non-canonical address 0x7f728084daf08d5e: 0000 [#1] SMP PTI
>     [  250.732967] CPU: 2 PID: 38 Comm: kworker/2:1 Not tainted 5.10.0-44-cloud-amd64 #1 Debian 5.10.257-1
>     [  250.751575] Workqueue: events page_reporting_process
>     [  250.756665] RIP: 0010:virtqueue_add_split+0x233/0x4c0 [virtio_ring]
>     ...
>     [  250.867678] virtballoon_free_page_report+0x3a/0xe0 [virtio_balloon]
>     [  250.883446] page_reporting_process+0x225/0x4f0

whoops

> Fix this by:
> 1. Unregistering page reporting in virtballoon_freeze() prior to calling
>    remove_common(). This clears the RCU pr_dev_info pointer and flushes/
>    cancels prdev->work on system_wq via cancel_delayed_work_sync().
> 2. Re-registering page reporting in virtballoon_restore() after the
>    virtqueues are re-initialized and virtio_device_ready() has been called.
> 3. Unwinding virtqueue initialization via remove_common() in 
>    virtballoon_restore() if page_reporting_register() fails.

AI review thinks the patch didn't do the above:
	https://sashiko.dev/#/patchset/20260709224330.946683-1-linkl@google.com

It also might have found a couple of pre-existing bugs in there.

