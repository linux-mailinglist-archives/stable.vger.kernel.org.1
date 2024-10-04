Return-Path: <stable+bounces-81142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD899129F
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DA8282871
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3CD14D430;
	Fri,  4 Oct 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="cAeDnDBp";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="pV+KgAow"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.aaront.org (smtp-out1.aaront.org [52.0.59.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D34314BF8A;
	Fri,  4 Oct 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.0.59.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083097; cv=none; b=i2gkwGtOfM22k52fMczsHYrx8ARI40PckdT/KS1KKCuw+cwxz6dWLb9M4bk0qz/N/3XXA232DTfi3DK3rKmz0L5yDN/xaqvReRuKmeNkLavZ0yuQ7MJcjdeL0hPKcQnkgAUHSRWvnas5y4H7V7XgclpwZCtlTtj2icdks6oXYF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083097; c=relaxed/simple;
	bh=gjC0Th+4DQx0Zl7m12gapSe4WeazmpHFL5sYGpiCjZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiR1tVbJlIqwg8rDlAS1t6pjjgUv0R4X0vMUVg/hZ91iQjk8hnZdb5tPaoRsZh5hodCAStJqXyuulWjX+Bv3X+O/tlGIyQMoeiU6pGFnAoyVLlRTmtzwcVmmPZiGU57QWJ80CDLWjFQc8FboSMSOdcClTp9souBpcMuHtpZoC/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=cAeDnDBp; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=pV+KgAow; arc=none smtp.client-ip=52.0.59.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: by smtp-out1.aaront.org (Postfix) with ESMTP id 4XL3zB3lbjzhb;
	Fri,  4 Oct 2024 23:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=habm2wya2ukbsdan; bh=
    gjC0Th+4DQx0Zl7m12gapSe4WeazmpHFL5sYGpiCjZk=; b=cAeDnDBpMkfdvdJI
    yoDHF7j8Up7w/R6ugfnzyBzwmG+PsF677z4I1g3qauQNzPfKMS8FbkH9tWgLVDia
    ls5uDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=qkjur4vrxk6kmqfk; bh=
    gjC0Th+4DQx0Zl7m12gapSe4WeazmpHFL5sYGpiCjZk=; b=pV+KgAowrzgf2CKI
    t6svpSLdxP7uXpmy89/xmyBg2tVG3zMxPq0N0NaeaFL81JIgrtuuJ3wqOdwfHOQ0
    N70P97RbaVnGysIsP3tExLOtsSRwdIyvNLDabU8Sxo87Mmk+iwD050AO6kMANMfE
    YJLffECp75vww5ZmB74s0kPSfW1WhHIjKFK9KLtjYZu569GwjyFNFtrDVW1OsU6S
    I2aw9l7ayGx+7aulYj//ZqB6mO2erC3HfLh9/+9TSKSOIkhNwqEBH0qxyFjANgok
    SUBDXxJfgaa5kuN0bDRrxu8t54tqZYNU7YCn73WfV/n6yVVSRPj2cg00bSs+ZJ/w
    /wNjUQ==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Aaron Thompson <dev@aaront.org>
Subject: [PATCH v2 2/3] Bluetooth: Call iso_exit() on module unload
Date: Fri,  4 Oct 2024 23:04:09 +0000
Message-Id: <20241004230410.299824-3-dev@aaront.org>
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
 net/bluetooth/af_bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 67604ccec2f4..9425d0680844 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -830,6 +830,8 @@ static int __init bt_init(void)
 
 static void __exit bt_exit(void)
 {
+	iso_exit();
+
 	mgmt_exit();
 
 	sco_exit();
-- 
2.39.5


