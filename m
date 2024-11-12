Return-Path: <stable+bounces-92782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB259C585F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD71B33952
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1621CD218;
	Tue, 12 Nov 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tms/bCPk"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63361B5829;
	Tue, 12 Nov 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731412999; cv=none; b=m7nq4UJVxViQaF0+8lu1bWn1W5faaO6Ac7U3Bl1JVnvDraNnYJFanDN/0+gwfgKaqwXoPq9EATJWxouOu89MV0gjJqgIqWzzQkyv6Tq4g3nZEhRDMm6UfpNl1NsJFjpS1JswTRKh69VXdpknnghymPTw2bSabiM7WnRRiQt3rQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731412999; c=relaxed/simple;
	bh=/Esi87XgeVovB6T3Sej0pCCkEukyUwemC8cD3KnIjv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zp3CZl+dzF7DYCKnviQBK/HN2WAb6wpRWXTg17D6yF5EvOIeE6JxTDsl66e763xSQ07Va8xEYebkm+lrn80NRoHu77MruELOh1M9wFhEKm7OQBy9fBr9oozl0bdNqFJZgGsSSKh79PnUYdGUDHiNekbGWZ/xMf2v5h7hprxfLkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tms/bCPk; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 78EC53FB68;
	Tue, 12 Nov 2024 12:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731412994;
	bh=wdkJXjd/KslLhG7uP/APNF6NFWhU/WHorIINMNlA3Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=tms/bCPkno7IgBwvYOOsQlGdhsHbmZ3C8VRMLVZEq3+7GW4Vj1Gs84VshSwfoHZXZ
	 BFVtMp3kZ/rx/zsY9ya2csnv/r7kG9jvei3BGsSI6SJgTgerEVCE6+1n8QN9ufuVvt
	 oOgfZsCudFVaJQK0jpPo1YAK2jlQN7gsy2QA4IYu36aPaWbH24hvfTcALfqxlWUaEz
	 GLL7QdcS9dfBNCqhnivUEc7cZZqf3eGsmLgzKelgcpZEK51G37ad/NVuh1wlXrXepq
	 Ky8Rh7ZfmA+Wgb9hmCxHLDXBuRP0Jj55nacvD9KSyKQ+pwt0rHBoyFPLeCCUVu8em5
	 7HTJeMHVi/ZTg==
From: Agathe Porte <agathe.porte@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	Agathe Porte <agathe.porte@canonical.com>
Subject: [PATCH v2 1/1] ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields
Date: Tue, 12 Nov 2024 13:01:54 +0100
Message-ID: <20241112120304.32452-2-agathe.porte@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112120304.32452-1-agathe.porte@canonical.com>
References: <20241112120304.32452-1-agathe.porte@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two fields are populated during and stored as a "frequently used
value" in ufs_fill_super, but are not used afterwards in the driver.

Moreover, one of the shifts triggers UBSAN: shift-out-of-bounds when
apbshift is 12 because 12 * 3 = 36 and 1 << 36 does not fit in the 32
bit integer used to store the value.

Cc: stable@vger.kernel.org
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2087853
Signed-off-by: Agathe Porte <agathe.porte@canonical.com>
---
 fs/ufs/super.c  | 4 ----
 fs/ufs/ufs_fs.h | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index bc625788589c..7ea1a4c07ba2 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1240,11 +1240,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	else
 		uspi->s_apbshift = uspi->s_bshift - 2;
 
-	uspi->s_2apbshift = uspi->s_apbshift * 2;
-	uspi->s_3apbshift = uspi->s_apbshift * 3;
 	uspi->s_apb = 1 << uspi->s_apbshift;
-	uspi->s_2apb = 1 << uspi->s_2apbshift;
-	uspi->s_3apb = 1 << uspi->s_3apbshift;
 	uspi->s_apbmask = uspi->s_apb - 1;
 	uspi->s_nspfshift = uspi->s_fshift - UFS_SECTOR_BITS;
 	uspi->s_nspb = uspi->s_nspf << uspi->s_fpbshift;
diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
index ef9ead44776a..0905f9a16b91 100644
--- a/fs/ufs/ufs_fs.h
+++ b/fs/ufs/ufs_fs.h
@@ -775,12 +775,8 @@ struct ufs_sb_private_info {
 
 	__u32	s_fpbmask;	/* fragments per block mask */
 	__u32	s_apb;		/* address per block */
-	__u32	s_2apb;		/* address per block^2 */
-	__u32	s_3apb;		/* address per block^3 */
 	__u32	s_apbmask;	/* address per block mask */
 	__u32	s_apbshift;	/* address per block shift */
-	__u32	s_2apbshift;	/* address per block shift * 2 */
-	__u32	s_3apbshift;	/* address per block shift * 3 */
 	__u32	s_nspfshift;	/* number of sector per fragment shift */
 	__u32	s_nspb;		/* number of sector per block */
 	__u32	s_inopf;	/* inodes per fragment */
-- 
2.43.0


