Return-Path: <stable+bounces-8576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F981E6F9
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 11:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCB91F223DE
	for <lists+stable@lfdr.de>; Tue, 26 Dec 2023 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422144E1B0;
	Tue, 26 Dec 2023 10:54:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B44E1A1
	for <stable@vger.kernel.org>; Tue, 26 Dec 2023 10:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9a79a1ad4so329262b3a.2
        for <stable@vger.kernel.org>; Tue, 26 Dec 2023 02:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588043; x=1704192843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09nXKgbFmus+6+4pIfyzUDWNSflVi1+DaVvhNCxLzoA=;
        b=Ou0l+uwDkp58Del7Dn5/iuWHVJi3z4sTEtk9g9Zl1GyQ5K8TGfq2/BqeupDPWv9p9/
         x71GxuXVgFALmpqtxv25Argpn8+CsvCmXHDNcjLPM02BzTgYIOn6R55HOliEsykxjk1p
         FAguSvika0EYGGBH3iUypO/t40YFdGzaCgGPFSwZtwPQNIFjFE2O2sSEyDRLQ8f5niRD
         T4jRv3eUcWjUj/B/1G5BB17xznz/YKCsXjxl9TYSKw31bTRvwpB6voccTmuNHWq+qIDR
         dMlLpAyWZau3b0+FyUI9BhEyACv4J2UMj9IQDAEC0aRAxpcWpE1QupOyTRSDjbTXQMdE
         LoiQ==
X-Gm-Message-State: AOJu0Ywh3Lk/n2HSU8ZJhYctDkTGlPD6YJCB3pmBVLe5hVgSkf8eN6hm
	bra2biIe/rwGO2ozG9vEtGM=
X-Google-Smtp-Source: AGHT+IG6YQnWHpFpuo4lQWpMYghCG1Rf8TnhxTSa6hJaEnWOkKTVJGaTXh0WMPN8T+QaAuUXAkGK8g==
X-Received: by 2002:a05:6a20:cea6:b0:195:ee5:be7 with SMTP id if38-20020a056a20cea600b001950ee50be7mr1995319pzb.27.1703588043267;
        Tue, 26 Dec 2023 02:54:03 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id sg4-20020a17090b520400b0028be1050020sm10874972pjb.29.2023.12.26.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:54:02 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 1/8] ksmbd: add support for key exchange
Date: Tue, 26 Dec 2023 19:53:26 +0900
Message-Id: <20231226105333.5150-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226105333.5150-1-linkinjeon@kernel.org>
References: <20231226105333.5150-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit f9929ef6a2a55f03aac61248c6a3a987b8546f2a ]

When mounting cifs client, can see the following warning message.

CIFS: decode_ntlmssp_challenge: authentication has been weakened as server
does not support key exchange

To remove this warning message, Add support for key exchange feature to
ksmbd. This patch decrypts 16-byte ciphertext value sent by the client
using RC4 with session key. The decrypted value is the recovered secondary
key that will use instead of the session key for signing and sealing.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/Kconfig b/fs/Kconfig
index a6313a969bc5..971339ecc1a2 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -369,8 +369,8 @@ source "fs/ksmbd/Kconfig"
 
 config SMBFS_COMMON
 	tristate
-	default y if CIFS=y
-	default m if CIFS=m
+	default y if CIFS=y || SMB_SERVER=y
+	default m if CIFS=m || SMB_SERVER=m
 
 source "fs/coda/Kconfig"
 source "fs/afs/Kconfig"
-- 
2.25.1


