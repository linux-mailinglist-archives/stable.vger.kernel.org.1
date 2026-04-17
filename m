Return-Path: <stable+bounces-238385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCB/FWiZ4WlavQAAu9opvQ
	(envelope-from <stable+bounces-238385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:22:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6A416354
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97F6B30C43D6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CAE231832;
	Fri, 17 Apr 2026 02:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXIhdGLh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDB8148850
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776392422; cv=none; b=hfmmly5wgFScg/GSEgL9Cnx3iUDeLKvCw/JaZxzCK0Ed+sSeyt45DW+O/GcDBKCp7aWguEOXTQVD3a5FUC7pXUmdRikDBrhn0o29mdltiHM0jD+XTkuYsi/wMT/iRe3EAUhuobkVURIkGJPQk9Di68iU+gSVYKw59w43lwpwmyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776392422; c=relaxed/simple;
	bh=5j85XGswc2GOHEzFSMXdQ2SxMifDnZPaFHM3gaXODcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CelSNv5XV/zp56p1YNEZQ7SPZPWMhG70Eukm5no+LaJmoTP7eVVuRs0DYUs/Mi1E33raRV2+oFlhwbhkmHwB9cLmWUX0Z1VdAT/0emMj73MLGLqfCQLHwR2bDs3OStM6Y/DNMXPCaa8+kzczBmnzEVRWEkXM3RPc3ZXL8vNCsKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXIhdGLh; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aae146b604so1055225ad.3
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 19:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776392421; x=1776997221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aP2NeMu1RlgKc7YK2syJ7UutDazfj2hr54ybuy2pACs=;
        b=QXIhdGLhqYXyObBouzBFkLZ8hTSLGdPraO2vroZz+QZJ20SQ6T5PGMu+siCObJxFmo
         E2j7InPQiXEItAN+HnBy6uLJ+9Ui2xZ23XEpffszMJRIiZgZI2BIAcCvymeDU7wIHTHU
         QRnsUKGHGShaQgOoligJP/ZljpFrHP0Fvz7DYPZ7K+XME8GWgjSVGhB6ehcV5RK0DgKr
         Lh5FDrQDT0fjQR01kMyU+rB3efmsh87eToCOyGyDPTXwgwdFtlRo/rVMcND2+Se6ehhD
         fA8luC0H9mV1JhH2BcSsfj8kgXk/AkhlIF5BPsk8vRSgem7v296WZaZfVgvl2pCgO9B8
         0sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776392421; x=1776997221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP2NeMu1RlgKc7YK2syJ7UutDazfj2hr54ybuy2pACs=;
        b=RpLkjbuMnH0Mob+koxbKqzus9jr+Pr0+yXgqGKTVSl6zWUAKV9P6VRiWTPqINUEtjF
         +T/zfG98kMoHY2sz9ZK1Z1S+8HSQjIF6NFEtBHtMYzpx8rflJbw4TtWur+GqLue1Lb3r
         tVvjVDChISiAhG65gbrvHCBaCtGJoWhpEOQRyIM8kSWfwv5rAQFcG4PJBQyd3YnNMGE+
         gRGuwyUt1SGHly8QQgsm0vm77fqD4VpMtB/R9xd59hy4+Diqnz5DIQEOaZgSBruYMdVt
         7DR7fz44ffPby1Ykv5lDZzhFsMuc/pYgPKTZ8pjtSYea0RFwIMqFGdTUgxZn+PbxbjYQ
         2vrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sxgXd3ErF4a0IzVnOYzjxeEvqejnlJ7k1UTAo06Ha5cLDlJYXT4bJaY5UrMFTaUrIC3OCidk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWEgLzhp6ufE7x+cT07Dny4tkcWxwQRp41XgN/ef43IWn3sKkr
	45kwxiGkoKbZ5G9SFH2fYeq7pRe7iQmCt2YFcWv8s3kmLSazKmq7Bnd2
X-Gm-Gg: AeBDietuELsb/Lwi5QxSIgImgX4kzdrcHfYbzan5LAX+pBArUyhsKf+cbNP/38elwjr
	8Ngu95Sknh6RqVSov/dM+IvhSGsfuDJcFCcPTd9yv+pD3sGNTwsAHaalaLeuwbjcR5fCoggXEnc
	NfQXtjbUFEvpd0FoXt7tVNxmAypXoey+pxqSKDFha5Zh5X9+VicjK6bvoU8eIA61zk3KTJMRvwf
	aYdHYAITHyl/uXd4esysuHOj/nUUuvHkriSsyJdMnvdCoR2VagQGGilkay+MO19qB4robNwRUDr
	fteB6xzr8eaAdN96cm84zQHc0Y+Q8JqOOtcuz2sUJRjVskNFKtX/d2AwjfgYzWlmF86Yw03fPOh
	zhi56mDY2T51IG+jNhpOMUvN91lDDQ3pMvvPImZTtgSqFKSs6sUuO7CMUHtYqXxAybdJUEMNeSw
	5majdtrkCk/49HNKtaEaQ8V4drQpzgE8Gi/Mhl3SU=
X-Received: by 2002:a17:903:3d49:b0:2b2:3eec:c75f with SMTP id d9443c01a7336-2b5f9f638f0mr6825755ad.28.1776392420915;
        Thu, 16 Apr 2026 19:20:20 -0700 (PDT)
Received: from zenbook ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0db13sm2569645ad.53.2026.04.16.19.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 19:20:20 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Carlos Maiolino <cem@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: fix memory leak for data allocated by xfs_zone_gc_data_alloc()
Date: Fri, 17 Apr 2026 12:16:30 +1000
Message-ID: <20260417021628.2608734-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238385-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C2A6A416354
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

In xfs_zone_gc_mount(), on error, a struct xfs_zone_gc_data allocated
with xfs_zone_gc_data_alloc() is freed with kfree(), however, this
doesn't free the underlying folios or the rmap_irecs.

Use xfs_zone_gc_data_free() to correctly free this memory.

Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
Cc: stable@vger.kernel.org
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 fs/xfs/xfs_zone_gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index e7b33d5a8b3d..2520e57e24a8 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -1230,7 +1230,7 @@ xfs_zone_gc_mount(
 	if (data->oz)
 		xfs_open_zone_put(data->oz);
 out_free_gc_data:
-	kfree(data);
+	xfs_zone_gc_data_free(data);
 	return error;
 }
 
-- 
2.53.0


