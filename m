Return-Path: <stable+bounces-192786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A218DC42EF1
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A4AD4E27DD
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6861CEADB;
	Sat,  8 Nov 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPhw8UE+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610611EA7CB
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762617447; cv=none; b=FXCkFhUnU5o6wQBZzYTk1xuerro2RvOfmzAuoc3zfAoceIgHfshsmcHxFIg1OKuBGQ6Z8QWDfsvx82BL5f/CafM1UuKG2/Iwz0hzguVXHGb+bG76O/bRpaqWUm/VZaNZWAYv8SKETW0XSN5aQThS4ryaqeAM0Lo3dnfYmZXu5Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762617447; c=relaxed/simple;
	bh=1B6qJxhbK00jLGFc+/1YeYK+A12GIKfCTEsHFV4BWFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZSgmLctyo2tR9BbEDmFqhgT+z7KFF+5rEUWa/zDEP/YCA6fTG4o/2so/Sk/doBTvVGzCyHxbTUTiCUDge5edsR25bZNuDarNxucGRO+726iLoUJV0Bn5GfISswSS9yZO9HD9ZoGamVeT2KlwkWBm/Bzfr2iGVQh1wXBnFA2/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPhw8UE+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3436d9da02eso38187a91.1
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 07:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762617446; x=1763222246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UF04VjpCgrtM4AACwnQlzOMrdSH/wb0uO//xFFcApf4=;
        b=NPhw8UE+uGSqouH7donjkwGs8XsLpQPCFsj2zK/upWEoCA2ckn30uTNztMiwWsFhwJ
         RUi2UQud8H7gjTorRjPKJk3d+uzhHRMvAauypLHQl7EaUI+tUKLZWSgnVfT/uta4R0/+
         x6Rx/HLFB6O1QQfqF1rjozka19gFNDSTcYp1WO7iGAg0WvjLPRZfFvuGv8bSxHzJBgON
         qXLHdGuLUb1CTUuCjirhLE1U+JrmKYfEF0WmdHyc3uqrfT1fna+Q7v63lktBZUM7MV1Z
         ZvrFhOiMY6IwvPKDRPE62N9WzDhQfBVMobAD6rRpo9bgWB+KW0INgiU19HnPEdMhWXvQ
         uHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762617446; x=1763222246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UF04VjpCgrtM4AACwnQlzOMrdSH/wb0uO//xFFcApf4=;
        b=hvDikZAh36mpsMzF1qeoTgdly+eKii+P51TPKjW8MHoswiAO6S7W9FZBaotj/U+/ia
         1SVipT1n2VT0f+1Qy8R0uRstkM3A5t1F0lzgVTUZyPG7Xz4PnNhIkOJm/DLnwqS4WARc
         6D8lrCmxUCZEjTo+YdJs8pLG4M9+A38mauEXbTQlUyPFk7JB1Us6VPOYbupso1/1ngl0
         aDqWhqjn9WfXFzGEFXF8UeFOilzs/dePXbREDB39sBz5aBNh+ihETDT3w9UA3+mOOE4L
         Q6LY8tOipApNMDYQOZxhycAsmLHyfTlzpb8A7J4qV+zy3VP7kYySMKK2jQm/on91UimO
         WnTw==
X-Forwarded-Encrypted: i=1; AJvYcCVx318AviRMtCaZn2gZ/whjScXqYXX8tArjIfpRHcMAm68BwNeJSW6eXvaWX/u+CzyuWJqvsD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAQdadkRIJ2ECTwznLCEFkDLmWVnQsLC6nY0O1ZSm+/0l55Fb
	W5Lws7wjJZqvTZdl6LXzHP+F1KINn4guWiHMouowPw/PfURgAs0SUOec
X-Gm-Gg: ASbGncuomSjuqJNPZ1Y/F42zH2EeJWWRRBcucv+IOG4XEma24uhEKGAHSxW3uR1W89u
	596ee2PDEv6F4yvOD3nfoSiSk3MLGUFNlP7QFnK+vwMby744DM3EDxPgRDIrz+NTbjbp119tV78
	coHuKFUEv/RSiXbHl0HYdj4jyP6l4MmTrdHpTolcb1R5nTCAN2GTsbVQtA338Z4wcscoe+xpuam
	NOXkTiHQVf4ZDwprTmRq3k1CqKkpK1EhJMPND0+HfUnZZ5zgRiiU6l/5WBbyaeavcGESC+UbLGs
	eYwWUJvq+o3mPG1uQ9GEMlr/VjYyf04T6Fpvqx8aAnbv7j4b9MsA3Em93o0EPOGnVtqYTGsPMhp
	cKS7cRcorvY3HsK8iwQD2/lmTBluFUOdOIsPK1O1kP8MQ+2mkY2WqBgmgi6M28jc6mzQh5Q6q+1
	hvPcffF/a6Ie0HHAK3D8/nlzBZVByMPixz/npWgrHiimgMFhKr5oGQKw2QhXnJfHbBuUQXIYi6
X-Google-Smtp-Source: AGHT+IH9LyA7/tnKICrBnlW9MvtAHS+5SqO+iVA2GT69gP6cJzXTVGRPCBtL5DJXPhM6hg6KNiVtoA==
X-Received: by 2002:a05:6a20:4305:b0:2e3:a914:aabe with SMTP id adf61e73a8af0-353a026aa2fmr1974504637.2.1762617445630;
        Sat, 08 Nov 2025 07:57:25 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901c39ea7sm8200832a12.29.2025.11.08.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 07:57:24 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ksmbd: vfs: skip lock-range check on equal size to avoid size==0 underflow
Date: Sun,  9 Nov 2025 00:57:12 +0900
Message-Id: <20251108155712.384021-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
References: <CAKYAXd-R8NGDzQ-GTM67QbCxwJTCMGNhxKBo1a0sm0XBDqftLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When size equals the current i_size (including 0), the code used to call
check_lock_range(filp, i_size, size - 1, WRITE), which computes `size - 1`
and can underflow for size==0. Skip the equal case.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 891ed2dc2..d068b78a3 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -828,7 +828,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		if (size < inode->i_size) {
 			err = check_lock_range(filp, size,
 					       inode->i_size - 1, WRITE);
-		} else {
+		} else if (size > inode->i_size) {
 			err = check_lock_range(filp, inode->i_size,
 					       size - 1, WRITE);
 		}
-- 
2.34.1


