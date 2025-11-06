Return-Path: <stable+bounces-192573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA27C394E8
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 07:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 899C14E3588
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 06:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B841027510B;
	Thu,  6 Nov 2025 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hymehJ8d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C22745C
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412300; cv=none; b=TylrF3VQa1MoVt8/cC8OJIiyT9q40rJuseQtnAPE3e4v17HIt0RNB+JLUoq+sdfrp8CP+QU1hiqhm12VO3eEGf+Ply28oM6Do1qYn5fmM7s3kAAkWPZrjwd2JPh1JiH5lCgGAwcTcwULzpD6a8mSYcSYgn2C7Rtezp1zVAs9s6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412300; c=relaxed/simple;
	bh=3USn+kAKMYwPb5j0sZCxRjClOwX15xPhtud3sUz3LSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pxmK+hNevsZwk43neFTMOwvI03noslhCBZTfMjWasonvUCoC8itt0Vlp9Kc6Q+md0uQNt8/ITFVJ8UhnES9ghV0wiSEEcAjLkyV6U1excZQRb5ck93LvNAXVaoO506svvYSklb0NVM3toHzAMQ9+xYyNoQbPQP+GL+JkfDltwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hymehJ8d; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340299fd35aso82799a91.1
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 22:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762412298; x=1763017098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkT3tsOZsMZ2+dYyU7EN69OYqrA2oFR+3YWlk36uRQo=;
        b=hymehJ8dpblQda1a2LtR7j75brDh4th8OHJceoKb3SDzOW2NmIXcrOXxDyyDXe6b3O
         6Q0HjEAY4jIcXt1RkyaQLRA/Msvt/KghIBKx8nl+/noxkTdY7TMeL9qxUy6V8AHOXJpO
         LUJxD5zHq7WIVjF9TkoHi2CF1gJBT6gkLzQJikh8jHofEhDSyfVkhvlo53JmbA47rynt
         /pkPLBVZC4BGe7DXo+DQzuKIFkCloZ5W8QIDMnZpdePR/CO1x3Ap5yjlnPBTjxZHeHkx
         AUSwKZGt3L85kK/B7OQL4dkHzOStjuf45LCxxGNIOafXaUzX4rvvYXdfdNdMubCMwPT0
         /Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762412298; x=1763017098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkT3tsOZsMZ2+dYyU7EN69OYqrA2oFR+3YWlk36uRQo=;
        b=uvufzqdYAVI/WAR5rrOVMi+Zf/hItPO8dwwNQlLgHQmTEMTzO3MGZZ2rFaIA4d8aFr
         hRpkJYE7woUvMyDZUoFLdj/xfyG0f/eZSwUhy5MTqZWanTXaUlbtZCJWmyfaxKmhli13
         O+mnxncjRKN7yjuLoS7yphRH4CTSgZX3HOHamhwN3nEvni/4nM+7sURh/xsGiL9610hU
         bZg6AGfRaYPgvyBtQONckp4hVlW1TMDq6y8x22fcusveI8l48FWZ/LaVRm3C7lH4fz8i
         LReEs0SriRiSvi2r8NO8A/wz3jeoyVVgmQS4MiAr2ujowlnk00C5zYLdzdbHq2XOWRby
         QDuA==
X-Forwarded-Encrypted: i=1; AJvYcCX7+HEb6hq4FeSKzCbhw9o+huXQeaV6km6wmEcsXlcXZqv5uN+NaYHcGYY5Aqfr+fpFZ2bCCXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwReYw5SDNpGoE6SIq655G4TSbPTWlmezPD2F/WMxdLqxe4WM
	YmyzUBmj+c6PS4JTGMFNdBwrewT32t7X0TYgK9QxNt87sm2ja/+rOzOb
X-Gm-Gg: ASbGncsUcqb1oQHEL9ksoyyx1pkb0bCvYnHvJUlprjdpN6EbT1vwp69joMMGv7m4c+3
	9Mu6Zl6UlIoJTC0J88TdWkOeO/EArgwHq3l3BkqvzFuP46RCsOKuEWL38+4OOvFRmEu3GruZE3q
	v9KAFgVyAsnpJ8ikPbJ03pSto2HUYakI7tDK1aae3v+AURHptHTx1U2vMubXIi3OnOkT8QVQM39
	HO8wrbgKjqsHNG2V7hbhf1egVDqnzfa2KuNqZJdgS579BADlAqK7EvtoUcYlEtf66fjXV2q2b0c
	OREX26ZCeNHAgPcwV+nXiA00wOgVUa2/1s2hk8F06XjgNUX3hHPl0GnJM76OwDuv/MBYUbljETp
	djXeIZ3mz0HvIA2xZB3Qlk2ZKrXjHhjAiL48RlW/EmljhY6eYpYPK9Nrjpc2evXcF2sut/2X2sZ
	Z64dVg4tYLuw8W+Hjc8x/HCvBTGHTAvFG1dBhF6+AhppBurKhPE6MKRssOv3pQ6DqeWf95anvy
X-Google-Smtp-Source: AGHT+IErOrBaCNdpSi7aBofzbjzItcvk/RGTQTtnd70szwBznVi23Y1OUlurbOHADjEnQEG0jggTrw==
X-Received: by 2002:a17:90b:1e0f:b0:341:abd4:b9f5 with SMTP id 98e67ed59e1d1-341abd4c08emr4244793a91.6.1762412298444;
        Wed, 05 Nov 2025 22:58:18 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d3e0b0b2sm702504a91.21.2025.11.05.22.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 22:58:17 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org
Cc: Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	Zhitong Liu <liuzhitong1993@gmail.com>
Subject: [PATCH v2] ksmbd: clear 'encrypted' on encrypt_resp() failure to send plaintext error
Date: Thu,  6 Nov 2025 15:58:04 +0900
Message-Id: <20251106065804.363242-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104141214.345175-1-pioooooooooip@gmail.com>
References: <20251104141214.345175-1-pioooooooooip@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When encrypt_resp() fails in the send path, we set STATUS_DATA_ERROR but
leave work->encrypted true. The send path then still assumes a valid
transform buffer and tries to build/send an encrypted reply.

Clear work->encrypted on failure to force a plaintext error reply.
The transform buffer (if allocated) is released by ksmbd_free_work_struct(),
so no explicit kvfree(tr_buf) is needed.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>

---
v2:
  - Drop explicit kvfree(tr_buf); it is freed in ksmbd_free_work_struct().
  - Keep only 'work->encrypted = false' and update the commit message.

 fs/smb/server/server.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 40420544c..a7444a78f 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -244,8 +244,10 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	if (work->sess && work->sess->enc && work->encrypted &&
 	    conn->ops->encrypt_resp) {
 		rc = conn->ops->encrypt_resp(work);
-		if (rc < 0)
+		if (rc < 0) {
 			conn->ops->set_rsp_status(work, STATUS_DATA_ERROR);
+			work->encrypted = false;
+		}
 	}
 	if (work->sess)
 		ksmbd_user_session_put(work->sess);
-- 
2.34.1


