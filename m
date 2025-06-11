Return-Path: <stable+bounces-152472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32FBAD6098
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC24717BD29
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9213A28850C;
	Wed, 11 Jun 2025 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWOMrLe3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC0288C1D
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675714; cv=none; b=USA8Y2YTlWXWVbX/I3UlUpzoSToBEkwjomNMb67Osfi5kVa1BxaICCksswa1vCd8ZrDrb4zde6ngz++DWOcm0b2BlQQQyA21ZwmAyjj7j0JvYJsPGDX/bXpRy/cKC6g1f4FGvOR6elnw0nqIFaqzZ7B0EJCgVNVXhCmKFkoooWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675714; c=relaxed/simple;
	bh=yPXn7eEATjfTUUp44EGbRvVcHrzkf3zwFvxuxk3VbK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olt8wF338nU+Xhck5EeVGKzaBhuUFdO342N0U/c7FHtOXT8+jAjILTrLLmNRt3tR9cV0tqPKOnXIiiqaqEvnBhUX6mxJi7RPwCYcpjbD5HsrpvntKcIrx0vJTiKzNfhyTKYrCystEEqcXA3woERgkA2c/gY9+yK4LmZUGRe88f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWOMrLe3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-236377f00a1so2387885ad.3
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675712; x=1750280512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxgl2lcSiLlro3lA+azxbn6lwN30ymmD9jBjDGpvsYg=;
        b=LWOMrLe3ZzCeOqh/7nQy/NtWlAtDPzZxao1ijBiXL3TSz4eyZjHX7FUqOid+nBIN3D
         vhcQHXfLVuMAfQo4AqBRwYu2maDgOh1vtFwZUwpMs/qrdj3zkhdPZHnQnXbCpC/IWUsk
         wfAkICYw133suo65htnpyto9GQLqJ80DipoV3Tc7Nz0OuTgzpXpGI89ZkCUB1uqKqkks
         AOq+dXiLwg00tuLbzTRtbq98MxeJs1ANA4DCvKxYKt+LHS7Bvnk4yPBT01jldQbz+bap
         idq9i6iYNCohk8G2fcc3sSJHrleMXwLkOlXTyfJbRb13fjvZQ57ittHZpHczYPIMcLyO
         Bp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675712; x=1750280512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxgl2lcSiLlro3lA+azxbn6lwN30ymmD9jBjDGpvsYg=;
        b=eJfXTGG/NS+0D1roT/46nXdAGoNu6nnVQF59AQ8ZD0jqMcDLL1c78HgSOsVVdpGhLf
         cx5v4sZLhHUUQaIkbKcKxHqxltctejLfeMtXNLhDYyDTkkpCI/qc+HlKCcWmPqhriLSR
         RByH2HtaZK/HjGlsIxBgcetwYXcIDVz9qrMKikZDt3roe83mk0Ea204DkI3x0RS6RKzI
         TAWSxi0H3PCzd2tMfnJeCV5De0tNf7vZhXp2rbgZowxWOoVFVUWK9uwvixrkikwnQbpD
         aDHpzikAc7IbqY77j+RTjmwN8N0Pu46pH/avp24eJgYBJfxtbCG0U3QoWeH7FePWBrlk
         0KOQ==
X-Gm-Message-State: AOJu0YyDlWq05Z/MhN+zhr50FBo4Q8z7/u/4ZsEyOD5Iv+MXIVzp0A3A
	9AWU1B1k7j/NGxLMMMiyEbGpjkjXZPDnvTs6bZgfvDl/Vshctb7uLk2DyJD7opds
X-Gm-Gg: ASbGncuK0n2jo9w6uArsd/45CXDhNqIzQZNKM2rmYG2DSy+DPBSmYADrUHKaueNcJaB
	a4GL8PWU7/OS2z8Ays00O6wtHovjD/5R9VYKuUVzdnjOCbCqc1akQiiyPJ9NlzL2EtKttS7luHG
	t2g0M474bjSETk8RH7oZSZexgWZInPXjFZkq4guzZ7wBESYpmOTSZdcpvOzpLyEHBpW4xI61EAL
	OvzOawSsL5mzLNCyuKRg+nbiUPA+FPABU9QtI39qdX2VfZRJ+Hb4SmN4PXdzJZklhzs8DLfpPne
	68EA7taxYpLqFnHqp6G+LQ46uF0SjdMBwTX/4MDftnG3LZ+c2mX1tgS4ULZYWXVgPdgY04X7/fT
	85s5m9+hdnpE=
X-Google-Smtp-Source: AGHT+IGxibAxT5mzhfAcUIyfek9e3Y8z958uyOtD0F1/vpYPVIGxQu7ug0t9vJAH9NYpTGR8KGlRpQ==
X-Received: by 2002:a17:902:e74e:b0:234:8ec1:4af6 with SMTP id d9443c01a7336-23641b3291amr64627335ad.45.1749675712026;
        Wed, 11 Jun 2025 14:01:52 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:51 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 18/23] xfs: attr forks require attr, not attr2
Date: Wed, 11 Jun 2025 14:01:22 -0700
Message-ID: <20250611210128.67687-19-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 73c34b0b85d46bf9c2c0b367aeaffa1e2481b136 ]

It turns out that I misunderstood the difference between the attr and
attr2 feature bits.  "attr" means that at some point an attr fork was
created somewhere in the filesystem.  "attr2" means that inodes have
variable-sized forks, but says nothing about whether or not there
actually /are/ attr forks in the system.

If we have an attr fork, we only need to check that attr is set.

Fixes: 99d9d8d05da26 ("xfs: scrub inode block mappings")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/scrub/bmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index f0b9cb6506fd..45b135929144 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -645,11 +645,17 @@ xchk_bmap(
 			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
 			goto out;
 		}
 		break;
 	case XFS_ATTR_FORK:
-		if (!xfs_has_attr(mp) && !xfs_has_attr2(mp))
+		/*
+		 * "attr" means that an attr fork was created at some point in
+		 * the life of this filesystem.  "attr2" means that inodes have
+		 * variable-sized data/attr fork areas.  Hence we only check
+		 * attr here.
+		 */
+		if (!xfs_has_attr(mp))
 			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
 		break;
 	default:
 		ASSERT(whichfork == XFS_DATA_FORK);
 		break;
-- 
2.50.0.rc1.591.g9c95f17f64-goog


