Return-Path: <stable+bounces-80705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907098FB8A
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 02:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB231C227FA
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 00:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908151D5AD3;
	Fri,  4 Oct 2024 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b="BaUcvNxo";
	dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b="RYzUmZTC"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out0.aaront.org (smtp-out0.aaront.org [52.10.12.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB02A955;
	Fri,  4 Oct 2024 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.10.12.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728001899; cv=none; b=LXCPLqIpxvZZH/s28BY7pkvemPVA9Qt6by+DWlOyJ/KNUpITsPZhn/MO/R3yxfFOKy0g0V9R0MPPqgx9sgkaqpdmF9rv/RogyIZuLav4EupVZaSRwKYALadRSQu4TA+nLOnuHsU8Tvtd5qQWwHQZRJXuJVCzr+rL4gBfq0AnPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728001899; c=relaxed/simple;
	bh=f0FQOyiYq7FpaBC/Z+gvQXYwpERUJNHDeFsnskdp8kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIlx4MYu1Sj/6SzQKiJOqMb0F387i3Jc5bBUHcpfzCyOQbawOx2o2c/tlyt18FMWWy7plGpEmeC6NjHdJsBbCrIjySC8cZe8XavxB1scDZgLN7m4lt4A+YlxQou80JzCFmbGYoIuEJ8OZKQ9ZPe4jGq7YNJKicFJl+g2GodOlaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org; spf=pass smtp.mailfrom=aaront.org; dkim=permerror (0-bit key) header.d=aaront.org header.i=@aaront.org header.b=BaUcvNxo; dkim=pass (2048-bit key) header.d=aaront.org header.i=@aaront.org header.b=RYzUmZTC; arc=none smtp.client-ip=52.10.12.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aaront.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aaront.org
Received: by smtp-out0.aaront.org (Postfix) with ESMTP id 4XKTxj0NhpzRj;
	Fri,  4 Oct 2024 00:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; d=aaront.org;
    h=from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=bgzxjfijqntwovyv; bh=
    f0FQOyiYq7FpaBC/Z+gvQXYwpERUJNHDeFsnskdp8kg=; b=BaUcvNxo9vK/8Y9J
    +SKv7rgse3m3vjeAeGt0M451L15SmSrzYNnmkHl9RIZykMapV2JCcxUbDJpverVh
    HBEwAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aaront.org; h=
    from:to:cc:subject:date:message-id:in-reply-to:references
    :mime-version:content-transfer-encoding; s=elwxqanhxhag6erl; bh=
    f0FQOyiYq7FpaBC/Z+gvQXYwpERUJNHDeFsnskdp8kg=; b=RYzUmZTCxYVdJUAq
    FDkVjIAy2EyvrYyJgzVF3xozkaeMgRKz6Ht4J/hHAqQ3l4dRPKKZQM0phu011sU8
    YZuYBNCSahCg9yR6l1zQNTfbW/ojBR2IrATVS6b9dqR4bNRb7RIw5SJREASVWcFo
    ho1Lc3dP0kELPM04St0kpAZuwuQwM8P/wvas85DFp+VNEEPY2Z1GZKwlxKXo+ytr
    0FACIeLA2VL+gU+oZr1sHQdwC3puUGDQ3G2Nyvp1CmoBgRQh4wG/0+IG4whKNte6
    FC77CRtDVyfvKmWJKMn9KBxtLlhKpHfsY0MbbuFfh8L+HN7XDKnl+z2PrJSx6SlQ
    mQryWA==
From: Aaron Thompson <dev@aaront.org>
To: Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aaron Thompson <dev@aaront.org>,
	stable@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove debugfs directory on module init failure
Date: Fri,  4 Oct 2024 00:30:30 +0000
Message-Id: <20241004003030.160721-4-dev@aaront.org>
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
index 67604ccec2f4..0d4b171b939a 100644
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


