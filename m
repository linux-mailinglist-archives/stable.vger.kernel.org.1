Return-Path: <stable+bounces-213525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GO3mDlxeg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:57:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF9E7A4B
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B09130C83B7
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251392C0263;
	Wed,  4 Feb 2026 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tYjkIsVL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A01E520C;
	Wed,  4 Feb 2026 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216626; cv=none; b=OYpEZJ/YZX82bXi+0Jp33POYCYyvcdBnsDemSIN/05BXg5OlWYL8oIe5c0UkddKfa/HLpg0mU2y5KJVosgutzfNAREWaqylauoFATPV1LBHfAujYJS8sBvBtnQTqj4gl/FaIh0WrobByISHKPzBPKDajVnAzX7yBT436I5Vttjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216626; c=relaxed/simple;
	bh=IfwKdxuXWmuf/+1n9Bp3s+IsG8lcmajhjLfwczTxnbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i0jxLf0SPy80zevlPQDYl3SxOvePGjSSvfBOQGBuAk+7qkIihMlYnu7g4L1po6ir0eqEhRlGvyi4NXr41HfvygjxvVVaJEb5i86CilMvpVBaCkkn8TOZ4hNUhpdTFfGCFowSMdTPcXS2RHEVeM7C4evDQ0VYs5xLjR4mVto2BWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tYjkIsVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D46AC4CEF7;
	Wed,  4 Feb 2026 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216626;
	bh=IfwKdxuXWmuf/+1n9Bp3s+IsG8lcmajhjLfwczTxnbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYjkIsVLQqt56AfWjCmdL9aAf/oVcdLEVt/tadjQxkMvFuZzcvaErqvs2Q21QOyEl
	 7y8KrXT576napXqJUCmU65xrSHNPAsXz59ZK3ts22+Rdpxm4P20jS5QO2e8dApCGpu
	 PRKJpBA4Ry34HCW0GKYEhKSbFZG+EUD6eBWwnDYs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yang Yingliang <yangyingliang@huawei.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10 145/161] driver core: fix potential null-ptr-deref in device_add()
Date: Wed,  4 Feb 2026 15:40:08 +0100
Message-ID: <20260204143856.965634095@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213525-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,huawei.com,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0FF9E7A4B
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3036,6 +3036,7 @@ done:
 	device_pm_remove(dev);
 	dpm_sysfs_remove(dev);
  DPMError:
+	dev->driver = NULL;
 	bus_remove_device(dev);
  BusError:
 	device_remove_attrs(dev);



