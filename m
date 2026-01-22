Return-Path: <stable+bounces-211235-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ct+JoAocmmadwAAu9opvQ
	(envelope-from <stable+bounces-211235-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:39:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C91EB67674
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 14:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 184755CC190
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 12:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD8743DA4C;
	Thu, 22 Jan 2026 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="V8jDrsU6"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD94438B9B5
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086373; cv=none; b=hVwjBfBCGKIx1Si5VWZQe7+W5poP/6YHtCd/O1hgB2kRbREx5LnCNs5h7xFjPM6xCN8TVbHD1D+LIy5QYj68Fs4B3YNQzqGo+g/Yl/7EQzyx/3yNdWFjhG6zUWckRAcPz8/yee5CbruNOke2jDtC7GG9o//8NBCYZ/4HNDVGUpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086373; c=relaxed/simple;
	bh=t4nOh5+o6JtAHNx+SkB2act5HbVqYvsLbYlc69Dki0c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=LgANGcx7hsKYRjsnOWfnznMmBhyNEDfkaT88vvNZvgKlS5ZaRMyvcr9fJvf3LM5MJT0qvS4DNSetaZkycjL9ErxPMv8BF6dcrft6i5AZNz8KYJ9Fag93GKiTXg3sZgFTvaOsGvQIgIjyREzFKMCdOZEDKz3Y5tda1Lr+a9jh9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=V8jDrsU6; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1769086360;
	bh=qbhItpn/5xI//ajON47j98HZD2pa2vAZaJkbVepWAz4=;
	h=From:To:Cc:Subject:Date;
	b=V8jDrsU669asMf9WZBWTruXjaeZj6jCy7eBj7F+OWH/ckgsaYiHvOLKLoj4iHINoi
	 14REvWwk/R3BUXI6ZlRrJpWJe904e1B0lXjYV6woUmU0qfATpHI0ceo4xJXiemkVbD
	 aM4TSGNVlJtUe/W+t515OUH25dIrMCNHOeuacwlE=
Received: from ubuntu24.. ([2409:8a00:dd3:9760:5235:9dc:dc2b:b111])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id CCD91427; Thu, 22 Jan 2026 20:51:13 +0800
X-QQ-mid: xmsmtpt1769086273t0bf25sk1
Message-ID: <tencent_B519CC73C33FAD50CDEE4799E49F75064E06@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku2EYAtOoMzE4X7gxqeeuoNtkvf4+kibaw7YL5WyYqnjV3MeIQFhd
	 YP/tJeeOBzBNmnGYiUZ3T992ShijCtZMyB6FoBtS95HpNgXhOlyV5dPwMiAJJY+nkHzl4yVYrc5G
	 VI75fjjEb5ON/5oPFI7liIQz4LTt9q+9XZYasBY//BvQ3aOx1ZWOgeCHuwjyFCedU0xznmWrbovP
	 RND6LUi6iiYzEzfzhclWgzyIckjW4a/vaxBIxpOvKQbrFa/mM+PhDk0gPLeb4WAazoRU3qpes2Rr
	 1MZBP0CiJi8XWZLNNc1lU89T0qdP9UliaKWHvEBz3HLkZBLxccjd7GQSWwmW+rMTue+auxd1DPQX
	 +ZX5FrlzSiDXSK+0cIb0/VaqX0o8oYAydYaXWRrg+ps1HMKBYTkumzf4PUkyux01Hqn8C2Id86Wd
	 Vern/zAtSW6BdHGpksxKXYm+iE/nTpc6rK1EL5oC/jdGhR7hzYkEHBfiBhbhPBWVmniNTVm1IyvR
	 YEthiSbfBHc62L0jRj6VGlBnWzRObV7dZxzwLCeid9FLnJ4EJIcak7nUWtKZg0QdnanmHranCvH3
	 RPz9ojS7+Yol6xmAsKHdCsaQByXHz66FW5d7lOmsb9qtCRH/qh6j2mAkRn63/lvn0N+p6MrbXBB2
	 tMQaCwqZ+CRmMogyJMDRn4yMSJdvqJlZ2ZMcuFoF1Qm6ezFFY+OvtHrnemUavEizq+OuJ3LlmfdB
	 cAhGsFUbh3DvfAIpWHdM3teNo8RZ9773Yzxs9uMmPX7en3TfXmqVNXtyV0hiJVPD8ZdY+pOTQts7
	 TdZXpv5bDKTkjIgSt6vCS4GZi5G8YFBNsGNSkAnYXgzAROKvj8xXG35m1s2nRQm5xk98usYqxM+Y
	 nlT76gTHGpxJW/an3DXM8XlHOIfktovD5zBK4Y+bTQhhAoOoDHim72lekaT9NNLyeVNCCm4c9878
	 O4uAlO1fmOFYPGaK8KycGBTwq7hHyZUeeM8EhHnkltjOinR7ZmYFogDDekGPq4o8tLg/jNosobwx
	 DxCass+Ymfx4osUGZ2usc8wyIbdMF5rHri8sGx+rwA7d2HWatNwbHDOXgSxXnMIxlpLO5xZvkXGJ
	 LlXSmZH3hyxfxO18w=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Yang Yingliang <yangyingliang@huawei.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10.y] driver core: fix potential null-ptr-deref in device_add()
Date: Thu, 22 Jan 2026 12:51:05 +0000
X-OQ-MSGID: <20260122125105.4554-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211235-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,linuxfoundation.org,foxmail.com];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[foxmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[foxmail.com,none];
	TAGGED_RCPT(0.00)[stable];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,huawei.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: C91EB67674
X-Rspamd-Action: no action

From: Yang Yingliang <yangyingliang@huawei.com>

[ Upstream commit f6837f34a34973ef6600c08195ed300e24e97317 ]

I got the following null-ptr-deref report while doing fault injection test:

BUG: kernel NULL pointer dereference, address: 0000000000000058
CPU: 2 PID: 278 Comm: 37-i2c-ds2482 Tainted: G    B   W        N 6.1.0-rc3+
RIP: 0010:klist_put+0x2d/0xd0
Call Trace:
 <TASK>
 klist_remove+0xf1/0x1c0
 device_release_driver_internal+0x196/0x210
 bus_remove_device+0x1bd/0x240
 device_add+0xd3d/0x1100
 w1_add_master_device+0x476/0x490 [wire]
 ds2482_probe+0x303/0x3e0 [ds2482]

This is how it happened:

w1_alloc_dev()
  // The dev->driver is set to w1_master_driver.
  memcpy(&dev->dev, device, sizeof(struct device));
  device_add()
    bus_add_device()
    dpm_sysfs_add() // It fails, calls bus_remove_device.

    // error path
    bus_remove_device()
      // The dev->driver is not null, but driver is not bound.
      __device_release_driver()
        klist_remove(&dev->p->knode_driver) <-- It causes null-ptr-deref.

    // normal path
    bus_probe_device() // It's not called yet.
      device_bind_driver()

If dev->driver is set, in the error path after calling bus_add_device()
in device_add(), bus_remove_device() is called, then the device will be
detached from driver. But device_bind_driver() is not called yet, so it
causes null-ptr-deref while access the 'knode_driver'. To fix this, set
dev->driver to null in the error path before calling bus_remove_device().

Fixes: 57eee3d23e88 ("Driver core: Call device_pm_add() after bus_add_device() in device_add()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20221205034904.2077765-1-yangyingliang@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/base/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 82eb25ad1c72..e162c0c49787 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3036,6 +3036,7 @@ int device_add(struct device *dev)
 	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
  DPMError:
+	dev->driver = NULL;
 	bus_remove_device(dev);
  BusError:
 	device_remove_attrs(dev);
-- 
2.43.0


