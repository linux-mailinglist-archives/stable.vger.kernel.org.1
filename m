Return-Path: <stable+bounces-119948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8599A49B22
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 14:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35A71893D85
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD8A26D5D1;
	Fri, 28 Feb 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqGICt0K"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A721CC78
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751083; cv=none; b=aNqrd7ndOJCAloOU82sotgpKPsPAuzJIEpISKsycHrzIFEWGoJTQAvzMjD/gb2i5uWyt+KZ5XHvlRCEW331hGWqFCtZGWtQHMlP2HikpiPY8F01tz0nKDP4xQObgxMlOJGsoHsoDkc7gfNQUF2wD3fGgnQw7ymYEWKzp2LamJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751083; c=relaxed/simple;
	bh=Cgm/2bfQ/P3Ha+TzDvXVV+Uty9JqKEvke+j43ItYX+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkgU/0xKajgc8O6oaZB3CnwJtqXJv/MYEolYunIo5HpIemd89tvTWVtHfiNe1MLA+6JvF31BsVNcUxPi/kACynjUceTukhAlIpYtI9i/wsAzcVMe9HYzqomsF8hB3DcIdETNYEtJpV6VfyBRU8Oj51bcJiWC92DGsxTbVI3ko98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqGICt0K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740751080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeXxloefKbsDghdmVl9UQHGjSma12SXlO3gv+ErHcik=;
	b=JqGICt0KGbE4vrUN46DSfR6UCs5yQZqDF7OLwMruWLgzidXBYeJNzYFolkjaUvOvDigOvp
	BxLie/aXc6e8LGgsKXJLzJaGliZPf78H/krD4exZY+90enOGu5NmnIIFFCEuvx6q87e932
	gWFkb+aioPNJQYOpdHPQrRwAeHbiryg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-V2LogJypO-Cq9hQp8hcALw-1; Fri,
 28 Feb 2025 08:57:57 -0500
X-MC-Unique: V2LogJypO-Cq9hQp8hcALw-1
X-Mimecast-MFC-AGG-ID: V2LogJypO-Cq9hQp8hcALw_1740751076
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1A4141954B20;
	Fri, 28 Feb 2025 13:57:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1577A1800358;
	Fri, 28 Feb 2025 13:57:52 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guillaume Morin <guillaume@morinfr.org>,
	Wang Yugui <wangyugui@e16-tech.com>,
	Jan Kundrat <jan.kundrat@cesnet.cz>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 6.6 4/4] rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
Date: Fri, 28 Feb 2025 14:57:08 +0100
Message-ID: <20250228135708.604410-5-tglozar@redhat.com>
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

commit 217f0b1e990e30a1f06f6d531fdb4530f4788d48 upstream.

When using rtla timerlat with userspace threads (-u or -U), rtla
disables the OSNOISE_WORKLOAD option in
/sys/kernel/tracing/osnoise/options. This option is not re-enabled in a
subsequent run with kernel-space threads, leading to rtla collecting no
results if the previous run exited abnormally:

$ rtla timerlat top -u
^\Quit (core dumped)
$ rtla timerlat top -k -d 1s
                                     Timer Latency
  0 00:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max

The issue persists until OSNOISE_WORKLOAD is set manually by running:
$ echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options

Set OSNOISE_WORKLOAD when running rtla with kernel-space threads if
available to fix the issue.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250107144823.239782-4-tglozar@redhat.com
Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
[ params->kernel_workload does not exist in 6.6, use
!params->user_top ]
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 tools/tracing/rtla/src/timerlat_top.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 832eb6ea6efe..7212855d3364 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -679,12 +679,15 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		auto_house_keeping(&params->monitored_cpus);
 	}
 
-	if (params->user_top) {
-		retval = osnoise_set_workload(top->context, 0);
-		if (retval) {
-			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-			goto out_err;
-		}
+	/*
+	* Set workload according to type of thread if the kernel supports it.
+	* On kernels without support, user threads will have already failed
+	* on missing timerlat_fd, and kernel threads do not need it.
+	*/
+	retval = osnoise_set_workload(top->context, !params->user_top);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
 	}
 
 	return 0;
-- 
2.48.1


