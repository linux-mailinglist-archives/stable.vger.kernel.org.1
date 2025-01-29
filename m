Return-Path: <stable+bounces-111214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCC4A2242E
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D433C167AE0
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FFD1E0DE3;
	Wed, 29 Jan 2025 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEDsMu4/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC9F1E0DB0
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176455; cv=none; b=M8jPS0kwUGktxMshOQtVdpu6z7L3iI2UPjnhzHy7Xx1DT2O45VNcq6wR9rKNv/O6LXGerATcHnNKl9Tw8Wf2FmJPVLN5ugQLIG6Y+S986i0h9JtXNEGE2JSYCp9jl7+5GZur/7hl3cUbCU71IhQcnOTXx01pqEKC0i61LquNapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176455; c=relaxed/simple;
	bh=XDsubgkhhaAj/dYHBKDTkxDQBsz9IPxkFE84+jusaQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsN20+X7WM3XLBGRlH9Q4eMqjatr04CcQAjdUgQL3LykNQuvlL2hj8SjPbT5NKKoXU7B0hi0il8WfAOn6TileeZBRxvINe2p2Y215ovvbZe/dibpDRUpiSttv/lnUiVeD+U2rMxJpkzzBlJjj6LvkHfZZfLM53TL5fVl6D5it6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEDsMu4/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21ddb406f32so11704695ad.2
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176453; x=1738781253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW3IAnOL6Qm3QXiXR3K/noNXhkGpnPKnF1bkC7YNOBs=;
        b=DEDsMu4/NlrZIB6OqGMV45ASNqhgySnC0T6YAZaK45tpIDwH8Id+wu77TqWulBmF0u
         5eWHO45GIzdZX69zuDOkUHQ26qS6Lx3CYcK9rsCLQSRqIUo+guWP9Dp0olxbfvzDtZd+
         tRssOjr9XlINupngIF3L++W0Cig56WNiLbS6LGwA9H0JC0bl97Wn9UA4m0I5oC8aXU46
         2E+j3N1pEJuVRes3s7aGPoyACsMddCu1NwWhoywR3gEbt2zLs3cdERK+1hxGlI9/G8Ch
         BEY2Gxeqp2Gq0ZBi8KcmGrd6xFT1+f0qG0rJs0WkRdS3pEys5qrsVzUBzlue0hVcudiX
         /lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176453; x=1738781253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW3IAnOL6Qm3QXiXR3K/noNXhkGpnPKnF1bkC7YNOBs=;
        b=YQDVlrQchC9lAP7eYmAd+6dFsg+Rz9LcNdNVMUplhov1mKs/sNzSctskU9e1xBcXFQ
         KGXmRwU0hciCfu9gY23nysBsMUeG4rikOUbGLhBpdWtfRWczOZxXdbXwJO1EbjODD8uB
         yxHwTN/XmyHaCTxGR2SSj5LdW45eZUVulSHhU9roRJWqHGlMOtuDLgoFjqhmDoK/HqoP
         noVCMd95wrrdPT1A74+hZvawi+nX5KFIfW+B5P64A8WjN7xwec1QhZcpznyhqY8K3+A1
         eDUuEcknEECYp6RpUs3GWuvmgcxRJeuBj65f7HwSQKLFB/bL0VayKJ3PSW98a6lfaUsY
         uFHw==
X-Gm-Message-State: AOJu0YxKTXGdWn8jYQdM537E2DS8J5weVfB8XeZE0Aw2PwAw5rfwhvZc
	625UHXCsAfN8DhussKOY8btGHjk3VfFRnxEyB7FkN+AJu6P3tYHJMpm2Ng==
X-Gm-Gg: ASbGncvljUuD16skVrEvNlldy+1+7RyHlqo1F7gJwoHMIG8XEUYHmNI8h0Kv8XXgpiB
	aS6tkWx7N9ZjFDO9MFHUhE0ZbzOuQeK0AGfMxjg7qGJB/jMbqY5SEbT76UBbHPn32Y3nbnXtveQ
	L3ZY2+I49VUhiuxgKopYeHs390HoYEBgq1pdbJkgso8PU2mzaAsM9pK2bwYuwgo/UmOjWCebOMu
	aQEnq4jJ2s6dg0h4+eu2rcnSAZ1xlPcH5CdazU/DjYLfJ/2ReRKAcKCMWCWV7dBDM/CseSdkscg
	wQ1I2AY8n8QcKqSoMRlG/vxmEl9YyQko8yTSg9GHEo0=
X-Google-Smtp-Source: AGHT+IEDhRCAYz6hVwBlG0jZ7oWcB6CG64aU8NzKQMc3JADACYzW4veOtwGfnNfYJk+jS6hhgSLPaw==
X-Received: by 2002:a17:902:e5d0:b0:21c:1140:136d with SMTP id d9443c01a7336-21dd7deefabmr76062095ad.40.1738176453280;
        Wed, 29 Jan 2025 10:47:33 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:32 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 03/19] xfs: prevent rt growfs when quota is enabled
Date: Wed, 29 Jan 2025 10:47:01 -0800
Message-ID: <20250129184717.80816-4-leah.rumancik@gmail.com>
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

[ Upstream commit b73494fa9a304ab95b59f07845e8d7d36e4d23e0 ]

Quotas aren't (yet) supported with realtime, so we shouldn't allow
userspace to set up a realtime section when quotas are enabled, even if
they attached one via mount options.  IOWS, you shouldn't be able to do:

# mkfs.xfs -f /dev/sda
# mount /dev/sda /mnt -o rtdev=/dev/sdb,usrquota
# xfs_growfs -r /mnt

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 fs/xfs/xfs_rtalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 292d5e54a92c..34980d7c2dd6 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -952,11 +952,11 @@ xfs_growfs_rt(
 	if (XFS_FSB_TO_B(mp, in->extsize) > XFS_MAX_RTEXTSIZE ||
 	    XFS_FSB_TO_B(mp, in->extsize) < XFS_MIN_RTEXTSIZE)
 		return -EINVAL;
 
 	/* Unsupported realtime features. */
-	if (xfs_has_rmapbt(mp) || xfs_has_reflink(mp))
+	if (xfs_has_rmapbt(mp) || xfs_has_reflink(mp) || xfs_has_quota(mp))
 		return -EOPNOTSUPP;
 
 	nrblocks = in->newblocks;
 	error = xfs_sb_validate_fsb_count(sbp, nrblocks);
 	if (error)
-- 
2.48.1.362.g079036d154-goog


