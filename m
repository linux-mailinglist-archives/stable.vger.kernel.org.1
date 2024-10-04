Return-Path: <stable+bounces-81143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65039912AC
	for <lists+stable@lfdr.de>; Sat,  5 Oct 2024 01:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6E02825C4
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB744153838;
	Fri,  4 Oct 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="EmRgQN6s";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="taiYZnGu"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.aaront.org (smtp-out1.aaront.org [52.0.59.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D61514FB;
	Fri,  4 Oct 2024 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.0.59.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728083100; cv=none; b=SIw2KkdkEYP6jVJVX22jesl8knKQSeAyrJ66Op4whoINamjWkBuHC6sQfjvwgEC6kszNBJEmvc1rxymo+KsqyTCREBiy1BnPAVETB6USd/fWbBrUBZbOoR/iwBxHBUwyaF1Qtv41PyPQACtuPmY1o5zWSgifiGNeHXi+OZvFe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728083100; c=relaxed/simple;
	bh=GXAjDisMoyLwQzUTKYzMVSa+TUKX6Km3nnqbIjEYk2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTbOXsDQa6PbtLkJLtNJdws3ncMpFOfQIsRj0HZY07+/VtnbFc+lr5QUaCzSFXY/X0ZI8UBxCe6E6xm0amrg6giEYMQa0iw3ZfQa2F+TYPCneMv0g+4T0l8VwBrl7QvxWEgez7580UfVUvtq1n7jzJLPMclHG+/w1XTDUgKaKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=EmRgQN6s; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=taiYZnGu; arc=none smtp.client-ip=52.0.59.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: by smtp-out1.aaront.org (Postfix) with ESMTP id 4XL3zG0mnYzhc;
	Fri,  4 Oct 2024 23:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=habm2wya2ukbsdan; bh=
    GXAjDisMoyLwQzUTKYzMVSa+TUKX6Km3nnqbIjEYk2M=; b=EmRgQN6sE1l6bqyi
    vFegWB+X8ymQlNaIRv8zLKBbw9mjI0hyv4xI9FsjAYMP6Nb0ZRCmfFUH5aFMvLI/
    TIjUBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=qkjur4vrxk6kmqfk; bh=
    GXAjDisMoyLwQzUTKYzMVSa+TUKX6Km3nnqbIjEYk2M=; b=taiYZnGugeAww4/X
    frnVl5z3HiwfLamfU3GfMVjZOu13ScBI4IFQwcqDxPhvnNilOsVZAQxUVo3/WcGU
    gR7VEofOdyJEBwI931+trFtjWWbmDEi/FeAQbLHJQ4Hed+Gzm7J0AVY+psVzYMVY
    T9QKaNhOplVuSiFNSk2eOh2f991USI05+6TQ8PD2ISr7RxoTqBjxtbiqiK8e/tGA
    XVwukyPbxNa4HO9rJ+5PC/Vti5Q1WFmQITylVUYzKzCcpAPW8jaYbpFNP4K6tS+N
    UNLutAhFT45/cbP06YLC5AN11yQKY2kNFG7kvI5HXMxII7V3u9CzdFtROSLnrC9b
    4Eyrxw==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Aaron Thompson <dev@aaront.org>
Subject: [PATCH v2 3/3] Bluetooth: Remove debugfs directory on module init failure
Date: Fri,  4 Oct 2024 23:04:10 +0000
Message-Id: <20241004230410.299824-4-dev@aaront.org>
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

If bt_init() fails, the debugfs directory currently is not removed. If
the module is loaded again after that, the debugfs directory is not set
up properly due to the existing directory.

  # modprobe bluetooth
  # ls -laF /sys/kernel/debug/bluetooth
  total 0
  drwxr-xr-x  2 root root 0 Sep 27 14:26 ./
  drwx------ 31 root root 0 Sep 27 14:25 ../
  -r--r--r--  1 root root 0 Sep 27 14:26 l2cap
  -r--r--r--  1 root root 0 Sep 27 14:26 sco
  # modprobe -r bluetooth
  # ls -laF /sys/kernel/debug/bluetooth
  ls: cannot access '/sys/kernel/debug/bluetooth': No such file or directory
  #

  # modprobe bluetooth
  modprobe: ERROR: could not insert 'bluetooth': Invalid argument
  # dmesg | tail -n 6
  Bluetooth: Core ver 2.22
  NET: Registered PF_BLUETOOTH protocol family
  Bluetooth: HCI device and connection manager initialized
  Bluetooth: HCI socket layer initialized
  Bluetooth: Faking l2cap_init() failure for testing
  NET: Unregistered PF_BLUETOOTH protocol family
  # ls -laF /sys/kernel/debug/bluetooth
  total 0
  drwxr-xr-x  2 root root 0 Sep 27 14:31 ./
  drwx------ 31 root root 0 Sep 27 14:26 ../
  #

  # modprobe bluetooth
  # dmesg | tail -n 7
  Bluetooth: Core ver 2.22
  debugfs: Directory 'bluetooth' with parent '/' already present!
  NET: Registered PF_BLUETOOTH protocol family
  Bluetooth: HCI device and connection manager initialized
  Bluetooth: HCI socket layer initialized
  Bluetooth: L2CAP socket layer initialized
  Bluetooth: SCO socket layer initialized
  # ls -laF /sys/kernel/debug/bluetooth
  total 0
  drwxr-xr-x  2 root root 0 Sep 27 14:31 ./
  drwx------ 31 root root 0 Sep 27 14:26 ../
  #

Cc: stable@vger.kernel.org
Fixes: ffcecac6a738 ("Bluetooth: Create root debugfs directory during module init")
Signed-off-by: Aaron Thompson <dev@aaront.org>
---
 net/bluetooth/af_bluetooth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 9425d0680844..e39fba5565c5 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -825,6 +825,7 @@ static int __init bt_init(void)
 	bt_sysfs_cleanup();
 cleanup_led:
 	bt_leds_cleanup();
+	debugfs_remove_recursive(bt_debugfs);
 	return err;
 }
 
-- 
2.39.5


