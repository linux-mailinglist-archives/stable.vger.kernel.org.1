Return-Path: <stable+bounces-107868-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC602A04524
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 16:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE0F3A197F
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885FC33993;
	Tue,  7 Jan 2025 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPaofSPQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE932594AB
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736265033; cv=none; b=auHpDfJ9ScEdz8gEejj0yEh7gl9s2Rh8qrCvoSWaF9dL/H0Be/kU8icaq2Abmnagc/BbcBqJI00tGhtazXdiyQzGuMycxUqSg3chvdxu/zBejw+WTC8EyWkK7PRWfZ3ZX7mS+wcHcozk2+jZ+Qv8ETgP6Q4G0BEsTfayTs+jiZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736265033; c=relaxed/simple;
	bh=80YpzQVau2iHsJbM/3HxC55tVhLcSIdIG9IUCjqWvis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dO92+1IlXsI4UfPM74H0GC/mAoc+I4i2cT9sihMuvWT8G1YWnLDUAQgJD1+4OqRMXoMg13/BYT6X8mTg4NZYI+JBRuneSl+sbhbt6cdBH81dZbXXCt3zP2KgSYXvMuZc0hF+nA4q+6wP3dDaou0/YZ1/NDu0lH63hQVdY3arDCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPaofSPQ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863494591bso8082132f8f.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736265028; x=1736869828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lHe0KygA/Lbfz7umC4cWgOiunml0PiO3u5JU8TrYweU=;
        b=OPaofSPQGDYNy6i9g+tl2ovAVDdJOtbV1YfDRODO/CX3yCRCsxVxqC5jXooNCL+BDW
         q89Yp3bLCKWAwFYoEI8YzvPt+ORYOzk++E4sSvmA3vosL0Woe4QcHgT2tiCwcCsJjObq
         nbI4YqUzyZpCmkbj7yunkC/C1qPs48mPNclyGhDQMOOZmhuIrOjujGblLOruilL32eMq
         qhXUeMa4ZiuyjxnFW7588ATySy/pX6RmAf5c78gS8F8jHu1rEXWngUJN6kVrigT12MTp
         zjGfqhk9xNGz6oKK5Ga9d/2mDSV5mxZriHvyB87IPzXll8bAWCo5NSbBFHN9s/J9Pgi7
         KXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736265028; x=1736869828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lHe0KygA/Lbfz7umC4cWgOiunml0PiO3u5JU8TrYweU=;
        b=uj2w5ge3TZ6HklGSlVXxS2/fHjf2C+2akPTAAl5yMxD563k4+Wq3F2DY18PuUMTe50
         atKLsohXRgRnpv5CewT1jbMJrMDhb0rWl7ho3BCsliBp70EDtIlVmah8bT/kQ6faCmYz
         egTtD7rRxkH1MjnYLYNwMzZKft027mhJSfZYnfpS1HeqoxEQBM6xC92qE5YWfRnikhJf
         RaGDuC1+5CrB6KvG2VnDEVgEBkjOsdZ7ST86/pMr1Oju7zADfaWFvDh+w5kw3vmMF2fP
         TmJ5okCJAJKx3HyYEbZO1awn6Kr13Z/DGfAevL0tDxc28vK1uQeyfpS970wLRep/ijlx
         iLyg==
X-Gm-Message-State: AOJu0Yx5zlt8wS/WucvFdn4icgIxYft2/vt166ti6CE+hzkz+g7166SD
	4XMTqun91BODXi4J1WnjSMmboh8zlPkC1EScfcsUCaKjiltfqRv97DQ1Dg==
X-Gm-Gg: ASbGnct+pPHAcc6M2JkODfCeDPK9CZ7AvpQe5cs0ANEvzIDGGR1+AE6s5L7pSUdCZ5J
	6vsKo/grIUB+nEdeeUps2vvrGvDViBVLm8lop9BcAOAiw06Rfgqscvd220LcPt0JB8ruuqxtsDu
	hHPOv72nbfZ0VL+pLPNUj23R23jXVWr5u3KC+z7a/3HGb+pmtrmXGZkiI3XtBzEBMiG7jT9csYM
	WSK5QfH+x25Yj7ky6xfOff/1/RrllR/KsgzyxAz6jXjaaAqtBn5w9CbAOv2sCYF+TSxfeFIn5cd
	tTLS/30T7ubD2wBGU+Fh2SZX
X-Google-Smtp-Source: AGHT+IHswZ5PunMRRmfg6wntLNnqMGbJQjQG8Ygalpb3cyfEetK8aX7XGb99yhCFW+NnRNXjziZKDQ==
X-Received: by 2002:a05:6000:1785:b0:386:930:fad4 with SMTP id ffacd0b85a97d-38a221fab43mr53564815f8f.19.1736265027739;
        Tue, 07 Jan 2025 07:50:27 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e8asm50015640f8f.37.2025.01.07.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 07:50:27 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: stable@vger.kernel.org
Cc: patches@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6] ceph: give up on paths longer than PATH_MAX
Date: Tue,  7 Jan 2025 16:50:08 +0100
Message-ID: <20250107155010.2658845-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

commit 550f7ca98ee028a606aa75705a7e77b1bd11720f upstream.

If the full path to be built by ceph_mdsc_build_path() happens to be
longer than PATH_MAX, then this function will enter an endless (retry)
loop, effectively blocking the whole task.  Most of the machine
becomes unusable, making this a very simple and effective DoS
vulnerability.

I cannot imagine why this retry was ever implemented, but it seems
rather useless and harmful to me.  Let's remove it and fail with
ENAMETOOLONG instead.

Cc: stable@vger.kernel.org
Reported-by: Dario Weißer <dario@cure53.de>
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[idryomov@gmail.com: backport to 6.6: pr_warn() is still in use]
---
 fs/ceph/mds_client.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 11289ce8a8cc..dfa1b3c82b53 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2713,12 +2713,11 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 
 	if (pos < 0) {
 		/*
-		 * A rename didn't occur, but somehow we didn't end up where
-		 * we thought we would. Throw a warning and try again.
+		 * The path is longer than PATH_MAX and this function
+		 * cannot ever succeed.  Creating paths that long is
+		 * possible with Ceph, but Linux cannot use them.
 		 */
-		pr_warn("build_path did not end path lookup where expected (pos = %d)\n",
-			pos);
-		goto retry;
+		return ERR_PTR(-ENAMETOOLONG);
 	}
 
 	*pbase = base;
-- 
2.46.1


