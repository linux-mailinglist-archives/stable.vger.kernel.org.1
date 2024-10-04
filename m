Return-Path: <stable+bounces-81145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3529912D2
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5484284359
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26339150994;
	Fri,  4 Oct 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="G8iry+1e";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="lLhMDNiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.aaront.org (smtp-out1.aaront.org [52.0.59.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666521BF24;
	Fri,  4 Oct 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.0.59.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083480; cv=none; b=ctZYd+vKsgwE13vhH9opYP3TTYvE0TTH8kaDPnvdnTRiwW5xYAl14DWFP5WcZF7VZ5fq3Bf1YJUiTpM9bTDbM8QdSpjvcsJ5jC9e75ZF5gM3FWvHBmKnmYPxqu2zmKSOtTjVFhV6CrIE1yaqaeqHl1CaunadTKxs7l2k7DK13dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083480; c=relaxed/simple;
	bh=hSwY89Dc3i1dwP9dfCASLPDb2ZwIGzu1zOA5C3dVPm4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvQPTX7RlwGS6YVg7zyNbBkJ8GroPkP4LLofhjwDfdImbf+2YOQ2krqf6Tq7I3yCFzcQHu8tPI1Cm0+0TFwOiDMhku+0mEDMMBkXRs1C7j64UFYV/KF2mT5ptgPBBVi4wWExMZHxkCuTJ7w54iErto0S3jFAilA7hCpBQ3RBF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=G8iry+1e; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=lLhMDNiy; arc=none smtp.client-ip=52.0.59.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: by smtp-out1.aaront.org (Postfix) with ESMTP id 4XL3z75BJKzhZ;
	Fri,  4 Oct 2024 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=habm2wya2ukbsdan; bh=
    hSwY89Dc3i1dwP9dfCASLPDb2ZwIGzu1zOA5C3dVPm4=; b=G8iry+1eo6z4ZKLh
    2CVrFRgCTxyo+XqfkRLUP0Sb1/TuG5T8cruuA53pW2QGOGlUhsc+co9meBhrJsD8
    jhbDAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=qkjur4vrxk6kmqfk; bh=
    hSwY89Dc3i1dwP9dfCASLPDb2ZwIGzu1zOA5C3dVPm4=; b=lLhMDNiyf3hfZ8vN
    ibqw4bJR1qetgbjKj01AsGlYJT+KuvNHhKlzQthhTmdXBloUMzMjZ2ZNDeTTXBkE
    ldDNeMLrxIMvna8Tr1I7qNBvMwSFkmYqn00oe4h6RC0zEeCWwqouEiTLlfgqdVd9
    Lw+7lKj4FxNuImUerSXmCaEDJq1hkHVD/HpyV6KWHQXucAywerVHVkL0GMiqtqvK
    4xziVRfUK3Hvd3cjLRfSd1OgfMgwGTDLl0V4Tw+UE/4A33+aef87NO9hlqeGfyqD
    4Mt6kogM/Xefjx8k+uytD+Prq7hoF3cbPuvSWpR8XeE6DeCmP3xQwcBIXTajJWGT
    25bQKw==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Aaron Thompson <dev@aaront.org>
Subject: [PATCH v2 1/3] Bluetooth: ISO: Fix multiple init when debugfs is disabled
Date: Fri,  4 Oct 2024 23:04:08 +0000
Message-Id: <20241004230410.299824-2-dev@aaront.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004230410.299824-1-dev@aaront.org>
References: <20241004230410.299824-1-dev@aaront.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Thompson <dev@aaront.org>

If bt_debugfs is not created successfully, which happens if either
CONFIG_DEBUG_FS or CONFIG_DEBUG_FS_ALLOW_ALL is unset, then iso_init()
returns early and does not set iso_inited to true. This means that a
subsequent call to iso_init() will result in duplicate calls to
proto_register(), bt_sock_register(), etc.

With CONFIG_LIST_HARDENED and CONFIG_BUG_ON_DATA_CORRUPTION enabled, the
duplicate call to proto_register() triggers this BUG():

  list_add double add: new=ffffffffc0b280d0, prev=ffffffffbab56250,
    next=ffffffffc0b280d0.
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:35!
  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 2 PID: 887 Comm: bluetoothd Not tainted 6.10.11-1-ao-desktop #1
  RIP: 0010:__list_add_valid_or_report+0x9a/0xa0
  ...
    __list_add_valid_or_report+0x9a/0xa0
    proto_register+0x2b5/0x340
    iso_init+0x23/0x150 [bluetooth]
    set_iso_socket_func+0x68/0x1b0 [bluetooth]
    kmem_cache_free+0x308/0x330
    hci_sock_sendmsg+0x990/0x9e0 [bluetooth]
    __sock_sendmsg+0x7b/0x80
    sock_write_iter+0x9a/0x110
    do_iter_readv_writev+0x11d/0x220
    vfs_writev+0x180/0x3e0
    do_writev+0xca/0x100
  ...

This change removes the early return. The check for iso_debugfs being
NULL was unnecessary, it is always NULL when iso_inited is false.

Cc: stable@vger.kernel.org
Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 net/bluetooth/iso.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index d5e00d0dd1a0..c9eefb43bf47 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2301,13 +2301,9 @@ int iso_init(void)
 
 	hci_register_cb(&iso_cb);
 
-	if (IS_ERR_OR_NULL(bt_debugfs))
-		return 0;
-
-	if (!iso_debugfs) {
+	if (!IS_ERR_OR_NULL(bt_debugfs))
 		iso_debugfs = debugfs_create_file("iso", 0444, bt_debugfs,
 						  NULL, &iso_debugfs_fops);
-	}
 
 	iso_inited = true;
 
-- 
2.39.5


