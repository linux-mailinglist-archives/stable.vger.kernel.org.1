Return-Path: <stable+bounces-144357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D850FAB6903
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 12:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3AF46548A
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 10:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5906C27055E;
	Wed, 14 May 2025 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqm9pMei"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68132205519;
	Wed, 14 May 2025 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747219134; cv=none; b=E+xtGey3UP1Hs1VQvUj74P1vHIG7SEF3ND1YAneFcYi80tR/uV/RP/483X6LacLWL8KtennpnmiQOBZ3Jrb6Irax5p28y9tvXAQxz6JmVQgNeQcGZlEt3jEKLxhv4UAk6uOCmbbpwzQmBwQ03+MC+zLMs+31lc2yvaQeRND23Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747219134; c=relaxed/simple;
	bh=QLH0gNrBQapb4DgKV7C9hWr0X48Qc8YYIoKa2VE6OQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eontHHzPxbk/Exvd3RKfcra/ug3GPe//m29fNygnlnBmVBrtqln6ud5uqiz019PaNfpXSwhrchD/BNq/3HGNEn9foyOPm/hWc7DFld8IfJwokQM9zhZrSJqqceSfEywCGw6J35cbohnRmjgzkJAW5ow552mgOipz63MGt+0dE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqm9pMei; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so8997830e87.1;
        Wed, 14 May 2025 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747219130; x=1747823930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u18rizJH6zQQVk6mtazUuj8QZQOQdRFQC+xxUzR/EJw=;
        b=Kqm9pMeiPj6Vy61mLm6TXx3rgplHL0sZEkcO7olw2k2+B5FkMkUdW1Y5hiqPE3CEE1
         iXwlLlB8pVAW+Wm1WXctJc51EgYTRJv6IAr21cOvieHrH/7qV1KSKgy9UKK+j+1u2YYR
         71N3jwcHwpPaLC/IOCb8ZO0CHRe5C9V0wTyEmncccuNcIUIsq3t8FnJSPNdddu4egwln
         auOYlhAQeqGsim42js5B5XnevPQGHBAbOhFfeyOgXkqzYzCPDpzDh8XErZ0E/lchU/10
         ozXUoP1v00oOUY2+w2AgZ3fV7bq5kgT1/HrcCiztn+Q0Rjpns28oyplZV6rlJlRFzrYY
         ce+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747219130; x=1747823930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u18rizJH6zQQVk6mtazUuj8QZQOQdRFQC+xxUzR/EJw=;
        b=NtXqGL8idsIndIeNhapQuXYssMRX+z5u+T0rHl/FeAxLDU65HZZW5MRwabMhvSuHLU
         n2L7GIAuHIryJJfjDB74DgcGoZ3yuAURfMPgfV1kqXmRWiRF1nYDRGw2Vdw5TMDXjjT+
         oHiMu/1W8DSFXUQQaio0lBDfNaDs5RdYkeX/NqKhPW1lUcfmwNG04s3vSD+rL+wzlZQ+
         BEviyrTE8tMlik/ikKLC8W81Xl/3dmgWzN37yb9T/yW2icaFMgcnlW/ekS48KA2o91Bv
         ZELOV0axsahMn4oCejog6a11OBu2kOyu2+7C4tc7NYKkO9xnatn7pcaFitUWUJ+gdVCF
         ofNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHY77cPkgsguaDLRUF9y8ntQpBE1MqGrVEfAA4TMOkEklXjX46bQwHEF31EssZZpIan7oUUdb8@vger.kernel.org, AJvYcCWo+Bc78NQ3PVASVXdJo6Tzg6MEXzKYGnaFATo48vLdeq/XT33WlA4HZC9xLv4TraXXEhMI3wqOdMHmVqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ+m5vX9m7H+F48QgGA2ORNAXfPbXQa4n1WCfDGlvCbVODuiSu
	UYbV98q5n1s4JpXZ3wstAUgn9+2XYC7yRFDScZsyXonJ+/PT2Skr
X-Gm-Gg: ASbGncuu7YeKgj4d24vsujwNpfm82S6PtaW9cqbVeZd4Bt5tfBm3ohwD2yN8YvJfo4d
	idCPJJL11+22VumO8pYkgnP/u15D1XnQMwyoxywXmWkswaYrqC0XaaJoFiQX8aIM9G7ieZ2Oh4d
	ospSKVohCr/IcaMuLRPuCMw53GiJVkS3B1IL5ep4RPktNrobIdXdiMdhtJxsuZW4gzAw/ivLfa6
	5mmao3ZusnCikR1BYN3PTZaXlryTM2LxfUPqUPjsTBNb11Wuks0mtdTybQKklNVNmWKRTQ4fllV
	8/e+TYnG9rMLKq3nLb/4+kGDM7k5R4k2qvGd0lYbv4C3AqTKupTw6VKOWaaTbLXL2AHDVI+YZVa
	J
X-Google-Smtp-Source: AGHT+IFIIeAIX8+mI9Youa23uFVdTyrEGM2yaHMFY1grmhUQonUuDWo6/3mO/dKIWsCisjaqVpzwiA==
X-Received: by 2002:a05:651c:505:b0:30b:a20d:1c06 with SMTP id 38308e7fff4ca-327ecf6b72bmr11420301fa.0.1747219130279;
        Wed, 14 May 2025 03:38:50 -0700 (PDT)
Received: from localhost.localdomain ([91.197.2.199])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-326e19da2bcsm11535601fa.74.2025.05.14.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 03:38:49 -0700 (PDT)
From: Andrey Kriulin <kitotavrik.s@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Kriulin <kitotavrik.s@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org,
	Andrey Kriulin <kitotavrik.media@gmail.com>
Subject: [PATCH v2] fs: minix: Fix handling of corrupted directories
Date: Wed, 14 May 2025 13:38:35 +0300
Message-ID: <20250514103837.27152-1-kitotavrik.s@gmail.com>
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

Make nlinks validity check for directory.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>
Signed-off-by: Andrey Kriulin <kitotavrik.s@gmail.com>
---
v2: Move nlinks validaty check to V[12]_minix_iget() per Jan Kara
<jack@suse.cz> request. Change return error code to EUCLEAN. Don't block
directory in r/o mode per Al Viro <viro@zeniv.linux.org.uk> request.

 fs/minix/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index f007e389d5d2..d815397b8b0d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -517,6 +517,14 @@ static struct inode *V1_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
+		printk("MINIX-fs: inode directory with corrupted number of links");
+		if (!sb_rdonly(inode->i_sb)) {
+			brelse(bh);
+			iget_failed(inode);
+			return ERR_PTR(-EUCLEAN);
+		}
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
@@ -555,6 +563,14 @@ static struct inode *V2_minix_iget(struct inode *inode)
 		iget_failed(inode);
 		return ERR_PTR(-ESTALE);
 	}
+	if (S_ISDIR(raw_inode->i_mode) && raw_inode->i_nlinks < 2) {
+		printk("MINIX-fs: inode directory with corrupted number of links");
+		if (!sb_rdonly(inode->i_sb)) {
+			brelse(bh);
+			iget_failed(inode);
+			return ERR_PTR(-EUCLEAN);
+		}
+	}
 	inode->i_mode = raw_inode->i_mode;
 	i_uid_write(inode, raw_inode->i_uid);
 	i_gid_write(inode, raw_inode->i_gid);
-- 
2.47.2


