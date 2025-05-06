Return-Path: <stable+bounces-140907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74486AAAFB8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963857B764C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09823C6F3D;
	Mon,  5 May 2025 23:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzEpKQfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD21A39B08A;
	Mon,  5 May 2025 23:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486839; cv=none; b=irZFMVqY/uKdrsC4EPzkmux2OwMhUmIn1RsTjs/nneTMeiLSafYsRrUSU6iEUEEt0B0troV93Ut3yjSK8HWm4WFsuP+lu8ZGA/LvRPOpyC9niUcwsFdMS+5eXcA3pIzNSOkqs2+2XQFBrLK85Shw16h8yABDFWSDxdsmYT1fpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486839; c=relaxed/simple;
	bh=mMsRvzBORKHjD8vtd6K28orEvJbjyOhbzMYjD40a0DY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h2yoca/PukMK/FpEhCUjduwns1ua1+srXuM39SaUL6kFo+GHN1idHAVX2o7NZqjn5YgIXjRlIRoTdCwyuPdJTbGPfYABwhnMmA3VXiorYQOzGP1QP68QH4gNX3okcICZnauW5ojvpCTE74OSHyJrITHpcQK52wSUWYllNhmIXyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzEpKQfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518C3C4CEE4;
	Mon,  5 May 2025 23:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486838;
	bh=mMsRvzBORKHjD8vtd6K28orEvJbjyOhbzMYjD40a0DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GzEpKQfVxuO1Tnhr9c/8zdpP3Cz+bBRHXR5Dyb+/Dg+/QYMhxV1lq3Awl2gPFO132
	 mnl1pxBCNk/FVcXdxIkduG2gqJ5sWMsTjnyhn+8Qx1udwHytweIZ3HBdp2iJkGkY29
	 limvm/SuwkQE96zQXBeFGCFQzjdXjuQMmK7INmpa6/BwmrP1aBYm5Xka9EY20K3sYx
	 V/krn85ANK3fZC07Tm/lGnTWvjCVt9GYZLGwtCkPcqcrXdG0bYD6rXecf8pfKPX6Lx
	 IgYLpcvq22DGtZOEYJvvTLi9tgKHOjFR4ZblBGwx0qhH6wrGqUGO2eiRHN1P7kZo9E
	 GRpU/MZVtlS+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	snitzer@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 017/153] pNFS/flexfiles: Report ENETDOWN as a connection error
Date: Mon,  5 May 2025 19:11:04 -0400
Message-Id: <20250505231320.2695319-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit aa42add73ce9b9e3714723d385c254b75814e335 ]

If the client should see an ENETDOWN when trying to connect to the data
server, it might still be able to talk to the metadata server through
another NIC. If so, report the error.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 4fed292de029f..a55eec241657d 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1258,6 +1258,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -ECONNRESET:
 		case -EHOSTDOWN:
 		case -EHOSTUNREACH:
+		case -ENETDOWN:
 		case -ENETUNREACH:
 		case -EADDRINUSE:
 		case -ENOBUFS:
-- 
2.39.5


