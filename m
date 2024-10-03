Return-Path: <stable+bounces-80618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E998E7FC
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 03:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE1C1C225CC
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 01:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76310A0C;
	Thu,  3 Oct 2024 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b="QZdyDH+Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EC8C0B
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 01:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727917524; cv=none; b=Z1MjfRHng4CoUjtDluOaSblvusZFvWty9gqLNLsnGGAwk7XlhxgJQ92YfVK+T6kfhyDKsLYkhqjI8RZn3ifcLr0qCgjeN/Eu4B73s0hXHbbZ26Vz+ojkRmoXedkSWMIJsqJjiRyk4bDzqQd7xzHKz+Dyx67s3TSulyEdpgDHZOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727917524; c=relaxed/simple;
	bh=8m0LTNxY8OvkDg1Sq4Qwbt1zzAxA2+w9iBXhwVsgBnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eapK96Zo+TfFJgdUlXbl0xcjcEbOq5iyBKW6/Zt/0houGAdtsauABMQRGgJVTMruSOYuKNK6gPAzm+QfWCFoYD8oQTZ4nOzdop14sDoIqxrrKePx2lOCLwMVA0deMBFqLkd+D7ohdF5mnln8PXfZxwBpOUdjLDSMUfoPzZAbPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com; spf=none smtp.mailfrom=batbytes.com; dkim=pass (2048-bit key) header.d=batbytes-com.20230601.gappssmtp.com header.i=@batbytes-com.20230601.gappssmtp.com header.b=QZdyDH+Y; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=batbytes.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=batbytes.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99fde9f1dso36941185a.2
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=batbytes-com.20230601.gappssmtp.com; s=20230601; t=1727917521; x=1728522321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QzuPQdSMxP55/NS7Cyi/Z68z6m9/+JyCS/Py90nZCwo=;
        b=QZdyDH+YPUfHhfzN3+10kZbC1/IWpArqNswUwmaCwZhcbVaYU0153Zssn0s10ulX+L
         /cb44IYj88wK2uaxxEt4cRB9Bfxzmmq9uJKLZdbT8atsR9VJiwc+2j0+VKeuVttG9sNe
         he/IQlb+du7OerKQ+JA286ANeSWtq9PPuN/34QjbyrI2XP6/0HpgUnS8thi3nlGHkg6Y
         6XEhZUdBsxEVzH2zk5zWzLB9Sh+2eYTFguwmkFG9Lk8BoXbmZYjUrI1bqaezWRTE0tqg
         uCzzVuqzXDVaforoSGZyl4IfOE+nFFnu2rhEQs2/T4x2WzVci3dNsJNinkUmfSAL9Inr
         Ihcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727917521; x=1728522321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzuPQdSMxP55/NS7Cyi/Z68z6m9/+JyCS/Py90nZCwo=;
        b=ZpgHl0Xgd1VWz5rQrkcxvQ6QLaC674+JbR8emFaR24OpHfZFY8L5Oin+dIXE/lEGb7
         5+pad8G+xnoYU+QyccLrNpR++XS74Gop4LjwUjC91hZ2XTkln5iY5eTDi/os++Kt6vMl
         oaX4MuWy+PcY89Y4ZKR9p+S0Jj2g6BefAIMkgiHXE2Bwj2zfqxuYPQU+n/S5dZ807nIc
         zdlTJdzIKrdt/yi1pmQA2CKUfDiFSBCswBwdpPhCEMVThzoSTJwJ1u1t03TsNudz7Ul4
         5KyWVdkjPZrG7n7bkbOIOVyLYbqgc9AGjx3GFfFDYini4Gtf0d73qWlMKnQqpNPcB3mR
         9jmw==
X-Forwarded-Encrypted: i=1; AJvYcCUr+oMXuX4tChHXxSyJ7Ygxa3Y4i5igExqaMTTsipZsPmVWRFJtX+/aPiccCgCEv3aKxNpdOj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVJ6G4Ogo91ZcDbxIEeJTZcUUl5Z9foEvFayUDcmC/7OIuGL7R
	4K5sLb/NFhP3G4kGgiuYfVLSsbX6MKyG48Upt2W89DZIVnWirIuClanCZtRw3w==
X-Google-Smtp-Source: AGHT+IEsoNF2uAO82nL0/Xt/GYIxP2Odx0PPROHsghTNIyVjiLKqEKD6E0G2RbxTjvG7xMtEpDm7Hw==
X-Received: by 2002:a05:620a:28c9:b0:79e:f9c8:a22a with SMTP id af79cd13be357-7ae626b1a87mr661471685a.12.1727917521357;
        Wed, 02 Oct 2024 18:05:21 -0700 (PDT)
Received: from batbytes.com ([216.212.123.7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b04473asm774585a.53.2024.10.02.18.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:05:20 -0700 (PDT)
From: Patrick Donnelly <batrick@batbytes.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>,
	stable@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: fix cap ref leak via netfs init_request
Date: Wed,  2 Oct 2024 21:05:12 -0400
Message-ID: <20241003010512.58559-1-batrick@batbytes.com>
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

Approximately, a series of changes to this code by the three commits cited
below resulted in subtle resource cleanup to be missed. The main culprit is the
change in error handling in 2d31604 which meant that a failure in init_request
would no longer cause cleanup to be called. That would prevent the
ceph_put_cap_refs which would cleanup the leaked cap ref.

Closes: https://tracker.ceph.com/issues/67008
Fixes: 49870056005ca9387e5ee31451991491f99cc45f ("ceph: convert ceph_readpages to ceph_readahead")
Fixes: 2de160417315b8d64455fe03e9bb7d3308ac3281 ("netfs: Change ->init_request() to return an error code")
Fixes: a5c9dc4451394b2854493944dcc0ff71af9705a3 ("ceph: Make ceph_init_request() check caps on readahead")
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


