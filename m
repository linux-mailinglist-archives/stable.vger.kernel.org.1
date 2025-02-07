Return-Path: <stable+bounces-114301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DFA2CC95
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 20:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811463AAD3C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 19:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1D31A3143;
	Fri,  7 Feb 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1reYqyX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3218DB0E;
	Fri,  7 Feb 2025 19:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956534; cv=none; b=QyrS0Jg07OpWhWbhKcSTTlaBUt3NKmMLEOFpNgnd6DL14WbrAM/SbrGoL19lY1IEci3VXA3tz5njJKYJbA+y05gA/l1VIKeVSKx96vSqtwji/VjW8dMr4bsmJJuZNOwklN5QB+w5X4X7HiUZXP/iGzaUphWJ7El9bmPRswVDlUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956534; c=relaxed/simple;
	bh=LHb/TuVy3D+/FibKVZy9IjJ6zLxeLpmti7E3Rsil9UI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DUj+3/0HW4D1P/aHwb4lnszkZYRFoBjKD8XriZVIvsnMYpmXAYydr9T8NXYELZ5sz7sCDKmcRiwMEn9zlqffLDjcNNH77ZGpFPRncv38553RZYd8Ox4KV9OgEzFn0UJ/KRLY1T6Tpw3XD4cpJjFf4ncYx1D3YZyP68WTKsBu3w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1reYqyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBCEC4CED1;
	Fri,  7 Feb 2025 19:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738956534;
	bh=LHb/TuVy3D+/FibKVZy9IjJ6zLxeLpmti7E3Rsil9UI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k1reYqyXuBl+L6IM6MjjaBlr8mbu7cMqn64Ipw9hTjUCDMcV8sdZ2ZL2yAOFbd322
	 ZDv6+cj3KWA8tuTIqCz+Rvvm6tAXvVIz/Kg4P2w20kJS99c/ibSARzpplI0K3hC8Xg
	 6GfgToJbmiaJ94zAF/GhWSD8nX0qbwp2+xTI7pQXUlN2H8mGiuVUYfS+ahEB7Y8E5A
	 PQHp36mv4juPaUUdE3O3Iukmv0YM89X0rdNGt/hLNZbZsA7JfuwJ3r2gB2L8DmHrh1
	 oksNjLGnUJ5VHtaHCdoct7gWWJYH09e0148jvD5hWI+1p9krVGZ0T5u5UTFrGMnOAB
	 SM3F8iyBPRXZQ==
Date: Fri, 07 Feb 2025 11:28:54 -0800
Subject: [PATCH 10/11] xfs: lock dquot buffer before detaching dquot from
 b_li_list
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, xfs-stable@lists.linux.dev
Cc: hch@lst.de, cem@kernel.org, stable@vger.kernel.org
Message-ID: <173895601566.3373740.7315790259628729484.stgit@frogsfrogsfrogs>
In-Reply-To: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
References: <173895601380.3373740.10524153147164865557.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

commit 111d36d6278756128b7d7fab787fdcbf8221cd98 upstream

We have to lock the buffer before we can delete the dquot log item from
the buffer's log item list.

Cc: <stable@vger.kernel.org> # v6.13-rc3
Fixes: acc8f8628c3737 ("xfs: attach dquot buffer to dquot log item buffer")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_dquot.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index d64d454cbe8bca..0d73b59f1c9e57 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -87,8 +87,9 @@ xfs_dquot_detach_buf(
 	}
 	spin_unlock(&qlip->qli_lock);
 	if (bp) {
+		xfs_buf_lock(bp);
 		list_del_init(&qlip->qli_item.li_bio_list);
-		xfs_buf_rele(bp);
+		xfs_buf_relse(bp);
 	}
 }
 


