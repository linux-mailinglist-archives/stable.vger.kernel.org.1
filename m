Return-Path: <stable+bounces-124385-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29731A602A3
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 21:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D20119C59FD
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F731F4180;
	Thu, 13 Mar 2025 20:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHO2lfU4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB031F4628
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 20:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741897594; cv=none; b=dTEdkJ7ZL9aU7HEcU2wqBHGMB82hSEQtnwccqTBpHF1NvPoiEnp4/7OO2uplDDq21tCMEXqeidIthBO6Ms4uAaOXgPURChVqxeKB5QRuckqZgSwHU9dIZ/Mm1zg4ouC8NRA5Jj/0Qz6kJ3a0/rvOVrOAm0GrNJE/Aseyhz0/JAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741897594; c=relaxed/simple;
	bh=oCS3jmSccTTwsB+9+8RJuOHx8t+HNWfXOeaAQCPMZr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWFnKeRQ5bNrxSfVOsq5kLmLkowC0T6zzc8vJppGw9k5Fl2LLPeUZ4d+5RjQVD9O9d/LwBhGhKaRTxW68OJoSyMlJIhW3IhW4PRE4TNGatAmiZA7qGAl/iCp7e7vSKiLFte1iEYNunDyNfwPphTRC6MpjELxRk0/LCfkKvFwqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHO2lfU4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2239aa5da08so29338855ad.3
        for <stable@vger.kernel.org>; Thu, 13 Mar 2025 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741897592; x=1742502392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0a+m6Ev2M/TBfK4JsuzNtsm9s9HwtYOoRUp8ogENMA=;
        b=IHO2lfU4cCQ/YNG2MwItsWEQB4/+g+SUKkAjuS6tDZJPO8wOTVMo/rmYlkNUTw5mOw
         P1ryobnYCFf0A/9xG3MgDyn0cPdCeazIiTLusmWUPDocRk9bOEvYq/UjB5ocJ0NPgafQ
         QWvPbU9XRokIaKAs52xD/uo5eY/fihUgb6sj9UVDxzcqn2wz/GXxdifADZEiNkg2dYn+
         fiVxTK3trNyf4pIAKRVeenZwZaIrTwqz4NYXDR/WBaghNSj0ROmJIQWcbhpBsaRu0AVL
         uM3kRgOdrrRVPoM/9OpZPqzZTHKQqwDwrlRcWPcVw0mjtSEoo8MFcETVdyWsd0UHzxrI
         /y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741897592; x=1742502392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0a+m6Ev2M/TBfK4JsuzNtsm9s9HwtYOoRUp8ogENMA=;
        b=usrejijRQQwksRgXvxdmnFAT3FPIlzQ39v4yQgB9UQ50AFt5XlC5LIhgE1J268AB1y
         hbMk61T1/u/kcYrmheompDUOwMBPZeQ5EmCRE+eiuMN2JRFFmZRcdP0WU6MMgnvWpSDt
         Jwxha8f5S/FqGtBB9Pvx0PAzwdjpLjcJv+dHPmOFa+snLOkdzEwS3+/pbzDSx1xzyesG
         wacPU6yemkf5ch/GCXZQKksqNrt/1vv7T+Bc1huy5C+TdfcGRMc27Pvlaqw6F0A/OIup
         7W5Cz2A2vDOGQeoTZb6Fq33GqNDiuqbhQDODV9/U1nkijqBxptFbv0yzavu7XEAzmCnp
         4vhg==
X-Gm-Message-State: AOJu0YxUOAxKPqSw65L5ETlWtkzfRjEevVcNxEW/n6cly8+S5zf7a7LM
	h3vOHOoZeIa232O8ZHddcqnRhqvcTKAPFm0sn3gxNAWV5qzls7k9fia6vhfG
X-Gm-Gg: ASbGncvfwC8rK02VVOfvvge60m4OGGbEEFwbv53PVLR38FmwWAtaj1E4FU0Uh0W5sLJ
	q0fAz4UUAi8dk0LN7Rrvk2UnLBX0tWxmT9kKWtJGU2hSATSIeaPyMn7H8TvONVlrXDdFd2mhiSB
	8n9v2EM4O80zfJbn2RIcM8DRy80yXneakcTaBTlCg7+vTSb5IQEGqITdTMowbkok7g1LgDbBp3x
	QIMd99bHJoz/uaQLn9Cx/WZQsR1cuHWnct+/Hx0cMgv4Ge7N0hzPG66BLH5cmGciAUaQxtWBZ3w
	oGYo/coRJnExetJQIc6xKHmu6IGqcr36Owke8K6Sk330LTqfPVYgCzmGHysOh2kFzddAaKg=
X-Google-Smtp-Source: AGHT+IGDAQcYiOo9NMZhogR1jScfeuv0QFs9/jEBRO5/PKi2FLxPK6OnxtBjD1px93KH/6SR7nMTSg==
X-Received: by 2002:a05:6a21:7a81:b0:1f1:432:f4a3 with SMTP id adf61e73a8af0-1f5c12473acmr84935637.23.1741897591706;
        Thu, 13 Mar 2025 13:26:31 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:b233:743:91db:ac7b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56e9c94cesm1724455a12.6.2025.03.13.13.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 13:26:31 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 6.1 28/29] xfs: reset XFS_ATTR_INCOMPLETE filter on node removal
Date: Thu, 13 Mar 2025 13:25:48 -0700
Message-ID: <20250313202550.2257219-29-leah.rumancik@gmail.com>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

[ Upstream commit 82ef1a5356572219f41f9123ca047259a77bd67b ]

In XFS_DAS_NODE_REMOVE_ATTR case, xfs_attr_mode_remove_attr() sets
filter to XFS_ATTR_INCOMPLETE. The filter is then reset in
xfs_attr_complete_op() if XFS_DA_OP_REPLACE operation is performed.

The filter is not reset though if XFS just removes the attribute
(args->value == NULL) with xfs_attr_defer_remove(). attr code goes
to XFS_DAS_DONE state.

Fix this by always resetting XFS_ATTR_INCOMPLETE filter. The replace
operation already resets this filter in anyway and others are
completed at this step hence don't need it.

Fixes: fdaf1bb3cafc ("xfs: ATTR_REPLACE algorithm with LARP enabled needs rework")
Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_attr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index e28d93d232de..32d350e97e0f 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -419,14 +419,14 @@ xfs_attr_complete_op(
 {
 	struct xfs_da_args	*args = attr->xattri_da_args;
 	bool			do_replace = args->op_flags & XFS_DA_OP_REPLACE;
 
 	args->op_flags &= ~XFS_DA_OP_REPLACE;
-	if (do_replace) {
-		args->attr_filter &= ~XFS_ATTR_INCOMPLETE;
+	args->attr_filter &= ~XFS_ATTR_INCOMPLETE;
+	if (do_replace)
 		return replace_state;
-	}
+
 	return XFS_DAS_DONE;
 }
 
 static int
 xfs_attr_leaf_addname(
-- 
2.49.0.rc1.451.g8f38331e32-goog


