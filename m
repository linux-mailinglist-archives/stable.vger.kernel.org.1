Return-Path: <stable+bounces-119947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA41A49B21
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB3E3B3431
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C11F26AA85;
	Fri, 28 Feb 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3r50HYU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDA1B960
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751083; cv=none; b=Kt1PkwGgcBt6qKI3HkQRailEfOQu4Gs+085HgNREcx/6MfmHb3RZKwXzbj+HrktVVdSWlo/bE7m+tjnUAKLjeEvHXQO+PNVU5/S/DU5JhN208/IAwROKrulG8ie2ptJhoiggcrbCOqinq/bzLKl1wawYspNQVy+1qZtT+vUrMe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751083; c=relaxed/simple;
	bh=HqUnVUHZ2IT69J5AVkUBm21D8We+9rxof/CAoT2q1Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Js5f5J1ysfe6/kXNXDUzPzOgeIWGRjwNLsorM4UgOCHoFHuVS1fBQQlJMr1AaChrrPXKODJEgd+5hgAa+p1RLV6/B6wcp4eRKNO10lJ4zW3xyP4Xt7aQhqYh/bI/nbRArdR3pDcGXIRbCT2Yyn9WJB90XAjbsWNKTgC7Yp1N8PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3r50HYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740751080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kO50PzBrfkh6LfSd3caMkHeAk8pbJk1uxSs+BIbyaUw=;
	b=V3r50HYUVma7HbVWZBzV2VndWCzJYfH8ZuW6Xhiz4qp0KKr0+qyWc3IrBqqftC85pSICVu
	y7cMXUK0g9fTE8M+H5ekF5bEQSpGuiTY3BzQcdyp18uSWPCnkquNI/xBQHSSu2z5PEjDvl
	hHdcxnh68nz/Moql5BeL9K06z00dKn4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-rPofLsxeNFSvE4QSht9tng-1; Fri,
 28 Feb 2025 08:57:54 -0500
X-MC-Unique: rPofLsxeNFSvE4QSht9tng-1
X-Mimecast-MFC-AGG-ID: rPofLsxeNFSvE4QSht9tng_1740751073
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E2EC1800871;
	Fri, 28 Feb 2025 13:57:52 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9C41F180094C;
	Fri, 28 Feb 2025 13:57:49 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Jan Kundrat <jan.kundrat@cesnet.cz>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6.6 3/4] rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
Date: Fri, 28 Feb 2025 14:57:07 +0100
Message-ID: <20250228135708.604410-4-tglozar@redhat.com>
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

commit d8d866171a414ed88bd0d720864095fd75461134 upstream.

When using rtla timerlat with userspace threads (-u or -U), rtla
disables the OSNOISE_WORKLOAD option in
/sys/kernel/tracing/osnoise/options. This option is not re-enabled in a
subsequent run with kernel-space threads, leading to rtla collecting no
results if the previous run exited abnormally:

$ rtla timerlat hist -u
^\Quit (core dumped)
$ rtla timerlat hist -k -d 1s
Index
over:
count:
min:
avg:
max:
ALL:        IRQ       Thr       Usr
count:        0         0         0
min:          -         -         -
avg:          -         -         -
max:          -         -         -

The issue persists until OSNOISE_WORKLOAD is set manually by running:
$ echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options

Set OSNOISE_WORKLOAD when running rtla with kernel-space threads if
available to fix the issue.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250107144823.239782-3-tglozar@redhat.com
Fixes: ed774f7481fa ("rtla/timerlat_hist: Add timerlat user-space support")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ params->kernel_workload does not exist in 6.6, use
!params->user_hist ]
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index ab13a9392bff..198cdf75c837 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -900,12 +900,15 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	if (params->user_hist) {
-		retval = osnoise_set_workload(tool->context, 0);
-		if (retval) {
-			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-			goto out_err;
-		}
+	/*
+	* Set workload according to type of thread if the kernel supports it.
+	* On kernels without support, user threads will have already failed
+	* on missing timerlat_fd, and kernel threads do not need it.
+	*/
+	retval = osnoise_set_workload(tool->context, !params->user_hist);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
 	}
 
 	return 0;
-- 
2.48.1


