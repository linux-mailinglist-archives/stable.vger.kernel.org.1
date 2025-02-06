Return-Path: <stable+bounces-114129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFFA2AD8F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 703D5188321D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFC1EA7FD;
	Thu,  6 Feb 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z4tnxZwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F901F4184
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858858; cv=none; b=JbeLNRiML5lPRLdeeOmsINE0YoVYIdR1kGlK9Au9oKA8TWmF0K4qCNJZPtz+bE62CnaAUnjNfzkmSofHj9IgjxD49eB33nH6BfroCQPOz4pAkflWzi+XkQweqL7cEOTZfMqgU4eELCGhD2semQ17RH6FgOiB78/ch/by9dzOKgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858858; c=relaxed/simple;
	bh=va5cpUmb7jhvx3QZdzCQQHKtHKpBB2/+uSgDE7tUqJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpCOlUF5VfIqo4ZKFKww0b/AyNncyehAgPhgLNlS98kcBXKNoIHfbr9jE32VeI7NgUdv4sVrsTWh1gprm/rPegx5sX+IfOaAAnSS88fYHnD9SRCcrOA6pJ7Cm0USUOjC0S7LXVhAZX4lhNIsrQCWFDhavcxBfWhVfj+KTETuTUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z4tnxZwF; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 52DC73F868
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858851;
	bh=7TfxeM0jQFipKRLVZQ1OypIda5SK/GhWRwz7pRtrDKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Z4tnxZwFP/SStIdnd1xH+S2Xbfp7jFoYFCUki8Dlo0sdffnCH/k691U6J76FV86xQ
	 iOcCbMtQd/+WG35ls/2EgxtkhmnBKLlDVg7o1KnMOHTG4Pjt1V7Vzl3xPZEk4H59nR
	 ztW+rjzwXWF9p6c1S4VVszeBjV653i4gNr8dCtiySAhq6sO6yzVXm0cOQB+k+0Wb5u
	 YhabM3jrQrrCy60Zsg+Yv8/sdRcZEq1UKe7cvL0xe+z+R8LZlqH1wFjvYq7/4VWzWa
	 iHjpBkw6cftbzc4D+7DZ+PxLT0tDRUDSlIuxx8MkmTqin65MeUa0u07D5Oj3KcSHLg
	 iY3sUNfUnF6Aw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fa166cf693so1356870a91.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858850; x=1739463650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7TfxeM0jQFipKRLVZQ1OypIda5SK/GhWRwz7pRtrDKU=;
        b=JJEgCcrFDA41SCukNMT72nQl2GgQusOgKMyKyB/SoBQa+hxHh5wzf3mUU1ehN6Biv4
         /bws1VVQJ4IMKRkNBU5olLS5PXsJhNv15gsqU1Fgzd3JbhDWmdKgCfYNVGxR0r6f20w2
         ddyIybh4JZ1C002z2Po1f4xBFvbGcJ0mSYC8VUJVmzr0qVoRg9D1LHPYh6E7/O4KAbWA
         y/MRpB4uEzofmYT+HaME91C1q2wVgfrhhPIVdD75n+EjMuBBr/g9yuXIF8p20BpgHydC
         LM2PR3PiJDpm2fdEmL5v0WklaZSP7uLEZLzvL2qJNW4ak2lrj4RZIt9cwMzYSn74iPhK
         dsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4m4PtqhSDYrJAKyl+n0fZP3Trli95G7+PpjLJz/9gwndlT0j12jILLXHkojuBe26b4zOSsJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BsEGLebCtPt4i3RCXIPD+b98Q2m7RUjep5MU8WP2ncFLQjC4
	IZEpABPNnzz5Ql27Uwq8IryGkLUE97j1DkZf2ajioz5+KF51ObJpUl2K5lSslQ2mZZE7sapyyQs
	CMQIa3ycMzhdOD/MwnO5AdheEhL2I9Hhfvi1xjU3wp7z9ggxuItmICdrPXz0riqf3yRwRltJczS
	B4yg==
X-Gm-Gg: ASbGnctyhD1IPFPhiDqQ42h9NwbmGay46LHjx7DcHbABy7nGXBtdwXQsj4fsSh7wjLa
	I7mfhe7gIBEdyELAxjGGX752QhyS+iCZszC5M6UD33FeWCKIfuM2i+km1Ay3F7xBKLeNYeyHd3W
	Y2ZRwEaGEFJHmsPrFqlkhKQdTQ3znekr4DPpTPQNUOGvNoTyzjmV/3GlYHEPR/NwqRV30XFO3EQ
	wKKMBqobbW8EFLlEOJ/RCKYVA9tpMDHCIxlDVE+N729QfbbHkUZ4ElgOTI5N8fzAflPD7DdM2F8
	8pk4I4krTpfK9hfJ74pKCfc=
X-Received: by 2002:a05:6a00:2306:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-730351395d0mr11541598b3a.12.1738858849762;
        Thu, 06 Feb 2025 08:20:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRVFJBUXVo3468wXoy0gmt2q5L6DdtktHkIkPDuUFtQo6M+OGfNQexVUzeuL4Wu2lYiW95zw==
X-Received: by 2002:a05:6a00:2306:b0:71e:6b8:2f4a with SMTP id d2e1a72fcca58-730351395d0mr11541566b3a.12.1738858849444;
        Thu, 06 Feb 2025 08:20:49 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf13e2sm1539312b3a.107.2025.02.06.08.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:20:49 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 5.15 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 01:20:22 +0900
Message-ID: <20250206162023.1387093-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 214d92f0a465f93eea15e702e743f2c63823b1fd.

The backport for linux-5.15.y, commit 214d92f0a465 ("btrfs: avoid
monopolizing a core when activating a swap file"), inserted
cond_resched() in the wrong location.

Revert it now; a subsequent commit will re-backport the original patch.

Fixes: 214d92f0a465 ("btrfs: avoid monopolizing a core when activating a swap file") # linux-5.15.y
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a6b1dd834060..8f048e517e65 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7698,8 +7698,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	btrfs_release_path(path);
-- 
2.45.2


