Return-Path: <stable+bounces-168767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C05EB236A9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECA51B66144
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430DD260583;
	Tue, 12 Aug 2025 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOVC0dyy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF21C1AAA;
	Tue, 12 Aug 2025 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025264; cv=none; b=PW6TLs+EWTDiknRg8gNzmlQ/G2SFJIt70IJBEJHlNlIQnKA0vIN9Kw6hWiozlPm/UdGn35Xvfy9EEM7bJ0ncm748zapjABj52Qt1TrIDd9eYZhorRxJmsrcGPoYGFuOmZCJJISM0fCXm95/jM6EfpiAp1fNC/4ZI4yCQ+Z06PVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025264; c=relaxed/simple;
	bh=8079RzXWPD6YyH1oTEWSyYXD4iJhvkJ3h7pAadNbTMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRn6DBnzujm5nIQjE0wRcDRk5NwgFNce7ZISWJNXyzP7HKpcT2oFDxlMaGMqp7XD66orHHH+aHhAe0GfXioX732Mx+EQibdDewUAq+V43n+ZS3LU8jUOkKIRh2uppeutTSuuUSc9y4VjGnFVTbI/XDTWyw5LJlTBWq/Rmw+zBW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOVC0dyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C4CC4CEF6;
	Tue, 12 Aug 2025 19:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025263;
	bh=8079RzXWPD6YyH1oTEWSyYXD4iJhvkJ3h7pAadNbTMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOVC0dyyNB4MRtASVC2siinq9csTlQriX0tx9jPGMNso1RgH3ifBK18ysxZy9kiNI
	 w6tgePJyd7KJCMEX/BlG+nXOxVmjEVoXt8zGqTGkpTYsQpYneCPZH1af8kim7yE12c
	 DKerkBy/cZE7/UQpZa3SKYIs+sEpdHISstqklHIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Akash Kumar <quic_akakum@quicinc.com>
Subject: [PATCH 6.16 617/627] usb: gadget: uvc: Initialize frame-based format color matching descriptor
Date: Tue, 12 Aug 2025 19:35:12 +0200
Message-ID: <20250812173455.352527485@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akash Kumar <quic_akakum@quicinc.com>

commit 323a80a1a5ace319a722909c006d5bdb2a35d273 upstream.

Fix NULL pointer crash in uvcg_framebased_make due to uninitialized color
matching descriptor for frame-based format which was added in
commit f5e7bdd34aca ("usb: gadget: uvc: Allow creating new color matching
descriptors") that added handling for uncompressed and mjpeg format.

Crash is seen when userspace configuration (via configfs) does not
explicitly define the color matching descriptor. If color_matching is not
found, config_group_find_item() returns NULL. The code then jumps to
out_put_cm, where it calls config_item_put(color_matching);. If
color_matching is NULL, this will dereference a null pointer, leading to a
crash.

[    2.746440] Unable to handle kernel NULL pointer dereference at virtual address 000000000000008c
[    2.756273] Mem abort info:
[    2.760080]   ESR = 0x0000000096000005
[    2.764872]   EC = 0x25: DABT (current EL), IL = 32 bits
[    2.771068]   SET = 0, FnV = 0
[    2.771069]   EA = 0, S1PTW = 0
[    2.771070]   FSC = 0x05: level 1 translation fault
[    2.771071] Data abort info:
[    2.771072]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[    2.771073]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    2.771074]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    2.771075] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000a3e59000
[    2.771077] [000000000000008c] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
[    2.771081] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
[    2.771084] Dumping ftrace buffer:
[    2.771085]    (ftrace buffer empty)
[    2.771138] CPU: 7 PID: 486 Comm: ln Tainted: G        W   E      6.6.58-android15
[    2.771139] Hardware name: Qualcomm Technologies, Inc. SunP QRD HDK (DT)
[    2.771140] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    2.771141] pc : __uvcg_fill_strm+0x198/0x2cc
[    2.771145] lr : __uvcg_iter_strm_cls+0xc8/0x17c
[    2.771146] sp : ffffffc08140bbb0
[    2.771146] x29: ffffffc08140bbb0 x28: ffffff803bc81380 x27: ffffff8023bbd250
[    2.771147] x26: ffffff8023bbd250 x25: ffffff803c361348 x24: ffffff803d8e6768
[    2.771148] x23: 0000000000000004 x22: 0000000000000003 x21: ffffffc08140bc48
[    2.771149] x20: 0000000000000000 x19: ffffffc08140bc48 x18: ffffffe9f8cf4a00
[    2.771150] x17: 000000001bf64ec3 x16: 000000001bf64ec3 x15: ffffff8023bbd250
[    2.771151] x14: 000000000000000f x13: 004c4b40000f4240 x12: 000a2c2a00051615
[    2.771152] x11: 000000000000004f x10: ffffffe9f76b40ec x9 : ffffffe9f7e389d0
[    2.771153] x8 : ffffff803d0d31ce x7 : 000f4240000a2c2a x6 : 0005161500028b0a
[    2.771154] x5 : ffffff803d0d31ce x4 : 0000000000000003 x3 : 0000000000000000
[    2.771155] x2 : ffffffc08140bc50 x1 : ffffffc08140bc48 x0 : 0000000000000000
[    2.771156] Call trace:
[    2.771157]  __uvcg_fill_strm+0x198/0x2cc
[    2.771157]  __uvcg_iter_strm_cls+0xc8/0x17c
[    2.771158]  uvcg_streaming_class_allow_link+0x240/0x290
[    2.771159]  configfs_symlink+0x1f8/0x630
[    2.771161]  vfs_symlink+0x114/0x1a0
[    2.771163]  do_symlinkat+0x94/0x28c
[    2.771164]  __arm64_sys_symlinkat+0x54/0x70
[    2.771164]  invoke_syscall+0x58/0x114
[    2.771166]  el0_svc_common+0x80/0xe0
[    2.771168]  do_el0_svc+0x1c/0x28
[    2.771169]  el0_svc+0x3c/0x70
[    2.771172]  el0t_64_sync_handler+0x68/0xbc
[    2.771173]  el0t_64_sync+0x1a8/0x1ac

Initialize color matching descriptor for frame-based format to prevent
NULL pointer crash by mirroring the handling done for uncompressed and
mjpeg formats.

Fixes: 7b5a58952fc3 ("usb: gadget: uvc: configfs: Add frame-based frame format support")
Cc: stable <stable@kernel.org>
Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
Link: https://lore.kernel.org/r/20250718085138.1118788-1-quic_akakum@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/uvc_configfs.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2916,8 +2916,15 @@ static struct config_group *uvcg_frameba
 		'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00,
 		0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71
 	};
+	struct uvcg_color_matching *color_match;
+	struct config_item *streaming;
 	struct uvcg_framebased *h;
 
+	streaming = group->cg_item.ci_parent;
+	color_match = uvcg_format_get_default_color_match(streaming);
+	if (!color_match)
+		return ERR_PTR(-EINVAL);
+
 	h = kzalloc(sizeof(*h), GFP_KERNEL);
 	if (!h)
 		return ERR_PTR(-ENOMEM);
@@ -2936,6 +2943,9 @@ static struct config_group *uvcg_frameba
 
 	INIT_LIST_HEAD(&h->fmt.frames);
 	h->fmt.type = UVCG_FRAMEBASED;
+
+	h->fmt.color_matching = color_match;
+	color_match->refcnt++;
 	config_group_init_type_name(&h->fmt.group, name,
 				    &uvcg_framebased_type);
 



