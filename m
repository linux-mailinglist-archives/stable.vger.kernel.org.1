Return-Path: <stable+bounces-183456-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2718BBED76
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 19:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FECD4ED814
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 17:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D528A3EF;
	Mon,  6 Oct 2025 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRRQ/Y5C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3162765D2
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 17:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759772834; cv=none; b=VucaxjlhWEWdBW7tNf77rtfN3A5rzgHPbPWQvyXbrD1jsYA4G0wiq+fAoAe6gVOOBM4Q+CU49/8dtzlTak3CAsA81VKmvA9u13ObFutf4o4Ys4j2Nzi77lLqxx9Ja4zd1wGnzP1TjG85lwPjZ6PH/fD5Srt3JxpuANFHWRbwgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759772834; c=relaxed/simple;
	bh=RIiagnyRRBU18SYukiZhday7InM2c8S8PNgxP9C7a14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eVFNgSz2Nu6ix2tOBGfC5CWYA0IXT5SRxMdSOop+iY0ryhZ7kbJ4v1gIJEaq4vOtVOO0NUHxvUNSkOx0JLV+WhpP43xfuMVjyq2Iq0Uh9d2N0nRd3CmHaZ9emV8IASoHe1B0wIXzBb4WBEHz++mOKFHcH3S3ydkApbztCGVr00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRRQ/Y5C; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7811a02316bso3662247b3a.3
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759772832; x=1760377632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fcadXEt2TbOOW1SS8BtpXmdQoRjzLU/r23ulkh5ITM=;
        b=WRRQ/Y5Ct8gfBjV/hnoxzpj2GEnZo/FVUTmsFHkNE9eJTHiY5FhGEHp9T0E3Hdz/7E
         K+y9t68aylYZ13dVvPmFgHS0lHdQ8qwhJ9ycB82S7LgHChMjLL2T2VxByMiMMuNt7N0V
         k9L2qpHoKziaxBna4PbBB0X+jmoFga+emxiUSb0HTvHwWmjTfkAYt6QU4EXq56sDTlZK
         LmKuww9a1F4UvxF/GTEKygzy91H393Z63RoFaPwn/gM0GNBBjqjBtiiTvoAIZNHYf77S
         CjiQsJPDmKtDdG2nUORnOVVuFf6LX0M6fxiKVUFCopYVJDwnnUfIiZd+lzgDNtQaMWIo
         m8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759772832; x=1760377632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fcadXEt2TbOOW1SS8BtpXmdQoRjzLU/r23ulkh5ITM=;
        b=fSzrW6Wufrro2NL+IOXumlLibYxWDEPzuvAXZzuJrAhMsTJGufut11uaNIfQScDzbR
         Ev0mi+1Ht7umN3gxTh/TAa7oLA2+o62+VL2vNopuhBAGww1VAcXaNgw8ah6DerIvKb4L
         ZVHAWFuPIDi95G4BzhtXhMjCGZASml1vViP+pXLcbjZIMaev+GU6LlaUUk1Wh6/MXRTz
         4vKeNZF+hPscRPOG0ATwHdMUJnTz9zXsSF42F31oo5a1Q9XftDlcNgV4kM2eWuECZ4J2
         IxQ/Z69P/+Q54cedAljgtLc3SzCpTZ7VIt/6HPKsrf4f3l5vMcWJKoA47v/D5gH27c1Y
         PHHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfiwP895cLLtjirLN9ZT3kpmJuggu8bsEPRB3zLTKjJ/d+K+hcUfCzcWPgA+KAXDXpolRQebE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+RM+umV2hvzL6KkFSydvoB36drAn1FVMBgW+0JqjtykeyTQ/
	MupE0ePm9mgdrRnnr6Hby/GsExhPKWZJLi7TjbgdFP8qlEmO/DgrSR0g
X-Gm-Gg: ASbGncuyagEv9BY0TqvnS4sPl/nQb/1q0VnJ2Ndx+N/3jqaLgnoHCuuvzAlNNtum01S
	ysZ2pLcn9FKmne2Kmmuhyz6+lPpLKUknzWTdCKWfoLuVKpoxQLeOmRxBBuIzwzp+l9ArwsNXqPn
	FkceBamxFNisLzO83ogO8EGRgDwQ5mmj+oDwr0D4NgM/NOxe+FJwN0cfDxauAaskPcjJupXx8dG
	O93FNI56H5T6vnojiXJiUpyV8wVAo+F+83LokmvCC+Wp62nH8G+Dc+xxzgOwdoQJD7ArZZCSLrp
	AkDGv1ytRmD9TbF2uAazGOizs0sJmr+R4gNB8QcJMn3AXjEGv7Rv+NaX7JI+oGw3yy3ZQrrPjKy
	M7na0kouRSBlKWI3xAZW0AFAln76qpA9fkivP9KBbYZveWIlgOQ9hQo/fvCiiqkctoXmNKLRJ+g
	==
X-Google-Smtp-Source: AGHT+IEAZ3GTNkzOlBaQRRxaIIrZTAJwj5D6x0H+u0usVi9mnU3RcuVZuSifIPdG1jRzEv56AOGPGA==
X-Received: by 2002:a05:6a21:9994:b0:2e6:22da:91bf with SMTP id adf61e73a8af0-32b61dff85fmr12599233637.9.1759772831719;
        Mon, 06 Oct 2025 10:47:11 -0700 (PDT)
Received: from kshitij-laptop.. ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0206e50esm13084516b3a.62.2025.10.06.10.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:47:11 -0700 (PDT)
From: Kshitij Paranjape <kshitijvparanjape@gmail.com>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Doug Gilbert <dgilbert@interlog.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Kshitij Paranjape <kshitijvparanjape@gmail.com>,
	stable@vger.kernel.org,
	syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Subject: [PATCH] scsi: fix shift out-of-bounds in sg_build_indirect The num variable is set to 0. The variable num gets its value from scatter_elem_sz.  However the minimum value of scatter_elem_sz is PAGE_SHIFT. So setting num to PAGE_SIZE when num < PAGE_SIZE.
Date: Mon,  6 Oct 2025 23:16:58 +0530
Message-ID: <20251006174658.217497-1-kshitijvparanjape@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
Signed-off-by: Kshitij Paranjape <kshitijvparanjape@gmail.com>
---
 drivers/scsi/sg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index effb7e768165..9ae41bb256d7 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1888,6 +1888,7 @@ sg_build_indirect(Sg_scatter_hold * schp, Sg_fd * sfp, int buff_size)
 		if (num < PAGE_SIZE) {
 			scatter_elem_sz = PAGE_SIZE;
 			scatter_elem_sz_prev = PAGE_SIZE;
+			num = scatter_elem_sz;
 		} else
 			scatter_elem_sz_prev = num;
 	}
-- 
2.43.0


