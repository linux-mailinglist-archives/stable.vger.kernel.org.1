Return-Path: <stable+bounces-223738-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJWnJn2Br2n7ZwIAu9opvQ
	(envelope-from <stable+bounces-223738-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:27:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D842B244369
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70B1130BF2B8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 02:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2D0329E60;
	Tue, 10 Mar 2026 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C47puvp3"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E97389E17
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773109396; cv=none; b=u3dI1UjiLx9sOBp6U5cpCKfyRYR8FOrNp33B1MKxy0dK0yERPUhMFZJwPGv3oSw3nxAwnWHjlOChaLimc9hcVdB0N7+0AZ++9R+XOuj1dt0Vgl8VjA+qSOFPq1W3cBHo9gJOtkz7ZvJUR5t1wIADgxnrRAjKb8/05TWuB4cX+xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773109396; c=relaxed/simple;
	bh=0Oy/qyNFvEtDE/8yDLQLiQNDR3tE0+FMHYje7L9G/PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ip/L1paKm5PxA3gTjwAclGhI5ILr7O3KugpHF2awTfoNSPhCHBWlai1BVQm6cFkpTuskgoW3UrKzS7qhfmu+S8WRl8NEH93Syer/Req3AGNru4M2oMq88qBBGPm9OjXNmsDXt+c/PQt8MeEsAOQ39hBxEZtOKpX5wkEhFEQoOHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C47puvp3; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb4136d865so1648951385a.1
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773109393; x=1773714193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFupXAgsCNMzzR9u0i2kTyZWA+T6N2pNDlrnz/oCetA=;
        b=C47puvp3g1w6xKiWLtXnuUrKbihlja1sOGrd/oQh2MmnxibKYAXnaA0L/384/4mP9J
         ooRmB0R4IxnwNGH+SUMwRbVnckUpyuqLjYIrwl5XJvzy0euhvjpBFlvOh2kbthR/QR6D
         fcu9EyN7l9czIQtQn3NUKul+EDu58653LcHIY107lnP5EdszvOKMiD/AuHbEXOdIoEWQ
         r2bn8rZ61BKTVxJrMIJaJ9ER+5SAuZBw7AyTKRn2KQp6+2r8oWoMoOHwR0o4qTGbb6sc
         ixhR8QPZuolgoTzmra1KjJo0U59tMdvlja0HZnFtMb1vB0Uwxq5n2urRpSd+SsFGoTr3
         RwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773109393; x=1773714193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFupXAgsCNMzzR9u0i2kTyZWA+T6N2pNDlrnz/oCetA=;
        b=IsnY5R8G0DBNjLUs6nJH8SrnEnGe9vMJS4YjgVRqkm2PF6VdF8gER//m0I3zfCDx7v
         xcbJNOe/LMIJ1Sgfrg+0utIkZb7bd+dBsD8hf+UPkZIr5dAL/tBv0MmprH/NfwbghZNV
         oYRePClYHQaaWN7AyroWn64Aj00BgLYJxtuMgChCmLSaUIW9wtJWuEn+PXAEWMfyfUhT
         cQI7rdkkBMOctfkizR62e6QcmyUkN8mOoe28rtmov3G6IKK2PJTclHwL6jOF64Wra9ku
         2A/uix+NG9vS9nrN/cyc6diKsI5YDhGiAofs38MfWQHTasf00xAyVALc+zOFLsEOv/kD
         P7gg==
X-Forwarded-Encrypted: i=1; AJvYcCUguG0clCjlMnBnp1ugEdxJZg8mR1MpSlp5yluVA4GvaIvq7HAVdmkuicYpVWvO1m1VEEhD6yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKK2UyYTWiqcMmVgRBhcGY/i5H9EWFKpm3erLs/51cri+j9lqJ
	/rHpysISD0J9Agi8Y1pWwmHcaatJzqTXXOCRjqyBIs7pHBGFaJDKQVeHbUHzxg==
X-Gm-Gg: ATEYQzzowEO1meiwy20PFIfjHANedQyfoOYnpBiLedk/AgdHwZFQxKcwq7xBJZeJhEk
	Hw9SfKDNyyjJGxfodW9VjbxBXXGK9RACfjCnMxStsYtFQvjxT9mvTiCMrS/jL0W+9afT5RAnWn8
	oSBM6jvrXzdmHUa/4OHHWx/f8NGE6lZuLYn6ARNR0inqQV7Rx6C14YvznonM38BfkIDuIron+SP
	KXLOcHt9+u4owyOHUPILFZT7nFbkfOmFA93NWLSVf/IpdgWPHPBBmhpWsGZH5YLxg0JVPEcRVAL
	MJmI8FD24I5HYvI8nzh4CUBdCarAz/K0ajBDJU7FMt542NB/jF22A4ZGXGORKUMswwd09XWWEOW
	TlWGrSrnLZXkUWG9T9pvUkM6mAaFgJOoR8gB5u3S4Zm9+tfHSQjFUx3Di34euoLHv2fusBKHab2
	ExQhfAJATstp3WxBXTPRjU7ZI9+ouvat/iXoUYVDl7DW4+1a5NWlo7ges6AJpZA0S8ORpV1lA5C
	fk6wI0T9h3h9Q==
X-Received: by 2002:a05:620a:4514:b0:8cd:90d5:92f with SMTP id af79cd13be357-8cd90d5118bmr420088785a.9.1773109393145;
        Mon, 09 Mar 2026 19:23:13 -0700 (PDT)
Received: from Desktop-PC.. (wnpgmb0311w-ds01-161-217-39.dynamic.bellmts.net. [142.161.217.39])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cd6f54bb7csm782935785a.38.2026.03.09.19.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 19:23:12 -0700 (PDT)
From: jassisinghbrar@gmail.com
To: linux-kernel@vger.kernel.org
Cc: dianders@chromium.org,
	shawn.guo@linaro.org,
	maz@kernel.org,
	stable@vger.kernel.org,
	andersson@kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH] irqchip/qcom-mpm: Fix missing mailbox TX done acknowledgment
Date: Mon,  9 Mar 2026 21:23:00 -0500
Message-ID: <20260310022300.311125-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D842B244369
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[chromium.org,linaro.org,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-223738-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NO_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org]
X-Rspamd-Action: no action

From: Jassi Brar <jassisinghbrar@gmail.com>

The mbox_client for qcom-mpm sends NULL doorbell messages via
mbox_send_message() but never signals TX completion.
Set knows_txdone=true and call mbox_client_txdone() after a
successful send, matching the pattern used by other Qualcomm
mailbox clients (smp2p, smsm, qcom_aoss etc) of similar controller.

Fixes: a6199bb514d8a6 "irqchip: Add Qualcomm MPM controller driver"
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
---
 drivers/irqchip/irq-qcom-mpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 83f31ea657b7..181320528a47 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -306,6 +306,8 @@ static int mpm_pd_power_off(struct generic_pm_domain *genpd)
 	if (ret < 0)
 		return ret;
 
+	mbox_client_txdone(priv->mbox_chan, 0);
+
 	return 0;
 }
 
@@ -434,6 +436,7 @@ static int qcom_mpm_probe(struct platform_device *pdev, struct device_node *pare
 	}
 
 	priv->mbox_client.dev = dev;
+	priv->mbox_client.knows_txdone = true;
 	priv->mbox_chan = mbox_request_channel(&priv->mbox_client, 0);
 	if (IS_ERR(priv->mbox_chan)) {
 		ret = PTR_ERR(priv->mbox_chan);
-- 
2.43.0


