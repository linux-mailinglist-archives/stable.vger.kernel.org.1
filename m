Return-Path: <stable+bounces-192350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A93E2C3067E
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 11:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63BA04E79B0
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646282D481C;
	Tue,  4 Nov 2025 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQ53Ntyq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A64C2D3728
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762250623; cv=none; b=BtpEALvl6MegT33AUzn42ccY5MTqCHO1+PiyaC2/1uksRd5lqNNnkuAYFTOqb5LquK6gXMx0iwSQxW3kepTH7GrMr3U7J/NT7DPlbztRwIxbxPJi1jDdUbr6sXMBw56Wad7IIvl3ZVM0feTYQqldkzkU2PIcF4yxx/W9u25acA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762250623; c=relaxed/simple;
	bh=yCNhQ4a0Nk0Atx6Dr4wxtJ0ZtyqyLGT9ZWpCeh0ba7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DSeZSrRp/hpVcnEmepShxrGJi5rsmVhpFouKU0IPTTjW/T5kkiSNbh3gnofiKbakY01pdNABETqPZ4iLc1O4ym/VCPirwtAfz3X1EN9/FhYWE9X+W7udMdoyO76Q95ifP1w46fzQ+4wpmrs6gL8W9x6lioSrJNc4LdJnpoHFM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQ53Ntyq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-294e5852bf6so8258635ad.2
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250621; x=1762855421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKUczaa/kE48HAcaJ5lE+YSGWpwTs3a+tEo/Ya98+Oc=;
        b=mQ53Ntyq00EMTSh035RR+uDtW7hqjDsU/ZP5ohgCtXU8iDxkKWRO+rWmFTmRd3dtve
         /9oHlAvsGwGsM7p2C1MXvAi61D0Uk3dIy6G2YyjJfgSsmY8gX3MXp3jMK7pwNmuNcqBd
         uHBqxjox4bQW/TlBTz4WEPe6EVfSCehly9TXbbO2OuQquuXC92Ulw1VY/Ubm7A+gTN0S
         LvH6K+3Z9chVBQ7YtbJ4ir7Yf1if9X0rhTIXdW/PEyCyRlKuRLOCEQpRXQEW0BWzRMAQ
         uvCO6YkLHlqWaMmAlYMUrhOdL11AIOQ6AHx7XxZhTMVc/xlY5vav4vcw3g9oeQk2eZ0/
         853A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250621; x=1762855421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKUczaa/kE48HAcaJ5lE+YSGWpwTs3a+tEo/Ya98+Oc=;
        b=mmeOYXSKKFwthTBVvyv92Qt9cZ9Ho+yvBuIujKDnoqkNvSzDJVMX85AMNhbqyAsepW
         +TplYXZGCBbTUNXF+aBxcl5PHZ3YIlSgEQetK6noDP7F2rBLLRH0T9TJfZG+ydOvHwvW
         Y5kd0tz5VsO57Op5dg6yzBHXeJ/EZbF8HIM0CdSqwhhF02ZedkVIzu8/vnBuLjbZPheK
         jyjdy5mDeQHwEiI38Yz6feZgWj8w9LvLsE/9D6B0yY7dpDZh28nZzhHWfr02rRBjALow
         B1bv75ulSS8uDDXrFrl1E+ldI2U+EMh1HP3aEZV/I8zbJ0lKA8rbVmZxmaF3bTzHHALd
         w9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCX8zI+eoYJTgIAJYjaKb0zwLCQxG+a/jfG0gaSZOhFojBvOSYU5CRWyQKVNfMh3LAh1tjDD27c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLqxPkzHLwauDl0pqmAJNkO7ucORZEoIa3+ouLpvd5wQl3fMB
	J3Kpe5nYChxi8jrv+QKRaIiqfn2UgoX1yQsVV3RebHFC8X5P38ZkX/l+
X-Gm-Gg: ASbGnct5VdBOtmC2vJ109qtUBEZfNOEMl8mQd+TdKZj3wF5rSfdnOrUQEMsEVw+sPdW
	UzjiWGyW6AaDDnIGrqcBdD01ReOfGdlfcfCazUC0vnHyGV5nVBgmUu3rRv1T1oALsrtLbkhhkoO
	/Q4JpdiV3BSqe7/kx3xLmVLo5lA1P/niufDEv+pHs9L2UGpOd9qDv/1oSrh80dJEpqE3HIf9hfT
	OP8mLEIMxynserkckXE3RAw8gJuDA9n41m7EL+O3wlMaDPwvXR5NF9OVNRI8I9lmjLftoKGgHIB
	Yzr9Z15W8wpEgUdIm5NBJLN7tDjzJrwwFUq/kW4qzICoDLWwJsS46B8hVqX+YcTNv4pPxK2Tsi3
	lX/PAiGb6LxOvMCBw8jU/LA7ANHx+kx5RZqbggjCG/CJz8Bzo22zU6p8N0YmMEZDkGis3OKuLkN
	uYcnuduoxxgMPZEXNKl3NA61cs3SeFASnY6KPRM/JED4nKYHjP/sBpgDNpRNtVNQ==
X-Google-Smtp-Source: AGHT+IERjCdObduOqXZ7oaX8UqF7sHs4pQ6NQtq4FOaNwiNZd5TJwbQT+UFYEFtX/Kv19Ewgasg8YA==
X-Received: by 2002:a17:902:f393:b0:295:54cd:d2e2 with SMTP id d9443c01a7336-29554cdd55fmr54991885ad.0.1762250620759;
        Tue, 04 Nov 2025 02:03:40 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998ef7sm20672565ad.33.2025.11.04.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:03:40 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: fix leak of transform buffer on encrypt_resp() failure
Date: Tue,  4 Nov 2025 19:03:25 +0900
Message-Id: <20251104100325.343863-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110432-maimed-polio-c7b4@gregkh>
References: <2025110432-maimed-polio-c7b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encrypt_resp() fails at the send path, we only set
STATUS_DATA_ERROR but leave the transform buffer allocated (work->tr_buf
in this tree). Repeating this path leaks kernel memory and can lead to
OOM (DoS) when encryption is required.

Reproduced on: Linux v6.18-rc2 (self-built test kernel)

Fix by freeing the transform buffer and forcing plaintext error reply.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/server.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 7b01c7589..15dd13e76 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -246,11 +246,11 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		rc = conn->ops->encrypt_resp(work);
 		if (rc < 0) {
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
-			 work->encrypted = false;
-    			 	if (work->tr_buf) {
-            				kvfree(work->tr_buf);
-            				work->tr_buf = NULL;
-       			   	}
+			work->encrypted = false;
+			if (work->tr_buf) {
+				kvfree(work->tr_buf);
+				work->tr_buf = NULL;
+			}
 		}
 	}
 	if (work->sess)
-- 
2.34.1


