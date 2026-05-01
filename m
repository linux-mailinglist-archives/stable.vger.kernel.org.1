Return-Path: <stable+bounces-242551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UExqAz4w9WlvJQIAu9opvQ
	(envelope-from <stable+bounces-242551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:59:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549F4B0219
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58C3F3014C3D
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF1837D11D;
	Fri,  1 May 2026 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b="HoRayGCP"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20337C0F3
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777676346; cv=none; b=qDEngebyVbuIPTcwi5UPx9NFgYJkfB5bunQspXZ8f9ey8x6i8+S+7TkJC21JAjodvKL9WBoYRVAz5umeiIhGy1+VP0HJP/5QPLwTesY77t9Ju2kvZEjlc88jYvls8Nl3wFOWMv2UtXGbrnuAXgO/YBvBCAeLlgHQ96QCxZ17/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777676346; c=relaxed/simple;
	bh=UlCiXbtXWuIqosOA2p9adzt3AbBoB6E1z4sBonjs93k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9GIBJ/F3nw3NL4OTSmQY6uYKrADNgmsCVDLSYFSVNc0WlSkeuFzbHaRzujuQIAUv3hh+1fD0qCbiwb5E43YdD/6ArKiz5LYcXmzaHO6P534edvcTUMYSJav+HCqYrQ0L04mb6Ff20GxQrI8fb5REarSBemrDwTzxqC1jXR63Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20251104.gappssmtp.com header.i=@nigauri-org.20251104.gappssmtp.com header.b=HoRayGCP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824c9da9928so1098972b3a.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1777676343; x=1778281143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DB31jPvrwkXD7aZt/7u0HOms5gkrxnTUOkOsWGwy19Y=;
        b=HoRayGCPPd4fGimgBwTN5pEZAaYvNuJ3/4ksBGVUFqMJLDY7dX8Aa8EschgjJccyTJ
         AmLgfhMEVy2x0R3w81W35RdFLc3bAZ0EIK2E4Q9S4qNXHJezuVXT9HscU/Z+4j4P8kvk
         GF2kH38W3MMrrvdogCOO0K0JeL15Ly2tNXmrW3SzOpAHW/fefa1LIhc3jRifPbEphX9c
         juOOmI0jlJ+kzqRy+lYc/nPvgAa923EeudArz5FdimbGUCb8TxBi5alsgabXcyzEDZ66
         FNvtfupN8BUB+eARFi8+poiXxUAhcE/fEXOdmZgYWu8BiQdB6xUSDu1Xkm+9aa0fjaaC
         yd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777676343; x=1778281143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB31jPvrwkXD7aZt/7u0HOms5gkrxnTUOkOsWGwy19Y=;
        b=BJjU3tALqn0EHmXZZUy13nYaW/HtUzpnIKqDw0spjtci8A0Ocsa+9i1+8Wna5AvF7M
         51XoCdygM8j74zFtXZ9/bGT8ulMGQhKcpwUTQGkBIcTDuNo+nn2bNpvqjaDHOBB7G4zw
         OSNN056BY0TIxiYfBou2dPDZ8weQ/zhd0P4tS/m0Qi+Mjb3tsUDjexbI0/n74V4Pns5J
         jCLG+vxR7tRyo+QVBAAoZ0ctv0FTldq7zQsXoX6g65/ogl4DZjl1BBDYnnEZm0AfgbZJ
         /BKf3MJOTvGjxPWgseQLdTQSDA244c3+sMysRAFC1bWK+fVYS+F5uACsKafrfBLjfJP/
         D/Wg==
X-Gm-Message-State: AOJu0Yzz9D5ZJlLLKUiGbMdjdQOH2trc81F1kvo9mQBaJrnR0IBPvhdJ
	LtK1yWizdzwjGeXUcASyXDHsobvKih34zJlQklGuFlxXPUt/bQksG4fjC3jJhscMGexmHqlw3Cl
	FJQ==
X-Gm-Gg: AeBDiev+8U9rMe89cNvr3WCLaMUxb2CAgs+Q1vYRC0KlAmXWZ7ehCWDBmUhgLyFTlf5
	N0Ki0xSMbDh86VVQWlA1HmhnddCG81dZoGzVaNmJgk7omCtJYCu4pj0oSmzUQr8sQTXqbzpXZom
	qe3XHxFg/6EiSVJPjWLI1CPfrzjNw1NDmhBfgjmdE4Fs7UOEPlEwm1GOh1j7BwLbTHnyxT23pvf
	g5JIrQU7WT9VY2x0KpzhalPpXZiCofppR7Ncbucx5C2ue140uQjQOYqCtplEfnGwJ/MDwk2KHUJ
	LFPhfK9vhAEK75hEw9cb6mzlQJVlvVPxkk8xJZ9F5oZsmsDbnBb0xGoI8xzBXP8yW1j7D30b87b
	rHEzScDkqnQOL/sL++XruX8OelS0LaInNgdaJjjGDBOLHJ3NY7XhJVjvb/wXjEDt33Q80Yvebf8
	d0Ep+C0cr/+UgjntMGgoJH/mHIytUmkuRl0LUAXlXCGN1OVp3/eaUGSVkXyahAdEItwBA=
X-Received: by 2002:a05:6a00:1a86:b0:82f:6a64:deac with SMTP id d2e1a72fcca58-8352d20b29emr895393b3a.28.1777676342993;
        Fri, 01 May 2026 15:59:02 -0700 (PDT)
Received: from localhost (ae047133.dynamic.ppp.asahi-net.or.jp. [14.3.47.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b73affsm3571932b3a.55.2026.05.01.15.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:59:02 -0700 (PDT)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
X-Google-Original-From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock
Date: Sat,  2 May 2026 07:58:59 +0900
Message-ID: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2549F4B0219
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nigauri-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iwamatsu@nigauri.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242551-lists,stable=lfdr.de];
	DMARC_NA(0.00)[nigauri.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nigauri-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

This fixes an issue caused by the use of msleep during spinlock.
In the original commit, msleep was changed to mdelay, but this fix was not
carried over during the backport to 5.10.y tree.

This is a backporting error, so no fix is needed in the upstream.

```
[   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
[   62.683957] Modules linked in:
[   62.687014] CPU: 1 PID: 126 Comm: kworker/1:2 Not tainted 5.10.253 #1
[   62.693447] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
[   62.699812] Workqueue: events deferred_probe_work_func
[   62.704948] Call trace:
[   62.707397]  dump_backtrace+0x0/0x1c0
[   62.711058]  show_stack+0x18/0x40
[   62.714375]  dump_stack+0xe8/0x124
[   62.717776]  __schedule_bug+0x54/0x70
[   62.721436]  __schedule+0x6b4/0x710
[   62.724920]  schedule+0x70/0x104
[   62.728145]  schedule_timeout+0x80/0xf0
[   62.728153]  msleep+0x30/0x44
[   62.728165]  rcar_gen3_phy_usb2_init+0x180/0x1e0
[   62.736946]  phy_init+0x64/0x100
[   62.736955]  usb_phy_roothub_init+0x48/0xa0
[   62.736962]  usb_add_hcd+0x54/0x6c0
[   62.736974]  ehci_platform_probe+0x1ec/0x4b0
[   62.744541]  platform_drv_probe+0x54/0xac
[   62.744548]  really_probe+0xec/0x4f0
[   62.744552]  driver_probe_device+0x58/0xec
[   62.744556]  __device_attach_driver+0xb8/0x120
[   62.744562]  bus_for_each_drv+0x78/0xd0
[   62.744568]  __device_attach+0xa8/0x1c0
[   62.744575]  device_initial_probe+0x14/0x20
[   62.752315]  bus_probe_device+0x9c/0xa4
[   62.752319]  deferred_probe_work_func+0x88/0xc0
[   62.752327]  process_one_work+0x1cc/0x370
[   62.759977]  worker_thread+0x218/0x480
[   62.759984]  kthread+0x154/0x160
[   62.759990]  ret_from_fork+0x10/0x18
[   62.760115] ehci-platform ee080100.usb: EHCI Host Controller
[   62.839982] ehci-platform ee080100.usb: new USB bus registered, assigned bus number 3
```

Fixes: 0f86a559900f ("phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data")
Cc: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 5166a115879ea..90f2a0e5b2aa0 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -386,7 +386,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 
-	msleep(20);
+	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
-- 
2.53.0


