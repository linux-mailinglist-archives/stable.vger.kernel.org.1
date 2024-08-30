Return-Path: <stable+bounces-71670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055B1966CAA
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 00:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D561F22F97
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6380185E6E;
	Fri, 30 Aug 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B5Tol0Pv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FC15FA92
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725058109; cv=none; b=VSpcZhLXssJVLAPv5molNpC9lpdCJ8hYCj/aVG7UmBWmufKtYFks/6KMExonckuC+S2zQLla01JjFGTWPLFvkbRELWO5oOS+JISAnbjzT34ID405Fbfv7eaS2fwMHeou5qeUmSERZsCA8P/Wgh2k44Jgx70ZUD5ZvzCnQY7cneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725058109; c=relaxed/simple;
	bh=vDBOVW/AVBG02x/v9uJ4/nu1OHfiF8pUsqC+5wp8YJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iwbL+LULx3JNAUr5E+JCzU5b1YXy2ilc24OtbhGQxnCRGMqOkct3OTVqaqcD899mJRNQGCpfdsrGM6On3Utu6S7nuHtg9iJ+Qz8Z+X0J0YI/0re5rj+Y8CEd2S66V/tVV5ay4OCZjGtssPaCv6/hQeAtH5CarUFku6hNOxclZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B5Tol0Pv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2053a0bd0a6so7071295ad.3
        for <stable@vger.kernel.org>; Fri, 30 Aug 2024 15:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725058107; x=1725662907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wW6gEJ1Jx+14Xq80zJDUEJGqqo7PszsHlAqP/A24X4g=;
        b=B5Tol0PvrhKKSPFhGQyxrFBSG4MRYkYMPmgOABcTd5VawiA12R5YdfsCW+SZgirou8
         BiAE3Q3OCyNaPgLXiLj02C5iQsjU+1aP2J+qgCt3RE1gZLbmg+eKYST+2wpNufqSJjaI
         XA93fmDxC8l5kd0tCCYhK4phUF9v/MquEmDQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725058107; x=1725662907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wW6gEJ1Jx+14Xq80zJDUEJGqqo7PszsHlAqP/A24X4g=;
        b=C7mrXLQrWBX9dSyjWt+g1ap2+g6GJjMSp96Kt1iBkCx6Kh2HOL8CFYVoOPfKkQyH3w
         QtzfqhJqNRfemZDsODdH+z1eSjWx3rgtHHXuHRlCz5ra9yZSLqwPX4x9fSQ8lxE0XYCO
         NptPTQywglpkAjLNelZ48NQ4ZZ6kWgqPzVgTggTws6IyAcBMhry469dJAFwwzDqovuwi
         w8LKXw73CIkKbG9OUDQESRPIxtfXP76+viR/R32IYvFG6VEhUDKQQFflLNlvXeksvsKS
         eZRh2kVR1vyPLLY5hR4BRm+vWfAR1bndaXdFDfd5/Nq1puqcroKr8/SoSFfLEO/tN61s
         hixA==
X-Gm-Message-State: AOJu0YwpMLWyk/51N0yB4HUwjoyP0P9gVEjNKpJd1krrZjAgymV8w7Hv
	vYA4jROzKgdOpn77CWcMzTZMlBQf1wSYy7gRrvaq6UUwFeKy3xjCh/xHgasVNu/St8N1rQdhGfF
	snrc2/aS7Qryj2y4aM/2TwjkwKdu3BmDAjcHc4SjZGIelLb4cCDFnyDlRf+yipT8r+tMGhBD8yD
	KrXYTAuEqCvXMaQf+lj527Sk/OU3iTWamar4VZul/BdfedJfZSkQ==
X-Google-Smtp-Source: AGHT+IER+xIuciY45gqep767TACOPrYbqk5vc2U2E6TNNhPn0PRMzBL1D6DFREDsVTCXO4FgzDRt/g==
X-Received: by 2002:a17:903:22c5:b0:201:f065:2b2c with SMTP id d9443c01a7336-2050c4666b0mr93068005ad.55.1725058106538;
        Fri, 30 Aug 2024 15:48:26 -0700 (PDT)
Received: from patch-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b15besm31300245ad.55.2024.08.30.15.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 15:48:26 -0700 (PDT)
From: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
To: stable@vger.kernel.org
Cc: clm@fb.com,
	josef@toxicpanda.com,
	dsterba@suse.com,
	wqu@suse.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
Subject: [PATCH 6.1.y] btrfs: fix extent map use-after-free when adding pages to compressed bio
Date: Fri, 30 Aug 2024 15:45:36 -0700
Message-Id: <20240830224536.64932-1-brennan.lamoreaux@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024072924-overact-drainable-8abb@gregkh>
References: <2024072924-overact-drainable-8abb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 8e7860543a94784d744c7ce34b78a2e11beefa5c upstream.

At add_ra_bio_pages() we are accessing the extent map to calculate
'add_size' after we dropped our reference on the extent map, resulting
in a use-after-free. Fix this by computing 'add_size' before dropping our
extent map reference.

Reported-by: syzbot+853d80cba98ce1157ae6@syzkaller.appspotmail.com
Link: https://lore.kernel.org/linux-btrfs/000000000000038144061c6d18f2@google.com/
Fixes: 6a4049102055 ("btrfs: subpage: make add_ra_bio_pages() compatible")
CC: stable@vger.kernel.org # 6.1+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Brennan: Applied to v6.1 ]
Signed-off-by: Brennan Lamoreaux <brennan.lamoreaux@broadcom.com>
---
 fs/btrfs/compression.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e6635fe70067..cb56ac8b925e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -613,6 +613,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			put_page(page);
 			break;
 		}
+		add_size = min(em->start + em->len, page_end + 1) - cur;
 		free_extent_map(em);
 
 		if (page->index == end_index) {
@@ -625,7 +626,6 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			}
 		}
 
-		add_size = min(em->start + em->len, page_end + 1) - cur;
 		ret = bio_add_page(cb->orig_bio, page, add_size, offset_in_page(cur));
 		if (ret != add_size) {
 			unlock_extent(tree, cur, page_end, NULL);
-- 
2.39.4

