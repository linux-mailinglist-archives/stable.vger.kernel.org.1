Return-Path: <stable+bounces-241167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPQVGEAQ7mndqQAAu9opvQ
	(envelope-from <stable+bounces-241167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 15:16:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA1469EBF
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 15:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4684A30028C4
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E08361678;
	Sun, 26 Apr 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUDRj9N5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF4019CD0A
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209402; cv=none; b=rM0SzdCTKH119yQojAVdSSGyIlzGz4tkoEG4T+NdvumGDRU6+4/t9f3zx8ukTup/oLHklpQbrLsYzqUC5OQK2DltrFYWIQHzN6ajZKf8vahT0SzFNr6INhjTkHy5IxCdYVNKf0LdZvEfCxj9vEGnzLFga4pwKtbXsUSkjsbKE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209402; c=relaxed/simple;
	bh=e7QWtxSkrIHtUdA7OH0NJS72f3PZVhziWa99JGad/Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O1UcEMi+GXTViqpbbfAXAuey4c7bKMTB9PdxuzZZZWA4pBIcUTvGlL/CkGKL/e5Zm5oc35y747fwyZiuspo4HZm4Gj9sy9hMbCW7mmNoh2LG8BcfIFLBKzIj23/igMspxOm6kOIxXJ+nway2bRW+T7MI4go3JlcotBJi/MMBOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUDRj9N5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso5763452b3a.1
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777209400; x=1777814200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfpir1cWg4EgfZHLjfNae2jfgPK4QiC8JAKh+M/m5S8=;
        b=OUDRj9N5JSklq2oJFKv5HoZuk1dK3FguaS2NjCv1tEvY+jT3bVMj0AoSbH27ccN7Xz
         6rClED7AGlKUYuqTQwtfNNCEE2H1MYIg4XPlFSZ7yfyAPMBJaZFeVDQvv+GyFA7pHZvn
         mx0bFQkilfbSSo9QV9jgTlTt1PeMaMBhdgbEAJo/L27v6UcIfzE4fskMsfzEX+n2q58t
         Mq15gWvRrw262/600gJCX/apIkCTQy+25aXELIP8ByD2++d9wBEOuGhcQTA1v09IT4hR
         0I0H6yUqBEaro1MIekwNqx9NFGVQw9wS2ytUgTneX4MCWs82vks0gihIMwrFKDE9Xug6
         slGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777209400; x=1777814200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mfpir1cWg4EgfZHLjfNae2jfgPK4QiC8JAKh+M/m5S8=;
        b=XhrplX2eKbzkH8eUrRsbyNopUpXcM4mWkWLJOLufTg/qZpsj1j/8OPCF0ueZ6cECYS
         XMXR/ncyWXnQAlVM+oiGGaLsFOykx+5KhJl+1oQZBAczhotjJcMUAgEXlxBQE3yL0tyj
         SZKdxlsf7lhf5TgwpafjJgkUlto5jTBbDw0AtXBRPCHG0NoSVFsUEMliGod7YqMinljo
         WQLz4nRlWBz3SyTmgEva0pG+UrJfSDTzO8uTWAsZodO0Las30KKcbizbTTFsRDDBk+xD
         19oVA3pyLIf0tThXD6YvzoT6O9FSHM7YHY1wTfPU7dpWU1vY1c8KXgP9bWv8YIqa5wEl
         4T9w==
X-Forwarded-Encrypted: i=1; AFNElJ9SFqxmnUXxK66v6GhpWwSII9U31vEybMn4J/XK63gNhfR+lEIEcn4HmvI6uVIT3jlL3lQ/Un8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs4RX2Bf4FHjLWxc6NHiqV0fJlEL8055DgezimOsl5qeqyblTn
	8rDFhUSgeXV/cdSWzCMmRwRwGFDwZWihQoLXrlpL+r+huRhn9oL9DNE=
X-Gm-Gg: AeBDietfoPDMxJwNhXQqdaI4C5vL7vX7ncRz/ddjwmngn5GcGuCoGtrhttUcCDxdaZr
	cxgE0RXbZ75zpCMt6O5B/1Oh3L6GpHNQkYQUY/tJp5Ell46VeH6aWz48BvXGd6tNfbhwjBEV5wc
	APeARr1+pl6rls9mf9PYsUKtgqYP5ICrw4/Pkikz5oIoY8d6QsO8bESJtiUq9tUS8psoy5Dc8/n
	E2symVT2zRF3OyotqNMEELcvEnnrJuD2VtVKBVGOX8C7bcxnVnZ6TJuW0yDubOnn1EbpdCAssRO
	5l/FrvEcERVQxTAx80nfjOcl95TYI3rPGTBs3m+/b5psh6ZHaoFlKUXpdngwh55OpH5yWB63oM5
	/mOh1TIorgiSATOxScw2FlkQpq7eDVmdPhH9KaJFWAc5DB/5F/Iv/ZBijIEu+WbpgpJjvOAxv2t
	hDaoKC9coLl9yAI6rfPKFCTookrDM6M/WrUk1BhJvroO6xwhxtM8Rgn61iXc0HvPhovKXI6KIGm
	izK9Mn6LH0Wgu4DVGmX0GW8iVfQW52wDPzD7TWQ+WB0pBg=
X-Received: by 2002:a05:6a00:2d88:b0:829:6f7d:3086 with SMTP id d2e1a72fcca58-82f8b3aff42mr34206860b3a.11.1777209400127;
        Sun, 26 Apr 2026 06:16:40 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe41cfsm31773801b3a.43.2026.04.26.06.16.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Apr 2026 06:16:39 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] media: ti: vpe: unwind v4l2 device registration on probe error
Date: Sun, 26 Apr 2026 22:16:31 +0900
Message-ID: <20260424000000.547-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73DA1469EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-241167-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Myeonghun Pak <mhun512@gmail.com>

If the vpe_top resource is missing, vpe_probe() returns -ENODEV after
v4l2_device_register() has succeeded. Probe failures do not call the
driver's remove callback, so the v4l2 device remains registered on that
error path.

Route that failure through the existing v4l2_device_unregister() unwind
label, matching the other errors after v4l2_device_register().

Fixes: 4d59c7d45585 ("media: ti-vpe: vpe: Add missing null pointer checks")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Notes for send preparation:
- Fixes tag was validated against upstream history; the local row worktree
  remains shallow/grafted and cannot verify it by itself.
- Build was not completed because this worktree has no .config.

 drivers/media/platform/ti/vpe/vpe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/ti/vpe/vpe.c b/drivers/media/platform/ti/vpe/vpe.c
index a7e5a85e72..81bd1f9cee 100644
--- a/drivers/media/platform/ti/vpe/vpe.c
+++ b/drivers/media/platform/ti/vpe/vpe.c
@@ -2539,7 +2539,8 @@ static int vpe_probe(struct platform_device *pdev)
 						"vpe_top");
 	if (!dev->res) {
 		dev_err(&pdev->dev, "missing 'vpe_top' resources data\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto v4l2_dev_unreg;
 	}
 
 	/*
-- 
2.39.5

