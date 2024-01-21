Return-Path: <stable+bounces-12327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38098835611
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 15:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28296B2218B
	for <lists+stable@lfdr.de>; Sun, 21 Jan 2024 14:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837F34CDE;
	Sun, 21 Jan 2024 14:31:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044C33CE6
	for <stable@vger.kernel.org>; Sun, 21 Jan 2024 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705847468; cv=none; b=SrBGXIOWOE7PY9G+yW9QCOsSiXodbQrllRFq6SqrGD4t2wjBkAeOLcXRX1wpHM79cJuU5vl3pLIGJ890KS4n3rfpv1Sk48PEy5c7T+tjIju2fSato6Z1Mo4986Y7ieLdbmpa4hpfiRzoxHHGZ00/rE2/ZSlNqx6ozKRUqFFZwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705847468; c=relaxed/simple;
	bh=tci0/bAYJ783bV0ukcWycEQq0l1yE28T8qdbCsEOh5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DsTfvXoC53uxIOmsNvBXIMGtC6pTwoCeGCYHEBGbirXzoaCQuk6v1ZOTy9IpDODm7Sn0U4n14bxkDSwOo5g0HQlWdShgFMiOEtoXlX/F5t3m/Xd4lQ+Q1PHxGSK9eGfU5hUrvHwwXL93ci+tClCHR6g0cC+RY88kLiy3IzK64qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d6fbaaec91so18932815ad.3
        for <stable@vger.kernel.org>; Sun, 21 Jan 2024 06:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705847466; x=1706452266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKLCMedeLceETvCq545+M9jMOmnK/t+cONrmAyE1juk=;
        b=vie3W/KUW9PQt9NyHKkc1/c0REYFPtx19T0asLoKRATZqPJI6H0QoqSBLT7pazh6Uz
         E4TLByI+UAb+bkCVK7kQkEbocVj0mPhtyjgiFyQ7wpqqNYEBUC5B/s2fsbnkvny2sMD2
         NuNeVK2tGEElhzdyfVQk9ccMYzT5Zlj66N6ym+wHZkY3v7BaNi5NqOe6fzO5lKyX6Bym
         a4jgJjojyYtI9dnHi85ktdfrkxyWbehClEv5x5nHBK1aF/RlHu5Vq4aHsiWPVg20tFEA
         BzUQHT9gLg4myABoyNdFhb1bNlglAKAvjJImnloYu1VNcF9WokJxVGsATGDAtGHvcUWJ
         daWw==
X-Gm-Message-State: AOJu0Yx8hmYHuhKvlG+dN+gJIUzyf1qxKJl4lyNI7kPrhbHfBSbQc1QE
	bcdelasH1wPz3tilTUa5GrrB5YjwRY/o5jz6q+MNiHECWyQghr6s
X-Google-Smtp-Source: AGHT+IHkg2c7q5wt3E4oM+34kMdsAqglft3A6FoIqITMybyvXi8pr90MPiSaNok2TvdEnk2BwjHA/w==
X-Received: by 2002:a17:902:8bc8:b0:1d4:e070:73c with SMTP id r8-20020a1709028bc800b001d4e070073cmr3007768plo.3.1705847466381;
        Sun, 21 Jan 2024 06:31:06 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903014b00b001d5dd98bf12sm5831027plc.49.2024.01.21.06.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 06:31:05 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: stable@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Tom Talpey <tom@talpey.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 02/11] ksmbd: set v2 lease version on lease upgrade
Date: Sun, 21 Jan 2024 23:30:29 +0900
Message-Id: <20240121143038.10589-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240121143038.10589-1-linkinjeon@kernel.org>
References: <20240121143038.10589-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit bb05367a66a9990d2c561282f5620bb1dbe40c28 ]

If file opened with v2 lease is upgraded with v1 lease, smb server
should response v2 lease create context to client.
This patch fix smb2.lease.v2_epoch2 test failure.

This test case assumes the following scenario:
 1. smb2 create with v2 lease(R, LEASE1 key)
 2. smb server return smb2 create response with v2 lease context(R,
LEASE1 key, epoch + 1)
 3. smb2 create with v1 lease(RH, LEASE1 key)
 4. smb server return smb2 create response with v2 lease context(RH,
LEASE1 key, epoch + 2)

i.e. If same client(same lease key) try to open a file that is being
opened with v2 lease with v1 lease, smb server should return v2 lease.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Tom Talpey <tom@talpey.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/oplock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index 2da256259722..f8a2efa2dae7 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -1036,6 +1036,7 @@ static void copy_lease(struct oplock_info *op1, struct oplock_info *op2)
 	lease2->duration = lease1->duration;
 	lease2->flags = lease1->flags;
 	lease2->epoch = lease1->epoch++;
+	lease2->version = lease1->version;
 }
 
 static int add_lease_global_list(struct oplock_info *opinfo)
-- 
2.25.1


