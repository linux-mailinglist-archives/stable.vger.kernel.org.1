Return-Path: <stable+bounces-59016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B3B92D310
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 15:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4B541F243C3
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 13:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72EE1DDC5;
	Wed, 10 Jul 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rJ4M57M7"
X-Original-To: stable@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C2F192B88
	for <stable@vger.kernel.org>; Wed, 10 Jul 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618902; cv=none; b=dXHTJBdR1UtcGA1x7uBsFIf2IiL5c/ll9Qod46kOpfwdntgDILaNXgxLtwqcntAESZ6nTke6uD1ZPHUIZTyov0804yhm5mwxvwS3kyZYJoJ7Wy8dnEx+33rYaowHQ1WUIit1deBHX19xKQMX2cO/n2EITsoxppU8S9nrCRAoBjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618902; c=relaxed/simple;
	bh=2auWrD7NqWu9Mj0mRfAGKRBLkTU4ExM71ypUjHC6rJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2I30i2CiwJ6FQUAgQZEhQPb3aZWZDppGD3/y+HeK3MkrskN0zPmVawS+TMln356V4S30R7wB44GlQlTFeAptHxdh0jmu/X8i2n3djcMRLSZhpQ7yNWwpXUMTqrqJm0eiCQBfaIdtK5VKSPjziaOWwo1gEJ2nMX0qjQ4qlhd+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rJ4M57M7; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GZA3Z9KKbNbEv/2+71PQ5lsb8BCfM182QAWYhtmpFfc=; b=rJ4M57M7vPnj70cSr6pMJTvyP+
	6ihJjxm8XI6EfkCnQqIsmomdH4iNG/8QXG9aw67/InYdEr4qpQEHqUCRUlXMxIqbb2preaLAmKJEk
	FvkSTQ6/uq59d4HKhqhFGvM1opgNdVsf36wO+fCHf9eh+URLor38fBE0UU8/d1zmfDWRK3toXhZJR
	iDnqe5q4/kq5S0hNxr1D4U+pQnUyKlRJwhrWCs9RxpJ2gKEcAxqWElUCcnOjzsRWvKyrT1Sc2U6It
	WsuAId2SgVrxpHh5dncMqBxum5rOa56tW0h+ewMiW4eGjUgtl5qPNQQcNM8eUXz2Yuo0HkvDOCoVO
	V2gKw6eg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sRXZg-00DH14-Al; Wed, 10 Jul 2024 15:41:36 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	stable@vger.kernel.org
Subject: [PATCH 04/12] drm/v3d: Validate passed in drm syncobj handles in the timestamp extension
Date: Wed, 10 Jul 2024 14:41:22 +0100
Message-ID: <20240710134130.17292-5-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240710134130.17292-1-tursulin@igalia.com>
References: <20240710134130.17292-1-tursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

If userspace provides an unknown or invalid handle anywhere in the handle
array the rest of the driver will not handle that well.

Fix it by checking handle was looked up successfuly or otherwise fail the
extension by jumping into the existing unwind.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 9ba0ff3e083f ("drm/v3d: Create a CPU job extension for the timestamp query job")
Cc: Maíra Canal <mcanal@igalia.com>
Cc: Iago Toral Quiroga <itoral@igalia.com>
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/v3d/v3d_submit.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index ca1b1ad0a75c..3313423080e7 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -497,6 +497,10 @@ v3d_get_cpu_timestamp_query_params(struct drm_file *file_priv,
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->timestamp_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->timestamp_query.count = timestamp.count;
 
@@ -550,6 +554,10 @@ v3d_get_cpu_reset_timestamp_params(struct drm_file *file_priv,
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->timestamp_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->timestamp_query.count = reset.count;
 
@@ -613,6 +621,10 @@ v3d_get_cpu_copy_query_results_params(struct drm_file *file_priv,
 		}
 
 		job->timestamp_query.queries[i].syncobj = drm_syncobj_find(file_priv, sync);
+		if (!job->timestamp_query.queries[i].syncobj) {
+			err = -ENOENT;
+			goto error;
+		}
 	}
 	job->timestamp_query.count = copy.count;
 
-- 
2.44.0


