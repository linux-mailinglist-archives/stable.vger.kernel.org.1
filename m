Return-Path: <stable+bounces-7703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF38175DF
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED4428361B
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48A95D755;
	Mon, 18 Dec 2023 15:39:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9455D74E
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so2106602a91.1
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:39:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913959; x=1703518759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HL9EBtYSbs0e3YgtCmmEUktBCgI7xw/pxNer9ZhLoEQ=;
        b=sJfEWO6529M0z24RsgwvKCIyVRZIgPaISSspRgT6rO0BMyEipLd4JVXQXzOe6nSJaj
         qeQ1TV/wW0/SCaj9TXkHydja+98q0AG/GnVzgi4BMAr532K3hHhVnqe1TxSdaJH71PTO
         0KrfjxsAY33yLkvu3aLWgeS2EvR4ILAKABEq6U9Br5TnWAS9ilgghZXXehJiRTcgbzZ4
         Gfv6GKgVfAlbAEgcjg35z172r7qEzHcuOJ63wTsgI9qKVq8ObmE/MBNwqD0jMJ8GJpGo
         ogHLjGHcPA+Z5zYvGe+fWImmsQ0G0NFA+aZzTcGDLrVfI4CLym1Pl6EZCThVx3yLvS+q
         1DcQ==
X-Gm-Message-State: AOJu0YwZ4t9CxuSs4d0wNDlqApaYCRwTp61pWcjRRwuvCpWRsZaeSNRl
	6W0j5p2t8nVVV5HWImpn+zA=
X-Google-Smtp-Source: AGHT+IEkj2M2GAGOa+WVvy4vj6hnonmyJ8K92u/tVCCJXvIR9AkgJIn2n/ow17miSbzcBZM2qQEEzA==
X-Received: by 2002:a17:90b:194b:b0:28b:6e4f:44fe with SMTP id nk11-20020a17090b194b00b0028b6e4f44femr972501pjb.38.1702913959311;
        Mon, 18 Dec 2023 07:39:19 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:39:18 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 5.15.y 074/154] ksmbd: update Kconfig to note Kerberos support and fix indentation
Date: Tue, 19 Dec 2023 00:33:34 +0900
Message-Id: <20231218153454.8090-75-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

[ Upstream commit d280a958f8b2b62610c280ecdf35d780e7922620 ]

Fix indentation of server config options, and also since
support for very old, less secure, NTLM authentication was removed
(and quite a while ago), remove the mention of that in Kconfig, but
do note Kerberos (not just NTLMv2) which are supported and much
more secure.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
index e1fe17747ed6..7055cb5d2880 100644
--- a/fs/ksmbd/Kconfig
+++ b/fs/ksmbd/Kconfig
@@ -33,14 +33,16 @@ config SMB_SERVER
 	  in ksmbd-tools, available from
 	  https://github.com/cifsd-team/ksmbd-tools.
 	  More detail about how to run the ksmbd kernel server is
-	  available via README file
+	  available via the README file
 	  (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
 
 	  ksmbd kernel server includes support for auto-negotiation,
 	  Secure negotiate, Pre-authentication integrity, oplock/lease,
 	  compound requests, multi-credit, packet signing, RDMA(smbdirect),
 	  smb3 encryption, copy-offload, secure per-user session
-	  establishment via NTLM or NTLMv2.
+	  establishment via Kerberos or NTLMv2.
+
+if SMB_SERVER
 
 config SMB_SERVER_SMBDIRECT
 	bool "Support for SMB Direct protocol"
@@ -54,6 +56,8 @@ config SMB_SERVER_SMBDIRECT
 	  SMB Direct allows transferring SMB packets over RDMA. If unsure,
 	  say N.
 
+endif
+
 config SMB_SERVER_CHECK_CAP_NET_ADMIN
 	bool "Enable check network administration capability"
 	depends on SMB_SERVER
-- 
2.25.1


