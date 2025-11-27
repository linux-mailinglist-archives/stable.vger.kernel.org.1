Return-Path: <stable+bounces-197474-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1E9C8F1A2
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 09F95352017
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D08A333456;
	Thu, 27 Nov 2025 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEj2DlJt"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFA233436D
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255922; cv=none; b=uSJu/fACXhGZPFf25ftk5mNsvu0WL1ilH2OoAIvzuIAJtpOy44RG1AxrvA1i30Peu6m1nrHNQkyTASOhSB0HTm4RwxuxUUzXDiPVCwhrf1HJKs1UoxQzSfAk/QOdPGZsmhP5pmcYIfsQa0Z8eQN0ZwfIZFETH+He7nnVPGY9muA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255922; c=relaxed/simple;
	bh=ip5685HuVacOSDFUg9j81oJuSt4lg+bea6HTh1DKJAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUtTfTz+pKhxVNfcNK9A6FC0ly1wKCB05wHHV7VfpNrwqo013yqKFRey8XtAKnA/Vlln93G9t1Cf+beGaQmxeZ9oqhb0lOEWbjYxwRRWPOV+pxwUfbZa9cT6T03mpcVKhSWkzPDlKDwts8+iFXahCd2D8SIgIao/mnz3MmtAXXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEj2DlJt; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-595819064cdso1316337e87.0
        for <stable@vger.kernel.org>; Thu, 27 Nov 2025 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764255918; x=1764860718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cqIIQBY8ET4F2qvPv/LLUG9+o1F+aM/rmaNxvOMhsvM=;
        b=GEj2DlJtOiFYRuxksMAexpbrfAcsj3Cc8ATb5mPB6/qhHAMX/wn0RT5EI9vRQYYuVE
         mSe/Dk5bg8P38LjAJ3JB5q3PHu2TJKeKLW5ooyWktKSheKI7ZCsqm1/4+QxUSBi97lnY
         uBCauAi5XPDKxO9fx23iPXLEfHQ6drzBdgoy3GWpLpsN/ehB5KUJjaohUHdhNA3hmQA4
         o1hUJvGFBTXRwB5WbRSJQ8N/oezFlGpvGc+plnGzJANI0AUeIeSlTUJNJ+lyORPx2KbF
         uRiEuZ/L7OEDJoLTbGmjXBYLmhe2qb23wFyDxlp3KtLPo1LEUr7CPhYFIxOLFUwVoEul
         2nNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764255918; x=1764860718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqIIQBY8ET4F2qvPv/LLUG9+o1F+aM/rmaNxvOMhsvM=;
        b=YrvVAgH8Z1u42SJTqaEvjWIb+CyqwwAknQqOJAGKy0PZbbb9ULBaG4eoIukwiamb/c
         JiRzJ0qLIdN8vhozZIf1IE6kwU46zrYuCUlplXqIXC2RFp2ZRlhjsc6+GcC/QJ2hwYzM
         2At+oAqvhvpUjCR1x8nFWj8UdKin+hq2lEFbIWFmHUyTtjO2B9IVD9dUlDHV86msYVHO
         hv6B8v3dSsjTFk98o2GSAOTK7veBolVx3L/K73CYXVui5XQouSQsaKEP3fGoDP6eCl/v
         vESaJzsotLbBzXVldQuI5G6MDqk68Oks7jAjGyPYketftkI3+407nMbHxw+keZyKn97N
         al9w==
X-Gm-Message-State: AOJu0YwHzVIoOQP1T/+BKrKGIlpqNuuTIfbSypb26qKEzak6Oy8lmr+6
	fHILz0XbfyLaaGR+8Fw4s80mTwewLJB0x9SYY4MmQ4egjYhyh/6PLYteHHsJkSlxL7u1rA==
X-Gm-Gg: ASbGncup9pDy2T2sMKYbfGx04/ORIFFScC3JpIj3uJPdM8dEmLGw7UYc/7E6aT+LnWs
	8j9ZxgoPimIt4j/p/m+gUJLxBQM3B5MqFedCrEyUsS0kayElzuoO5N50A7VUZxmLI9/dxLg/NMt
	JcJm7ugOk8kmV06nyVccMGxTV60S3sDYEGvnHr8aizTcyCEoaaT8Lr/JHJ7+GPulVD3ahVKN6K7
	h+GGWkDQFUTlvymoyFPQbdRd9QepbvinBb4acUp3qX3X63G2YtZ1xvTmFY/As2eb8d/y2IJT6me
	miaBqqpO5ufe2uDak8IO/ZpYN8QQl6vr2kcIY4MZNXWvXNBSTfsecIyR7kD+JVraby9KUDoAUhe
	LelWhcjGCH94HxxZJLx48YmSisOk9e+c0/mtIttFsRlh+GlortTCxPIcZ0S2XiKcIAwO1rvi/Ks
	1goqHzFWxseRAQzztTzJ5FXEJFdYs=
X-Google-Smtp-Source: AGHT+IEdfHstPGMT6ATeY0hKxefvApt5zTTLtNMGQ/uAsE433oloJwXugl3AYp0K+M5u6nZD6O0mTQ==
X-Received: by 2002:a05:6512:3c89:b0:594:34c7:cb6c with SMTP id 2adb3069b0e04-5969ea1b9e4mr9365995e87.15.1764255917737;
        Thu, 27 Nov 2025 07:05:17 -0800 (PST)
Received: from cherrypc.astracloud.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-596bf8b0ea7sm463504e87.42.2025.11.27.07.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 07:05:17 -0800 (PST)
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
Subject: [PATCH 6.1] ksmbd: fix use-after-free in session logoff
Date: Thu, 27 Nov 2025 18:05:10 +0300
Message-ID: <20251127150512.106552-1-nkalashnikov@astralinux.ru>
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
index d2dca5d2f17c..f72ef3fe4968 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2252,10 +2252,6 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	sess->state = SMB2_SESSION_EXPIRED;
 	up_write(&conn->session_lock);
 
-	if (sess->user) {
-		ksmbd_free_user(sess->user);
-		sess->user = NULL;
-	}
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_NEGOTIATE);
 
 	rsp->StructureSize = cpu_to_le16(4);
-- 
2.39.2


