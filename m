Return-Path: <stable+bounces-9323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F08231D6
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 17:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79ADAB2316E
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9131C296;
	Wed,  3 Jan 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oo2mKHNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A721BDEC;
	Wed,  3 Jan 2024 16:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB9CC433C7;
	Wed,  3 Jan 2024 16:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704301151;
	bh=HsXEHiBiwRoQhIp4zyeAiVJWRmemFKhtcKoR+VhEAEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oo2mKHNP6MieVkJdwXZzRQj9Ph8VIXlPWiazfxOSUQydKXkNyy001J7SDKsHLkucd
	 TMpVnNOTXLu/rU6W9BIMSoZWiE9v9ChsWoZFbJJsj+sgUrZ6MGKeI1rNIZrxd2QJsN
	 rJheB3tok43tUCTxZZmhESxiF3RktYzltatRm+yw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cheng-Han Wu <hank20010209@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 052/100] ksmbd: Remove unused field in ksmbd_user struct
Date: Wed,  3 Jan 2024 17:54:41 +0100
Message-ID: <20240103164903.886537333@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240103164856.169912722@linuxfoundation.org>
References: <20240103164856.169912722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cheng-Han Wu <hank20010209@gmail.com>

[ Upstream commit eacc655e18d1dec9b50660d16a1ddeeb4d6c48f2 ]

fs/smb/server/mgmt/user_config.h:21: Remove the unused field 'failed_login_count' from the ksmbd_user struct.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/mgmt/user_config.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/mgmt/user_config.h b/fs/smb/server/mgmt/user_config.h
index 6a44109617f14..e068a19fd9049 100644
--- a/fs/smb/server/mgmt/user_config.h
+++ b/fs/smb/server/mgmt/user_config.h
@@ -18,7 +18,6 @@ struct ksmbd_user {
 
 	size_t			passkey_sz;
 	char			*passkey;
-	unsigned int		failed_login_count;
 };
 
 static inline bool user_guest(struct ksmbd_user *user)
-- 
2.43.0




