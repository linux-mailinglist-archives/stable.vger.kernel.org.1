Return-Path: <stable+bounces-119945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93AA49B1F
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0388E3B9371
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A4426B961;
	Fri, 28 Feb 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bmnbkdkW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABE31B960
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751073; cv=none; b=uFv29Bh+Mfru5nR4CHWeOKbIiPG2k4pkqlAfb2QeAtoaFOpC1Tu3Oh0kjA0/UNLbK2wUd8GgjEO0Cqx9i/FeP6f/32kdWjv7EnjbbrnwhFB79vmvRU2T5AW8AAIyjALsJWSodmbvJqu48pBu7FWk28eYhpX2gFn5lGXvSEq5XDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751073; c=relaxed/simple;
	bh=g/74muxbUao18Rrce0VzY6Gop4Ympgv+G3myEUIKusI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgaAjo4fLyktxhIPb+g9j1CKXh9XizmWJ807c0IKn8nHDL8fzc+3iJ5hOgppFu3MwA27gxHpaimC+0K4cOLNoIPbxPUVJYyN8laTkVKDmxqb6QTJtlPxRMdybKQzZG3uv7ffjN5jY5vB3w7iuaHhIxKyhQDZvo/OdDcU479MfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bmnbkdkW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740751070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=irSF6kS2aZ9lDRd8TBTIWf4GF1z8kAB0azowdUk+zBc=;
	b=bmnbkdkWK43KuZ+1u22CUOqbE7oNmxsyqOqUIQY/DNC9PehMNWFDBbOab5miXc5c9a1tbM
	ZrOusMG7zid1PACCjbqqcxshR2L5yIL/W6CDsvuROaN+euqMyb13aTjriayUkLkZI1Jrv7
	ZYPq2CW0MOobzbnd2fxbVPhnNKU0LKU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-SGsnwcQTNiiv2NjzL8sQNw-1; Fri,
 28 Feb 2025 08:57:47 -0500
X-MC-Unique: SGsnwcQTNiiv2NjzL8sQNw-1
X-Mimecast-MFC-AGG-ID: SGsnwcQTNiiv2NjzL8sQNw_1740751066
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80FA1193585F;
	Fri, 28 Feb 2025 13:57:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 376B41800358;
	Fri, 28 Feb 2025 13:57:41 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Jan Kundrat <jan.kundrat@cesnet.cz>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6.6 1/4] Revert "rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads"
Date: Fri, 28 Feb 2025 14:57:05 +0100
Message-ID: <20250228135708.604410-2-tglozar@redhat.com>
In-Reply-To: <20250228135708.604410-1-tglozar@redhat.com>
References: <20250228135708.604410-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This reverts commit 41955b6c268154f81e34f9b61cf8156eec0730c0.

The commit breaks rtla build, since params->kernel_workload is not
present on 6.6-stable.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1fed4c8d8520..832eb6ea6efe 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -679,15 +679,12 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	/*
-	* Set workload according to type of thread if the kernel supports it.
-	* On kernels without support, user threads will have already failed
-	* on missing timerlat_fd, and kernel threads do not need it.
-	*/
-	retval = osnoise_set_workload(top->context, params->kernel_workload);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
+	if (params->user_top) {
+		retval = osnoise_set_workload(top->context, 0);
+		if (retval) {
+			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+			goto out_err;
+		}
 	}
 
 	return 0;
-- 
2.48.1


