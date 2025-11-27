Return-Path: <stable+bounces-197504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42131C8F3AA
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F38B24EA84B
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E429133345D;
	Thu, 27 Nov 2025 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqFDVA6r"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02E296BC2
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764256382; cv=none; b=eBW/ahl0AivMFpTQ3sJOfiZsNE+M00EoBYBsXPGJxLnWZ3gjGz81kjLVnw9ctlLK6hMr7cbM07lgdq2YUnguqdYsbPLRSpNi3g94X/tYCFjiO2clHW2skQ2Dkz8KEEeMQZMOGXrKkbkkbY8fWkmVLu8blkTBJotHfGwIQrmMRK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764256382; c=relaxed/simple;
	bh=L3wH1dZ2OsI4qXhVsrxGUjiBqTWXd18/FbeuIC0+2r4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWyELPAim+WpL8QGX+ua24PII7sQwYreP/+v5owYHWRoByil3HsUgXO43HqQeMEu0TLEH39+zU2QHMY5zO0MkWBwH4AHQkFLBfuMxDtHuQfUAXPHb7gHFUs84RSNk4Ul50NA9vzgJv2hS1/HO3Vc3RMHpaYeJl6imnlk3rND5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqFDVA6r; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso7430731fa.1
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 07:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764256379; x=1764861179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ED1C3ibqhXI9fuhgTYBvzdlG1H90hVJ8Fjdd0YUiAJI=;
        b=NqFDVA6rjvxVAd4FJpPzDS71sCRC4x0DBKsQqPg2gjNvZDXsbEyyUS20PnshKHmfDa
         GWIxstfSWCqZXV5Ym1tlr+ZJmuR83TLY35gpUVpOZLfBy3RRst63Qsy7cdHbQ8SYAwVJ
         4xxfso4nTCmxZNr6zU/mBksgRS0z74se4oFbMZYVIOoduxtqZIX1kvy97/udNa5afMTM
         xdFJrNmm0XPZOn0HrK1Sihqj9C/WsSH6u9d/eOGICaAYx26Cyq5P6I1dKMSHh019iAvi
         8loAtSdYJRLqHeygqXRwgUViEsOszO3IxkzuQkEVnMsoScOu2nKcwZuQrdYrgl9FAQsA
         ovew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764256379; x=1764861179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED1C3ibqhXI9fuhgTYBvzdlG1H90hVJ8Fjdd0YUiAJI=;
        b=qs1rv3uLOyux2t+DTkiGs/XtdyeKbjENEc+cYxAp7QteRuQBhv0IP5BCjqhMCaiFw4
         16O1wf0A04prdcdOpT+CQy0xEb4rIrkzVMxOWunsEcy+oJnmcKoMfPA5KP6GXuZ8IOKL
         l9jfFcIh2EO2UKkwSFBCpQjOdhhrGOUUj8wFcq2Pe34nfGOntoqmo9TCGcw7TUrECB4j
         vO4/4v4HWwBS+Y9xemqUSO79PcA6/8Qz1kOMoJkTvsKMip7RcO1FTq6PZWWiw6Ciwi2G
         qOVm2tDqA8u8zmRYkeg/9nX29F4ZGsyUeqsHIHgzu+8sZrMOpAc6HxtipTQFvZnoqr0e
         BLIw==
X-Gm-Message-State: AOJu0Yw0PwkgvKOOlPSu8pXADerAkJqEBvDT+2jDduzoh25b43BlkDym
	1gJYHHGqWLkfs8c0c/fJ15r72T7g7JXwfsegePnwMF7CKTatbj1PyHMO7Vv/3TCocRZOqg==
X-Gm-Gg: ASbGncvmYJmzZiN5i/G1yB20B/v6t1IB2PWH80FbOHWPf6CzukTcyendezQRjohppAk
	q75V4SWQ/8BVm3UU2n3wUBHaIUV6KCnbRjNNHjRZqKuKbhsAoq2JyKOiBOqYl3n15U+2z//XJR4
	fiWPsopasgORdfogOCnxQdRLu9T9CiTRZoB/fstfvWQq8CnD7gZxUXLN8+8oATYvkznQfJDF8c0
	kVBq4y7bIkmfACtrRIrsoPkyMTOo/e8EkZXjApCvl/lUmx/xjr/UCNFrsfKjUGM359p29Uz42NO
	hlM0w1Wm+3U6td/WDG/Lfunr/VkT8Sfxt+yJ0jR4YbobaV8+fKRPVNQ8Lnse8/KRRFopuMTt2WX
	Wlq+sUcQu2w+ufOH4xcYJfmgP+IGLA+KYLbT+NLmjaY6t0nFqap0PQcOJIwZY0BDq9gClAFOrlE
	YnjaY/0FUSnv1TSRKWbqekl1uPReQ=
X-Google-Smtp-Source: AGHT+IF3H290YEVRrB7mbBY9eiIKdjw3YXsiJTPdz10I9RjESS09gqJtTisxKUm+Mdw2RcCSA11Xng==
X-Received: by 2002:a2e:9e58:0:b0:37a:2c11:2c61 with SMTP id 38308e7fff4ca-37cd91874e2mr59529531fa.4.1764256378814;
        Thu, 27 Nov 2025 07:12:58 -0800 (PST)
Received: from cherrypc.astracloud.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d236b7e97sm4329601fa.13.2025.11.27.07.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:12:58 -0800 (PST)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
X-Google-Original-From: Nazar Kalashnikov <nkalashnikov@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Sean Heelan <seanheelan@gmail.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6] ksmbd: fix use-after-free in session logoff
Date: Thu, 27 Nov 2025 18:11:58 +0300
Message-ID: <20251127151158.107004-1-nkalashnikov@astralinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nazar Kalashnikov <sivartiwe@gmail.com>

From: Sean Heelan <seanheelan@gmail.com>

commit 2fc9feff45d92a92cd5f96487655d5be23fb7e2b upstream.

The sess->user object can currently be in use by another thread, for
example if another connection has sent a session setup request to
bind to the session being free'd. The handler for that connection could
be in the smb2_sess_setup function which makes use of sess->user.

Signed-off-by: Sean Heelan <seanheelan@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
Backport fix for CVE-2025-37899
 fs/smb/server/smb2pdu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 9f64808c7917..a819f198c333 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2255,10 +2255,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	if (sess->user) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_SETUP);
 
 	rsp->StructureSize = cpu_to_le16(4);
-- 
2.43.0


