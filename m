Return-Path: <stable+bounces-114132-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFB3A2AD92
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A941884630
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8E922D4F8;
	Thu,  6 Feb 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="J52GWfSs"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B831E5B75
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858890; cv=none; b=J2p5jniSGrQEM24ZUMBc/130WtSVd/bui3A//inan3JTe9N1mdP8Hrhs2ZsNrNGsR5e+ZR8jYvDRJw6JYkvf85ce2HWbtYBUxZisE6dnE9K2h2Dq/qaz+vKOgAHIYgWzRRrzIL6p9AFY+h76pt5gtKIElUEpFAxUqu4ZYrlcZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858890; c=relaxed/simple;
	bh=9+Pi1GqtYSK4HCQghonN9Av712mYaRBQQDPcOPURDHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFRr0u5XXP/gCWM9H0SGyXMX877jhYK+t87LGFlLlrpZSgc5S25Wx5Yj1esNqHBmPPXIGvrBtsjduKUE28PwAZmWG9g3MYYUlTE9tEnDFm4fBPb79nVFoLt0EtE6nBWuNGWxo1PVPprgX+Qhu6LNJdE2YbHtROsKgS9eCh0ejtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=J52GWfSs; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id AFDE13FA55
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858885;
	bh=fneuB95aVx97kDbX8lVrz2LT0zoHJgL3mct+HtJN08I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=J52GWfSsN0dQL8Ld7lg/Dlb1nc/nz/w6BEQ7NGQPiXVN+kOnn6/5tDcDWfRWgouIX
	 xv1dV4Pi2n8rK7IZts/bduWhLxW0BTetDwFtb/z9rkufqACxefbKxeFyFgm3bawMJC
	 UV3i0mKS6QsrSDcUVWqJViR7yQpmDYmCNF0/SS5D2N1RdfjySLJOeMrMZ4Fc/RuxTS
	 9c/zO2tKzlbbZNZvv6ejiQ7DuarnE7sNyqzrV5Rvy8mGHylbfn/viqkGSpatCx1r28
	 LqJiLVwTo0nRQ7e1CfpdZq3bWSQ+HfSh2+7moEN+5LnsK2h3JWltWPbh1uDoTHyy91
	 8dBrzTaqirpUA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso2168963a91.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858882; x=1739463682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fneuB95aVx97kDbX8lVrz2LT0zoHJgL3mct+HtJN08I=;
        b=K3MS1CE+oTLY5ILqYg+wWvcZuCQ9cWmGjhZSdFENyXNgXK6W2BIfbtPDDalJaINksd
         HRMNl6F9E43xsHbeXKbrTanTKYMGqpc0xqTAUNLcXJB3c0GCMoTib1V7vlvTFA1IKX8p
         p9I/3HkLIXWlWRthEgLUyPg2PTQIMih+FFF/ChkH0zuLSnt+n6Ml2g2I6kaP/c0uWTrU
         p8ZdCgpt8DV+Mt03voNxHeOPRDVyaim0SUFP/qfnC22PyTch5KbEnxCQaF/OHdi37q2i
         neZRB+pqDpyqtujEpZh+trea01U6S2IisHkDnrRKKYuk0yAJN8D5auVk6MA/2ThRq/WO
         +u+A==
X-Forwarded-Encrypted: i=1; AJvYcCUMicqUfWUXlAlLS9ryOXmjJKjGDfqB5WJ8sYeqBpqmIZnS4SxusXcA6raPUC2up6N/IPYM1Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHeb0ifRe/o+/GFNy6TM8QIG2b7wTqJ7+ZhLmk9+ru8Kqley2W
	o9v7XZtEJj9Fi0H0FsRqDUXW/fY5vDb8iJFdHwXalVTKXhh78q8RUnvlZ3pSTA+Zh4tEw9HqQIv
	S1CViaEkn3pHkijJeMc8vOG+aBASBBfr4beGzHmwzqxKunKjWd86ri+jxmstT/A2pAMPSow==
X-Gm-Gg: ASbGncvX27TDu6y2zfvPdzmK4QawJgSRaAvGl+roegyIyPypRWSXQ1Mp+CcNSsU9roK
	+1Y0CcQhlb1tqFxjWaDpISFOpZZrHvj/Tqphv3hNH26huqs72/yBOyT5UKFKFIIhmytFGzYgilP
	LtufJe6EoGHwlIuXlnDWTOS58Tu6wSnJjsv5pQnBtfdEbAh89A2mKoW+iq8z5WHyecyoWsQan23
	IBDDco8TwXLsu8ldX+MoKnyCNQS+geQXpEPJTb6P2+QhCFQpUXipOKu4mygxm13WxDBhIyvq+QO
	vwVeaSfuPAtWw6O4Vo5og2M=
X-Received: by 2002:a05:6a00:1152:b0:724:f8d4:2b6e with SMTP id d2e1a72fcca58-73035103aaemr12926852b3a.4.1738858881801;
        Thu, 06 Feb 2025 08:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHSAzq4MLopnXrKp9McPidGn2MzcNbftcrmLVCeR3O+0vCr4vi1CJQa5p4FhsbwqzrECm5IA==
X-Received: by 2002:a05:6a00:1152:b0:724:f8d4:2b6e with SMTP id d2e1a72fcca58-73035103aaemr12926818b3a.4.1738858881441;
        Thu, 06 Feb 2025 08:21:21 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c16215sm1542191b3a.142.2025.02.06.08.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:21:21 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.1 2/2] btrfs: avoid monopolizing a core when activating a swap file
Date: Fri,  7 Feb 2025 01:20:55 +0900
Message-ID: <20250206162055.1387169-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206162055.1387169-1-koichiro.den@canonical.com>
References: <20250206162055.1387169-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-6.1.y
branch. Commit bb8e287f596b ("btrfs: avoid monopolizing a core when
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
index f4a754d62bf4..a13ab3abef12 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11368,6 +11368,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


