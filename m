Return-Path: <stable+bounces-202747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C1CC5B6A
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 02:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC80E30204A8
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060052571B8;
	Wed, 17 Dec 2025 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zctc0A7l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71556246797
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765935663; cv=none; b=Db6zyD8PtUr4PdIubtQpIeShLA4vPb3ENeLPfbDqENWHs7rgOUF++15pxD+oPn1ICAKVhmObvmgzAofWrEBAoygLrec+T7Fp+zEhxpoepg50SCLQuipL9EQnTkUFXUpXpsoPq0jxehdVSIw8/K9fC1U0ms3UwPTT4E1m+mspvWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765935663; c=relaxed/simple;
	bh=8TyVSvKXYxR05iL0+NnYb0R4ktZ+w5a/caOd/UaYwpk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xza7BOziv0qxYQLN3A35ZzAjy0Of04BS8YpcuLWgEu8Lnnd6egJS4d5uWNbhqKrVEEsx17tYeMZCQ8w9aLF5kYtdU54I9RlNsvw2OoxmLJHnehV5aE4SdUffiurbY+McQUAaNqtTM1hhVB8BAkkr1B1SiyrpyIsLcqj7bj5Rm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zctc0A7l; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a08ced9a36so9394635ad.2
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 17:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765935662; x=1766540462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDxHcZkTjmjUFpD0nPdaDh+C7TB+4JYFvDaSUk+afn4=;
        b=Zctc0A7lyZ3TvRozNmzCOk6Ut3H6lHvT7WTfVdYkv6TGiHwfd3tajEnlHG9VFxhTmr
         19LjuylpMNb7JsxsxnwMDyXNUIN1m/fwh7zf/I46bguaADrn6CHiiOxlmBnC8e5VLLjj
         m1AlUQJpLZCdrSGEYvNzGBOQ6t/U26yFpcUsWS2+Eqj0cdX5y8cB8ivewjI1PNX5UsDR
         4FGm3NyNG0rN+vNOOpdepTGofVngIrc12F+VD0XfIH1GQCvXj6/Z9MSCUgoG+Y7/zhDW
         inaojLFQcoNpiPog5C+tPj9WmCAEb5djsEyodoN4akEwN6BnOmuoHAdk3OZZIhI5mOLX
         yR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765935662; x=1766540462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDxHcZkTjmjUFpD0nPdaDh+C7TB+4JYFvDaSUk+afn4=;
        b=sF4sE3RyaxipGPHNcur1x6pj1vKp5y2hAZJd3yBZzSxvggoev2Ah7nFMxVb9RfnLIC
         VrzRq+MNeuyJMlA21wXJd3/2N4eRFFrBJgBqVc40a/jcavpaNPM6lEBsrXOIvHLaDqw2
         JH9zr4MT4YfFtYw6KAnkIi3dsCChEPtqvNksaaz3Rn6MDhD3ZWPaM8lDYwBwTOtRxBrE
         qazKGQd63F3MFB/ublYotCiU+ZzyCZBDT22JeAKSmk06wkyPs+6f20nm+ENDiYWBlZIw
         SFxYRAAo/Err0q46oP4Gu40qGJgmvWnOe0RsD/I/ZfpblUBg2MEx8y/+sqDpE3STUDgm
         Yz5A==
X-Forwarded-Encrypted: i=1; AJvYcCWE4EqfQ1wfgpsS6wTwjjBmJklh7Gxmd+kHlFmGAAvbG3GsaoEvJg8rLnC5Yiprcs+8arg1GIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5DN6ruPPO/IOCg/Ytwgarv/un27mcgtYc+AFb9tlgATfsCMx7
	qLBKaKSIiQV7R42+GXbPW0fxzKpTgnm03mIHOtN9kOnzuxXMAPPeYBXB
X-Gm-Gg: AY/fxX50fUCMfj2sPZ+EOpcLxvR8j5vBcQZiGvLKcx2wCmuCDh7dHFkARLaLtqdplFw
	YOL5eVWp67iz9EJ4+9f8Io5MEQdTNjXtSy5G/F02+kP77MrMVoeeC4+l3P8dR8p8rNLq4VytxzH
	Z4DTywe9/pC4Iz2aZhXV9ekTZjqOVcuOHl8GtaM4CVBbp0dCyHRt4A6HJnAtxBhAoqKAu++Gs+y
	9FbSgngF0sULwMld+ukW8/pbD5cr2XQjD8IEhhBOR7cu5uPX/zfvvK6KA7nH84w1Qoj37CXq4ef
	7kHowLYK7GRR21tIWEsyiTWMut+PUIUwgccPZ2W1LUnOM4nU4v6rxUCoe7egCDu7pscZfnx00S6
	CcY733qXa0I5T+o7z42uzfyfuVJ4GKmlG6dZpzQCsNgf6/0cY6qZnzcWOmjt2K06a7+RDX41JRs
	aXhbff5ge14TeGaCUIdZwBwiejsjgVh8Nwuw19pLfaOezVqilUV/81QoUz26/3+GaZuEplYCO3H
	8VcBIC7XCI=
X-Google-Smtp-Source: AGHT+IF/SEOxDOKcFv5IqFKvN9ywf362IPWc8RJF/t4t5MrZbneoibmeTII8xwlbnor44Kr5k43j5Q==
X-Received: by 2002:a17:902:ce8b:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2a0cceebcddmr72318115ad.1.1765935661607;
        Tue, 16 Dec 2025 17:41:01 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea016f80sm179600095ad.60.2025.12.16.17.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 17:41:01 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH] nfc: llcp: avoid double release/put on LLCP_CLOSED in nfc_llcp_recv_disc()
Date: Wed, 17 Dec 2025 10:40:48 +0900
Message-Id: <20251217014048.16889-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_sock_get() takes a reference on the LLCP socket via sock_hold().

In nfc_llcp_recv_disc(), when the socket is already in LLCP_CLOSED state, the
code used to perform release_sock() and nfc_llcp_sock_put() in the CLOSED branch
but then continued execution and later performed the same cleanup again on the
common exit path. This results in refcount imbalance (double put) and unbalanced
lock release.

Remove the redundant CLOSED-branch cleanup so that release_sock() and
nfc_llcp_sock_put() are performed exactly once via the common exit path, while
keeping the existing DM_DISC reply behavior.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 net/nfc/llcp_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index beeb3b4d2..ed37604ed 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1177,11 +1177,6 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	nfc_llcp_socket_purge(llcp_sock);
 
-	if (sk->sk_state == LLCP_CLOSED) {
-		release_sock(sk);
-		nfc_llcp_sock_put(llcp_sock);
-	}
-
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
 		sk->sk_state = LLCP_CLOSED;
-- 
2.34.1


