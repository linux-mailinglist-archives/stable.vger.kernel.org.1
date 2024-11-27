Return-Path: <stable+bounces-95639-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 381219DAB8A
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 17:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C7C165056
	for <lists+stable@lfdr.de>; Wed, 27 Nov 2024 16:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A802C200B89;
	Wed, 27 Nov 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc/HZ6cR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D01FF7DB
	for <stable@vger.kernel.org>; Wed, 27 Nov 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732724112; cv=none; b=jV8ky5Um/XH/5KhNdIN1oQVbl6sFi4sgxgU0azR/sF2H9Ar/KoV8aPjeyAFRdJeid/l3rsfftpTBX7evC9lirJeC2P6GsPZ3iwmpuipgQNPVMI/+Puzj1o3/e6OxprhjT5dwqam1C7oQ1Zl1/cchKPvY73ynxcZeLoQOALPnm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732724112; c=relaxed/simple;
	bh=AzOMQpJdTtKCmGlFihUbBrEVJHPmC1Y9vSjPYsngots=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iavpvEQbGkg+F31WkNMwaSZ1ebxrRghsFxa53N1sP2SWmrwk7wPwdMgJmXgRey61y6IdPKuA17wXkzqFHcVwYK3WW2VvLxXOrmfPIrsywaq8qiwpoaSUQo/yOyKaGPd3JtyaGwosOinsvNT4VVppOScPlepoJqvZAg/rt3jLUcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc/HZ6cR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3241C4CECC;
	Wed, 27 Nov 2024 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732724112;
	bh=AzOMQpJdTtKCmGlFihUbBrEVJHPmC1Y9vSjPYsngots=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lc/HZ6cRkHPLqJWmRFd4X+8VO8wuhT1TcMi8vTQlCzGjBFyYJkDaj+tGFQaTU4En4
	 JlOrZ/psRMD/KRLK+3hnFj41u0caCZ2dhrIPHKesU9cKji5cNSpo8pqZ7DLwZ+BZsK
	 9J8PI9MQbuWzMA62/pyxVpi/e19pcFdh2nuWwxFziEv37EsgQu+b7YoEShpnh8HsGu
	 CoCJpYbYL/tPq5Ep4e/tIDJLW3CeQWp9oWtf3M2WkYOJpnOkS1XIbMr4lyBwqjDDeb
	 OIPU+SVfWnOiu+Vd4pjnjTbinPn/w3a49oZeOUpy5wIjrWInUsSXt5BDCCbS2KMN2l
	 hGUh7EzLSgcJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: mingli.yu@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] ksmbd: fix slab-use-after-free in smb3_preauth_hash_rsp
Date: Wed, 27 Nov 2024 11:15:10 -0500
Message-ID: <20241127083256-48e3c9908efd4c7e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241127063833.2525112-1-mingli.yu@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: b8fc56fbca7482c1e5c0e3351c6ae78982e25ada

WARNING: Author mismatch between patch and upstream commit:
Backport author: <mingli.yu@windriver.com>
Commit author: Namjae Jeon <linkinjeon@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (different SHA1: 1b6ad475d4ed)
6.6.y | Present (different SHA1: c6cdc08c25a8)
6.1.y | Present (different SHA1: f7557bbca40d)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-27 08:27:30.965656947 -0500
+++ /tmp/tmp.cpyd1kXGy5	2024-11-27 08:27:30.959243327 -0500
@@ -1,3 +1,5 @@
+commit b8fc56fbca7482c1e5c0e3351c6ae78982e25ada upstream.
+
 ksmbd_user_session_put should be called under smb3_preauth_hash_rsp().
 It will avoid freeing session before calling smb3_preauth_hash_rsp().
 
@@ -6,14 +8,16 @@
 Tested-by: Norbert Szetei <norbert@doyensec.com>
 Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
 Signed-off-by: Steve French <stfrench@microsoft.com>
+Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
 ---
- fs/smb/server/server.c | 4 ++--
+ fs/ksmbd/server.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)
 
-diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
-index 9670c97f14b3e..e7f14f8df943e 100644
---- a/fs/smb/server/server.c
-+++ b/fs/smb/server/server.c
+diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
+index 09ebcf39d5bc..da5b9678ad05 100644
+--- a/fs/ksmbd/server.c
++++ b/fs/ksmbd/server.c
 @@ -238,11 +238,11 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
  	} while (is_chained == true);
  
@@ -28,3 +32,6 @@
  	if (work->sess && work->sess->enc && work->encrypted &&
  	    conn->ops->encrypt_resp) {
  		rc = conn->ops->encrypt_resp(work);
+-- 
+2.34.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

