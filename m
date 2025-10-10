Return-Path: <stable+bounces-183853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB2BCBB01
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 07:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D783B3A6A1F
	for <lists+stable@lfdr.de>; Fri, 10 Oct 2025 05:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07421F5827;
	Fri, 10 Oct 2025 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZlWfOJ4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB40846F
	for <stable@vger.kernel.org>; Fri, 10 Oct 2025 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072641; cv=none; b=Smn/JxJpgAeN0WQrY/wCpe67WrNlvLJF+B/lBdGCz3zKO8TKdZno6Dh3oN4Weo+XnHogFFoKeI5KY22Q+vzpr8Q1znEmV2j9zxTVWpjA3Nff9pQ4010otztwyzGth1oYOu/5QrTZ86+Lx2IAjrKb2zwN/KTQtAPHTNsCzSFU/Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072641; c=relaxed/simple;
	bh=1Dc701lWNd96LkNgZ9yo8fbcDa5EjS3FNySFxixaJsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Taab0v2XIcF2RBq+RYSdkxrjdE0pumzova3rextJWDlAVQNrFQxpxZIUTT0fTuAYe7x3i1NkoTbqeijBglEYVu09NSUqEepKZbo6K2MYoFkxfIqE+RtBZ+6UYv/5LWWzkEiHmOE6C6Ib5Su9wn73yiHLi7iwQnzUTcpGltiU80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZlWfOJ4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-793021f348fso1586745b3a.1
        for <stable@vger.kernel.org>; Thu, 09 Oct 2025 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072639; x=1760677439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOIbcB6sHuY59NsTH9o+B3XGfKC27cxgCVvQpYalfzk=;
        b=UZlWfOJ47gLWD4xqhE67hUNZf+pbRQc1Z/rO+wjLVNcIRBc/FvKIMrudizMLhtKCsg
         dkmRDnzZB/lEjFhPtAMBVXbBaCy9dZeeEtE3tTPyWlKj6QBLZz6qkFHC78P2rts6GjFt
         ASCQqXDpJfJ9j+WgJ12xcdjQJpTlsucxWbtHj9vTxFMpLHyR71ibPLEK9huS9D7Vdxx5
         9tFvxDfIrQd2z/hj7DZTbHzVoh6EUCBfGVFgoX2G8D70x9cXr9OqMTxu5tduIf66F1pE
         /GSb/bfS9xhVXdb3akbDWBxhdES8iY+oiJmO/RGdsgME6i+z4PyR9fTWKXTFEibI1Vke
         Xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072639; x=1760677439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOIbcB6sHuY59NsTH9o+B3XGfKC27cxgCVvQpYalfzk=;
        b=ctangaoF8Am3FRWdk5B61Gu791kPhx2AUQLT4x9Wby6W5ZLvZZKz1qvlbSOZ1n3bdT
         FBgN24pbaf0ubHYKIvF88ue70VpJ36kzmiKrWHOUi259dNuz//m1PwYDseQ3AE+hbZY2
         ukaf/qLzoGiUOXvSyU5+cCbBhF0LcMGiguPWtzSPZYe1fQea+s6CkIGlIbHw/9OQc8Xj
         sfWIykkzNf6LH4puH0prpS8ljFhurvErlEKs8sllKzzLuOwKudz48OAySP/Loe6lJF0U
         LuHaWFYm66u3QtzWtj1jjhrhmExy4lpMFSqLn5e1z7NgbT42RAWYbi3tuVL8C8U1b/VK
         p20A==
X-Forwarded-Encrypted: i=1; AJvYcCVZQU6IZ2CYcjEQCTHPhT9hZOd1pAeQpydBtK+3pZGxLyKpnk1Ui8Zjb+Y0TbGRuH36FMWQIKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxzdQ+hmcB+bsYn8BaoJ64XydZ8c7JuRbRyqJ70bjkqQ8cVf49
	Io54f6YW+qS6zE/eMjvTEAjogleSYMcZLWfvqrWADkaHtuPHnGfYMQgg8WjSWxSv0+U=
X-Gm-Gg: ASbGncuioJECM19Lhz8slIDQByvCZF9xbC4A7koH7aDxlwTGgO37oPyyTeC8YsV53bk
	Avrp/vsCjIyc8YPVrm86qNkc8DHLwHgYsYNeqLGTMREDbYnSjYtw2FeFYV/m/vjqIvfTQi3h/Fr
	quvHr2xJFnNm6AJqJzm/sqWahFwWsc8rAqTRXUzOgI5wvMoM9lcWH+Ya5Z21WcrGuicYSxoDamL
	1/eiasTX19B6MZE7kRGIQSGN9CKHQpputxhiFM8uKzMP8wSo8zzScxCkjh/1BL1525jJtvpBZyH
	rgp6jnANbD+MGgwVnQ/pwS3/Ng/qPj3MPF59XAY2AyccwRWHmuIIit3LZ1cWlRiSTgdYeJHZ7yh
	4QK65jxz+f/GdRtBusdzc9HnEOAETGUIvdDaIiFtbaV7PoTA/qdzZLFoJYA+Hk78pLUY0
X-Google-Smtp-Source: AGHT+IGuDVmXLZYX/y/OUM5zsyxoqV8HwvNsVgBWqVPj9W6hKvMwFMtAmda8Lcymjv6YGDInXNZEmA==
X-Received: by 2002:aa7:88c8:0:b0:77f:143d:eff2 with SMTP id d2e1a72fcca58-79387c191fcmr12173718b3a.28.1760072639240;
        Thu, 09 Oct 2025 22:03:59 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733355sm1505098b3a.26.2025.10.09.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 22:03:58 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Fri, 10 Oct 2025 14:03:29 +0900
Message-Id: <20251010050329.796971-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In exfat_nls_to_ucs2(), if there is no NLS loss and the char-to-ucs2
conversion is successfully completed, the variable "i" will have the same
value as len. 

However, exfat_nls_to_ucs2() checks p_cstring[i] to determine whether nls
is lost immediately after the while loop ends, so if len is FSLABEL_MAX,
"i" will also be FSLABEL_MAX immediately after the while loop ends,
resulting in an out-of-bounds read of 1 byte from the p_cstring stack
memory.

Therefore, to prevent this and properly determine whether nls has been
lost, it should be modified to check if "i" and len are equal, rather than
dereferencing p_cstring.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..de06abe426d7 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (i != len)
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

