Return-Path: <stable+bounces-9043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4298209FC
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 08:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C8DB2171D
	for <lists+stable@lfdr.de>; Sun, 31 Dec 2023 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD817C3;
	Sun, 31 Dec 2023 07:14:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8617F4
	for <stable@vger.kernel.org>; Sun, 31 Dec 2023 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28c0df4b42eso4136380a91.1
        for <stable@vger.kernel.org>; Sat, 30 Dec 2023 23:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704006855; x=1704611655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6X1Wlvu4/Fvo+Wnh2Z0kXEM2hoTENNgE0wBQZC1Ph0=;
        b=DRIR/bksb+2aShJMcG9gflyII4WyjxIeaHpxzeNnQEyXPHFFAlzFo9EwyK7At26nNa
         6YjKCSdGIKbCvbXku7Z2LM4mup/OJcBsHCkdOlM8947HNdtyFLy+LZDwgA7+lkXbFZkE
         2SJNWueh+E2oQrE+J/swjAw2tN5ZcYATrG9acOTa0taGiDXc8CHwNXxfT6i7RS32EDZN
         vx+AIJg8ZIjriangMIizS3j5BiFh19m9edsZg+fJQILItsehnXLRjOk2ejtSzmJ3+YSQ
         syBKxqPYBktzWJUiwzkL8FCVGrNc5bMY4CGPTjBwbUVftAypxPqJMro8tNkX7cQOFmHh
         s0ew==
X-Gm-Message-State: AOJu0Yy/9fUNlUh0PzPevl2pi4Ix9bGgneZ3KmhLDY3Y4UXd/Obtu5Y6
	AjVQlQRDlC1AhMLkWMk84m4=
X-Google-Smtp-Source: AGHT+IFP4h1oTZ7p3+L7e9a3bnlvYQX2sk2s6RmUntepaOdDIAnsVx8UsiT7cwGrWb29sf6YgBuMZg==
X-Received: by 2002:a17:90b:1d09:b0:28b:c02a:d0e2 with SMTP id on9-20020a17090b1d0900b0028bc02ad0e2mr16034521pjb.18.1704006855065;
        Sat, 30 Dec 2023 23:14:15 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id a2-20020a63d402000000b005c661a432d7sm17146357pgh.75.2023.12.30.23.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Dec 2023 23:14:14 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	sashal@kernel.org
Cc: smfrench@gmail.com,
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH 6.1.y 09/73] ksmbd: update Kconfig to note Kerberos support and fix indentation
Date: Sun, 31 Dec 2023 16:12:28 +0900
Message-Id: <20231231071332.31724-10-linkinjeon@kernel.org>
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
 fs/smb/server/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/smb/server/Kconfig b/fs/smb/server/Kconfig
index e1fe17747ed6..7055cb5d2880 100644
--- a/fs/smb/server/Kconfig
+++ b/fs/smb/server/Kconfig
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


