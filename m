Return-Path: <stable+bounces-114134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 819F5A2AD94
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F69D3A24FE
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194EE1EA7FD;
	Thu,  6 Feb 2025 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lk2v0LUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABF22D4F8
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858924; cv=none; b=JWArHiAMJfTEm5189r/eBHJeGJYhma/FirNGg6ZgcG7u8PTD5L57jc8YSvjCNNziswhYI6NeSnhfVPClwFx1Ue3Fk79rfkw9H7bef6Qi9tXdYDsCVLv9taPs65TAnsH+tgJ05QhCuQj17lLFG9OWTknTZsxlZE/ayKqdP3dnME8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858924; c=relaxed/simple;
	bh=r7S38TP57oYSvHC6/aBPm1vGAm8sGq9cXqUclXwxEys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT6UaTpfrN/0JT/ZHxXeim+r/86RYkseT7Pymtl6m5IWQaRZyl/nuHnn6398m5slSl7RrwS5xLSEWu1to6TjUE68fl99l13ZXVrogo+msn8mpi9hHG4s5BoZOEih84XJAQGxLMiKt5t2OEuTxOf0fZq+5fpeWtZk3L0tbcB4U5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lk2v0LUz; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E9CF3F212
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858921;
	bh=nxTtSAg/Nv03uFfgDmOYCX8kwCjMdOn1nhpG92ulRi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Lk2v0LUzN3Ees71vJccsMz+GP7nyKE/m8iaFRuy6ZO7GbqB5WrbTqRPAwkSPQ9JoM
	 L2vlInaiwW76/OpOQ1VST02OPzX6tjWUpOD49kmrvJMOSatm5T39Mqx6+kDgfhXFJl
	 7YvWTrZk1zgom/7kGx6d3kEMR8YmlpD+BMjKggRr3a7dW2gGK/ujQjRdG07VNGXS1r
	 qyFkTpeBrMxMftjbs7jtoG9B2gTdo9jLBE03X/2NHUd2AohiZNal/jF79yNy1rvWYa
	 c378OL/O17g6dog/U0WXyrdWNDUPR4XxqYt0Om9ozadS61Qol/ip/Tu3IXp2AcRFJq
	 iSaalV1nMinXQ==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa1a3c0f1bso548469a91.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858919; x=1739463719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxTtSAg/Nv03uFfgDmOYCX8kwCjMdOn1nhpG92ulRi8=;
        b=BwX9LvDai0lECHp/MjhFDuujX2+Bhw9Wur4dt8B/GjCZPaVMKmUcG1xVYMGf+JVlnD
         We3LTgvwVgTkv1Vy1ZXQhPpz0F342qO49LU40QLuvvFh78HzNKv/Pvh7sPsy2C0GhT+8
         rIvOnnYPeLesG+xB3NH/T1NnNTiG/C4MAGVSnCyljOvu9qixAapaoHF4gWuko1r3o+8A
         X+QefcdMtax20DidBMaztXUkyD5SZTGWO+Ps76BkEsFs1GZJXcEZqqvkUxUDow3NcRGs
         OevQahLKLP9Y8zsdmTIBxpGu6RCw2W17ci9HlQld4iwu2QKo62BF7alHsA9ggd7cNtQd
         H8gw==
X-Forwarded-Encrypted: i=1; AJvYcCUtbVpsTkDcgRd6YjDG3/iEz/B9AxsQTXdrCJVz13SuvSWI4iOCJL1eVWRiZ+kXlCcSeMHNcqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/VOrGjeOnznjnULpxF2KlSEQ8fWOabd5WV2pnWq4/nryfNpef
	k4Ekn4LBK7lbUmw8wMl5g5Up7Yptln9Ngi4r6zVY1N/53mGSX64zl3LYYJOtBd++N4NLORGRhRf
	fy2OUQbR0NfnNvv5Nws4Zd4Zm2JX4u+WgERnX+npe5/nQ80+EgEQtoW3g0jiN1P4PTW6+Kw==
X-Gm-Gg: ASbGncv31caVJB4aniMbc43BrqUhU4QLFLfhCiKoObkaLKz4XRq94TvYQXjB2FeuN7o
	5llQf5zurcygt4999e79+ez3GoeDokOYX/xTFaRtWNDI9zX/Da51kH7s0GqLo5KYGd2jW1hBF8Y
	ikOw05TH9AjnMTdnIG6okw63IX+AYI0h37bTHerLDjrbeT5luXVpKCv4JRg8KfKHw1FiSKVyUdE
	9LS8LiYMTNnTumyyXgvlBp6HKFOouhPwzRXAVjKPbG3AQFR9tJBm5nHHxppcTy3OGGuObNPV8tR
	LW4SLNb2d3ROfDyPQI9tHLE=
X-Received: by 2002:a17:90a:1c90:b0:2fa:176e:9705 with SMTP id 98e67ed59e1d1-2fa176e981cmr2304119a91.10.1738858919675;
        Thu, 06 Feb 2025 08:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWEg2If5HBgH7oowBTqgTn/AK7vUeahcxJhyEIOQA0u/8XBkTu4OmFwdpjr7YxCwx0RwlVcw==
X-Received: by 2002:a17:90a:1c90:b0:2fa:176e:9705 with SMTP id 98e67ed59e1d1-2fa176e981cmr2304085a91.10.1738858919347;
        Thu, 06 Feb 2025 08:21:59 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c4e7sm14850665ad.188.2025.02.06.08.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:21:59 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.6 2/2] btrfs: avoid monopolizing a core when activating a swap file
Date: Fri,  7 Feb 2025 01:21:31 +0900
Message-ID: <20250206162131.1387235-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206162131.1387235-1-koichiro.den@canonical.com>
References: <20250206162131.1387235-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-6.6.y
branch. Commit 6e1a82259307 ("btrfs: avoid monopolizing a core when
activating a swap file") on this branch was reverted.

During swap activation we iterate over the extents of a file and we can
have many thousands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 49c927e8a807..cedffa567a75 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10833,6 +10833,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


