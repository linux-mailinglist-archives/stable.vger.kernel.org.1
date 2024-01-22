Return-Path: <stable+bounces-14089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DD837F73
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA567281642
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC86313E;
	Tue, 23 Jan 2024 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lCNVm60x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD6D62814;
	Tue, 23 Jan 2024 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971138; cv=none; b=KdhEl8eTYlQXIGGCz+oEjl921+L7EG5Wak4dajy7fJdrJcI3PNwb4SQxm+ym9r+b3UVkvHwVet0jM4MtEjYc7hmeO2jLQQyiCkC/W11qaUkZC6yQQ7fprN2HWS250QsTmw2wDHCioWjXLHToGrwOIFswtZwlr4EaGICdOqP5cTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971138; c=relaxed/simple;
	bh=LCtYnopr7599kg5vWIQSIDWSZtPlar3LSN5nnugy7Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPRmzAkQuoXQGr4ekv+Hz+GAqw8FiwZi6TtvDRcfcUozJ2GBBzZ8sysUgNmsXXvGAmbF3Ij0Up0wvf9Y4rhqZCyOWPZ+EO/Df/7z5E/5Mi5qZWPBoyg65H1hGp8E+CxPVyAdA/Bz99FLgROAQabWQPm0L6gP/glv3ZtJhTPTff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lCNVm60x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B69DC43390;
	Tue, 23 Jan 2024 00:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971137;
	bh=LCtYnopr7599kg5vWIQSIDWSZtPlar3LSN5nnugy7Jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lCNVm60xSUwGRwtASfiNWmsc0NG55dfTqwnAoVtmsmSxVRZh+7ZeNtvL3oPXsrnQs
	 0uJQB82MtvaTwYCxFOGHs8sVXTlcF/VWtwV820daSPyOLKL3Y+zEXCNTRhVDwjO34h
	 JdFNAfyIy0vJudI2CF5xNoy8wUvwktIaIIrmBaGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Osama Muhammad <osmtendev@gmail.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com
Subject: [PATCH 5.10 096/286] gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump
Date: Mon, 22 Jan 2024 15:56:42 -0800
Message-ID: <20240122235735.762506094@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Osama Muhammad <osmtendev@gmail.com>

[ Upstream commit 8877243beafa7c6bfc42022cbfdf9e39b25bd4fa ]

Syzkaller has reported a NULL pointer dereference when accessing
rgd->rd_rgl in gfs2_rgrp_dump().  This can happen when creating
rgd->rd_gl fails in read_rindex_entry().  Add a NULL pointer check in
gfs2_rgrp_dump() to prevent that.

Reported-and-tested-by: syzbot+da0fc229cc1ff4bb2e6d@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=da0fc229cc1ff4bb2e6d
Fixes: 72244b6bc752 ("gfs2: improve debug information when lvb mismatches are found")
Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index ac0715aafa8e..1ffdc4ad6246 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -2231,7 +2231,7 @@ void gfs2_rgrp_dump(struct seq_file *seq, struct gfs2_rgrpd *rgd,
 		       (unsigned long long)rgd->rd_addr, rgd->rd_flags,
 		       rgd->rd_free, rgd->rd_free_clone, rgd->rd_dinodes,
 		       rgd->rd_reserved, rgd->rd_extfail_pt);
-	if (rgd->rd_sbd->sd_args.ar_rgrplvb) {
+	if (rgd->rd_sbd->sd_args.ar_rgrplvb && rgd->rd_rgl) {
 		struct gfs2_rgrp_lvb *rgl = rgd->rd_rgl;
 
 		gfs2_print_dbg(seq, "%s  L: f:%02x b:%u i:%u\n", fs_id_buf,
-- 
2.43.0




