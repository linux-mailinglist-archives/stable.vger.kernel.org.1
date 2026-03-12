Return-Path: <stable+bounces-224817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK7cOvN1sml/MwAAu9opvQ
	(envelope-from <stable+bounces-224817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:14:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1426EB93
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 09:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080E930226B4
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0D30F7EF;
	Thu, 12 Mar 2026 08:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GScT1G/Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9BC3101AD
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303281; cv=none; b=fOsbjCMEn1/Oz2l+poOblji4hByXpD2ItgnXV3jxdq0qO26l3jEgY7nwMrO35lfsh2ZUmlM9vgX3BjX8TGslU+gL8ToTgdLbiMjp+6VQLJUFKmu0nbfhIaxqVU0oPYX+9wTPMNYi72mVlM4Jhxi0gP+u6qEL+RtKDJp5DtNQr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303281; c=relaxed/simple;
	bh=er8uEkvKYbxMLBrtAkD/Ds/M1WLkmn8Sf0zjcM183JY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hvsrI3iPS2nuvVDQCoq43Eqd4W/NxX+hHuJMVT5yABLEd8w0/fFQQZGUGljkVEEoYOn8Q0OBLj0bW5QE34obqQvjx8GzxDGuasCp6lw7OPTMTKlSDEm3Zr/RiqVffSlTXnym4YxM+26gj8BVfw+HN8rW+LWlxM9BU4YWAD4EW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GScT1G/Q; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a14be4733so9139686d6.2
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303279; x=1773908079; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFkV5VaoXwwGdJuWMIX9rdpBK0Bevm1lwza2wIag9uc=;
        b=GScT1G/QC06xwjZjYN4fFrJYyJxJmbl4ZisZxB4W5A/uG72wugoPvaypq0+s4v6SLD
         KZ87wgBrD37o0xozTZeSvtAmoktf/FsZU7YqGpkK+dCvQ2PDPVcuCniCmeisHmeWUZYO
         SesXyaia3c+w0tCUmey+8/B9YmQW7QYUcIaJ81nBuWnnAeYCMq+uP9B3bIV+e21ZT4w3
         JI54AYhw0py911qybx4PYpf5Epcf8Y9jU/o0kAAxlmdcH7+oWr8VzQda4L6pC5vq8Y/l
         +ZPluThT41N3n32mELnOv7uWGpY8okBHz2ub2T+YNo4/9CLfF9jskX6PTDhNH4JGUDsP
         OfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303279; x=1773908079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFkV5VaoXwwGdJuWMIX9rdpBK0Bevm1lwza2wIag9uc=;
        b=jftHmyUOPgLCCW6Uc8Kybvo4Cd6y5SfVTPjSbiO+SIJd9pRGqbWJX1tyvbkY7cclmq
         +VzkdCYRbR8vCBQ4b6H9VS2dAZM7H2n5O/kzx/or7fAhelV3IoJ1LZzYRtjd5qun0NIF
         JcsE0Hvspq8/B1QCXfbzyGNBL7+v6wE3HBH71Mc6xiMPgCjBjNfHVxZ8X810siGUym39
         qpRPCLwj15ACx3UFBPL4M3xBGhPhkR+wo3/efR+ny1Lu1r+TKGTXiTgEWRXEnuO4QWRW
         a6UQMTTvlriK0OhHCM211VtG9ySyro1S8Hc+SZ/WKlHu1Fa5/x+tq7j9jtWwTGMCBCVR
         OZOw==
X-Forwarded-Encrypted: i=1; AJvYcCUW0Wbo1uLzRrpWnRsP0WqaUewxvpPuo+Ko3T5o7AOy4zvMFftpBcn/KRFSWmoSyKjgwdJ/4Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrm9Jm8nIfTCe5bYthQK9Ds3iAKae1fndXi/uSV7Pndtila8ks
	4f06q32HDf3mfoUc1eyL+CJ1ko+tVIXwkd1xd62aVxnho3fPwZhMqDblRAIg98tt4c9t8Q==
X-Gm-Gg: ATEYQzwaVmzM/B7eJblVFWKq4cH1lpAuCNBUz8mA3mMWR5lDCmVo2casMDcAXFxgLLg
	Ji0yzf7Fv5Znc3lY/YaMuOmvL875m9cD7xJsugnFGBPAalweoN4+hMWqbgLAc0S5HZRHm3MJweY
	7mC9bn9Pjy6ostZGnOSCf0MZDbabLNnIU6dAeDHSHGLUyC3DD3jKS+6sSN1DT63fMdHwKuG8G1u
	gXxsJNdjfBGQ2BrA/aB3sZtzKmO0xkcD9nWXcPcgvZtHhuwXHCKZN2siIQxKewUzxP4yczjjZ70
	cCvsFdVSxjBuu0qL6FWbBscjLxcnZB4eHZKz7BErAAjUHeOidQTaesgrxapIhI7bUK46wfsHbqU
	eH5OeKP7qH+CUCxXGX2K7nKriyxG8fKAOYMDWib+gLJf24Xa252OkiOt9DzWvAksQ+3rqze9EA0
	JhghBVH3s3yfuLfOdydcsBcZGrAKFtMHymTvZjusJNhuY=
X-Received: by 2002:a0c:fec4:0:b0:89a:3013:be02 with SMTP id 6a1803df08f44-89a66b01056mr52519386d6.34.1773303278891;
        Thu, 12 Mar 2026 01:14:38 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65c122c0sm30423076d6.23.2026.03.12.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:14:38 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: macb: Fix Ethernet malfunction on AMD Versal
 board after suspend
Date: Thu, 12 Mar 2026 16:13:57 +0800
Message-Id: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMV1smkC/x3MTQqAIBBA4avIrBPUfsCuEi3UxhooC40IxLsnL
 b/FexkSRsIEI8sQ8aFEZ6iQDQO3mbAip6UalFCDaKXkh3GWPxiT2Tn2nW6tNU5oD7W4Inp6/9s
 EAW+YS/kAAGvwsWIAAAA=
X-Change-ID: 20260311-macb-versal-e5493bbac09f
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>, Quanyang Wang <quanyang.wang@windriver.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,windriver.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224817-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,davemloft.net:email,lunn.ch:email]
X-Rspamd-Queue-Id: 50F1426EB93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Versal boards, the tx/rx queue pointer registers are cleared after suspend,
which causes Ethernet malfunction. This patch series addresses this issue by
reinitializing the tx/rx queue pointer registers and the rx ring.

---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>

---
Kevin Hao (2):
      net: macb: Introduce gem_init_rx_ring()
      net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume

 drivers/net/ethernet/cadence/macb_main.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: f90aadf1c67c8b4969d1e5e6d4fd7227adb6e4d7
change-id: 20260311-macb-versal-e5493bbac09f

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


