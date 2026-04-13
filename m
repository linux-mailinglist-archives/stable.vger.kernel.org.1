Return-Path: <stable+bounces-236041-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LqID2bg3GlkXwkAu9opvQ
	(envelope-from <stable+bounces-236041-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:24:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C333EBE40
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDE2E302D0AD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7833C4542;
	Mon, 13 Apr 2026 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jE8R4+iY"
X-Original-To: stable@vger.kernel.org
Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF933C454B
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776082987; cv=none; b=ljSHwk7WnQy5ih181zb1WBytxqXhOpjOHCMCMIcMvtRaDbe8h9u77jBbJKgel1slgilGLESy9c8fUqodVNpA0l64m1NXsXzrMAFV5CuicA1fxc8G2G6tmZK3E86M3HT1/NwGMm19yEcDxvtjjYuB6zJBzLsUL+8Bp+qnCMvEqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776082987; c=relaxed/simple;
	bh=BBkzYw2zsCOt65g0/czwmFam61bS0fD+YbV9/bZ3PTc=;
	h=In-Reply-To:Cc:Message-Id:To:Content-Type:Mime-Version:References:
	 From:Subject:Date; b=gt63UV4u/o2MqqdW8lFN24wCSKpjPKqfXmJSaYPYxjcT2Oe/5h6/fe2RZ3zsbaZJ5KoF4p104+t4ScUKIi6yuHZb0rfhvVIOqS52jllKyROI9yTzKnGOLqKtbifn1BZW9Si7DAzCoUSHzFgbCFKEcYTKcfLO4PerNQj+9nw7D3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jE8R4+iY; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776082981; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=BBkzYw2zsCOt65g0/czwmFam61bS0fD+YbV9/bZ3PTc=;
 b=jE8R4+iYADVxS7UvGT4SGVzHU136YhJtExmhVQInByWqxUfKy08yVE9/LajSXBG98uOT9F
 wnEVKXl8cul+u4nzck33Cv11ogqUP7Z9c3Ea8tcXVWpVE/ZkXa7dhdMCZy+zYKosEgOgvX
 9PpT9jDZpOpdt4RK/ZyHl3nJZsne77E7P8DndrRq1W/KAtYYLsfyq2KGym0vyaX4J2eqOO
 Ww5ZQ1rADuDkuLS1uki4C2CHMVHgfRm9C3kO67OsBBvP4qyk86YyoYCXAz5v1hhwoQol5o
 mOze6xCBwe5HVelLVSDEX6oRHhWpF3YepEttOTMxgdS1hSeVRQHHdbPYaZj6rg==
In-Reply-To: <20260413101759.6323fb68@pumpkin>
X-Mailer: git-send-email 2.17.1
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	=?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"Jinhui Guo" <guojinhui.liam@bytedance.com>, 
	"Jason Wang" <jasowang@redhat.com>, "Jiri Pirko" <jiri@resnulli.us>, 
	"Xuan Zhuo" <xuanzhuo@linux.alibaba.com>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, <virtualization@lists.linux.dev>
Message-Id: <20260413122244.534-1-guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: "David Laight" <david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269dce023+9f30b6+vger.kernel.org+guojinhui.liam@bytedance.com>
References: <20260413101759.6323fb68@pumpkin>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: Re: [PATCH] virtio_pci_modern: Use GFP_ATOMIC with spin_lock_irqsave held in virtqueue_exec_admin_cmd()
Date: Mon, 13 Apr 2026 20:22:44 +0800
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=2212171451];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236041-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guojinhui.liam@bytedance.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bytedance.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:dkim,bytedance.com:mid]
X-Rspamd-Queue-Id: B1C333EBE40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 10:17:59 +0100, David Laight wrote:
> Or do the allocate before acquiring the lock (and free it not used
> in the error path).

Hi David,

Thanks for the suggestion.

Pre-allocating the memory outside the lock is indeed a good practice,
but unfortunately it doesn't work in this specific virtqueue context.

The kmalloc() in question is not happening at the virtqueue_exec_admin_cmd()
level. Instead, it is deeply embedded inside virtqueue_add_sgs()
(specifically, in functions like alloc_indirect_split() or
virtqueue_add_indirect_packed()) to allocate indirect descriptors when
multiple SG elements are provided.

As a caller, we have no mechanism to pre-allocate this indirect descriptor
memory and pass it down to virtqueue_add_sgs(). Furthermore, virtqueue_add_sgs()
needs to atomically check the queue's num_free status, allocate the indirect
table if necessary, and update the queue pointers. All these operations
must be protected by admin_vq->lock to prevent concurrent admin command
submissions from corrupting the virtqueue state.

Therefore, allocating before acquiring the lock isn't feasible here, and
replacing GFP_KERNEL with GFP_ATOMIC (with a proper sleepable retry upon
failure) seems to be the more viable fix.

Does this make sense?

Thanks,
Jinhui

