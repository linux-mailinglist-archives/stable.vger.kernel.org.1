Return-Path: <stable+bounces-139504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DAAA779A
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 18:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DD71B676A0
	for <lists+stable@lfdr.de>; Fri,  2 May 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472F26156B;
	Fri,  2 May 2025 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcPcSVxu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6989926138F;
	Fri,  2 May 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746204230; cv=none; b=Dbo7RIoRK/WcqQA0GbhwoQfHADblMOPjKa58hSROLEsAwwYle/R/sU8CJ6AW0Nu9KcTm1wU60X7ThEk+Vmx+/kfzWb2YmVqyMa6pgez+PSQRCtsexM/YDRV4g8ZN6EK1TPXVlN8exkeGHohzyEhBYGW7Ii/yCm+jZWyRXfH0RUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746204230; c=relaxed/simple;
	bh=amLX7FDEwYM1CydOTz1TzXbPOF2Acs7PuTpiYKs/K6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rG58S0MYrY+bkoT7cyf+0XDg1rOiPzQJSak6Z3QMcrJ802ogkD/cu9v3zpdJ0bwfIdtG8m7/Uiz6VjTKo2tIXaZy4ZrdTk3qxV2gMwksG7cXYXyF93jSyudWQLglTtDeLhv4Oy1HqaRG7ckwJUY9vnkSDOYf/OMNrp1y2C8Q1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcPcSVxu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-549963b5551so2576675e87.2;
        Fri, 02 May 2025 09:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746204226; x=1746809026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhPxxO8YPt82z7DOp+d+tt8ExEv/tDtudEGn21E0idc=;
        b=NcPcSVxuYJGB4Qck4tEkFuUcsPIkV2JNIAlrYdADYYdDNgxfCnrJt+YUce48LxuZpC
         2DChB7WGy0UVwLfo6jA/mXALlQgp2eRvzbYCcQP8/9UsqAu3DXiiBZisZGfosl246ZkN
         EjcZKldemrJu9MJphdM20WOBL3M87tlLFNAfwzoNWLLnjKzGu5ZaIg2xn006ch9fbFrL
         KaoSBO6frPZ3jNodR5EslUcPC6Ix6yXX9W2WLV+7LlcSJXpePNrJ0GAoRwYfi8W+d+6w
         EHlapf/3qHosjfBKGoTbyL8+35immpRCHfXP0vj2ELNBEdehckqbsr78+4p6RoXOT/qU
         C4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746204226; x=1746809026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhPxxO8YPt82z7DOp+d+tt8ExEv/tDtudEGn21E0idc=;
        b=p0EZGGYzEfin/E7cvqtw6P9Qp3CaIe8woisQebAxJxmR+g34a4DetedFrO7N/2bTcL
         KJUdvh+/TbQlc9zPqfvzVpLu+r+shjIT9/9UeAHBe1ZZfZ8KaEnyEFrOTTMlH4jOpZ2G
         9t8woXbgbrEws3G2NGq1MXef7lSLh04704OZpeIspHX6fhACrqnLUbTr/e3NLVju3xED
         bXZTw+DMeGAO04t6Z+O8aNdke8xN43VGDVIDnktYp8x1L0ERzRxAHhO0ZssbHa4MTaml
         iwdjx7gjq1pPQ2e3byQmkwIpPDW9pj9/C7XMEIqQxcLa/filfi/t+5dWCEP1P0qOOGOU
         954w==
X-Forwarded-Encrypted: i=1; AJvYcCUM3fvpQMdIpTrBmjegffpnNT1SsIXNc999CzXmUs+mgIEez+wX14rWvUcILmdeHGd+JaFM4yhZkk1V+s4=@vger.kernel.org, AJvYcCWLrDi0/dMSEuxQCutXvn1oPed45I33e0p7LFMDDMVIDtAlvs+G2/uhWZgn0q4qaAH6VsUnvIze@vger.kernel.org
X-Gm-Message-State: AOJu0YyHS6RFh76d5BwOjBLJ3k1nPn+eLyIzY3KaxRpsRoNapSOiD2lS
	+2udwpQ/dAqOkrB239HPuhuGeyNGRP4WAVJXrOxJgIjgQsVKuOIt
X-Gm-Gg: ASbGncutpGcP0ipeK6MedJC9MxATUlm3b04blxwuldgP66U8CX+39a/3T/wMOMBeULu
	hnkwcI23n4GolsyVzM1eMW4rw62wun8gdcQlmqrw2HPBrvS2nbugERKMaY86/N74u7WJXsqEwYB
	eDKm2juaVx0WTQobv6opIbLAf4NOyYl6oMfgXI4MD8hZiII2IMGP/D/RCkVzPk2aziarqc+SM+U
	ueH6EvM3VQToYi8iB/1x1Aux5iyca8F0+HphkuD9iUKTJUF4y1HH7K9bhHRxy3jrzu2x55XWuZD
	Gh90x2CKrGDZHHQ+YR4SlXXvvgOhlkgQZmbJEZUc16TuzN3QO+MQdOyzJhGfgOU=
X-Google-Smtp-Source: AGHT+IFIMmhFt0XsxkysWhs6WHqtlWSo1GlKtlOWd9aa9MnWOS2gRs6dDUZjRsWMHLBCVgIpsmC86Q==
X-Received: by 2002:a05:6512:3d27:b0:549:5822:c334 with SMTP id 2adb3069b0e04-54eac24c748mr1051225e87.52.1746204226227;
        Fri, 02 May 2025 09:43:46 -0700 (PDT)
Received: from localhost.localdomain ([91.193.179.235])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94c08c3sm398459e87.81.2025.05.02.09.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:43:45 -0700 (PDT)
From: Andrey Kriulin <kitotavrik.s@gmail.com>
X-Google-Original-From: Andrey Kriulin <kitotavrik.media@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrey Kriulin <kitotavrik.media@gmail.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Josef Bacik <josef@toxicpanda.com>,
	NeilBrown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs: minix: Fix handling of corrupted directories
Date: Fri,  2 May 2025 19:43:36 +0300
Message-ID: <20250502164337.62895-1-kitotavrik.media@gmail.com>
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

Make nlinks validity check for directory in minix_lookup.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Kriulin <kitotavrik.media@gmail.com>
---
 fs/minix/namei.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 8938536d8..5717a56fa 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -28,8 +28,13 @@ static struct dentry *minix_lookup(struct inode * dir, struct dentry *dentry, un
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ino = minix_inode_by_name(dentry);
-	if (ino)
+	if (ino) {
 		inode = minix_iget(dir->i_sb, ino);
+		if (S_ISDIR(inode->i_mode) && inode->i_nlink < 2) {
+			iput(inode);
+			return ERR_PTR(-EIO);
+		}
+	}
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.47.2


