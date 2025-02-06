Return-Path: <stable+bounces-114136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24FFA2AD9C
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 118093A5DDC
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4923643C;
	Thu,  6 Feb 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Lrrr9Udz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9CA232360
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858978; cv=none; b=Hy9tj4yosCuMboLCnmk1PDf+SwKtyuMXYqgISkmjvuawR28V81djN5wovfxd8vwaNhJES88jBxXZYAgG2a16heSpl8VYFFc3fTxULln7EJwNNnIWeSDNkKYqjImipZ/RFM152ZBQRbMlzCVDTErWpHwXEp+BROuKeva4ZDFCl6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858978; c=relaxed/simple;
	bh=75V2oZC7pnmIyZRfgokQjhpju5VB78QUWdO9biKNrCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV8ylW2c4ct+dJ3PQcAUdwiJlG6cq3A/dcPNdhv/EuwHqYc7i9srv72vDrx3TUl92uvkMInwBi5bbcxjy7elkY2wV/0ocqa64Vz+rYGNd1IEQxK72ypa5K6I/klIN9Tzsks4BtscZ7xKgRjSI5qF3saeUYvueY+TK+30/TYEfDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Lrrr9Udz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ADBCB3FA50
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858975;
	bh=MxTMb69R/m9lPyirK3StshDDEaD/M2NsI/7VpYKJ4EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Lrrr9UdzmzXLlO5b80rZ6PjbrBTE9lQ7bJAi3yRrZVvklsT/sZXyos5vrENV1sMWg
	 vEBhH/p2WxsEDw4zRcYgYdoMIq/Y9twg2k1UMDuSC/ySEFu7GDBPBEbpUkBNdhr0Iu
	 0YBzwxdPMSztGrIfSelHI6AhVIchLIUtwxRWLLVwFtbq8gWGp7vISXMunbbTQ37wSX
	 7LsN03eYUK5ftnAoTtSRS9AC8TptGnxF7zRW7k8UsTEI4nZklSLaFHiFKxYt5EfmQ2
	 pZJTHUOXc74lD0zOyUj8A432a4U6BR5Y9TvZAdQm9Axh9mwVT5AbDRjHlY+iwni0wN
	 isgzrqCo+reIA==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-21f40f40788so11435025ad.3
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:22:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858973; x=1739463773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxTMb69R/m9lPyirK3StshDDEaD/M2NsI/7VpYKJ4EU=;
        b=cTd99M7h6nNJpGIQph2kVwV+ZxhriXMlwgXiVvsOzgVxjFCPj4NP7muLmEdxJ0ELR+
         Ch/t2CNNLjP5nqvOqxvWXnCkXp24zh2h8kNrq5Tl5vboO/cPAVU3AT5jNvXO7imMRc/e
         KJ/bWt2YM6fulIe4haleUKZRfL8XEdQqqfcQ6yyCyF55Y33DBMqLMISIdwkkRHjJW5jU
         0dFef+JmMHJb1EM6BmBoXzjonsSIhSJiWDkq5IRyiku4TX3aPLrUK5GVhZa9WVIPrh7m
         rW3SE4ei848tdbzBSSNCB4Yd3ANzrYR0JMwbZjGh5ckHG6g7Y9H2wGP+h96vNikco94W
         gWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2vu5bQHn0HpQdlnKnXC8yahxFgOhDjeNPxO8qxZcz7wtByKLwUcToGxx2soEu3PUCSe8cQGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEp23ZybbSfl8/4O+NYbBSqTork4KVaU+PqgWEFfaCyEJZ7Pqc
	bMlLdeqYO1aez0kUhSd2Hl+2cWjkeHc6Ig06xfnmGvebrEB8PlfLokOQTf9t0rqnrqLImvZCzum
	NEYGiZrVuyrVXPWDVkcdmvEvuPnOND7QWfla3OiIrHDnOhZ1Avs15i4TXiaZV0I9TLtKyuEDgb+
	R2Jw==
X-Gm-Gg: ASbGnctSz11kWdUxZVin59jlif9fvdBko6uK5hazssk4ZK7A+t4RZYZ1GOpEMn93+xv
	Ihl+QGlCrJkvfwb80nzrx4F9zLuNH0BvW4yJrA3i1B93HDDnHoksrIjfOCnbQ6G5qTps78a6ihT
	LXg5DeUaD+2rzMFS9wZFbN9nIBBA6rw64cow10m6nSzdcFWqCIIfaO1TA5LS6KkPzdlRH4rQrYL
	az2DSBdNK6a8Jsdkp8pIDQpD/1Gx+Xs9alx4PzLL0edpQQQpnjB3IdIbjM00GGLdE0K8Kzz6zgo
	2Y7QYYIAPh4ZacmFS0TuoX4=
X-Received: by 2002:a17:902:f550:b0:21e:ff31:526 with SMTP id d9443c01a7336-21f17ed4a80mr138024345ad.43.1738858971872;
        Thu, 06 Feb 2025 08:22:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsKcLS1NzlYE+imkZ32W1Ud/nGAhJoqSsrmwNQ4cR842W6T2DSdM2eF8omxhIKsvT5dE7J+Q==
X-Received: by 2002:a17:902:f550:b0:21e:ff31:526 with SMTP id d9443c01a7336-21f17ed4a80mr138022745ad.43.1738858970127;
        Thu, 06 Feb 2025 08:22:50 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e69fsm15008815ad.1.2025.02.06.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:22:49 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 6.12 2/2] btrfs: avoid monopolizing a core when activating a swap file
Date: Fri,  7 Feb 2025 01:22:17 +0900
Message-ID: <20250206162217.1387360-2-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206162217.1387360-1-koichiro.den@canonical.com>
References: <20250206162217.1387360-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-6.12.y
branch. Commit 9f372e86b9bd ("btrfs: avoid monopolizing a core when
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
index a74a09cf622d..eca2a7ef98a0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10059,6 +10059,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 			ret = -EINTR;
 			goto out;
 		}
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)
-- 
2.45.2


