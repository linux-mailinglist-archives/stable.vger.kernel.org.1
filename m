Return-Path: <stable+bounces-119946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3602A49B20
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A900E174867
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA325F984;
	Fri, 28 Feb 2025 13:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MijIg/A4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D8A1B960
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751076; cv=none; b=i0pAWmMmhPzfo7RoqglEa12ZXQsIYPObWxtCNzWEK2H9kdY2l1i85RXkXZV9goSJc+Ik+VbKPkDfEVwgF6tSCTbQ5vR8YGHCUJvV9Zf2CedZtsPunwqeLv4dvNjO1IX0PXoZaw42YKH0ithdcD1BCM5nhjP1OeMUjZqtPkYTNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751076; c=relaxed/simple;
	bh=6KT/af4yfhAxPSdDvuqUtu0j+S2tWEBBXYMZKqoXCtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGeL2YkF3JXxeBKqxVP0F5FsI582LjRZ7tby2WqBCGf8TL9cB0hVHRcK7Zd4ePhxLhFCwA7c2jbsKnnFBjfM7CCctV7hhPwIhi/fufHWtqOkYBDsb3Tu7s4JBcZcqxtaMt7TezJs2XRR5feqCEf27GqXmcOUqKWyhoUSKHjY1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MijIg/A4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740751073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQm9lCL5VLblh7IDkp7qYI3hB91qoKmNigOuBV6Qe3E=;
	b=MijIg/A40TpYbCJBF/g9wqJ2vRyoG/S8LQqLmpYdU5bSRP6y1mTmhxMDikZmx8ovp/MPS+
	7qUw/B0Rv6rIZkYiJTFYS2V24Z0ok1Z1bc0vCniB4wH7/GxSvl+FHXuQ6qMX0O4zrxNsqG
	QRKE5i3pzrYZiiES6yFhaL9uZrSQkbw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-9Ee6F-flMVSaItRiX5gCaw-1; Fri,
 28 Feb 2025 08:57:50 -0500
X-MC-Unique: 9Ee6F-flMVSaItRiX5gCaw-1
X-Mimecast-MFC-AGG-ID: 9Ee6F-flMVSaItRiX5gCaw_1740751069
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 242131800875;
	Fri, 28 Feb 2025 13:57:49 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 056F41800358;
	Fri, 28 Feb 2025 13:57:45 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Jan Kundrat <jan.kundrat@cesnet.cz>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6.6 2/4] Revert "rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads"
Date: Fri, 28 Feb 2025 14:57:06 +0100
Message-ID: <20250228135708.604410-3-tglozar@redhat.com>
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

This reverts commit 83b74901bdc9b58739193b8ee6989254391b6ba7.

The commit breaks rtla build, since params->kernel_workload is not
present on 6.6-stable.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index a985e5795482..ab13a9392bff 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -900,15 +900,12 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	/*
-	* Set workload according to type of thread if the kernel supports it.
-	* On kernels without support, user threads will have already failed
-	* on missing timerlat_fd, and kernel threads do not need it.
-	*/
-	retval = osnoise_set_workload(tool->context, params->kernel_workload);
-	if (retval < -1) {
-		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-		goto out_err;
+	if (params->user_hist) {
+		retval = osnoise_set_workload(tool->context, 0);
+		if (retval) {
+			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+			goto out_err;
+		}
 	}
 
 	return 0;
-- 
2.48.1


