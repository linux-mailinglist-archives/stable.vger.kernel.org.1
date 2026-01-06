Return-Path: <stable+bounces-205185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C92BCF99BB
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E01E3009238
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A442E8DE3;
	Tue,  6 Jan 2026 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="itMuQsCf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7234347FD9;
	Tue,  6 Jan 2026 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719858; cv=none; b=rMW1UCgM9zx51/EEeQeYLKvWz+6+DfI63gv19vZ2EOKZrJLDyrnrb07jamINrpYeP1i4ReQn3fmVrYyarCGyKISec41YGlssjl+ESJoJYL7ZS9rqWseDS8dwXCCC0pOTj97NVGYoep522qgpi/1TwzrB/wZ86E5lsrFvEecDR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719858; c=relaxed/simple;
	bh=/NiPM1jHh9XaE5xQsJODTWRrJwbmgcuIrXp4wBDXFaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUcwJjcdo+oB9FtarSiWfzmLHoqN+3EbelUWyzzcLcvaga7xD1NWyKCcLfGqK80OUT3RA9bA/9+gRuIzM4O8gs3g2OzvdXFSedEh5xrOMBEK5+LW46g+OAQ3C8QnygIsMi+bQYQgLUcSHhcdSatwlbXJZyxv/OWZgiIpE/s5BGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=itMuQsCf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23056C116C6;
	Tue,  6 Jan 2026 17:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767719858;
	bh=/NiPM1jHh9XaE5xQsJODTWRrJwbmgcuIrXp4wBDXFaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=itMuQsCffgX3/Wrvl8rpeB3UI3RhDY7dpTfQa3cj9/oYtxJMzKBuUgLQ8gB2J/D0c
	 MwC9W5aMnx6P3u/1XG7xfITIaVZpeYpTXOqwyR4x/d2b394VJ85GNwUbYNTEtMFvLK
	 bjSJgS4/CA51PjqUEN0dIPrgDqsVyXMQHMrOCPyo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 034/567] gfs2: fix remote evict for read-only filesystems
Date: Tue,  6 Jan 2026 17:56:56 +0100
Message-ID: <20260106170452.604039325@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 64c10ed9274bc46416f502afea48b4ae11279669 ]

When a node tries to delete an inode, it first requests exclusive access
to the iopen glock.  This triggers demote requests on all remote nodes
currently holding the iopen glock.  To satisfy those requests, the
remote nodes evict the inode in question, or they poke the corresponding
inode glock to signal that the inode is still in active use.

This behavior doesn't depend on whether or not a filesystem is
read-only, so remove the incorrect read-only check.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 1ed42f0e6ec7b..d13a050bcb9dc 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -631,8 +631,7 @@ static void iopen_go_callback(struct gfs2_glock *gl, bool remote)
 	struct gfs2_inode *ip = gl->gl_object;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (!remote || sb_rdonly(sdp->sd_vfs) ||
-	    test_bit(SDF_KILL, &sdp->sd_flags))
+	if (!remote || test_bit(SDF_KILL, &sdp->sd_flags))
 		return;
 
 	if (gl->gl_demote_state == LM_ST_UNLOCKED &&
-- 
2.51.0




