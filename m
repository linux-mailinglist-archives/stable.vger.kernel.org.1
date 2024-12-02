Return-Path: <stable+bounces-96147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449169E0AC7
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 19:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05972281E97
	for <lists+stable@lfdr.de>; Mon,  2 Dec 2024 18:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A8B1DDC24;
	Mon,  2 Dec 2024 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z73jEOVa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0B7080E
	for <stable@vger.kernel.org>; Mon,  2 Dec 2024 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733163411; cv=none; b=TtpR9SsjCDsAtJfY96wAQjzAhwisEA+iuNNtl9EwDNmx5J/yiva/oc2Qx9pugi39En25pwGQfL9cRCFvGfmtsC2rTWpcwqTfaeMu4i6K/3aWJY9QSh9f1vvreqxBCu802y14yXHBpIzSVRxi3dC+7Cm6pmUYzvlAYXMow+YainE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733163411; c=relaxed/simple;
	bh=opSXhLypmrOvhL+KRR62vbHueTVDl6XDS2Fjfdfd1k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clypuqbBeZ7OCYorg2d48Tz5aJo7Pv+VyuENomjzCfTA0zhVd9SJEHytZnigHm4rndv3HdT8EDHjp5Stx3I4k7Lz43Plcsulkglzeelxs43jDYVkCYr23/aFTKJk9XezsjD6Ve6Y09XRaCug2Zc0mrooEPm+N4AYolzTBdsTlDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z73jEOVa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733163408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RGpr01F8xk0sRuOzvOUOFOKNe4LLyAg6HQqCXymY6w=;
	b=Z73jEOVamL/D5yT2WdIni269OUv4gFjxe9ETO3PWd8HviZ3PWox9cf7zFuJDEGcmL77Qs6
	zpwCfA4YfhIayktPuFdQVz/NGZsFm03aquCWiUL6zheOsmVXJKm8VKFgGllMvjgxQbgDgA
	wflAuE+2LFj1zuxQFY3pBxvW2RWkSy4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-VUq9AvHXM6aQPzID-mCMSw-1; Mon,
 02 Dec 2024 13:16:43 -0500
X-MC-Unique: VUq9AvHXM6aQPzID-mCMSw-1
X-Mimecast-MFC-AGG-ID: VUq9AvHXM6aQPzID-mCMSw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C9021944D07;
	Mon,  2 Dec 2024 18:16:41 +0000 (UTC)
Received: from rhel-developer-toolbox-2.redhat.com (unknown [10.45.225.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACA451956054;
	Mon,  2 Dec 2024 18:16:38 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: calvin@wbinvd.org
Cc: giometti@enneenne.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux@horizon.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] pps: Fix a use-after-free
Date: Mon,  2 Dec 2024 19:16:31 +0100
Message-ID: <20241202181631.1451976-1-mschmidt@redhat.com>
In-Reply-To: <a17975fd5ae99385791929e563f72564edbcf28f.1731383727.git.calvin@wbinvd.org>
References: <a17975fd5ae99385791929e563f72564edbcf28f.1731383727.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

> On a board running ntpd and gpsd, I'm seeing a consistent use-after-free
> in sys_exit() from gpsd when rebooting:
> 
>     pps pps1: removed
>     ------------[ cut here ]------------
>     kobject: '(null)' (00000000db4bec24): is not initialized, yet kobject_put() is being called.
>     WARNING: CPU: 2 PID: 440 at lib/kobject.c:734 kobject_put+0x120/0x150
>     CPU: 2 UID: 299 PID: 440 Comm: gpsd Not tainted 6.11.0-rc6-00308-gb31c44928842 #1
>     Hardware name: Raspberry Pi 4 Model B Rev 1.1 (DT)
>     pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>     pc : kobject_put+0x120/0x150
>     lr : kobject_put+0x120/0x150
>     sp : ffffffc0803d3ae0
>     x29: ffffffc0803d3ae0 x28: ffffff8042dc9738 x27: 0000000000000001
>     x26: 0000000000000000 x25: ffffff8042dc9040 x24: ffffff8042dc9440
>     x23: ffffff80402a4620 x22: ffffff8042ef4bd0 x21: ffffff80405cb600
>     x20: 000000000008001b x19: ffffff8040b3b6e0 x18: 0000000000000000
>     x17: 0000000000000000 x16: 0000000000000000 x15: 696e6920746f6e20
>     x14: 7369203a29343263 x13: 205d303434542020 x12: 0000000000000000
>     x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>     x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>     x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
>     x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
>     Call trace:
>      kobject_put+0x120/0x150
>      cdev_put+0x20/0x3c
>      __fput+0x2c4/0x2d8
>      ____fput+0x1c/0x38
>      task_work_run+0x70/0xfc
>      do_exit+0x2a0/0x924
>      do_group_exit+0x34/0x90
>      get_signal+0x7fc/0x8c0
>      do_signal+0x128/0x13b4
>      do_notify_resume+0xdc/0x160
>      el0_svc+0xd4/0xf8
>      el0t_64_sync_handler+0x140/0x14c
>      el0t_64_sync+0x190/0x194
>     ---[ end trace 0000000000000000 ]---
> 
> ...followed by more symptoms of corruption, with similar stacks:
> 
>     refcount_t: underflow; use-after-free.
>     kernel BUG at lib/list_debug.c:62!
>     Kernel panic - not syncing: Oops - BUG: Fatal exception
> 
> This happens because pps_device_destruct() frees the pps_device with the
> embedded cdev immediately after calling cdev_del(), but, as the comment
> above cdev_del() notes, fops for previously opened cdevs are still
> callable even after cdev_del() returns. I think this bug has always
> been there: I can't explain why it suddenly started happening every time
> I reboot this particular board.
> 
> In commit d953e0e837e6 ("pps: Fix a use-after free bug when
> unregistering a source."), George Spelvin suggested removing the
> embedded cdev. That seems like the simplest way to fix this, so I've
> implemented his suggestion, using __register_chrdev() with pps_idr
> becoming the source of truth for which minor corresponds to which
> device.
> 
> But now that pps_idr defines userspace visibility instead of cdev_add(),
> we need to be sure the pps->dev refcount can't reach zero while
> userspace can still find it again. So, the idr_remove() call moves to
> pps_unregister_cdev(), and pps_idr now holds a reference to pps->dev.
> 
>     pps_core: source serial1 got cdev (251:1)
>     <...>
>     pps pps1: removed
>     pps_core: unregistering pps1
>     pps_core: deallocating pps1
> 
> Fixes: d953e0e837e6 ("pps: Fix a use-after free bug when unregistering a source.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>

Reviewed-by: Michal Schmidt <mschmidt@redhat.com>


