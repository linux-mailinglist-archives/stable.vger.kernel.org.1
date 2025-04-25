Return-Path: <stable+bounces-136685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F0EA9C358
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE75B1BA3B58
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A3F235BF3;
	Fri, 25 Apr 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAQN0fMd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782414830A;
	Fri, 25 Apr 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745573154; cv=none; b=WFFSaxmFZRo/xYadpheWC0NR53X4mZjvpvvrT08+fmLvlVoHnGG4QGJT4dmzZc0oG8XNU1GIuAWLNFg3ZjrLCYKyCnt48bd8t0unvoFgMTkcNNiEnOAKq5/0vipPRx8X/fBlXl9JeohhwS9R+1DO726vYsdhbvWsx8Hb3m6XYcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745573154; c=relaxed/simple;
	bh=QE7mOW26kkySrrmlaEPi+392lADObE2IkVgHPBXseSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbMc8s2JJeEK9G1isW62DmBEwxk7viqvikn4dceVzt3cO13JomSNKUyctOiNKbOtYBxkmsVJ3nyeCxQhHz9OHDwMsSTufD1rX40/S4beyeXE5KxdOTllMAoZMzOOL/dVF1/GaUax59Mh/SLYFfCD/nObxUPUiemc5fJ8ScPR5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAQN0fMd; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227d6b530d8so21977745ad.3;
        Fri, 25 Apr 2025 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745573152; x=1746177952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zpw3Rz6u1oBMxe9Q9lkMBXu8OJBxqRuaiGqqfq4qDbw=;
        b=KAQN0fMdKP2Rod8f54bGhh3EzU6GLijWWgs6tLp4zihn+KUxe9rDA8W73KlVWQOiki
         rmYKjQ18hoTtx1CfbDS+fR7FglEV+eOU17ydUXb2Cdu0UK4aLVVxoa5JcYD3G9ZRvuyd
         tkIymLpV46pa6ka6u14U0CCe7+QOQk5BKydw1kQvgQH8GAsr5hH02xoFZX5CTFfAEHQS
         /Z6S0AIgwGCrximDQIOag0wldktYKQtG13KuzBcfF/nBDAkZgY84+s84UeUOwppXx+mr
         qdygVKb+k0jDsF8TUyRchDnfNWWTH3oVqnccrTt9PCCfw4cCXQD7Knii4WqhRekFjQjp
         Gp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745573152; x=1746177952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zpw3Rz6u1oBMxe9Q9lkMBXu8OJBxqRuaiGqqfq4qDbw=;
        b=sGFgdhjvwFMFNIl9OA3uOOFgxfL6XyH+3WZW4hfeDeICOLEgnJzm/lcbxSYMPaX67I
         8DisOqzjKccXIyDS9FK/u9sOOhoUSib1p/FaeYLwuaYjY24qXQv3l8I116RqFWwjPliU
         8I4xpn8Im6gVjOG4V2vX1eHvIK+TwMw1cWPDlrawQdg9xHGl4PpTZ9T7RqhQOIwIi4GK
         fgGkQMuxksYL0wITxHBaMNQe+EnoUO/3ndzHnxXHhFpGSnpsgpRCPz8lpjHoC8RxYRiW
         R6Xzs1/rqWn4m1J9D8ijKtXPiNdmikKy7klksdvc3+UA8RBizg4Vgk7QEFejeqvJHJa6
         RufA==
X-Forwarded-Encrypted: i=1; AJvYcCUzaSR+tPsbV7E2T6Pb4qJtxSVvl/RzwlBdTUVWJmOcY0jVviRlABfrN/G6w7STPvt2u1NM37Nu@vger.kernel.org, AJvYcCWgjmHHChS3ceLLDQUSrcul9TZreYG8ss+mpK77FR2lasrk96UEqGsvIZmGMOJW9gieSFAfcwmMEj2FJLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVV/ICh6SKpcqYqt9VZXCP1KdaEirgxced0Pl029PJAAfzacb4
	juHad8iZtve7ixKNc2AEhp0fgTvMKPPkExphK03xF5DQ7v0QsznAb5B98A==
X-Gm-Gg: ASbGncsV2tmjXTJGyRR/ZukSatlVtD7SL0eIF3Shuu0kLXsWEOmZvEtGS7MfPJwTVDn
	g8D6jkY0ZZTkDdmJR4Q9SireaVacGtNYrLt87bV7kEP5kcJ7exVCL8T69Jp33yd+ugHpqTtE5Gs
	W7HZlhzfgRNm9jYsr6i8dwudke7gteivfAPcnjtv57JlBv9aLn6uN7UVdx0EXXGYT3qocBtZzjX
	/qjbKrEMY6X42WTFSJ2at5aFbdfqlgGEA8f5wo0bVJpmH0HgzyWZ4Vaju3Iw+ZCte5/abiSyMRA
	PlnHdOA3iZuydDvLobxo5miCFcrvOdGGH3Imk2GKN08gE08p/1U=
X-Google-Smtp-Source: AGHT+IFmqEXNwrDl0Wtkrw1o5U6LcpJDp8+kKb/QGZFXVOu33uoj1+y9CATWTiyXdUUEALy82oDCtQ==
X-Received: by 2002:a17:903:252:b0:221:7b4a:476c with SMTP id d9443c01a7336-22dbf5f0015mr23441835ad.18.1745573152449;
        Fri, 25 Apr 2025 02:25:52 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f7ec0c08sm2494533a12.19.2025.04.25.02.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 02:25:51 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	greg@kroah.com,
	chrisw@osdl.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] securityfs: fix missing of d_delete() in securityfs_remove()
Date: Fri, 25 Apr 2025 17:25:48 +0800
Message-ID: <20250425092548.6828-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

Consider the following module code:

  static struct dentry *dentry;

  static int __init securityfs_test_init(void)
  {
          dentry = securityfs_create_dir("standon", NULL);
          return PTR_ERR(dentry);
  }

  static void __exit securityfs_test_exit(void)
  {
          securityfs_remove(dentry);
  }

  module_init(securityfs_test_init);
  module_exit(securityfs_test_exit);

and then:

  insmod /path/to/thismodule
  cd /sys/kernel/security/standon     <- we hold 'standon'
  rmmod thismodule                    <- 'standon' don't go away
  insmod /path/to/thismodule          <- Failed: File exists!

Fix this by adding d_delete() in securityfs_remove().

Fixes: b67dbf9d4c198 ("[PATCH] add securityfs for all LSMs to use")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
Cc: <stable@vger.kernel.org>
---
 security/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/inode.c b/security/inode.c
index da3ab44c8e57..d99baf26350a 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -306,6 +306,7 @@ void securityfs_remove(struct dentry *dentry)
 			simple_rmdir(dir, dentry);
 		else
 			simple_unlink(dir, dentry);
+		d_delete(dentry);
 		dput(dentry);
 	}
 	inode_unlock(dir);
-- 
2.49.0


