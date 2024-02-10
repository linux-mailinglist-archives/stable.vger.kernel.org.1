Return-Path: <stable+bounces-19414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B612D850636
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3651F243D1
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848B95F85C;
	Sat, 10 Feb 2024 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JZuJErMx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132A5F87E
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595987; cv=none; b=EDtffXjoo8fhWW2Vva5c+rxqXCAXNVitz/pErumDAdyH4Dres0JWDSvWSTsRpp/09o7TxveQBONmWobX95bB/yUaPUpoV1d9wK0Vsn35CCOrqhsrleEyii+14oCT504dgwy5nACIl2oPOrNJFPMuRGgXnR0oWTndEcXp67aJRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595987; c=relaxed/simple;
	bh=GrXZ9Nz2/5QSsD42qQI1yFbBNGJS3ki8p3gG+jZGSIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQrMO3wSwCjkQ5umfH92i7nXnWvSZcJy2LQ1dI6zo2D+ITBtvIciiY1sBZkFClmhloWeMn9QsEQSIC8/sa+JnI8/iVwpgx4/M7gF7AjLmiodxQaDeA6O974fUcUY+odfq3rIQ/8sUlOdEud1hSO3T0ARBMaCjRaeW0KSdr8hOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JZuJErMx; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so1256843a91.1
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707595984; x=1708200784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3MpZszRya3IsjMi/g6Mr3usta9ZLa8cQmnpdKmp6W8=;
        b=JZuJErMxdBNCgJMlN+Y/VgjoeiAoL/TSWqbhUzmBsMfMi10cBuNdiVxxRO4/QERx7q
         +MagswLqbNyt/2fCV+SDiBp8eY0m6JbotnzQd4Xl5EaQRHP081gBfRqOmJBgPQJmefvN
         usj/vAs5RUQP0pKzUJWeggs2QAacWDDZ/Nik8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707595984; x=1708200784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3MpZszRya3IsjMi/g6Mr3usta9ZLa8cQmnpdKmp6W8=;
        b=phcV1YAqAV44rIBFbUtAKB6mCx8joUhC6JhI9SSCRz8L1fPs8NWarwlGKxohn8i2nW
         jyWu0QE0k2LAE2Bw8OUb4oBYvn2Eq6JhMDuSfyg1DFMDKigQlcUXb+s5pAjqib4LdKS6
         Kp34lyCIZb0lrUVRk/4m+ogf9tTXM+H1MaYk/35NAe9Ua6yRLT+T+jyNUdKa7do0h52Z
         0BEINmNQRkjuaCgw5wbfZZcTKx3WZdJ81KIHe4PTNYMAGqEp1J9lHz4iJuue6d6H5sz7
         ydP4iPen2JhizAzqGioyIkZsrhdkmOniDRiTH5IzoCV/4Vg4If/ayVJt315/ZZStgvBl
         0/1A==
X-Gm-Message-State: AOJu0YxJR/4763SwmYRDu8vjgxpkBMIfktM3bYZUiigkje7m/LfibiiQ
	GfB0nrm/7+7oCD/sgB3Y2107sHd7x39nO5dgZ4XFdIvXEvPylmzfnZqJZDCP6l1bZZnqatuYcmp
	RJP1Z60Kc16wF6lBNYq/dz/paXcACffSaeUIlTZdAg7uhelwR56BGrtDiNwSfDjSklctG6i+URt
	zbfR8sLLxK/7hVp+UhTivKLc4IBzgb1V9FeI0v4QMTnya0uMnPyaH4Mvs=
X-Google-Smtp-Source: AGHT+IHQHLVKGTx3fPlNKScBJE04jR2z0LF8IWibqEaM5J3Xa2BnJQT79LYf5J6wB7E/ld8SBumhCg==
X-Received: by 2002:a17:902:6e10:b0:1d9:9e4f:c0d5 with SMTP id u16-20020a1709026e1000b001d99e4fc0d5mr2625830plk.40.1707595984072;
        Sat, 10 Feb 2024 12:13:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGctD69GIwBbfLDAPhCBnn0dOXzUoJWNkkz08/E2PKuVjxFdqfN07YomrFyccJvpXhGmdz10xZqoie/zuPv+t+V7fcLsJ1K48vGCsgA5Lllwj/jLA9S0wjf1E6Uia5TlClRBKWsjv5tCBDE038JEQZgJ2SAzGIFvwD+Bme5Z8IHUirOV2nIOvDZguEPFB3STbJ/MpkYnr4OntRreFblxJSgHmUjTTYFTD1VL0lVGdsJQ==
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001d8da07e447sm3503527pln.9.2024.02.10.12.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:13:03 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.10.y 3/3] smb: client: fix parsing of SMB3.1.1 POSIX create context
Date: Sun, 11 Feb 2024 01:42:36 +0530
Message-Id: <20240210201237.3089385-3-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com>
References: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 76025cc2285d9ede3d717fe4305d66f8be2d9346 ]

The data offset for the SMB3.1.1 POSIX create context will always be
8-byte aligned so having the check 'noff + nlen >= doff' in
smb2_parse_contexts() is wrong as it will lead to -EINVAL because noff
+ nlen == doff.

Fix the sanity check to correctly handle aligned create context data.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
Signed-off-by: Paulo Alcantara <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Guru:smb2_parse_contexts()  is present in file smb2ops.c,
smb2ops.c file location is changed, modified patch accordingly.]
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 541f7d6aaf3d..a358c139ba74 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2095,7 +2095,7 @@ int smb2_parse_contexts(struct TCP_Server_Info *server,
 
 		noff = le16_to_cpu(cc->NameOffset);
 		nlen = le16_to_cpu(cc->NameLength);
-		if (noff + nlen >= doff)
+		if (noff + nlen > doff)
 			return -EINVAL;
 
 		name = (char *)cc + noff;
-- 
2.25.1


