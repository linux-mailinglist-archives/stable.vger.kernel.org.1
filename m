Return-Path: <stable+bounces-91477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DBE9BEE28
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E671F22270
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB91F5822;
	Wed,  6 Nov 2024 13:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pr1TeVQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68D31F4298;
	Wed,  6 Nov 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898846; cv=none; b=XGxZTMFhfb3OGomBblu3inJm82E5E7c9cOVOVfGjeIscW8kyr7NYw+scTSwgsQrpcMxyxVTA4cbIMZPNELKyT8fLjvNqc8p9/BZRcIDL4Jj4FBxS4GBRO7vrnXXyz1RwagrBlH1KOEeaMdmbMmdWAwy06m4nORcxfn13FJsqtV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898846; c=relaxed/simple;
	bh=dLSTJVH0CuecPRxV6lYLglqOeTUcVYeRM7vGIQ++t8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDJTfGgBKnAjSOcyFaz6fpzhrJg7qJyRcBf+a++Aa0HHSsYFXIXmqt2oDCRcJJSbxshAx5EAO19PJSJPnqQjMy2su6ETHqTABnZlnjOf//HXgxUJXlH07YsRrlYMMG1VtNLfkrG+Ibc7GpMTV5gu5uQTfGALP86vLm6bO282VXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pr1TeVQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB11C4CECD;
	Wed,  6 Nov 2024 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898845;
	bh=dLSTJVH0CuecPRxV6lYLglqOeTUcVYeRM7vGIQ++t8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pr1TeVQ/xlU1vFmTAWxzyIKLAPvvaw+dBagR9UmLDwC7WoDc6GQcOF6MPF06j7QjP
	 An5P+tjgGHx+RMZUEvs7+wFupeL5fnSjnWrXffVGVZESg1ny+6l+RFg9DHQrapgXJK
	 xGzXrGVjdAumqR74M7iL/mqhWMklpDUZSv+2nn4k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aaron Thompson <dev@aaront.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.4 374/462] Bluetooth: Remove debugfs directory on module init failure
Date: Wed,  6 Nov 2024 13:04:27 +0100
Message-ID: <20241106120340.762690215@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Thompson <dev@aaront.org>

commit 1db4564f101b47188c1b71696bd342ef09172b22 upstream.

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/af_bluetooth.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -773,6 +773,7 @@ cleanup_sysfs:
 	bt_sysfs_cleanup();
 cleanup_led:
 	bt_leds_cleanup();
+	debugfs_remove_recursive(bt_debugfs);
 	return err;
 }
 



