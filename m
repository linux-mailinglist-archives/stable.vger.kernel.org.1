Return-Path: <stable+bounces-80602-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE098E3C3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 21:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A6F283F6A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 19:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EC7216A0D;
	Wed,  2 Oct 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="xeao0JIc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3286A216A06
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 19:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899091; cv=none; b=fG4TQZsjA8PBdjEOPWse3SqfyxucR80wKniUibPMrKfdk5T5kyenSWIjPdTxiu8HD2aLStpZ2uWA3leGdb+UCk7+RYBNAvgnBKTuLDguYOyoR/M3+/regpMIjwIpjwldAAKBnFQ+8qXTb7lL3cmO8BUa/O5RCz5ZrWpKR1help0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899091; c=relaxed/simple;
	bh=FZvT0DvIN6rDZY2K7NeI70Si1D2y6eDzt439Y+VYuo0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FL7AbxNBtu7pj0RAnNJ98xUc4GfJa3yLQ5srghp+fKIZQU44z5YnSRmba+zZ6bpwnNc0DJkraUc5snU+JOiI5rSaKW8w6scMWOvWBC03aB5XMnZL710tPeunL53uK40oBe+iL/Z/NbHa2YoMS7LJ+iKYgz8zu9X1O+QZJkxeY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=xeao0JIc; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7a9ac2d50ffso22396785a.1
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1727899089; x=1728503889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKBi/49Hk49zeYze675qyaPFtzkiIePzc8OgUXDE7Hs=;
        b=xeao0JIcNIb2vNFKiAVdSrr0VWcFMvOBAAhmYeep6keXojicON5Scy0Kq0GibTwTM8
         0Jfy+zB7tKPlN4KQJxCpsqGp4bAgERniuEHH0AcvN/PobX+saukP38U2g5DNqYyCJhkA
         +ru/l8jQYJV3PZ/ujo2XuH2C3F3kaTUfmLZ8j7yuyWn6wYqSPG8aRVBvzVjkWII9Vq4N
         Ly6g+T7T/MLSOBHwCiJuHsiDqCGzypaf76GnEgO1ycZaWXiwFXFew1B5/6FbScZ1J5ag
         LwNiGIt70udr36IBjh2WFOmcMg4BPqZBkuU0xn0txlPi17AjahaQpEObsfHfaUvsP5um
         mRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727899089; x=1728503889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKBi/49Hk49zeYze675qyaPFtzkiIePzc8OgUXDE7Hs=;
        b=GKRzksbSMrV9D1pcbdwiu+ub4LZGFU6nGVhF2WB98GHJ2BFjkZOGzU9WIToK68vQtJ
         ZZRlw4QrOyLguUhiiWjOyhSFs8vEHFEq/EuYx4b8+AjcvnAGNbX3oxoVHDfyae3DJxHL
         yjcT7hISdp606BDsJfH5WR+zgvjZjS5/pB5x5JJ0TpEQFD7ZCNMzFbZRQ3ifmsDc/Pfj
         h7dAhJvcRXbD7qJy+2EvuOY65RsgZiq67UnKUN+/Hi56dG/Fx3MSk6L6xg643OVwmJ9u
         yF14nCnFwjzF3FL/Sf5UpPRy3yRIZdSLy6GgIUWPoNU/tzuQOlRdW9zSD7Yze8HPEdht
         YSjQ==
X-Gm-Message-State: AOJu0Yx2nuoOKlI9uvG4X3mtnKJurGKsFeMhm+WnkJDh11LVqoNYZYIf
	QBjEf7VDv5hBM5PIvibJIkuskh05/FvOGn5uh6Syg9RC35GZ82NFhZIQiLvlUld6HeXyqqpDwBc
	=
X-Google-Smtp-Source: AGHT+IHVaW520RJeIfp96qMB5eHpsFf/CYFR8dZlqKcX1ELRzDMCPMHKWWbYHv4LhcjpXEQ4Kv5leg==
X-Received: by 2002:a05:620a:462c:b0:7a9:a356:a5dd with SMTP id af79cd13be357-7ae67e479femr149663785a.20.1727899088963;
        Wed, 02 Oct 2024 12:58:08 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377bc91asm651102085a.25.2024.10.02.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 12:58:08 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: pdonnell@redhat.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ceph: fix cap ref leak via netfs init_request
Date: Wed,  2 Oct 2024 15:58:02 -0400
Message-ID: <20241002195806.33220-1-batrick@batbytes.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Donnelly <pdonnell@redhat.com>

Log recovered from a user's cluster:

    <7>[ 5413.970692] ceph:  get_cap_refs 00000000958c114b ret 1 got Fr
    <7>[ 5413.970695] ceph:  start_read 00000000958c114b, no cache cap
    ...
    <7>[ 5473.934609] ceph:   my wanted = Fr, used = Fr, dirty -
    <7>[ 5473.934616] ceph:  revocation: pAsLsXsFr -> pAsLsXs (revoking Fr)
    <7>[ 5473.934632] ceph:  __ceph_caps_issued 00000000958c114b cap 00000000f7784259 issued pAsLsXs
    <7>[ 5473.934638] ceph:  check_caps 10000000e68.fffffffffffffffe file_want - used Fr dirty - flushing - issued pAsLsXs revoking Fr retain pAsLsXsFsr  AUTHONLY NOINVAL FLUSH_FORCE

The MDS subsequently complains that the kernel client is late releasing caps.

Closes: https://tracker.ceph.com/issues/67008
Fixes: 2504470854f8 ("ceph: Make ceph_init_request() check caps on readahead")
Signed-off-by: Patrick Donnelly <pdonnell@redhat.com>
Cc: stable@vger.kernel.org
---
 fs/ceph/addr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 53fef258c2bc..702c6a730b70 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -489,8 +489,11 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	rreq->io_streams[0].sreq_max_len = fsc->mount_options->rsize;
 
 out:
-	if (ret < 0)
+	if (ret < 0) {
+		if (got)
+			ceph_put_cap_refs(ceph_inode(inode), got);
 		kfree(priv);
+	}
 
 	return ret;
 }

base-commit: e32cde8d2bd7d251a8f9b434143977ddf13dcec6
-- 
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


