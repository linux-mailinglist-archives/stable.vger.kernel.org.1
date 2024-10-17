Return-Path: <stable+bounces-86707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7BB9A2E66
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 22:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1021F234E8
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 20:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC731DE2B2;
	Thu, 17 Oct 2024 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ucj2eGTe"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2471C1DFE2A
	for <stable@vger.kernel.org>; Thu, 17 Oct 2024 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729196459; cv=none; b=GovSY+e40uy7gJ6pHpd4W4dGDXrA7CiwxlZ9ZvvyPrsL0/nIn+oyActqlpDjL8wLQcoL5qIGoagLuTqB5rtp71PXJKt9tmwQmAznGq9QMJahuZQWy8PkpSl8duUAcGZ3CUPRnDzv/MEAgcRW33K8aJAov700Zz5vf9pQtnjrxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729196459; c=relaxed/simple;
	bh=5JzJR8VGRVxiZs0TxCk4qJH38VOAT6qyLgwiqUxDls0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FAl1QiVIli1OdREizwIm8D6G2YgkgTqxk7GX1kstIyhE6IoxrgI4pL8CXW6Qbbsta3ZIAQqg9Jy2Oe4fe381tH+MC1P9r0BebavibAL1zw/IMJQ1t2iccfofoXl98rbSwnrmN5Ihinny0ykShMeypQJwGgIakL0dQvxbYQZdF08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ucj2eGTe; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=64NxjBUB2hoZTb9MG6oA5zV+4P+OYtTU9vbbws6AijI=; b=Ucj2eGTezEjzLo4wljPe3rnjvB
	CXgjqyRTxle2Mxmx7+PddYIWOh3Qv3OoFkLu9mUrAfnHsnC2xIOigg4jf+K7F/yk+UDFJgWEO5swV
	Gxm7XvCxm4hIjA0GR7TUyGM7zEcOWIIEEj2UjY2gbQM7DElIYt/5MOkdkTo66GuLQEDvZpBwTfYNF
	k2eb+S3vnm/VxDHr+uz07qR5W5/p74jpQkgrObVvRqGG5i3HIPzdmkcSNZPhHKUuKfY+e1WqpR0IW
	LN/X+r6labY1qC9qzw3kaQkAbToUV3xInz47UPvPfgO0jekagtbeHbU7tPvOk3Gk2y8mxGOF+HfAw
	CH2+VB7Q==;
Received: from 179-125-64-237-dinamico.pombonet.net.br ([179.125.64.237] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1WzL-00BmZ7-T9; Thu, 17 Oct 2024 22:20:52 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 5.15 18/20] udf: Handle error when expanding directory
Date: Thu, 17 Oct 2024 17:20:00 -0300
Message-Id: <20241017202002.406428-19-cascardo@igalia.com>
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

[ Upstream commit 33e9a53cd9f099b138578f8e1a3d60775ff8cbba ]

When there is an error when adding extent to the directory to expand it,
make sure to propagate the error up properly. This is not expected to
happen currently but let's make the code more futureproof.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/udf/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 21a976154779..ced58595a474 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -192,8 +192,13 @@ static struct buffer_head *udf_expand_dir_adinicb(struct inode *inode,
 	epos.bh = NULL;
 	epos.block = iinfo->i_location;
 	epos.offset = udf_file_entry_alloc_offset(inode);
-	udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
+	ret = udf_add_aext(inode, &epos, &eloc, inode->i_size, 0);
 	brelse(epos.bh);
+	if (ret < 0) {
+		*err = ret;
+		udf_free_blocks(inode->i_sb, inode, &eloc, 0, 1);
+		return NULL;
+	}
 	mark_inode_dirty(inode);
 
 	/* Now fixup tags in moved directory entries */
-- 
2.34.1


