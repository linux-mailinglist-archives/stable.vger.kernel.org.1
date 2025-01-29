Return-Path: <stable+bounces-111216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB7A22432
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88257A23FD
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A0B1E230E;
	Wed, 29 Jan 2025 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BuB+BOH1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2B1E102E
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176457; cv=none; b=MvSSBdhSlfEHOyZPJI+hdNb0iaB1KhJQQVj1Sf8Dn4fAZ9MIXf4mUIh1KqMqZZ1//+sMc6BBbH0RBfEyA9IV6ucuFH5WnYMmgnFytNYqqmjcCXX66WHS3EvuqxH3muephGSPzErToxrkWhnla64rRcLy7IHXTtD/fFZ//rBxAWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176457; c=relaxed/simple;
	bh=8TUQnbp0W/lUjDrjWUQTL6h2ONa0wAN7fHdtgv8jeSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/h3qaLWqsbBTy9H/yxZ1/CRSIkXH9faQvYc5/xpPI5riz8L4Z0wQnRoducLO09HUOwzGq5wQtNLCUJl4IKJw6xwQb+WDI46flyZ4vDK7eAJJDpOa5Omatter75XfAw2d1kd9KxV/KY42U1PfMVP+MyDmE8YAGPrNN4xHR5Z2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BuB+BOH1; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21634338cfdso13960795ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176455; x=1738781255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33bh8LQpxG6HB4sUmO1rFJAHvfEKG95QzpFImrPBXAw=;
        b=BuB+BOH1KvtovaDKQKMVa1ifZt6UWxkqhkSSZDxzNfbfz7klnOk42GQSJ3G8aTaEV/
         yo/PfnprGNT41kWs033oDkQw/J1bnUMgVnB+RIoyF01YaloWoGizPljYzSapYZyjc6UK
         UfPAZxpGCPPyFLQrnNv+qZzAOySfukc7FOjXBPuSGrAHhaFUEl7ZmleMc3GQZrZADtTX
         uqBr4XlElff4sdip+LZCUFTIDq9oH6imNsxVXaPmn7lcx1oXgXyFY3xgE5HzJ0wWwrQ+
         tegcxyetI0oJ/gosxvH8wbjNp1pLhc0PllovwA0qlWAyO4XkZjVQTMsQZJoSYaEhebIq
         iZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176455; x=1738781255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33bh8LQpxG6HB4sUmO1rFJAHvfEKG95QzpFImrPBXAw=;
        b=mUDHqQR70Cm56TD7Z3OAp6SrbFrxPFznU+0BdmPzrT5NeLHNXwhRAhwl7y3hDi6JuX
         oaGySgGBUPM1dIkZGUIC6cC8Kk3P1k/az9v1XINVzzEKcKpEuMMGyo0yuTvRfx1oZzlu
         cwnzhPf69Hr1EQuY4PltL6D/pluBZ1wkc1lrcVVQpqEZqBhCrw1XIm0Y7a3Njp46ZtPc
         jhyDm3wrC9fdl+DoVdKuLwxQhLMAK/gpstIYoyLgLlMD5HPhxQh/X+OQZgSEMa4K1gQo
         rlZBuFM4WpjxYOJLSWDrbwHB5mXzyMxGioFz2L2EUIZA6leBZ7JZNZK0NpV76dZCTDYN
         3j5w==
X-Gm-Message-State: AOJu0YwF1DHnjM6mcUk1yzGNk5URcOh55g2tVXuWg6WbXwPkKoar9Nif
	SImn4wN7ssZkNxZepjOIb3QO4CKtL46EYIczKhga4SjwWLZzZq4/+V0yGQ==
X-Gm-Gg: ASbGncvdY7UguzpFFtsUT0M7mV9B0q5HkL9KUedmQpa5Sp1hz/YnsjNZaBvBI9NwUN5
	VJrovmMHibM7lqFNNMVPgfU4zpnyDd3CFE0KJGKqp8ii0E/qNP1KsUQyFgfXaZ+CGGr3jy46pc+
	f7dtIDgubSr/+AOp5cs97khcfxm9Ecp5QwWtNSKUAEtpu1ygpBBjqp1JcTKYY7D1mb0qyCUXX5a
	XchIuh/6dDIiekbVBZpTRW/OK4TO638Er4UMrlV/rqgMoIXPDtSG8H2NUXVUIlBrQD//3NXx+R0
	8xR6uG3KQIcQWn+WtoHYHfciBdd5wxjoyoiwEtGES4A=
X-Google-Smtp-Source: AGHT+IH1M8mUyw2jPPNovInWQCPZZj2D3lqUxI0kxAycv4P4Vm0YAwTjvug3BpsnZP5cmaAAUpn3DQ==
X-Received: by 2002:a17:902:d2c2:b0:216:401f:acd with SMTP id d9443c01a7336-21dd7c65ae1mr63207665ad.21.1738176455256;
        Wed, 29 Jan 2025 10:47:35 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:34 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 05/19] xfs: fix units conversion error in xfs_bmap_del_extent_delay
Date: Wed, 29 Jan 2025 10:47:03 -0800
Message-ID: <20250129184717.80816-6-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit ddd98076d5c075c8a6c49d9e6e8ee12844137f23 ]

The unit conversions in this function do not make sense.  First we
convert a block count to bytes, then divide that bytes value by
rextsize, which is in blocks, to get an rt extent count.  You can't
divide bytes by blocks to get a (possibly multiblock) extent value.

Fortunately nobody uses delalloc on the rt volume so this hasn't
mattered.

Fixes: fa5c836ca8eb5 ("xfs: refactor xfs_bunmapi_cow")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index d45a2e681f93..27d3121e6da9 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -4805,11 +4805,11 @@ xfs_bmap_del_extent_delay(
 	ASSERT(del->br_blockcount > 0);
 	ASSERT(got->br_startoff <= del->br_startoff);
 	ASSERT(got_endoff >= del_endoff);
 
 	if (isrt) {
-		uint64_t rtexts = XFS_FSB_TO_B(mp, del->br_blockcount);
+		uint64_t	rtexts = del->br_blockcount;
 
 		do_div(rtexts, mp->m_sb.sb_rextsize);
 		xfs_mod_frextents(mp, rtexts);
 	}
 
-- 
2.48.1.362.g079036d154-goog


