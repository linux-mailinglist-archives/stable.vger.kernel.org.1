Return-Path: <stable+bounces-86709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141459A2E68
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06131F23378
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ECB1D07B0;
	Thu, 17 Oct 2024 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Egw9nWVp"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228D31D0E1F
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196464; cv=none; b=nNgGgelrbj5KPb2H4IDWMCmAHiwPP/hT2Fbdgw34nR/BjHoddtu4eDOX8JFZT6rqElzRT9qIuanvczBX9dbZNIhfZqmRMtZrdQ4aOIzbTqxT/CRSE2blR41M3ipypso5HVQefyWb484Kl88lPM3ymqk2HOIpf00SkBX4/4Ccw5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196464; c=relaxed/simple;
	bh=gVwSc4xJ+fRjuTsXo/UlVxT0KnNA7WmT9brpuke7xms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y+odMeWk+mFXssAOksYzvuscGHVtC9J9409Mv1Wb6EDW+pFAY5xye9/21A9GbAz6tBq+GeN5aEmJ7J1nudHrsUsEjCs6JZVc18Oubt2vscs6RveiJ+03FQ63Vj0Hlc4Hj8fejfZgxNdWGCWtMKbNTbUGmg05611NYHNdDMvpDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Egw9nWVp; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=k/KcqShYt/M5tAnhmCXQHSaZQ0LlodwmKM8ym7eoSXQ=; b=Egw9nWVplwtV404dlyYIyVh3vA
	7egDp8ZCE/nM/f4DUgzmtqQANU6kgMdleGGqaPaL1bkpMrd4gHns6UWygjCZ5ucelRF3vp0omufpY
	k5buOGKEiKOGFrgKL+0fO5384EBicwGLEXA8bOLBqkW1DAXbUham0cgpfKIThMGftAZ/4O0tfTGJ+
	/7BdTXwjPp53QhlaLLpM0ZaT90bfSXcnPjLLbArxEFvciNzPsqQnPwpRQnIwHRBre7eIeTHtTXuoj
	/gESa8zAdgQpTgWvfbjGn6fT0DlYgO4E/tA+gBsTkoim3IMpEPOB1DnwitIUuU06rpZrcmwdCOPnk
	mYpcjx6g==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1WzQ-00BmZ7-Jo; Thu, 17 Oct 2024 22:20:57 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 20/20] udf: Fix bogus checksum computation in udf_rename()
Date: Thu, 17 Oct 2024 17:20:02 -0300
Message-Id: <20241017202002.406428-21-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017202002.406428-1-cascardo@igalia.com>
References: <20241017202002.406428-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 27ab33854873e6fb958cb074681a0107cc2ecc4c ]

Syzbot reports uninitialized memory access in udf_rename() when updating
checksum of '..' directory entry of a moved directory. This is indeed
true as we pass on-stack diriter.fi to the udf_update_tag() and because
that has only struct fileIdentDesc included in it and not the impUse or
name fields, the checksumming function is going to checksum random stack
contents beyond the end of the structure. This is actually harmless
because the following udf_fiiter_write_fi() will recompute the checksum
from on-disk buffers where everything is properly included. So all that
is needed is just removing the bogus calculation.

Fixes: e9109a92d2a9 ("udf: Convert udf_rename() to new directory iteration code")
Link: https://lore.kernel.org/all/000000000000cf405f060d8f75a9@google.com/T/
Link: https://patch.msgid.link/20240617154201.29512-1-jack@suse.cz
Reported-by: syzbot+d31185aa54170f7fc1f5@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 093de955ba10..5e39cbc74524 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -857,8 +857,6 @@ static int udf_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	if (has_diriter) {
 		diriter.fi.icb.extLocation =
 					cpu_to_lelb(UDF_I(new_dir)->i_location);
-		udf_update_tag((char *)&diriter.fi,
-			       udf_dir_entry_len(&diriter.fi));
 		udf_fiiter_write_fi(&diriter, NULL);
 		udf_fiiter_release(&diriter);
 
-- 
2.34.1


