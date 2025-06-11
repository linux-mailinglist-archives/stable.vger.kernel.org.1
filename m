Return-Path: <stable+bounces-152462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D4DAD608E
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F89A1BC21AE
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF1228850C;
	Wed, 11 Jun 2025 21:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgaagulG"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D74F2BD586
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 21:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749675704; cv=none; b=UWsLbInnQAPRfYY5SDIHoyiDJUmQif4pjk24cURVyj2uwckg6D5HPwLMQPohJ99vXQHJNWQUAlkgSFLMX5hRJNQvH+EOSG2BGP9rbbHYu55kLan9axvUAgk97E6NSc8tqznskYclZny9YLqVpTsRuk4f4m41/Ii7dGnD4Mgd3U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749675704; c=relaxed/simple;
	bh=glhZS0g+8bLtEV1n48mt5ifrRd7yAFYFgsqoE0CexI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYOseV2mBECMEkIrO3lpwJFzJRiUWR/zQL2F3RVNtf6+4mAwskZ/gsXJhenwgVQlT5Plrsi+N02ojoBec1ZYdCZzVh3QFP0kJxNYl7JUw1Bgnq0eF5q+WGXFypyB74griAz5xaZhN5uAEbHxsx+ntbbU8OdF2jnJnchUvji5q1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgaagulG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-236470b2dceso3338785ad.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749675702; x=1750280502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D54ofHFQRuHzljXgqZTu1uz4+soWDfrtlKKCLg59xqA=;
        b=GgaagulGXASB1g5JoQoUMnmcbECGj9hEh3zbBQefrWjfn6dWYMES5EqLlnrQTeGJN0
         ao26b1Y2OIrUVswMRkc9xFzCALF/7ovoRvc1+QAV9GdoF3pjcmNjzPWJ77gfLrXsczff
         +zrWBZoA7dJr1JkLEFc/D1+AUYSuXjR631nzl7O6ygcMVh6HKpwyp72+y8e67SG/RQHS
         bZ9+GPuQTKkdsfhyJyEwGv+RsWz0JTqXJvwL/9s/k6dWTJIoylN9wckKtSZJNuA/lQtq
         3aQk/y9BoyVNsAbU+G5655vuS10x3ze85gSG3lhtp06vdSIAr/KQ/Gkgtn0xvA/rj/gr
         Vs8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749675702; x=1750280502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D54ofHFQRuHzljXgqZTu1uz4+soWDfrtlKKCLg59xqA=;
        b=gW6oJENnylvd448FcbDUqlg74zd2zSjQ7dWigIDRM3YLsjGZ9mfLb9JCSQVPsGQYME
         sFt6lX3vWqihX3dfkpx6duY19kou6FsUmqeXFG1iwmqTpcJ+2iWSd6dFpBf3DCBdrQPq
         pkJA6RANr71ATW5ugzsMUYi8e2fG+9X9UnRAQmx4dQW7m7Y0nsknfZk7FawWtDJpy66C
         ZuGQ52RixB9CIq+tiQ/RK4N7JYxJ3n25M+58R5SkK33KYzOXUPNrPR6WvyLcBLFas8kS
         B2cFJxWSonP9fPhColj9oNDRcolVCB5l97oDtefE0Si47yBui79llk9ohu+I9k9QJSha
         v9NQ==
X-Gm-Message-State: AOJu0YzT9aU3nDn5qU+SNoRCrA5muxNxOi/zdVbrT2xymd1yaHVLv0rS
	u1HA/O9jRckfrvp1fhf3I38lOm4F1RkRagSZIB+XBP0bAvyYKV9kxSp5qVoH58lI
X-Gm-Gg: ASbGncshe+UE9+Wx42yZ8VE5hZ+n06xbtE7q6+fysL6ThiRVIrqkMLCuLlG+iC0XqKS
	grVebXaxjAynlz3oQpIXfu5OhlbwOSRZYaqGO8yfN+nm1uLujagugnkbVpPx5kA3nrXJoQdhCPT
	c0e9BwI58zeSrZZCz3Dxh6YY9KynHlMSqsRZXmNRKxoMV3AtUNA2//VrIW2/RzLHOWT/lXlmb4y
	PLmtbuorT4ZmkeoUkfU+xQj7LmurSqmxJx2cli7PhwoEbU+JTQcZyztpYfwAPP8pLGUs9CXMCuc
	3SL0zh/OJt44uCf2cE1W85cXXHlGlbUH/g6bntyA5gqYJZW51WKiMDiejgSFxYDWc5EZxVrNlrD
	cTGNofvPf8SY=
X-Google-Smtp-Source: AGHT+IGobE9PkUv5XZDyyarbTCBMtY56aC2srrH6tflPtrcbqR9W5G8rnlMGjKvF92RFlKbNSmX0oQ==
X-Received: by 2002:a17:902:ebcd:b0:234:ef42:5d65 with SMTP id d9443c01a7336-2364d90ff78mr8661165ad.52.1749675702332;
        Wed, 11 Jun 2025 14:01:42 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:391:76ae:2143:7d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9c86sm62005ad.101.2025.06.11.14.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 14:01:41 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 09/23] xfs: fix the contact address for the sysfs ABI documentation
Date: Wed, 11 Jun 2025 14:01:13 -0700
Message-ID: <20250611210128.67687-10-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250611210128.67687-1-leah.rumancik@gmail.com>
References: <20250611210128.67687-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 9ff4490e2ab364ec433f15668ef3f5edfb53feca ]

oss.sgi.com is long dead, refer to the current linux-xfs list instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-xfs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-xfs b/Documentation/ABI/testing/sysfs-fs-xfs
index f704925f6fe9..82d8e2f79834 100644
--- a/Documentation/ABI/testing/sysfs-fs-xfs
+++ b/Documentation/ABI/testing/sysfs-fs-xfs
@@ -1,37 +1,37 @@
 What:		/sys/fs/xfs/<disk>/log/log_head_lsn
 Date:		July 2014
 KernelVersion:	3.17
-Contact:	xfs@oss.sgi.com
+Contact:	linux-xfs@vger.kernel.org
 Description:
 		The log sequence number (LSN) of the current head of the
 		log. The LSN is exported in "cycle:basic block" format.
 Users:		xfstests
 
 What:		/sys/fs/xfs/<disk>/log/log_tail_lsn
 Date:		July 2014
 KernelVersion:	3.17
-Contact:	xfs@oss.sgi.com
+Contact:	linux-xfs@vger.kernel.org
 Description:
 		The log sequence number (LSN) of the current tail of the
 		log. The LSN is exported in "cycle:basic block" format.
 
 What:		/sys/fs/xfs/<disk>/log/reserve_grant_head
 Date:		July 2014
 KernelVersion:	3.17
-Contact:	xfs@oss.sgi.com
+Contact:	linux-xfs@vger.kernel.org
 Description:
 		The current state of the log reserve grant head. It
 		represents the total log reservation of all currently
 		outstanding transactions. The grant head is exported in
 		"cycle:bytes" format.
 Users:		xfstests
 
 What:		/sys/fs/xfs/<disk>/log/write_grant_head
 Date:		July 2014
 KernelVersion:	3.17
-Contact:	xfs@oss.sgi.com
+Contact:	linux-xfs@vger.kernel.org
 Description:
 		The current state of the log write grant head. It
 		represents the total log reservation of all currently
 		outstanding transactions, including regrants due to
 		rolling transactions. The grant head is exported in
-- 
2.50.0.rc1.591.g9c95f17f64-goog


