Return-Path: <stable+bounces-226968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKtjKgJJumkFTwIAu9opvQ
	(envelope-from <stable+bounces-226968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:41:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDFA2B6822
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 07:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 704EA303BB2F
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5956367F3F;
	Wed, 18 Mar 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy4a4+qh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E86363084
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 06:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773815855; cv=none; b=THsD6H6ZqrcDSOzhgQ/wupv4OtTCKzVH5bFeayn9AjFsfWcNSxyqhJpm1MaNFuVNTwEjxxFDXgN4S2ZRjK/JR6P25WoPoN3fE3wnVUn9WtjUZNnwsJSLCLY4T7oHQnjcHUldOkQLYUGeMXhsHFN5f4YOHY6pNryxdBg/UqLUoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773815855; c=relaxed/simple;
	bh=4O3QCGLvuxp8TyNV8Xtul/S4j8KUMp0uGU1+uJd2FNc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qEbIOck+suFYvMruTjZAwh2v/iKDImvGxBtL2qqHPXML/vuaXNux2mza7sd4zY2OEkKNqw1u5aOISh1r9k1YB1PghA3xb7pTLvvhSWaxSmH1Sp7lmXMOgHsRw38mQeLK/g5MfgcjRLsiXpaUvFuHBzZVfZmcDaOt00fQDWN8S40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy4a4+qh; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5094ba0af1aso72652321cf.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773815853; x=1774420653; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TJIZ4oOL9g078MWbi96VubW95O3IIVBMwuixA0Lt16A=;
        b=Dy4a4+qhPSLMXf5HJ/18hZxtqo+cXxTnxOs/lnFJTAZWLsozkxhHSDvzP2ig6OjvOs
         tgWEGI8IBY2WSkvVV0bNe88oZhFTxOtwd4GkMGvwC9QmWUSahyN6UKO39BVKOnugcQjT
         NgBqgX+2fnAZIoDOsIrk66iZVFdOXNcM6YpZo/FKMqXFXCA0U30zrexZTQykVLuXt02t
         E+H0reQqlVxE5Iw8LZ1ruN4OGVB/cneNdAEGitfVLQjPHsyK/u2PhApOzDk63S8Nd4Vs
         jIJ5yGdUZV0v5pdC4i/94K3I3ODi0mm3WfF/u2MxUUTi0s1S+chy5hjk9ejFvxR3eYny
         PtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773815853; x=1774420653;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJIZ4oOL9g078MWbi96VubW95O3IIVBMwuixA0Lt16A=;
        b=r6eQFxWLihoTlcbLJqvY23nV55Ro9gOffmbVHv3wjs8vOgSfQE0Epq/4cP933V+LfS
         P9Q74EEdl8UEzZYeiIogZISgOTF/dPoEJ/XldEYcmAHi+WE0itMkbXMtfxG/5sTOz3Pp
         /eZzCyI5Ba0z9JSYEXQhqbwjJteMTM2gK3Pzv0MGaw5MOkEgPhqhXw1otBrTjWzHjifN
         LJXggkHlTthP/BiSm9KNbFgt/uidZWKByEYr2XPnI9RmXux0RZWCHh/TyUeClHKls7xr
         q2JSCZB2R12wMhQfoW8w9mJ0846+aYcs8Xuyrc0z7l8a6D7Ivo8woUluvqOXxQ13txJg
         kJOg==
X-Forwarded-Encrypted: i=1; AJvYcCVSOkncDsKu3cexEYjJtD41/rPfHPzwPBo1iPOW+W5oESGDfLy6/0KS673RGVjIK9kJMN4o4ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYnc9aKw6UPM+4dYGvi8LJoe0V6sfMm0lKpOgRFNt5Wj4pXop
	qZxrshJVgcy1Tk315u/K14hRsBQVEx5+yw9uMC4J8eYAaOvmGOUG3yUz
X-Gm-Gg: ATEYQzz7WALQ7PVkzzrPa7QrzKVE+NZC2nlCmzjhaPl9Qow0IxVQwmUw/zXspibv72P
	PJx+d9xo6METkEFHIImoUMlHcTmtOA++WDkar9TfXGJcYDmiuWDX3YoePg0owo4w46HwWdDT2dI
	d7UWC9dVCv4yGVardYC0wYuDw8BL7cfDLatIhnuqajt4fr4J98QIBudH0ZRbLdjV/fUvtB4TGZ/
	Iw5pTDlHBu4HlnxXgLWlAlVrRic0HLQD/jrTiWWkqpQ7PNOfWQEq3xhTtOI0InaQa1RJq/3tuXs
	2EYcXamdDHDbLtIBKWV1gVsSKD0/vS2fhcCuRhVvIauvcIrlu8WoN65hpNM5cg5rxdTKak2gDan
	0gFFMSNL37RbTjH9l7gw1E0lKzv4u/fefqoNJcQ/oB7e5KW/uWIBr/Y08+sR7ZGCnBSwIs1gQWB
	reLSEvCJ2U/J7Ivi0heOPNutXyOUVMowkJ
X-Received: by 2002:ac8:57c3:0:b0:506:9bea:3229 with SMTP id d75a77b69052e-50b148bc32amr26455801cf.69.1773815853203;
        Tue, 17 Mar 2026 23:37:33 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b135b875esm15235351cf.25.2026.03.17.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 23:37:32 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net v2 0/2] net: macb: Fix two lock warnings when WOL is
 used
Date: Wed, 18 Mar 2026 14:36:57 +0800
Message-Id: <20260318-macb-irq-v2-0-f1179768ab24@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAlIumkC/0WMQQrDIBRErxL+uha/JiHtqvcoWagxyYcaWw3SE
 rx7RQqd3ZsZ3gHRBrIRrs0BwSaK5LcC4tSAWdW2WEZTYRBc9FwiMqeMZhReTF70oGSJngYo92e
 wM72r6g6b3WEs5Upx9+FT9Qnr9DN1f1NCxhnHrkXeGj33eFucosfZeAdjzvkLK+TWcaUAAAA=
X-Change-ID: 20260311-macb-irq-39b8a3333bd8
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>, 
 Harini Katakam <harini.katakam@amd.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Kevin Hao <haokexin@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226968-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,amd.com,bootlin.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tuxon.dev:email,davemloft.net:email,microchip.com:email,amd.com:email]
X-Rspamd-Queue-Id: 0FDFA2B6822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patch series addresses two lock warnings that occur when using WOL as a
wakeup source on my AMD ZynqMP board.

---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: Harini Katakam <harini.katakam@amd.com>
Cc: Théo Lebrun <theo.lebrun@bootlin.com>

---
Changes in v2:

- Add Reviewed-by from Théo Lebrun for patch 1

- Reduce the scope of the RCU lock by using a local variable, as suggested by Théo Lebrun.

- Fix minor typos in the patch 2 subject and commit log

- Link to v1: https://lore.kernel.org/r/20260315-macb-irq-v1-0-0154104cbf61@gmail.com

---
Kevin Hao (2):
      net: macb: Move devm_{free,request}_irq() out of spin lock area
      net: macb: Protect access to net_device::ip_ptr with RCU lock

 drivers/net/ethernet/cadence/macb_main.c | 37 ++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 14 deletions(-)
---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260311-macb-irq-39b8a3333bd8

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


