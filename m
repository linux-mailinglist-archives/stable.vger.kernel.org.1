Return-Path: <stable+bounces-140995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F527AAAD23
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87951A8343C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E69289362;
	Mon,  5 May 2025 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUX6tzUS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016E3ACFDF;
	Mon,  5 May 2025 23:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487155; cv=none; b=TXiieN2Sf7QXt4qTW+bR4sIavwZmKPYSrVG9NFrMAIOuRYeUnTe9hGHAdMMaONEQRjV9lFMk5Hu4udniTgQVVh0qTjxqfPtmxNvr6CXouRa0ljmxc9xXEnRHmb3DzIWrtsCIl2Gr0aayJn0/g8fRqAtPdkpic8rwx4VXglENWi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487155; c=relaxed/simple;
	bh=pxB8LBwfhpVSLkioEauLcXwKL80JaJNhUyoMm781dXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvGMV9ubePWmkj8TqP+tjdUkjbp7dv0YPWaKX5Q9mrVLEhtmPw2sf1xwVpqeGjcUktfSswPi7hSJUI0GY2HRF07W5LPEE158lEtk4j3yXyiutJOTx5X/6bSCsWDIOnC8q7oDl2VWUgy0/06PwkH341eMQImgn/yl4zVpojyiRWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUX6tzUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67405C4CEED;
	Mon,  5 May 2025 23:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487155;
	bh=pxB8LBwfhpVSLkioEauLcXwKL80JaJNhUyoMm781dXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUX6tzUSVxXJFWPA30ZBcW60NVuAHQCN+blxGrO9J8PB0NdUFmufWOhw0befBeGoD
	 W+Drr/FX+gyrXzXvZUMSw4WWnG10VpmeH6hrmqRPLe0P+0ccyom3n7EpTYBcIWFBkr
	 YaBoaAi+QW1oWwDDEV5sNtCXBAPeoOsZbmzoXLF8/wt4Y3qlG3Up31euxbqAziWtyR
	 QGwvK8HX5QPJIbDE9LJIu1tlbn5PViGCSn/hadl7HhwqOIaNhEoSKqN5C2tgOuvCmM
	 f+xSvryTyli/ZxUc4ekb8D4sHxOMI+25kKGtZ6CTxxmyXsCrx8+Q7gKQX5V1lpuZmp
	 h71j52sjQl/jA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	agk@redhat.com,
	snitzer@kernel.org,
	dm-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 030/114] dm: restrict dm device size to 2^63-512 bytes
Date: Mon,  5 May 2025 19:16:53 -0400
Message-Id: <20250505231817.2697367-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
Content-Transfer-Encoding: 8bit

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 45fc728515c14f53f6205789de5bfd72a95af3b8 ]

The devices with size >= 2^63 bytes can't be used reliably by userspace
because the type off_t is a signed 64-bit integer.

Therefore, we limit the maximum size of a device mapper device to
2^63-512 bytes.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 31bcdcd93c7a8..6bca56ed83ae1 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -681,6 +681,10 @@ int dm_table_add_target(struct dm_table *t, const char *type,
 		DMERR("%s: zero-length target", dm_device_name(t->md));
 		return -EINVAL;
 	}
+	if (start + len < start || start + len > LLONG_MAX >> SECTOR_SHIFT) {
+		DMERR("%s: too large device", dm_device_name(t->md));
+		return -EINVAL;
+	}
 
 	tgt->type = dm_get_target_type(type);
 	if (!tgt->type) {
-- 
2.39.5


