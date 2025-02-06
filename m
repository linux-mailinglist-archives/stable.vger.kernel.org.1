Return-Path: <stable+bounces-114127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB84A2AD8D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC4EA162678
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 16:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808522F391;
	Thu,  6 Feb 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="KNK6UWSr"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD301EA7FD
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738858827; cv=none; b=KaCEWn1aekyEsl/hgbJ4fTgI3XUF8F8dHv2/kXIfavMMW4j8SgkyZ5d+Q9qQrVbxoK3Jd4U+vWL2pvo8wiNCg0E/oOe35JpyJcz2hMNhiRIHPJ8QEmXc9V/9asxSVgQzhryYr5I/r80DcZ29KYlEw7FdR+p1d6AwzjesA/EFD0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738858827; c=relaxed/simple;
	bh=NWrbC5j0BNYpOgfnwjQZmdxNPTB/wmMZjcYylbcurtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XCTrLb+CmG3rqBDaGp1SEo87N+PUhDQJOcXOgWTTA/J7NHYwRmGJYD66nLPO3AhvebDnb6pfbJtfHR6n+W5UOJ4l41r44I1YbKOtDZ7BRHDbruGAfO16iq/DEr/WOI70ET4KHMKLl8W69fDJqNW17ZEUsgBNiSvNz17nPXSl+7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=KNK6UWSr; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EBCD33F212
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738858822;
	bh=79PcSS/cwR92ZwAQ5v7C16AD0cb4DeCrPAjnUMehZjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=KNK6UWSrLaBqIiY9/+44LbQoPP8TxZdSlN1T80o7a3SCoBHLK0CsjLLUwsreUyyhh
	 JU4CCBQzKbfHBI2Bo9vwOZVrmLQEj5eQ4OcZu5rMiUUpL6+gvkfsyalP3lVKoj5h7U
	 J3dqJk7Qser4Qhz+DF3z5N1Nv7QtecExz3RAcOtGap+ypkh2BUyhj0PGG1Acdz2flb
	 3y9Be1Hyc5iVmbEHmIUKkksVWZ8PJBtBx2rXYvUDf1xTeYEwoZHYzuTiTIyRutxvpy
	 GjnzNld/2WqLYv9CW36r+W/RTQW+hEK1uU8Hs2G2DKzkERCG+sk66IUvK7ME4ktSSA
	 GdVIu/LsJFMng==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216750b679eso18284045ad.1
        for <stable@vger.kernel.org>; Thu, 06 Feb 2025 08:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738858821; x=1739463621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79PcSS/cwR92ZwAQ5v7C16AD0cb4DeCrPAjnUMehZjM=;
        b=gPlbsvmjGdKiyX2CAZ7Qqw9RYudaHXGtwG80EJsjUx8ZY19Sjk1eJLVyXV2cW4Dt+t
         1BgeqNn7266dY5n4T5LCzA5ub6Oo2+bUr+waod1YqZwcP4Hf1EYrEBFKu+VbHu/RlmCW
         162GWlfCst07D7FwNax1+CWy5aEFepjFHiPwwZF1A6lyfE1r7e0OvK0aAsidKJ+V+DUH
         JshA5cl/R7wzAvX+/eoWm70Crntr8dlYY/vUfRuSnqVYhMqMpGmVdhG2HxXQ5XzO2X/o
         RTvV+xM3/Y59g2As2CQiPvsbTA4ivWeI/RjaKHGMBOj1VZL6lk5MQ14gNNywo3GXmU5J
         bWKw==
X-Forwarded-Encrypted: i=1; AJvYcCWb+N8fTf5i6YALQWsNpYohNFrLWhspq+X2PRSNt+k0DB5Zgo0CXYVmOF0+p/wrtbt901cd8Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtOifvajO3BXQeYt4LCT6fKCaUD210WggyRh9HxAKh4THT4AHQ
	eG28jEl7hmYSi+7hJYNR9JOWOzfP6G5JRud4f/iBNMddYaxZF1WSrem64F06tI5Sr601q29WX3D
	vC9kEU6IdlPe1UjGecYQCVefHf58iqlx4SxsdckevOVdA4lZ7mpAWVERkKZ0MwTSRBixVLg==
X-Gm-Gg: ASbGncvAi36qtdjLN4EqMwVfVF4u8WSNQ41Sy5luRaqJg18lhFQaT8ANBZWtOSF6Y3U
	KGoGtsvs1JL77ecRflB8Y+UFfHtC+yS+kDX+tOS253bSd7KAnCXjb/0ELEB0+EwqLsHL7EMcpYf
	N/1vQZ2qpLQUZ7xZ9qi0UwMCYN8IdzwwHzWH6pFeiT5ttqMoH9vb2yyp/OdP2EhaAxYaGo43FY6
	9oWO8P3hqZxCr8Q9+/UQlIYUK9hTCfEilM39QD0uDTEPwWm6qVF0C0v3x3D2KstDiV7bEyJ+9I0
	gYM5T2aOe43jr/+v0HPwUBQ=
X-Received: by 2002:a17:902:ce86:b0:215:a60d:bcc9 with SMTP id d9443c01a7336-21f17dde083mr133101325ad.2.1738858821676;
        Thu, 06 Feb 2025 08:20:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7xIUWI64nrQu0fKqx9xZ8GlAmAb7kqDKBPa/ICJYO9mtpVroAEEoXcqhbtONl4/U2xYaoOQ==
X-Received: by 2002:a17:902:ce86:b0:215:a60d:bcc9 with SMTP id d9443c01a7336-21f17dde083mr133100995ad.2.1738858821341;
        Thu, 06 Feb 2025 08:20:21 -0800 (PST)
Received: from localhost.localdomain ([240f:74:7be:1:c489:148c:951f:33f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368d79a7sm14788045ad.253.2025.02.06.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 08:20:21 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: wqu@suse.com,
	fdmanana@suse.com,
	dsterba@suse.com
Subject: [PATCH 5.10 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 01:19:54 +0900
Message-ID: <20250206161955.1387041-1-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a1c3a19446a440c68e80e9c34c5f308ff58aac88.

The backport for linux-5.10.y, commit a1c3a19446a4 ("btrfs: avoid
monopolizing a core when activating a swap file"), inserted
cond_resched() in the wrong location.

Revert it now; a subsequent commit will re-backport the original patch.

Fixes: a1c3a19446a4 ("btrfs: avoid monopolizing a core when activating a swap file") # linux-5.10.y
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 560c4f2a1833..45c1732a9677 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7127,8 +7127,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			ret = -EAGAIN;
 			goto out;
 		}
-
-		cond_resched();
 	}
 
 	btrfs_release_path(path);
-- 
2.45.2


