Return-Path: <stable+bounces-166987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4735DB1FEB8
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 07:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAC03BB1B8
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 05:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF92701C0;
	Mon, 11 Aug 2025 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F82pI7jk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE226B2D3
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890828; cv=none; b=ECgoQK1pufz8AoqTnrRR5pPX+PBi/aWG5W1LeuBepLHOR3bBct/o3IQKkoyFwjY5w1cflo8YCLMvV4sEprp0aGHg15maPD4SZENgiZzrsmXmUc1Ap8c9M93A7yL5/I2oRkAZR2DCJOEu7DAAYz1eKIDlyCM8fGIRHBWWpMTtN9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890828; c=relaxed/simple;
	bh=zrVBUNxxZqstsRJDYJz90CxtD6sPPVd06a6UywvSNv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uy3osGCiy3Dj80nX6stg7ao9Gv+CRHBMRD8ZijUTCwT2JscMYNWwbvAVLKG7QYs1TlvIw+Nqa6F7JZDH5PKW1mZNZUIvbKS+PF6HjhiNGrNIWwsu2zR5wnR/j1gDix8hXXgArpryZAs3QZWgk7Uh9Y9xW63xNjOOzcDRTkgneUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F82pI7jk; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-433f787057eso2175025b6e.2
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890826; x=1755495626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5Tm8MncGgTzffuubiEuxBs0xK5k7TEVaXhLTBjgDNo=;
        b=EI2XE1XWRtH26bBjbk3yenIj7n42kSjidJNagwExy1iWn8a0VENFSluVGYZs24dWPy
         yWWaQjc3aJTGg2XTMVGpPw745ZvvN+GagI8bF5p2ugAsHtCJdqF0WcC2z1xI/qe6IXzb
         8d00WRRXdAc4VzActWR5R8dKaWgeu3s39z6rKYDk9InidEH3JtXrKKzaNzDsErt3oB4q
         9hjGeBxOYFWql2zWYM/m7nAPFojBwff5AatrLmo7tIs2m0SLEDf2TBl+1UdPJkLDGy4S
         gXFdb1LA9EmXbJtKgSifuUNhUeVErRVYOXM7xoKbVhg+cS0P3RbnPAhL9EdQpUSSIP/Y
         8zdg==
X-Gm-Message-State: AOJu0YyxxmHOxTGzoMDYA2XJOjOO8OCESi3NY8Z40LT+whappBEDhC10
	4mgvS7KYly/I6xQ2isiN0VtiyJafs5SMXlTI89Xbu4VO5CTBLYTonDj2sxe9RErsW8OkRD3Dh3r
	S6Q0Rjf5sQxnMeIJKH+SCY/dYQ0LnWTQbuco2QSbj5EYnXG61Ly1PddYNd4FElcZMme8h0YXE3w
	qtFJ9dtew2EyJ9QpVFlOd9MWMs/E2RBb1p763wKFZCmTFquo4FnIFUe1Myh81DEnfIt//5/VBaB
	EJh0AdpbLn8s059sA==
X-Gm-Gg: ASbGncv9iDqDP6ViilXTydDJywPASpMQ//I3e+27v+HuK/oMd5A+oVjxhnF5nUjgbbe
	6IHb9vcMz4VM2ylDDlf8yZF9YpeOblq1LPkXW6UQuoonw10rjHzf87l59K5LdTI2ALMPRZAJyKK
	gAgIVxg1Ec4yb0BdFvTS6KIiIBu4LKqnour5cWlB2hg4YL46hH6McH3pr3pUtgeZhYQEJl/FDwX
	cQlup2SyB6iKRqqZG6c9c9pcQxQJcOMaYRSzu9aDknf7RAbRHgh41uN1pSPmN+83VsjBWrpDN7G
	yM7Yd5QTzOpc+n66iWNDHOkbDZ516cuPxSSr/fUlvehvXVufdvKXeFSVfVehZNkxXWNOVzmd5Nn
	hmvYVhNZkv0m8m5JSBPSjh9tSg3NwnGFo7AKzOVjNRUyRwU6BhBjtNAx3w7/9lic83lGbK3J1Gm
	P8StDCdw==
X-Google-Smtp-Source: AGHT+IFzqk4AMZoOVtSTMA4KuOioSr04SL9y15yZBxnTCMMw4gQN+i1waxtc/ODzUG+SfEmAsHkIg9Vjxgbt
X-Received: by 2002:a05:6808:bc2:b0:434:15b9:deab with SMTP id 5614622812f47-43597d1cf03mr6436761b6e.18.1754890826166;
        Sun, 10 Aug 2025 22:40:26 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-30b8d7354b4sm1543358fac.11.2025.08.10.22.40.24
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:40:26 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-7073cc86450so73185286d6.2
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890824; x=1755495624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5Tm8MncGgTzffuubiEuxBs0xK5k7TEVaXhLTBjgDNo=;
        b=F82pI7jk8lD4NyfKNvSsguHbcaQT0cCrlwl83gnk0sVUmnbx2SCTZckCKnNV3dwvRr
         /lVZL2HahkU98tkNtBiU9N07q45LS3K3xB6JeTq8EvZymQMwo0bPrSu/mqwAfTLySTKh
         iNNbB3MANbNDLsCeHkVTJxSf5KSZn9klMXNDY=
X-Received: by 2002:a05:6214:528d:b0:706:ff82:a3c8 with SMTP id 6a1803df08f44-7099a1cf2b2mr155458616d6.5.1754890823929;
        Sun, 10 Aug 2025 22:40:23 -0700 (PDT)
X-Received: by 2002:a05:6214:528d:b0:706:ff82:a3c8 with SMTP id 6a1803df08f44-7099a1cf2b2mr155458396d6.5.1754890823367;
        Sun, 10 Aug 2025 22:40:23 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce44849sm150544766d6.84.2025.08.10.22.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:40:22 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 0/2 v5.10] Fix CVE-2021-47498
Date: Sun, 10 Aug 2025 22:27:00 -0700
Message-Id: <20250811052702.145189-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

 To Fix CVE-2021-47498 b4459b11e840 is required, but it has a dependency
 on e2118b3c3d94 ("rearrange core declarations for extended use
 from dm-zone.c"). Therefore backported both patches for v5.10.

Thanks,
Shivani

Shivani Agarwal (2):
  dm: rearrange core declarations for extended use from dm-zone.c
  dm rq: don't queue request to blk-mq during DM suspend

 drivers/md/dm-core.h | 52 ++++++++++++++++++++++++++++++++++++++
 drivers/md/dm-rq.c   |  8 ++++++
 drivers/md/dm.c      | 59 ++++++--------------------------------------
 3 files changed, 67 insertions(+), 52 deletions(-)

-- 
2.40.4


