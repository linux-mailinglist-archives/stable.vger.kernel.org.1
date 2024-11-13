Return-Path: <stable+bounces-92935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD779C785B
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A862DB26618
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD66154BFB;
	Wed, 13 Nov 2024 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="KCtzAYyw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF285249EB
	for <stable@vger.kernel.org>; Wed, 13 Nov 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513921; cv=none; b=EqRBcPKUgT29pzs8+kooG2G6/+g2aNPrT2pQ4di28CHlWoSpRPl5XFDUrgpUmWJDXZ+waHSXHEgXxJAwD5GxoHFL6n9PVpoFnV/cD/4dOmStGSq3ral+KZIrWO7rULXy+TEnKpaVve9tZTUiZNReggVmmANV3broF9adHEI1LoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513921; c=relaxed/simple;
	bh=Na/grnMDZNedpgQeysiBdj5+/PYqTh2BndPQC5ZI/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4h0IagxyexpO1CKWO89NDABVggDuo2QrpkMdH9YeYhJY3ASUB+ZXj3AUMJ00586rdphy8emLAbuvpu5GUNUUOPXvhzsWr5RPDqDX+fRxnNfNO6JqSG6d9V6esyZgPdleZKvTDWkeW49Pbb3TAv8Hrh6Qe+Ko7Fy6k9Z3D4kAtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=KCtzAYyw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cbf0769512so47244746d6.3
        for <stable@vger.kernel.org>; Wed, 13 Nov 2024 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731513919; x=1732118719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcFDogal5NryDPa48hgqdxJVj4yDxQkvbCrhPZCGTxk=;
        b=KCtzAYyw9Ve7WG6Rr23mWNWxNHubNRn5djB2eA3xLnAtzmAquL4is+s+Sa9E4FEjyh
         JnPYRYY7cpZ2XCU+/f+Xc756/cYT+x0ndtUfcXbXnemadCfX8eh9256INSKwSo1K+2VZ
         rXZoGUm5A7oXxf4Qsah61ZVaGRCvh/osMKcCUALnbrKios0Ln9vB8pSoekqKdHxUiDiA
         KN6T+szkn7G4WnldFUmJWG+DpKhJ1DRvdawB+Wi5V7pvWmKR8F3XnemDLgYsIB384uxH
         F5d9rNFXcJB/8DikCy7iicQvK/whMOqETMHtIc9IFrdR3YZ4SKVY/QixSocDtlRpiVU3
         NGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513919; x=1732118719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcFDogal5NryDPa48hgqdxJVj4yDxQkvbCrhPZCGTxk=;
        b=hS8ltDkS9EQLeKhPwLZxlakNIf9svlvFgNOlFHBV6pCL9pSzBsA7E5XKw9mHiw8zKU
         MRRdy2n29bchWHgwldj2IPV82XoipfCTaZ1AXba4FBuYzGdQqiaHeSvzAD4LEHkC/umo
         JOt7+VsmdUntpV+44BqgOvqFtrQvjyQddIokwg1Vst+gYffm1UF6PVTWq2qOwN0XDI46
         IBCIF7j5B4xv0PMdYUSEYqw4VKTT72NXd4FE47g4dtmT3sKl8M3ctm4BHIUNziMuxX3O
         TipkwPl2eUp5LjBRd7YrQKsdEW6mKKnnKM2H3ajBPbWpRpTsFGgg7wFMbpk3dAqAba/S
         qBSg==
X-Gm-Message-State: AOJu0YxTQTKiKuBEVRpyh8jfIrUd48DbmJ4vS8j+CbWZQy82dW8tSH4o
	o1iSWzEcsr5bSerR6PBqctVi7E5ql2irR1FasDGo4FieJ4rATm87TbNgmf9bV+Q=
X-Google-Smtp-Source: AGHT+IGpr3Pe7mhvy60jSiQoQxLE3e5pAsnbCLZr3nlAa4MV8tpy17afRGHY6BZ3hQO21VrAWk7p3A==
X-Received: by 2002:a05:6214:570f:b0:6d1:7438:7b94 with SMTP id 6a1803df08f44-6d3dd0813b5mr41710106d6.47.1731513918626;
        Wed, 13 Nov 2024 08:05:18 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961ecc7asm85440196d6.43.2024.11.13.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 08:05:17 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Cc: stable@vger.kernel.org
Subject: [PATCH] btrfs: fix incorrect comparison for delayed refs
Date: Wed, 13 Nov 2024 11:05:13 -0500
Message-ID: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I reworked delayed ref comparison in cf4f04325b2b ("btrfs: move
->parent and ->ref_root into btrfs_delayed_ref_node"), I made a mistake
and returned -1 for the case where ref1->ref_root was > than
ref2->ref_root.  This is a subtle bug that can result in improper
delayed ref running order, which can result in transaction aborts.

cc: stable@vger.kernel.org
Fixes: cf4f04325b2b ("btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/delayed-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 4d2ad5b66928..0d878dbbabba 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -299,7 +299,7 @@ static int comp_refs(struct btrfs_delayed_ref_node *ref1,
 		if (ref1->ref_root < ref2->ref_root)
 			return -1;
 		if (ref1->ref_root > ref2->ref_root)
-			return -1;
+			return 1;
 		if (ref1->type == BTRFS_EXTENT_DATA_REF_KEY)
 			ret = comp_data_refs(ref1, ref2);
 	}
-- 
2.43.0


