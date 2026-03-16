Return-Path: <stable+bounces-225509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM3JLVq2t2mMUgEAu9opvQ
	(envelope-from <stable+bounces-225509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:50:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EF295D0A
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 08:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D34383011C66
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 07:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED3352F87;
	Mon, 16 Mar 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MT56xu7y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4334A3DA
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773647440; cv=none; b=t1ArcN/yJpC43OG1pcJFvRB8ecxgdZF+ULtyPybWKWhsFS08+ChwsCQT6pO+y99jHz63tP0pvCmM2tKLOGFHOcnlw+PTm1vhIFrH5gbowjgotvDFuuqJPJ9EstiydtqNreF5YB1GfE2yXYNsoGPjQw7qxtDX4c1Rq84X4KsH0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773647440; c=relaxed/simple;
	bh=/RWe9PyCUXFRwSCWlayNd4QMbnC9+kpyi17Lalv4lm0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nIy8Md3ryzAFrd/khytZfZ9UgKwPlWDr8X0E2MHQhNx+oTPaQL75kYzoDzArFWkT6Ar4lPeuJbVvDHnwSmS3ue0xKkLPcHH3kVafdWRSoCDi0sFoZAwxk4GIlZMOReDVmQC9Dj5ZIjVkSbw4yipEkVDAyiwIajjwWNF7lYoo8Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MT56xu7y; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--khtsai.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aad5fec175so218447435ad.2
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 00:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773647438; x=1774252238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=70Y+37cssWLBM/QACErgvTZBS7seii+FSq2yCHS3MXI=;
        b=MT56xu7y1ycPe+nTwTGd2zeDEaYJaYAbLgUUI/0V0bZdZT7BMWCLIk5bRvolmQskNb
         63whBJLQ3s0BpAlfdjDccBts+dsbL8kUuYBULmeF9D5UfQomnCp0u6sKWbK18xTPfrPN
         lLOF960CgGXbFPxorzwkYjQ5dWU/2NL0uvbSmrSC6o36LHFZDwn762M8XgsgzloI6nmC
         7wMLSR6krcyE9dnsSJkeaaYiylSCGcehjCYMoK2CGEjtsTEqkGjN1yhsgqch8tkeoJEc
         T/Ck8Glvgjid9TuqWLhnKR8CqiPCs0C1q7SJ3+YtCblXhv+7nS6MpQ3CZ/R3LnKpT9u6
         BlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773647438; x=1774252238;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=70Y+37cssWLBM/QACErgvTZBS7seii+FSq2yCHS3MXI=;
        b=WhcBJrD/jaXyuWQUKtSmggW7mmrVALF/qTdTq2uiEx3mYehiW6fejaTgHNHEk9WfcT
         IvVMf0W7Kdk3Y5rNy2BI04cp1mb2JBHXXfG2gN3kETVkeXZYYc4YgvrSQJpoBRd9ip3q
         almWzQi8WN7llmezQ3UJG8dCkmBIFcmE07Nm2+47NwHfe3GK1RIuZyv8NyovfKyWz/RE
         t0I5vunHaE/PSe5n/TledyM4vPn/b+Nl+gJyakUyRjB8kywLSTrqPr80d+7/p/HuE+zK
         vsI7TSOY6grEh9uDt7TKoGWOFaxEsEWugbECarbXeCKC0yhbhNduWYaT3E04QNpkK7zr
         hirA==
X-Forwarded-Encrypted: i=1; AJvYcCWJQPQe0mCQY9mdF8cnVqbIjGYzKwrBgs+WgI4IHcZaOop5T0XfuUuLRlRV7rXmormCn2Ac16w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXuyUW1uDrOADP1edmxtYQnnpwlZtjtaBG8uwHoOs80Jv/SFT
	TGq7g1vq14TUahNHgGaYKJaHJx/2BaPPk5Mi+qDs3F5MQmkRRXecynDLvj1LHY3PQfeOJoLDzTP
	t1NLmsQ==
X-Received: from plblh14.prod.google.com ([2002:a17:903:290e:b0:2ae:3b56:7c68])
 (user=khtsai job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:90f:b0:2ae:59d3:27f8
 with SMTP id d9443c01a7336-2aeca999738mr112643535ad.19.1773647437769; Mon, 16
 Mar 2026 00:50:37 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:49:09 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPS1t2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0Mz3dSSDN280pwc3ZTUotQ0XQNjA5OkJAMTCyMzcyWgpgKgYGYF2MD o2NpaAIWD94hgAAAA
X-Change-Id: 20260316-eth-null-deref-0304bb048267
X-Developer-Key: i=khtsai@google.com; a=ed25519; pk=abA4Pw6dY2ZufSbSXW9mtp7xiv1AVPtgRhCFWJSEqLE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773647436; l=2135;
 i=khtsai@google.com; s=20250916; h=from:subject:message-id;
 bh=/RWe9PyCUXFRwSCWlayNd4QMbnC9+kpyi17Lalv4lm0=; b=TgvUJBTeQcaDr54lNumTEgp8wSLlfl1c9X6UN/k1ZUamWhUv2Q94uGWTtLUrpmRYWmAL3NAbc
 ba/BxZL7Q9zD97ejcNwbhb/hXgfH0+e6H2t1WQ4aGX70cyaCYZ4bZIv
X-Mailer: b4 0.14.3
Message-ID: <20260316-eth-null-deref-v1-1-07005f33be85@google.com>
Subject: [PATCH] usb: gadget: u_ether: Fix NULL pointer deref in eth_get_drvinfo
From: Kuen-Han Tsai <khtsai@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Heidelberg <david@ixit.cz>, Val Packett <val@packett.cool>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Kuen-Han Tsai <khtsai@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225509-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khtsai@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,packett.cool:email]
X-Rspamd-Queue-Id: 717EF295D0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with
device_move") reparents the gadget device to /sys/devices/virtual during
unbind, clearing the gadget pointer. If the userspace tool queries on
the surviving interface during this detached window, this leads to a
NULL pointer dereference.

Unable to handle kernel NULL pointer dereference
Call trace:
 eth_get_drvinfo+0x50/0x90
 ethtool_get_drvinfo+0x5c/0x1f0
 __dev_ethtool+0xaec/0x1fe0
 dev_ethtool+0x134/0x2e0
 dev_ioctl+0x338/0x560

Add a NULL check for dev->gadget in eth_get_drvinfo(). When detached,
skip copying the fw_version and bus_info strings, which is natively
handled by ethtool_get_drvinfo for empty strings.

Suggested-by: Val Packett <val@packett.cool>
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/linux-usb/10890524-cf83-4a71-b879-93e2b2cc1fcc@packett.cool/
Fixes: ec35c1969650 ("usb: gadget: f_ncm: Fix net_device lifecycle with device_move")
Cc: stable@vger.kernel.org
Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
---
 drivers/usb/gadget/function/u_ether.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 1a9e7c495e2e..a653fae9c0cb 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -113,8 +113,10 @@ static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)
 
 	strscpy(p->driver, "g_ether", sizeof(p->driver));
 	strscpy(p->version, UETH__VERSION, sizeof(p->version));
-	strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
-	strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
+	if (dev->gadget) {
+		strscpy(p->fw_version, dev->gadget->name, sizeof(p->fw_version));
+		strscpy(p->bus_info, dev_name(&dev->gadget->dev), sizeof(p->bus_info));
+	}
 }
 
 /* REVISIT can also support:

---
base-commit: d0d9b1f4f5391e6a00cee81d73ed2e8f98446d5f
change-id: 20260316-eth-null-deref-0304bb048267

Best regards,
-- 
Kuen-Han Tsai <khtsai@google.com>


