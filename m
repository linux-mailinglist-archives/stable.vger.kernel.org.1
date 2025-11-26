Return-Path: <stable+bounces-196941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8B9C87BFB
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 02:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 300F34E2F23
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BF6305E2F;
	Wed, 26 Nov 2025 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcQ5ODI+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91DA1A9B58
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 01:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764121792; cv=none; b=lG8wTVFM1GlV5+wwoNw4PtMxQ1I+Yf3FevycRD5DN5Keuj7MeICD/8nfQF684CORD8CYbs62kiVwe5dBKHECs+d78xgVKa4GAydZkLBQjfktxSROdXemIx5UyHTO5v+nzEFm++SuGB/RoJiRxZRfh0FOOy2KYUjM0bPRhDfnMQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764121792; c=relaxed/simple;
	bh=pWKdAtmbcjOBC/rjEzN8Ynk6y/vXR4p9htT1qe9JR4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xs9IdcoBaiXUX2ZDpowI0N74QdGEkRZrpzZyYxhzUVdIYcy0Y/VwyoJwn8afXDLAzcksMPRug7pURLKjt5We962l1R6Y3cdUUae9EsEi21E8xQ9nCvQ2ScTWfAKqSoAc+36KgRkYirv/PFA30NWhq3cdhA5ZPcwvMO1vcDZRcNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcQ5ODI+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3436b2dbff6so920781a91.2
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 17:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764121790; x=1764726590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2JIwhg1M/+/Us4TNcrvjEWCQJJcUG3hiuOxKjzzsq8=;
        b=jcQ5ODI+PFrMXzjVV/SSc+gsg6lDKiqqPtAwlNgmH5En1koBOf40KLSaLk8OrCppUl
         qTnA4qNS7yI56q8cCfisfrKWzPJ+ceW+O4xYxUHloRZrdRR8oZvuW1zlmVWpFwotlrDt
         RvzgcwW25xn8mIrOlL2S6Uy53z5lF9sll3cVAzs8Y0INZ9iMYBsRgnkFHStSYO5Rw8+N
         2za0owNybyNhRcPMntkALozfH5ERHcOR0qXVceJhBpVpV98lkk4XJdjz5IBDfrx6mZhL
         uqmA70mgFrMnYJYdsgcRp4/OqLQfZay/YEpZBNPG7RihRuQ762RCzAs6dsIz0b0ebM4L
         Vm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764121790; x=1764726590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2JIwhg1M/+/Us4TNcrvjEWCQJJcUG3hiuOxKjzzsq8=;
        b=jqj61T5bxxPEr2VK8mVSbrLtdO5LcAyE/vtk5qDe4EU5eeNRtn307Ga8mpm8Cdt7gs
         GV+ayfYhVhJTvtqlJmPXKy0Cx3qSdioeLOlbgJ+IrdsDRC2Dq5OBGPwW7zxdrnrP36JQ
         ujJBVgwZKUdsdP6gtP5WN4ZLrSJMrmd7t5CZSTiLwqokuipeOf0swZTK+4UrwucBrtQE
         K89C5IxBr0kuUlIf++GnLicdzoNauWCpryyp6NyRH744PupO0Njt/Mek4gB0/PO4Uan4
         UYwsBrqfw/SjByqNdfiMrwwFoBFCNlkdm32df6/bW9huPZ5K5I1hSjvaIBAFOpr9oVOV
         4Drw==
X-Forwarded-Encrypted: i=1; AJvYcCXq4g3ZwnuFVpHmrEMRfDcu/zK0Sl1LPXCeWPlGHLP+7g4HRVJ3VTYGoy971eYFT0VGbqWC2KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLg3jU+XopoVGOJW07jxEfb+tFsciqY62duGJ/btlXQudwwICV
	dI7FCukomDFCWgSF8JGW2QsJ7lK9mAhK9c2jR/51OV2nneUTXhE66Lnw
X-Gm-Gg: ASbGncsL0aigq+bJ8zU8ILHI+WLSa7QOWEd33j3M5lgUqu8LH4QWboGfSUZLUoeeRsX
	ylX1NMSTmrFSJFnP2ciZyiV0kYsLPoSmPdk+USoGk0PcXFWmQX788B6JicA7PiD+u/hkuidY/VZ
	OgmA4G3KbyNbVOF+fXX0LsmbgY0yk72ytzSFi9W4wbtlpfOzjIEBAW4MmHzKbEwewr/430AvsZr
	1BFgZQVNdmOtpZaUKFXiybMqeQm+0lLKXvOgqkOPBGKBJ4DoYBf/h+snR0ukf6IafJOk0W9MmA/
	d0RbwpyzYJRfMwCl6u9/CtUNdUEloQiymgbS5SUv+PMs5H25X8UKVfoLIIAfNjIcNWAhH408KyG
	vqGeVv0DiqbkKe4mkYUCljLneirne7A56ESTs4MLc00bOo/RMKk2zVXD1kP1vwk9txc/bpBgo8k
	2XWyiVr6luL5roeBEtJj+24u2BIIjwzK/8UU/3WITi2/YkfL/KKjste5EOYH5I4daEbvmBVAgR
X-Google-Smtp-Source: AGHT+IHrljL275fXtsXNqEjG58xd1IF8GPPmptkpdwAzH5JqK8ILh0LAGkZo45N/WI2fpgRCE5WxoQ==
X-Received: by 2002:a17:903:1ae3:b0:290:c94a:f4c8 with SMTP id d9443c01a7336-29b6be83ec2mr109629045ad.1.1764121790102;
        Tue, 25 Nov 2025 17:49:50 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm174994755ad.25.2025.11.25.17.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 17:49:49 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: ipc: fix use-after-free in ipc_msg_send_request
Date: Wed, 26 Nov 2025 10:49:33 +0900
Message-Id: <20251126014933.10085-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd8=buKQRve+pdBFp9ce+5MiR02ZnHtGHy-hYDfhGWn=pQ@mail.gmail.com>
References: <CAKYAXd8=buKQRve+pdBFp9ce+5MiR02ZnHtGHy-hYDfhGWn=pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipc_msg_send_request() waits for a generic netlink reply using an
ipc_msg_table_entry on the stack. The generic netlink handler
(handle_generic_event()/handle_response()) fills entry->response under
ipc_msg_table_lock, but ipc_msg_send_request() used to validate and free
entry->response without holding the same lock.

Under high concurrency this allows a race where handle_response() is
copying data into entry->response while ipc_msg_send_request() has just
freed it, leading to a slab-use-after-free reported by KASAN in
handle_generic_event():

  BUG: KASAN: slab-use-after-free in handle_generic_event+0x3c4/0x5f0 [ksmbd]
  Write of size 12 at addr ffff888198ee6e20 by task pool/109349
  ...
  Freed by task:
    kvfree
    ipc_msg_send_request [ksmbd]
    ksmbd_rpc_open -> ksmbd_session_rpc_open [ksmbd]

Fix by:
- Taking ipc_msg_table_lock in ipc_msg_send_request() while validating
  entry->response, freeing it when invalid, and removing the entry from
  ipc_msg_table.
- Returning the final entry->response pointer to the caller only after
  the hash entry is removed under the lock.
- Returning NULL in the error path, preserving the original API
  semantics.

This makes all accesses to entry->response consistent with
handle_response(), which already updates and fills the response buffer
under ipc_msg_table_lock, and closes the race that allowed the UAF.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/transport_ipc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 46f87fd1c..7b1a060da 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -532,6 +532,7 @@ static int ipc_validate_msg(struct ipc_msg_table_entry *entry)
 static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle)
 {
 	struct ipc_msg_table_entry entry;
+	void *response = NULL;
 	int ret;
 
 	if ((int)handle < 0)
@@ -553,6 +554,8 @@ static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle
 	ret = wait_event_interruptible_timeout(entry.wait,
 					       entry.response != NULL,
 					       IPC_WAIT_TIMEOUT);
+
+	down_write(&ipc_msg_table_lock);
 	if (entry.response) {
 		ret = ipc_validate_msg(&entry);
 		if (ret) {
@@ -560,11 +563,19 @@ static void *ipc_msg_send_request(struct ksmbd_ipc_msg *msg, unsigned int handle
 			entry.response = NULL;
 		}
 	}
+
+	response = entry.response;
+	hash_del(&entry.ipc_table_hlist);
+	up_write(&ipc_msg_table_lock);
+
+	return response;
+
 out:
 	down_write(&ipc_msg_table_lock);
 	hash_del(&entry.ipc_table_hlist);
 	up_write(&ipc_msg_table_lock);
-	return entry.response;
+
+	return NULL;
 }
 
 static int ksmbd_ipc_heartbeat_request(void)
-- 
2.34.1


