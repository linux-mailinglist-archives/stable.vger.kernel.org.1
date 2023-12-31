Return-Path: <stable+bounces-9063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B1C820A10
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0364E282F29
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B656517C2;
	Sun, 31 Dec 2023 07:15:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD3917F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9b51093a0so4147527b3a.0
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006926; x=1704611726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/7BZ4MZdrLljQMhN83bGzRf8fwgqp2seTmOEcMBDN1s=;
        b=faZsUXzhD0xss7AczX+VlbbpiOp1Mqh12Gs4crIDuY9iEU6Dg4QByzWwq5bxSlNbAv
         YusCRRMtvDx3AZk7yTwNQ1f20Cwi0kP9fxSFaxzNQgUovzHfxHnwBpFygp1y//3N2pi6
         gWEM9lBsLPB97x2uwzfA5QQka2iJDsS+Olns2J7ClN+EICLdoeC9iDqITSNH7rbvwrQc
         UAgwNzq4JzeC/ai23ubZOvo2qCZhEEidQnvmGOQ5hCotADljbcAG339SimMSH2seU7Bw
         JRhWKHHayPs/YEfUThUG5ktzpaTgpTazBtvv1qP5LsOneVc0/Nio59zkcLsZg4ShDGyr
         wRtQ==
X-Gm-Message-State: AOJu0YwexSo2gFvcZoI4ILh1+XVKYz7PbEkLtiBD/XH9KFOzvTod5TBC
	wBVG+74681GfKjdmmSxGOeg=
X-Google-Smtp-Source: AGHT+IEY/UzfDYyWumQMcHETBNEm+mvpbfIcjDckoD8KNx4CtIUzBN7Z20+Kr8GnWc89eIKTb/IiFA==
X-Received: by 2002:a05:6a20:1395:b0:17b:426f:829 with SMTP id hn21-20020a056a20139500b0017b426f0829mr16224075pzc.37.1704006925896;
        Sat, 30 Dec 2023 23:15:25 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:15:25 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Lu Hongfei <luhongfei@vivo.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1.y 29/73] ksmbd: Replace the ternary conditional operator with min()
Date: Sun, 31 Dec 2023 16:12:48 +0900
Message-Id: <20231231071332.31724-30-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231231071332.31724-1-linkinjeon@kernel.org>
References: <20231231071332.31724-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Hongfei <luhongfei@vivo.com>

[ Upstream commit f65fadb0422537d73f9a6472861852dc2f7a6a5b ]

It would be better to replace the traditional ternary conditional
operator with min() in compare_sids.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/server/smbacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 8fe2592c5525..03f19d3de2a1 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -97,7 +97,7 @@ int compare_sids(const struct smb_sid *ctsid, const struct smb_sid *cwsid)
 	/* compare all of the subauth values if any */
 	num_sat = ctsid->num_subauth;
 	num_saw = cwsid->num_subauth;
-	num_subauth = num_sat < num_saw ? num_sat : num_saw;
+	num_subauth = min(num_sat, num_saw);
 	if (num_subauth) {
 		for (i = 0; i < num_subauth; ++i) {
 			if (ctsid->sub_auth[i] != cwsid->sub_auth[i]) {
-- 
2.25.1


