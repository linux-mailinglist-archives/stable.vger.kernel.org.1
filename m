Return-Path: <stable+bounces-124381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C242EA6029F
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FDD17D5FD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077861F460A;
	Thu, 13 Mar 2025 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJBP+Kf9"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF71F4624
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897590; cv=none; b=X6yWcPCz/1aqDroI5LdoLTTL6UCFjYF6HibLvuOpwOVXPAilyBeVRLBgAG6XnMvVl5z6uxiW86D5QoMGdwSK5WJiK0phX/QAgYyFcZ20MfGfUsZAFmui1tx0ozoPhA8VRm3xXoPG8Nqbcbx8P61XzItq/djRltBfAAudbZynRns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897590; c=relaxed/simple;
	bh=UCEF5cAyQR2i3kM+IWKX2aV4NjmYsoWMifDh1HRyyxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrsSn5FvaYOq2Htat12QpIpehdP+QeW/OAeWnx40r4Hq+zynBesn3KSGip0zYJYwUvpSyXj7qpfokGJszKAq0YFfPIPSZlh5kt4cQQ32w/EK+a54/hS1xMarXjiErBbfy4gi/5ZrY57C/OxNA0zt/GWYcn4BcTTs6oOSJbrDwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJBP+Kf9; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fd89d036so31227735ad.1
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897588; x=1742502388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8Fo+7lYuejOCNgFSfEv4KCBucjx2ttu+XY47yKvXwQ=;
        b=aJBP+Kf9d5f0i6ou8jJrooMJNujFGPpDwwk0mJPI1YvzeXEGNlntBfkZ3+AVmz2EkV
         8dnz0inUc7jzcXRdGhHNRD1zgIOF251MyZcdouj4+PgqOea4MnV1AfZWNq2nQEt/NZHs
         /sLr6alp9DVUTintG3TFwYle/lFYpgVyf4ohYJFsOvZ8nXdCOTAPOM3ntPzoMn929EH8
         js2qosbjHyO/gWN6NsbvtHJg4F/9nVlcDLxP2DNYVbIj8yqvft9lRJ1xZPKADP+R2Ne3
         /fCkBQMgwHI+GvCqalqe/UhPWlIyDheYM1dedpiVAdYIY2ri6u4OSRcgdC8ZFbbW64wI
         Orsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897588; x=1742502388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8Fo+7lYuejOCNgFSfEv4KCBucjx2ttu+XY47yKvXwQ=;
        b=uT1lsQJdNjBsSsv/n9jacd119lHXo1h6dIll/FIpD5ybG5G8WQ5nXPjhvJri08nSkj
         WKGQT7L59wfIts8dcwqMt2s3rfzIDXuT1J8Zp+RVNYC9guppqNCdMXMJAifxUtJ++gV5
         1PtKjOirp2Nv4tYE7Ovqw/2nxUtxRBGkKc4QMJCKR7VUelZXs172d9TUZZosFMtJrw5y
         ldOGSz5Mc1TSR7Ila+h/fMMMM6yIsFgvV9tfX10fhGVBSZ7PXWi4ZswPBOX1iiQMhdKN
         LpNPBtqUCKjykmpAbYXDCyF9o0hOCxiVB0+MHFWR/f+irt5AqzwNfwQlPMtsH7WRkohd
         DijQ==
X-Gm-Message-State: AOJu0Yx2QVCPC+hIqi7iDwTUvXGoNPC3URSc1pyr8WHR0txgF7Sb5ury
	gqCIW9dgxWpdxN3KA01BbRSUSTBnNT8zXIaFta0TsikjFeRu3ITGMN6cqclq
X-Gm-Gg: ASbGncu19LTZhAngD+5YFtB+oYJ+kDALbHW0ZdyjQStHeSJ2LkNprt/O2wDilsBV8W6
	bhFDTogVf179mRZw+hmYrMsCToDcHWTDtNtto5UjPJb1ii/JCu2ihvzIPvtsWhWsdVFgpHJFl5R
	mgzuVSrKjJrrPYC0n2aGCgoLfAK15r560ZAWGrVIx+1doAcWjildze+XNO/mjOvdX0CXzKYOlkl
	0FqHlASwjfsOJlj7NES/zwNTAE0YIxiHH+kFEyZBKpVi2IxOHG51vpe/6XtGBgwGL9Ef4Pg6qqa
	rxU4UD51h0MilfJLL1cB6LI5IU2zXo46QfbK+db25pUHbHFdcTcoBPpP1U1CC0sfvKV9mFo=
X-Google-Smtp-Source: AGHT+IFxIji81KqiJayEp6eUiqqleepJ29vJcZ2l09ZolIZnKbqIC5sbKhOiL8T16sRgxcDU7Zvu8Q==
X-Received: by 2002:a05:6a21:58d:b0:1f5:8153:93fb with SMTP id adf61e73a8af0-1f5c114b9abmr102609637.10.1741897587704;
        Thu, 13 Mar 2025 13:26:27 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:27 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 24/29] xfs: add lock protection when remove perag from radix tree
Date: Thu, 13 Mar 2025 13:25:44 -0700
Message-ID: <20250313202550.2257219-25-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To: <20250313202550.2257219-1-leah.rumancik@gmail.com>
References: <20250313202550.2257219-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 07afd3173d0c6d24a47441839a835955ec6cf0d4 ]

[ 6.1: resolved conflict in xfs_ag.c ]

Take mp->m_perag_lock for deletions from the perag radix tree in
xfs_initialize_perag to prevent racing with tagging operations.
Lookups are fine - they are RCU protected so already deal with the
tree changing shape underneath the lookup - but tagging operations
require the tree to be stable while the tags are propagated back up
to the root.

Right now there's nothing stopping radix tree tagging from operating
while a growfs operation is progress and adding/removing new entries
into the radix tree.

Hence we can have traversals that require a stable tree occurring at
the same time we are removing unused entries from the radix tree which
causes the shape of the tree to change.

Likely this hasn't caused a problem in the past because we are only
doing append addition and removal so the active AG part of the tree
is not changing shape, but that doesn't mean it is safe. Just making
the radix tree modifications serialise against each other is obviously
correct.

Signed-off-by: Long Li <leo.lilong@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_ag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_ag.c b/fs/xfs/libxfs/xfs_ag.c
index e03bfeacbed4..e7b011c42b7a 100644
--- a/fs/xfs/libxfs/xfs_ag.c
+++ b/fs/xfs/libxfs/xfs_ag.c
@@ -343,17 +343,21 @@ xfs_initialize_perag(
 
 	mp->m_ag_prealloc_blocks = xfs_prealloc_blocks(mp);
 	return 0;
 
 out_remove_pag:
+	spin_lock(&mp->m_perag_lock);
 	radix_tree_delete(&mp->m_perag_tree, index);
+	spin_unlock(&mp->m_perag_lock);
 out_free_pag:
 	kmem_free(pag);
 out_unwind_new_pags:
 	/* unwind any prior newly initialized pags */
 	for (index = first_initialised; index < agcount; index++) {
+		spin_lock(&mp->m_perag_lock);
 		pag = radix_tree_delete(&mp->m_perag_tree, index);
+		spin_unlock(&mp->m_perag_lock);
 		if (!pag)
 			break;
 		xfs_buf_hash_destroy(pag);
 		kmem_free(pag);
 	}
-- 
2.49.0.rc1.451.g8f38331e32-goog


