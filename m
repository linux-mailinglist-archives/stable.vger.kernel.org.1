Return-Path: <stable+bounces-267465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Y3RKA48rNmpO8QYAu9opvQ
	(envelope-from <stable+bounces-267465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 07:56:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 633A26A8629
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 07:56:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.s=20251104 header.b=stZ+D3tC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267465-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267465-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=iitm.ac.in (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C74D3034E23
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138F3559F5;
	Sat, 20 Jun 2026 05:56:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769F01FE471
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 05:56:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934977; cv=none; b=WNHt5+degn1UiiTFOShFohxsdJGlQo99eRGjBYiEhTnVC7YOHSoXffdX99tSkZmvcXEfsshv/MpBBqrQM0xcRhvd18enedEMctiigFlOwRpR2Kj+xHgoFtEZWFdF+sYNnNb2N7OvoZuf1tfS5xLypNENJIs8RrILIXIc+Sr6UtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934977; c=relaxed/simple;
	bh=kZrrfVNFD93NlvT+ynFij6zQtLwaTzMwYCPnIqtb740=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSkNk1NrdJqr9fUb3Guqj5LT9Fe5CdXlXMZ2nfZaSFqot0mjbJXYibaLWwPDHGtPJI6b8sic1BS3D6uXAc4CAE73UU6+wVGVz4QBYdBb/2hkMr0RotC4lYOPRDzT9UKEUFmqmKrAXGAe3uHOtAxXtXPCFWQ+Rmr0dRR7ig9sQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=stZ+D3tC; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf2247e38eso31827785ad.3
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 22:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1781934972; x=1782539772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yuzv8yDsj/qISG4lvPB4PHWCiqTUSEXSMNl6v4uCp4w=;
        b=stZ+D3tCYYS0qOoZzQj1gvzKBh3XhVoAzGirE4GPVjwu/TfET8EVanu1XqaHSRntJ9
         rBX0KzPFSVEXht4knZQEqvzILY5UxTCcgq3vCke2HGEyA2Rtjlsyeae/IBZ0gV5QQQnB
         +ECY6tyCr5TwHnpPnT65VL0kEmyHpHJoZ9KOH8CSAvNW/RAHX2tH94C7oQAIqr1jY2et
         Z1L5/97RrUmFQiVT1DbxLO+0ZDnnErRIqH4Tt7aKDI6NM2A3Uqvzd9nSYKAl/ZHpzF74
         5zh8SZL9WZuVzyx1dPZoRJ/b40jjPkq+NYNESvVyClueRrphmhyz5lQb3JOgkvpPdyKV
         +AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781934972; x=1782539772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yuzv8yDsj/qISG4lvPB4PHWCiqTUSEXSMNl6v4uCp4w=;
        b=Hxl521oPx/e6n4teQ6OxrXPlHz9Wn3j9fcd3bccaVKYU+j0KL32SewU9uuyLwOMmaw
         JiXUM+dxdRmNxnuhal4UhrPXSc4FZ5OYUI7hrlBuuF5JVP1Km0ng4JPukX+hU3mb/ZIr
         +H41+0dZHl2pTmbHP0ZPUUy6MUTDQTK7zuPnG1ORYdZR8b/eizpYlb8h/duhWodrI6+U
         oUmDU3muJXnkirPqAnKw1Evkva1yiJwO5WdjcNU4wnqWFJcPIXKDqRJ/enMmtycj9Stb
         6ffYbN3/rGK1B6IvVj/AhwIgyIRkpLpvZNP8FuBbXbCeDNuDhlygNPmsxQnv7Kw1PhNk
         BhCg==
X-Forwarded-Encrypted: i=1; AFNElJ9pApdshCDa1Vzg+uyt8gmlZ1qiyCKt+ycSF/aOBS/YwTMmrLSSNwUXwQQiIPFYiKemVG7iQtw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9CF9IYk9xhtKwYUnGe1/+xRrWhb26045BGZhB3lYG3Jj2RV6
	zVKZlZk0T9b+btSE8EMdkR23DSqiRzd7k4/pxGu/ronmqP2cQxCnE7x5ab6TyZio6OI=
X-Gm-Gg: AfdE7cntLfDn2ybmDetd5akvSvI2LULN0MxK6gTtE7Ir5dUfFYyjVofXe7kTsgY8p5l
	agKD9KPdSZhZlFbVVgi7y6JiWlRoYAbLwlBByGZgI/2SDV6ygpz5a4fJXYPfCOLrBH764sp7jnW
	Zge0YJJlhh1By5/fr17i+jNB8hvAap7CGTNIYegr34FX6ZX9EQ9pX2g7x2MWdVxmv8IhsxkdtJo
	p0VCj42QBzLk/U5b1HiuBJBV8pDkvGCbz//zJn2OOZkN0PVQv3R0u3IDNu8TzWXDePdteDyLhUw
	/YSh5DRWggZ3Q/yz9itUaeWEpd5JiEpR/l4K/apSW7cA/o5b123RLNw5NNpNofWx6iBDuSfZ0LY
	PwbLQwE7gj7CkmrTOyRSOgYB62SgQUYzzDyKhp5hX8uNhXXDqNjb+HPG7SJKrfN181pObRbDgLA
	lYcz+sbvFh62LGaKEIvLzLArZOP0ttuDoRMxkuld4FDLvyGJDngt0YjJ8MZc88PT9kWxSfYA6A2
	bC1U1YDPSre9urvTXxWUOIhrXGqAQjGeDP/TV1G0fFTHQKaXSYus9GGOQ==
X-Received: by 2002:a17:902:f687:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c718cb05e9mr76481095ad.5.1781934972555;
        Fri, 19 Jun 2026 22:56:12 -0700 (PDT)
Received: from localhost.localdomain ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2c7439f8524sm13079295ad.47.2026.06.19.22.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 22:56:12 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: stas.yakovlev@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ipw2100: fix potential memory leak in ipw2100_pci_init_one()
Date: Sat, 20 Jun 2026 11:25:54 +0530
Message-ID: <20260620055558.75740-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stas.yakovlev@gmail.com,m:nihaal@cse.iitm.ac.in,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:stasyakovlev@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267465-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iitm.ac.in:email,vger.kernel.org:from_smtp,cse-iitm-ac-in.20251104.gappssmtp.com:dkim,cse.iitm.ac.in:mid,cse.iitm.ac.in:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 633A26A8629

The memory allocated in the ipw2100_alloc_device() function is not freed
in some of the error paths in ipw2100_pci_init_one(). Fix that by
converting the direct return into a goto to the error path return.

Cc: stable@vger.kernel.org
Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Issue found using static analysis.

 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index c11428485dcc..82280890f1c0 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6157,7 +6157,7 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_enable_device.\n");
-		return err;
+		goto fail;
 	}
 
 	priv = libipw_priv(dev);
@@ -6169,16 +6169,14 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_set_dma_mask.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	err = pci_request_regions(pci_dev, DRV_NAME);
 	if (err) {
 		printk(KERN_WARNING DRV_NAME
 		       "Error calling pci_request_regions.\n");
-		pci_disable_device(pci_dev);
-		return err;
+		goto fail;
 	}
 
 	/* We disable the RETRY_TIMEOUT register (0x41) to keep
-- 
2.43.0


