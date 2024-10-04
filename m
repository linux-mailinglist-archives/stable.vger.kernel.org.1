Return-Path: <stable+bounces-80704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE1D98FB87
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 02:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598312834BB
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512B61849;
	Fri,  4 Oct 2024 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="XDYlgl8N";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="IJKRwipa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out0.aaront.org (smtp-out0.aaront.org [52.10.12.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1B2C8E9;
	Fri,  4 Oct 2024 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.10.12.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001896; cv=none; b=GxX8FAGQYS3ArJMkSgkZen6z7NRWQnN4HqZtUIB5Y5pvzpT6J6CBvaRfACCs6tS/eAeF1a/YRTSRHsw/CHnjot39i9PdfRCJ4kfVwspPPlrOfZ7I1cWGs5snbJLkGaDfikHFUnGrKSjA6lWoc7WRatNA9w4FRXuJE5+OfPZCC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001896; c=relaxed/simple;
	bh=0pT50F1cem0hrgdH8pcqVClHyZziPHRa6KdtvkEn8No=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ka6EabcmwmQQj4zYn7CCEiW8DNuG1RoLBNVHWqnIpJ3Y1EF088y7WB4rWN6HBPNFLNYA28APlTW5GUsvC/KOrHXAjLCWSFV/gcl0+tFBVPzYL+rxbJGuAC5j1JohdHXBdCElEl1z4coFThgP8PI4RrRogEuP1ksf8XwjAwnrFqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=XDYlgl8N; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=IJKRwipa; arc=none smtp.client-ip=52.10.12.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: by smtp-out0.aaront.org (Postfix) with ESMTP id 4XKTxd5CCSzRh;
	Fri,  4 Oct 2024 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=bgzxjfijqntwovyv; bh=
    0pT50F1cem0hrgdH8pcqVClHyZziPHRa6KdtvkEn8No=; b=XDYlgl8NLsNRHd96
    VVSzgBMTh7igHjFSA/x1/bJIFP2n0O1qa0t+wwlnnblghgUDDANMICVPi/phcKA7
    fGInCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=elwxqanhxhag6erl; bh=
    0pT50F1cem0hrgdH8pcqVClHyZziPHRa6KdtvkEn8No=; b=IJKRwipaASwdRJga
    55eXfloxQVbfFKmxtEDqPRsrSGZOHl3aoY0lljvdcbpPczYs8mtfHXKVAp6pJ7qy
    j6N4OJN/OmDHm1MtASGJ4qhlk8146muetetchf652HOXs8Uqp5cupyAe4m6cX+hB
    AjVxS/cy3K8++dVbhSZERmPVycGYcYQ9gfkaL3BI7OkK6bTKCcHTb99g2zi0b/Xm
    3JX6FpwVbFkrdQIgE5GaHY1YRkY9nzwpqI0idAyT72toFqhuDn7PLTW7Hs137waV
    gDQozmEp3bfeGly9GfKRAHceAYtslE2WubVJLk9Ev/d4gJbCmDINnm8+9/u4G4hM
    XQhTGg==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aaron Thompson <dev@aaront.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Call iso_exit() on module unload
Date: Fri,  4 Oct 2024 00:30:29 +0000
Message-Id: <20241004003030.160721-3-dev@aaront.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004003030.160721-1-dev@aaront.org>
References: <20241004003030.160721-1-dev@aaront.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Thompson <dev@aaront.org>

If iso_init() has been called, iso_exit() must be called on module
unload. Without that, the struct proto that iso_init() registered with
proto_register() becomes invalid, which could cause unpredictable
problems later. In my case, with CONFIG_LIST_HARDENED and
CONFIG_BUG_ON_DATA_CORRUPTION enabled, loading the module again usually
triggers this BUG():

  list_add corruption. next->prev should be prev (ffffffffb5355fd0),
    but was 0000000000000068. (next=ffffffffc0a010d0).
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:29!
  Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
  CPU: 1 PID: 4159 Comm: modprobe Not tainted 6.10.11-4+bt2-ao-desktop #1
  RIP: 0010:__list_add_valid_or_report+0x61/0xa0
  ...
    __list_add_valid_or_report+0x61/0xa0
    proto_register+0x299/0x320
    hci_sock_init+0x16/0xc0 [bluetooth]
    bt_init+0x68/0xd0 [bluetooth]
    __pfx_bt_init+0x10/0x10 [bluetooth]
    do_one_initcall+0x80/0x2f0
    do_init_module+0x8b/0x230
    __do_sys_init_module+0x15f/0x190
    do_syscall_64+0x68/0x110
  ...

Cc: stable@vger.kernel.org
Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 net/bluetooth/mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e4f564d6f6fb..78a164fab3e1 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -10487,6 +10487,7 @@ int mgmt_init(void)
 
 void mgmt_exit(void)
 {
+	iso_exit();
 	hci_mgmt_chan_unregister(&chan);
 }
 
-- 
2.39.5


