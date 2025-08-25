Return-Path: <stable+bounces-172768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85983B33396
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 03:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D9718808B6
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 01:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C0C225A29;
	Mon, 25 Aug 2025 01:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hk8rWh8U"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBB220F5A;
	Mon, 25 Aug 2025 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085670; cv=none; b=pCQxkzulXqozrfpa40QwyLwWYJYKgjRPSzMC560IQyibhpusC3kF2ARZAT1sOAiCi9bWEkWSBo2whgotfJD+HsC3J9YshMFyaTYi+K/d40LgGdIYeLFyyl5ZK8W4DYisCauW09DSj5Hs6U7eUfUe5Bi9ECH0cadB7rRkcANgvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085670; c=relaxed/simple;
	bh=ukUAJsWaQ4bxugymtKelkvQhqSXA8oyveHJ2nHM0Ays=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/ZPsFH1lIWLg7WRlhdL6LHaf1uX3oiXNTJQo8BM90+c1x4d6ODUFdZqpUlFtSRklrG/4puZC0YLA/Zz5lqqqJHS0MBwqYk2m/ZCpuM/m4VZYTzpsRiAFkaUVqHWWjXolu4Wb58MnEu31dS+fj0tuycJtrbstYZ2quCKs0UO1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hk8rWh8U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3413471a12.3;
        Sun, 24 Aug 2025 18:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756085668; x=1756690468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkTHcDw+15jLqpjUkSNwi/I5M5nWONRiouVZuKjTmL0=;
        b=hk8rWh8Uxvc3Q6Til2T9AAatrgIuLfiEsOPe3OyAZ7KSqu/yLiKmm5YmDD3U6nfM1c
         EYS1juCWwJv4MjymgPAAT6CL9av1rWY10OumSg2N999hhD55Ez6ZNc2yYSrzrLHFSHbp
         RLC09ha8d89HO8evhpM0bTOKeAja1HbWGX6c4FYYmc3d1kJAEOYNjEKKFtixC2WtrqNh
         EFCxgPRVLJBPIXoDzoMndWL7Eo0WEax0ThIehHhhJTmIRTWIo5N55VuDwOPyaiYA+cP+
         5QFIJXex0kcGFxYfHY7uh3tZ/Q+uy2FxLq/DM4UV8LjrWXyjVC7DbBRnLIefzJn8uykR
         cIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756085668; x=1756690468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkTHcDw+15jLqpjUkSNwi/I5M5nWONRiouVZuKjTmL0=;
        b=pjk6/EOhJjbXEfCMooaGwGsf10aTbBt+ZNphW73NxjSgFLnURLPMX3demK7ke6BUpk
         2ns4sZdyFUZcM7m3cp4IpwYc/nckvFcSraT+gWHTKgMdLeCU3sDccpqOXQndgvbuBk9y
         PUxpVFUCQFZT9DNqaUe4+0RnTWNhUaz4DCazCMIaisph0JONeurIto8e73W3eUpIEv5M
         z0frDfi7EBGR+rwI60ifKPcthkoYGT3BnRD1fvFVV4TTNlcvnRXVlh0I5JIr5+5hJgYZ
         3atosfc1KHZAEJnJpXd1H9pB/YS3SJtMJvMak4d47jrMmwPQHsM3IihP9HxhN447sfAf
         gwSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8L0MX0WHDxkgwa2ISocdi1UvW+bxY9X/5w1tG/0VdYSJXGf3GXjPnHLEErDNyI8pXtZZZ5XMXnUfSK6A=@vger.kernel.org, AJvYcCUAKKYXID3fDLa4HjEdKJHWE6sSFsFC8CHJUeZX3Pe7/qTpcPID+H5LkJDX7gh/5rX8NHomodYl@vger.kernel.org
X-Gm-Message-State: AOJu0YwXdO339GBXY4af6hXVaeEHqhlnot/SxgFeb+tMNXQN6BrDr6O6
	mcJF7ZA7jQF+/ko7VMIyQOBT4Hix1RiAJW1MvoohZtfG5RstSDlSrNo3
X-Gm-Gg: ASbGncuCVGK442P6FYm0j0WmLx4++X6YNXSwwJ+TpdJDyfE0B536XODH7nXRGsxVjCz
	IeJd7C1OLRAJcVv2ySdztVECDTHj/Dc+PEezUpjgqYf+kZZmQrd1Hju0vFLri7pazqLYphEThhi
	ycm/R4addIWU2iLsAB4+3jA9LtXG9wnG0trPaOzB9bXJ1sksyWrekZ53zHUB59w/SUsHx2+SrTl
	83BG5jv90aqgx54uSFkQdmzdiZTNe5BhhtmVNia/GF/1DmRSjofMVIlWnLs2XByZ9gJH3uowSj+
	bU1thYVamQ0WAaIgiOAQhyd1n5aLobuRy8d3SFeruLyOU63O4b25PqIEig+LaF4qxIxTItEGqQa
	LK/P96v2trKUw2a13sOQG0SQ8jLTwOEu8sDiNTn+b6QJpdpcQjyWsP3njq7fxKHs=
X-Google-Smtp-Source: AGHT+IFPavs3Bbx0Gq76QMUc0UeeZlDyoP1050rv1eo9ReYKCveThRPf7S+53lCd/VHSMwZ3zX/UsA==
X-Received: by 2002:a17:902:ecc6:b0:243:38d:b3c5 with SMTP id d9443c01a7336-2462ef1564amr146801935ad.47.1756085668240;
        Sun, 24 Aug 2025 18:34:28 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668880a99sm52425995ad.121.2025.08.24.18.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 18:34:27 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org
Cc: cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com,
	glittao@gmail.com,
	jserv@ccns.ncku.edu.tw,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/slub: Fix cmp_loc_by_count() to return 0 when counts are equal
Date: Mon, 25 Aug 2025 09:34:18 +0800
Message-Id: <20250825013419.240278-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825013419.240278-1-visitorckw@gmail.com>
References: <20250825013419.240278-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comparison function cmp_loc_by_count() used for sorting stack trace
locations in debugfs currently returns -1 if a->count > b->count and 1
otherwise. This breaks the antisymmetry property required by sort(),
because when two counts are equal, both cmp(a, b) and cmp(b, a) return
1.

This can lead to undefined or incorrect ordering results. Fix it by
explicitly returning 0 when the counts are equal, ensuring that the
comparison function follows the expected mathematical properties.

Fixes: 553c0369b3e1 ("mm/slub: sort debugfs output by frequency of stack traces")
Cc: stable@vger.kernel.org
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 30003763d224..c91b3744adbc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -7718,8 +7718,9 @@ static int cmp_loc_by_count(const void *a, const void *b, const void *data)
 
 	if (loc1->count > loc2->count)
 		return -1;
-	else
+	if (loc1->count < loc2->count)
 		return 1;
+	return 0;
 }
 
 static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
-- 
2.34.1


