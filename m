Return-Path: <stable+bounces-214377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBWGNr8EhGmHwwMAu9opvQ
	(envelope-from <stable+bounces-214377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:47:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBE9EE186
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 03:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015F0300CE61
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F062C1F8755;
	Thu,  5 Feb 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCz8lea8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7423EBF11
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770259642; cv=none; b=axTsyzdfTyP0xyKEWZpRVUmKBW2YSP1q8Ow7OK35leoF3a3iXJlRc7aquyk5E5MjlN/X9//oplseVgFCbByUa0qQxV/P0d5xrg9tiShXVT5fgj23mSCxqut5HsGB5F+Rdq+yE8/cLL2J2jt7NlkbbHUMY/MV5aJO0tCp/LDFPL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770259642; c=relaxed/simple;
	bh=8Gg0Td2TnZxUw2O77jFwN1ILQNYnFw/fjFCDTq59L7s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IBA3c8U4Ot/wXEx0+PUGwwH2iuyTi4JVw/HXKgg3xB/NR5W2XZSlU9usFSsiQ8RWpB0eegmftwnBlGa8pYrA4MP70kolg2bavuDepc1zLdSmed1T2gTCcYBBpgtkkvOn54SgHlHq5eJ3G8lHjzSJDhwLRgQgO2NRXel2MqC+FNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCz8lea8; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a3d2f3299so6171856d6.2
        for <stable@vger.kernel.org>; Wed, 04 Feb 2026 18:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770259641; x=1770864441; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nY8yM9Zc7+K73Kkfh7FYItubbQedLPsN6KpC2egtpVw=;
        b=VCz8lea8AO24AxguUZNZbQHcKsENy+UuqehHjyHuDnOmJGfUMnTBbtrE+3A2FN2Mcs
         /5yvx/4iXb4ir00o/Hj0jbCkVq8kK6sGBuo/MV0QujfbUxUJQgcSgcnwtef2uGS/ExU1
         Vo/Eter55UIofqEEJhSghxHifpr88MsDdZ6y6elB67y8khqmVCXnhEsX4ZX/AKXf4tHK
         L5ukdPJDL9BnviNJTiDhORFPL+cRlE0Xq/vqfNc0MFgM0DvsuFiDr3S7lHUUUEnOdEJQ
         srpxmg2Vo0hAkmHwvgwLTvgvdHp7QyMSAGs1AGh+Hm7J2N9YUVJt3Gy7ewnf9fNcskA0
         sJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770259641; x=1770864441;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY8yM9Zc7+K73Kkfh7FYItubbQedLPsN6KpC2egtpVw=;
        b=OROdkezPpnBp6lKFpDc1q7+wD+6zLO7r2KnVdiIuipsXUhjXdXi4gtBQcVCIiR/OtN
         1B2D9xqXMhjgoIr1I5YyOIytnuUzkF3FKhzmnVOu78EyG9+SMYROmdJGnjKyGgBC9vEg
         qkYzVK4HYG79eY1AkwE3tlHSWf1eQOhnYtNUe+agLdsiUZbtIFlKm5NZQ1qWh8VpMLBt
         /Nlc+2sVG1C9z+MP3wIkK0Yyt1z4rKUfd1AHPniMnf6fQHVEpoKkiyt/4egEPszTiDlO
         IhPM6h3YMBpPAN/4JYywAZjKFqC2Iw5xnquUii4fqceqbwnWk6qlko5DiGYuDyv09WQe
         InIA==
X-Forwarded-Encrypted: i=1; AJvYcCXXDZmNO8vMaMbDaROhJ+QQ290L+yJfUDdii4lZR0ec5BLFe43R0GuF0c25IMztkVtoL693mD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQdZhgzFxz8JnxW6kRsVHsKBORDDi7pmdnBMeQKS91+uiRXS2y
	nNFYmPamOTetFtNeaftKvo1VGT9jYaB4jLHRZS4q/y+1t48eNv7PxsiB
X-Gm-Gg: AZuq6aJu/nCgHYoGZJO6tDwIXh9mvt30RrJUIupx06ruBUsjkoNQIrs5E/C2gW9ARee
	1KRD7dnhmJBnYmT+1X3m4AiiP6RWNu+2MZoI9OpNnxaje3/KsOdubUO0O4QLe/mmGIqs2rX1ZnY
	fa86jteaa5dkhqVbGj84V6HFmiGCZl8xoW2lQwh2y+YCNxkzkk/3vgDDOSxKGmuPVdhCGsu/zhk
	uSpUnKKN+4RSs6XmWaYtouJ7fBSPSJX/Ln1R7gpaWyQR/jUcp93gBT3JAQn1y6xvP7SCFZhzWeM
	FyuhmulorQSmA+AIhBpFETR07KnsnRKKjrYqgqo80aDZWPz2aY8fvSrj/e+k3SVRcLLFArn4Pom
	Y9+nfbtNyAm3U8QFCNRRf20Hhzp9uZarBUiN9rtGyhZxMSukEQS01olJhng+mQ0FzLR8t2vrqk9
	VWq5As/BEqtR46Nx3fAFH+NJaENkQReRQ=
X-Received: by 2002:ad4:5ce2:0:b0:88f:ccba:8f20 with SMTP id 6a1803df08f44-895221ad111mr65849446d6.48.1770259641266;
        Wed, 04 Feb 2026 18:47:21 -0800 (PST)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ca2fd2b5e3sm308193085a.25.2026.02.04.18.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 18:47:20 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: cpsw_new: Fix multiple issues in the
 cpsw_probe() error path
Date: Thu, 05 Feb 2026 10:47:01 +0800
Message-Id: <20260205-cpsw-error-path-v1-0-6e58bae6b299@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKUEhGkC/x2MMQqAMAwAvyKZDdSCCn5FHGoTNUstqahQ+neLy
 8ENdxkSq3CCqcmgfEuSM1Tp2gb84cLOKFQdrLGDqUAf04OseipGdx1I1K9+tDSQc1CrqLzJ+x9
 nCHzBUsoHZMvzs2YAAAA=
X-Change-ID: 20260202-cpsw-error-path-dd5bc72d6daa
To: netdev@vger.kernel.org
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Nicolas Dichtel <nicolas.dichtel@6wind.com>, 
 Murali Karicheri <m-karicheri2@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, linux-omap@vger.kernel.org, 
 stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214377-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ti.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,nxp.com,nvidia.com,gmail.com,6wind.com,linaro.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 3DBE9EE186
X-Rspamd-Action: no action

These two patches address duplicate or unnecessary netdev unregistration
in the cpsw_probe() error handling path.

---
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Cc: stable@vger.kernel.org

---
Kevin Hao (2):
      net: cpsw_new: Fix unnecessary netdev unregistration in cpsw_probe() error path
      net: cpsw_new: Fix potential unregister of netdev that has not been registered yet

 drivers/net/ethernet/ti/cpsw_new.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
---
base-commit: 0f8a890c4524d6e4013ff225e70de2aed7e6d726
change-id: 20260202-cpsw-error-path-dd5bc72d6daa

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


