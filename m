Return-Path: <stable+bounces-146317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA71AC3839
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 05:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3A43B26C3
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 03:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292A417AE11;
	Mon, 26 May 2025 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j64JAbNl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337F6101FF;
	Mon, 26 May 2025 03:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748230359; cv=none; b=jcLYQfVbJfnoOsw5TdFGKz+JoKuWjhQKgpcz2gv7g1pf3FPcUCVYFGoezlA5TGvo5W1xbkvIqz1zhVG+bfWJ+PblOuw3wXVXYlHn7c+7uexMCjZ224OnlgdwA51L+uzZEd0loEzho22mPOGSTIOkWVmyIEv0xgOkUxS7Nrxw1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748230359; c=relaxed/simple;
	bh=PXVta0mCTYq6yt9jSQRdHzSV6a2PJ/jUqh30SUGtbZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Js2xmxHMifEpbV+STETOnZimPRPBluoCFovPSkhrIbTT4QNGUiph6VH1yUet2q+ctWoZaRDspf2lPS0RwskqSqs7ou3uT9EyTBFlq2VrqNn3myggco6c5C/AeoyG3myz/Sut560OdTUyodLcCLF6T6UMLSZ++DPweWmun+Hp/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j64JAbNl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54acc0cd458so2274779e87.0;
        Sun, 25 May 2025 20:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748230356; x=1748835156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CzYuom+zI5De3oMnCByXzViMDJT8mx4FU1edPifGipU=;
        b=j64JAbNlME1DuyRr5Q9S6cjhRhEUswKfsU1ymSxr4mZSD5F7r3pEf53EXs5wP8oOrI
         mXJxD0Ul74JVf41vQhnxRniDssRY24qhaayRhji9ExkapXxFPGwnUCvD40j74YkKrJtk
         u7dfM1/e30GVZ9/56RsMCOv/uWggD4TsIybwK5jWjKKl/9PzU6u8w+94cuQ+u9NEwsWS
         U1cWaxq0vfQsuR9nQtuNEtn40gWSl7/46HWVeKT3EqghRaLIMJLiLCFv8+UumTCeJPBL
         M2mBQov+0BQbncBtaMHpj/s5MZ31WZZd+cVejNOSoFVOLPicydKhxfnUniYRDTM08Rda
         4bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748230356; x=1748835156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CzYuom+zI5De3oMnCByXzViMDJT8mx4FU1edPifGipU=;
        b=q67WEmCaiaJKSl5hJPuAUR/05jJmSl2q6uXAg2XpKU1GnLlnj5PTPWmIUo8ZE4b8xb
         mpZIIWBXen/KwaPvyCHjxELtjBx78Grlb6x08dP2NlMuGYyR4HsQvV3mEsMEcf1tfq3J
         ZmLJ+BrpgxxG1voKPRO5NqsEQBX9BDTZnQDQUYsnD3j5cRfc/YBDGC2p64hK4Bw8rklI
         nGUqJh2aqxwEEJOYtK+7+hSdppG2Aw943oh3gJz0zbCvfpjApQm1Iw7Hl/LmZ1SNBjCh
         ZEDTrN7zMEwsvezj2YlHcwbUe2gweWOwlnQk0qW5W9ksto0W8ZctYShvZ967MlRnnrq5
         ORTg==
X-Forwarded-Encrypted: i=1; AJvYcCV+ioAi3SsVUc9V+tdv6yg1Ia5j61UthqEfitfJ/pZaPM8IicusEZp4V5xsYTccR54e09hgOa2w@vger.kernel.org, AJvYcCXRQCzEbGrvaPUeZ536zJud7+Ey3YuZrJwf76TiS8n1vQqR3/txHJCoNr0tRsUml1MuP7L7mcNGcxk+S4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCjI1fmoktE7Qho5062+CUGYzVjraSqZ+Xzqqwx3CUeipBklq
	johuvgqcpfH2IDahwQbLTX2sF1atixgOXpGg2AnR9PLThQHCzRs7Dec2
X-Gm-Gg: ASbGnctHpcnlnvZkM0apfXtWiw1KF3twLDWTQ/yZL42qeS1s4SAZJ2QAQ9OG342Ec3a
	1Eh4aTDbQ/MTbkYURKhouYBs/d0P5SwZDqvRBSY6A+kO2+npQ/TAwVMmhZ6JEOM36u5RzqvwHpj
	jTAvXVne8xQOlZLiruPNwEDV12I4v11cBjqPFTZHQnKdPFv0t7zfnExuUDfSVcJmWRstOvTs+3U
	JaCI+LhvS7enuBlugAvMi9kXO6sGji7VSQ6rSvAKprg3zXUjfuDGoiPq/H5hHrXqKf34GLCOH1D
	KkUWipUyU7IVgFpGDuvpeCTtCuFySi6/KCrZP4HDVTmp5hW5annFereIRsVhIqwz7IBMnoxN8m4
	I
X-Google-Smtp-Source: AGHT+IGyrGp6b48Ely0ZtD7Md68redpGAx/FNDjyorHfUyE8ZME9a7yrYCtt1hrRzl5IPkvtWUdahg==
X-Received: by 2002:a05:6512:b12:b0:54e:a2f9:d0a with SMTP id 2adb3069b0e04-5521c7a9b33mr1922854e87.11.1748230355937;
        Sun, 25 May 2025 20:32:35 -0700 (PDT)
Received: from localhost.localdomain ([91.197.2.199])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e9cb4d69sm4798517e87.21.2025.05.25.20.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 20:32:34 -0700 (PDT)
From: Andrey Kriulin <kitotavrik.s@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Kriulin <kitotavrik.s@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH v4] fs: minix: Fix handling of corrupted directories
Date: Mon, 26 May 2025 06:32:29 +0300
Message-ID: <20250526033230.1664-1-kitotavrik.s@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the directory is corrupted and the number of nlinks is less than 2
(valid nlinks have at least 2), then when the directory is deleted, the
minix_rmdir will try to reduce the nlinks(unsigned int) to a negative
value.

Make nlinks validity check for directories.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
---
v4: Add nlinks check for parent dirictory to minix_rmdir per Jan
Kara <jack@suse.cz> request.
v3: Move nlinks validaty check to minix_rmdir and minix_rename per Jan
Kara <jack@suse.cz> request.
v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
<jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.

 fs/minix/namei.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8d3c..ab86fd16e548 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -161,8 +161,12 @@ static int minix_unlink(struct inode * dir, struct dentry *dentry)
 static int minix_rmdir(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode = d_inode(dentry);
-	int err = -ENOTEMPTY;
+	int err = -EUCLEAN;
 
+	if (inode->i_nlink < 2 || dir->i_nlink <= 2)
+		return err;
+
+	err = -ENOTEMPTY;
 	if (minix_empty_dir(inode)) {
 		err = minix_unlink(dir, dentry);
 		if (!err) {
@@ -235,6 +239,10 @@ static int minix_rename(struct mnt_idmap *idmap,
 	mark_inode_dirty(old_inode);
 
 	if (dir_de) {
+		if (old_dir->i_nlink <= 2) {
+			err = -EUCLEAN;
+			goto out_dir;
+		}
 		err = minix_set_link(dir_de, dir_folio, new_dir);
 		if (!err)
 			inode_dec_link_count(old_dir);
-- 
2.47.2


