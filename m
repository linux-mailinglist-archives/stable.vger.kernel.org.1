Return-Path: <stable+bounces-214931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBdmFBTeiWnGCwAAu9opvQ
	(envelope-from <stable+bounces-214931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:16:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E9410F817
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC37F301F4AC
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 13:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6431A377562;
	Mon,  9 Feb 2026 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgjH1jNQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE7A37756D
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770642876; cv=none; b=rWPn24zFNUGvfboWFweKU+NS5aVy95lNz3LqxLfKa/yDP4Px5DVlB5LkXPbzp1Pae9k43BHzg5QdUvzdprvxKJ0aZDgsFp6sWlZghAxjx6ppttyEPXlBFVACVhj58mu/LFgMV/QSJMB4BbANEqhujsOapy7z3LmWmHvUzCqKrFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770642876; c=relaxed/simple;
	bh=BsCyYY706eP9kibwFEw5teWvvr/D7HjWBFdh5Dsrp0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdjM+CHCeu2O+0v6UOUbkwOeobx1azZQNwyK+iQuMk3oHuqTgkQW1gJ4xoFmcl6o2QsCEfzvOgMzujdHi2DEH8aOehHHL0xhcHFIQm2pZnPTOhzHz+xKcqrxQFzmEWko+Q39ssJ28Lji5DMfEEOBxjrb20yNhe53MnCDTzwuLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgjH1jNQ; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-386d3ac7eceso11116681fa.3
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770642874; x=1771247674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RoPSheucwNdJ0J9aHupvUSWIaFIaKnYUl6Un356KuXI=;
        b=JgjH1jNQnPiNbYKS/ksIUt3FkeHXhEfn0JCASBuctD2odZ8izupOXuNyZ8WW8B3ujU
         ZkH+OGppkxKSVgu0zfd1VLmqVCULFWQc1C3HxyAwFyqdL5/0OgKZ2uJcghH4H7Ar/r6V
         RQ3WI6TLJLZjgYcBoNQ4OyS+R5mOiqb3FjoQK24Bk6AxWohR6/Fa4mb4XtZr2WSvw1Hj
         epJg6db2tEeVzavZOcvX1gHrAfI6rimS9vby9KsZmdoPGbkMTAbfrEOXVbc25YycAENx
         m4TFO9iBjNSHldJmwdVmEerhs5MVWmzFqJPago0d7UQxnJd3ZSouIAAgzUg5D7C1nNV6
         NMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770642874; x=1771247674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoPSheucwNdJ0J9aHupvUSWIaFIaKnYUl6Un356KuXI=;
        b=Gwjf4A/msdU1087OTRX74SniY4U4v489Zf9AE75g2ew4fIwv9LzDRUT7HfyZb2840U
         8FUCIJpW2llV0QyCN/2aS9NitC0QXBqx7/ecBsqvMN3g5PCxaYQDMdGat5OdUUmkYZpE
         i38QqnbGCWYw5me51HnbMZgCWPD42o7hfm3tEBYTVlvblfEHtK0HDBUOesWdVLyHLp8o
         8xYDrKGpk9Xh3SWQIpOZ8X7in6ePDBrmGG3G5Fo2xxUIhxkrUYhZ13NPIRtxhPNcYyMl
         hyCHyGjNIVhBqanCp0E5M0JCYsciGKIbfL1rCibH1TFcJ4l1xFIH6PljfaLHirXB7Kz7
         fosA==
X-Forwarded-Encrypted: i=1; AJvYcCXH/E0JWAq3F9Cl8Cm2Zs5IqgdPmrOY+LBtHq+b8R3XN8ugVAvsTyva/FUOBp5l+3czVCxy7Zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyURrlY5QMhrOI0CEfLKqM0iCqsTA6zq6Ykw4CEw0n5RrkImBDz
	LTJkgoi/tNPbK2ON/gAhMz+LBO2k2V9H0B25/vfeMH99SzJ36vSOy761
X-Gm-Gg: AZuq6aI1pJlhgAt15UtNldK9iv1AATYpnL4BdIAc0UbmXIzNbMxrsOEo0lQ7x2N+vGC
	DfiUrgdqdcGf+oIbl4RMQTg339U7kjcjhyW+iBuu4tnXNASwJI4JYzVGTTm2bz5PJ2J9GKUYxJn
	fTkvvy2WM1vez53Z1/W22xOu7aOKoRhJTfO1JXPylATCPE7+i+4Kt9GmeCKgN+Xg87YYZiiWrsO
	ReqejSCnNG/rK3VZ15GLAEjRUNv6jQGFXnNaz0BPr7RYu+9ah3rEy57Hz3HF73ArqnSc8GHZzCW
	n0nTgjB1PACqkR1lZn968BaNE1U3GYmohlpgkGVBLdZZJ3U31e1fCy46GnrKGSw5kAvO66d+Ktd
	DjKtTmxLd3Fo+pjNuHLTlYdq2lpfLmsITC2ObZpfeU1lEt6heO5a3mym/h93j1+SAhAYEzPIjch
	Ul6zdtrrDPIV4/NR/tm8wEYLhd7xG9QBVthCkbz6LGXemjb7Mdb2ez0BuqFUMDI6GIFbFtGgPIk
	R9gjO0GOIQg8e8=
X-Received: by 2002:a05:651c:b22:b0:386:1ce2:1198 with SMTP id 38308e7fff4ca-386b5110ee8mr29967281fa.31.1770642873785;
        Mon, 09 Feb 2026 05:14:33 -0800 (PST)
Received: from localhost.localdomain ([176.33.64.73])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-386b63e8483sm27212191fa.34.2026.02.09.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 05:14:33 -0800 (PST)
From: Alper Ak <alperyasinak1@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Alper Ak <alperyasinak1@gmail.com>
Subject: [PATCH] gpu: host1x: Fix passing zero to ERR_PTR in host1x_iommu_attach()
Date: Mon,  9 Feb 2026 16:14:26 +0300
Message-ID: <20260209131426.37611-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-214931-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alperyasinak1@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2E9410F817
X-Rspamd-Action: no action

When iommu_attach_group() returns -ENODEV, the code sets err to 0 but
still falls through to the error path, returning ERR_PTR(0).

Returning ERR_PTR(0) evaluates to NULL and breaks the ERR_PTR/IS_ERR
contract, causing the error to be silently ignored and potentially
leading to NULL pointer dereferences by callers.

Fix this by returning NULL when err is zero, and ERR_PTR(err) only
for actual error codes.

This issue was reported by the Smatch static analyzer.

Fixes: 06867a362de0 ("gpu: host1x: Set DMA mask based on IOMMU setup")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
---
 drivers/gpu/host1x/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 3f475f0e6545..46a570b861ac 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -450,7 +450,7 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 	iommu_group_put(host->group);
 	host->group = NULL;
 
-	return ERR_PTR(err);
+	return err ? ERR_PTR(err) : NULL;
 }
 
 static int host1x_iommu_init(struct host1x *host)
-- 
2.43.0


