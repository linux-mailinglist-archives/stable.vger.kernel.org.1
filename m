Return-Path: <stable+bounces-263829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RehVAd9nMWpkigUAu9opvQ
	(envelope-from <stable+bounces-263829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:12:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9BD690D3D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:12:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=b2aQkOyx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263829-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263829-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AB2130B2EE6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC2044A71B;
	Tue, 16 Jun 2026 15:09:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713FB44B681;
	Tue, 16 Jun 2026 15:09:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622547; cv=none; b=Yp/QN86fVkyWeDYULSNdX7yK8ANBfb+aQdv5x2Qu/M9pl8YY/jpPRiahZbVLSv8cZs+K2mRIB/WpnyUvB1SRA7/qeRe5g6ZesqHLl1IOAxdZHRsNdEfQcRmV2xeDWMhqd8UBm3rEIM97NQkhEOHDwfuhSSqU/pM4IkPi7QUmQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622547; c=relaxed/simple;
	bh=RRGOHYv9PIVGHzKVi3KVttJbq4+Oy1SrfUZCxHarreY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grvMv2SsZnjK03Sq9xshJYWOPWd6lB+HJp0k1dWm8MqUhaSM+KefkFfZ+Php2a4wPhnBxHWk5fX+2I7L/YihEmP7VQOpASZv2Yz6sozWR4vdu2P1QmRzem8jQvA5BPIxPNx3K5ONjChzZhrt2YLRehN1e9ClkYnir9cMXeLe+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b2aQkOyx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAA21F00A3D;
	Tue, 16 Jun 2026 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622546;
	bh=fklTJu+QGlgGPgERtI03nAtxEipNtUthYza0zDXihGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2aQkOyxArvQX3sdwW08oQdf6mVYnlG2FIcDPYxVSLUU7onMnF8PKnXhAygjCxjGX
	 E0Eui+Vz15l7isLxQqt8SS7HvILJWcgOFvFHDpfLhaSH/Byw3E0AhJ9qTr+wweg82Q
	 +P20I+psTREbGU3KutoVboujcH7JJVfMZQDLV6SU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH 5.10 004/342] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock
Date: Tue, 16 Jun 2026 20:25:00 +0530
Message-ID: <20260616145048.546190636@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263829-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:claudiu.beznea.uj@bp.renesas.com,m:sashal@kernel.org,m:iwamatsu@nigauri.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,renesas.com:email,nigauri.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F9BD690D3D

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 5166a115879ea1..90f2a0e5b2aa05 100644
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




