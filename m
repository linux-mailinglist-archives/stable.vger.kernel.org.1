Return-Path: <stable+bounces-245140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJGvDkuHAWpscgEAu9opvQ
	(envelope-from <stable+bounces-245140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 187325095C0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AFB2F300A31E
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8838F935;
	Mon, 11 May 2026 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssCnlcKi"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A42038BF67
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485043; cv=none; b=UqGwqk3fadgBuJDKfoulBOrxsS++HhxhFWlKPbDb8WIaNuJNfUcxR/ncoOssO0FPZLUBkiAtwVqirSvPR+QTiC4pO4zEhIm0J+q08bV8BP7kZWYm+J0FUkpUhOTk5Ub7425x7G0+ZARiOyKiLIny+iHe0W+45+4HWPmsmAdBe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485043; c=relaxed/simple;
	bh=gSDeBrdaEggc97Xdm7nwB/3eggqp+eKj4Jvx7PQgHKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FuMcIslBEP9srnO5HgqOwM4H4soR1Dv88d7QNZJxfA7wxIHQ/M5SzZ4yj0GeADYzR1eD8CNFEj8wiw05q+WYjctjwMix6NOGkA96r3fZ/K5ccYYANX1fmKI9z06TUnjCB/yJWnmzBSKX+IdQPAGxVvu+4en6i2NehgJAoEm3Idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssCnlcKi; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8d560ede296so436006185a.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485038; x=1779089838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI0P6k3hB2yZaaJXqEPCK3cLYBDx+iGuXlAqc6mouFg=;
        b=ssCnlcKixc1yJxiqilaGg+Y9+PtZ0tYEjvL7PLpCt/Arm7bqGCMaz6pl3PraqcCKTG
         4RRHt5rVyThEmfI2L00JatJXENJSveudTE3n2bdtFbPdfq//muSdzHWIRn+mH7qpbttI
         lUxjBFrLQQUPPnSclgnel2w1BZyPPi156IpyTvjLoSDt3A0rZs3J62F1jG+DF1OjVLJ1
         AeslQD/1R/K8TJDgC0j23KmBtP8kzuPyAuGVQmfq5WtMFsF6Nt44HKLYB406Jan9GStq
         2105JDo2kfpmkO4tF2OOKuodV1oAkaoBfS7M7vXakzc4nVJpPFscAoYQRCsYncaAsKXC
         e4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485038; x=1779089838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bI0P6k3hB2yZaaJXqEPCK3cLYBDx+iGuXlAqc6mouFg=;
        b=gfloqUylRzotva/Vskdya6KZP3RUkCaKQOJYcitiafVt16fz6ho0q6Agg+137ib0bJ
         d9MojgEvxWHm4VeGjiY6ua3r7nDlUodTIw0+CJZPzaRcBM0zO8hSdE+I9MXDofG/b285
         YPiq912l+v/Xkgrhr13R2u7fWWOLX2ArQ3W8fMPqRimIQ2q9JtPyNIbOecRBpyfgTamG
         QIW/tAjKy0yZgATMUecRDFXa+3Y9eRDggM0QNFwccIO2cBdvOwSpk0qrygajdLGvF2Cw
         9K4OJYyeqJxVmOTxphxgYqfFbZ+Aq4wQPcYzgWXI/p5s3pTJJF3a3sRgSa0/zajfYH3z
         1LVQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zMbNDxrJDXNXB5u6xRvYTDBPW2VSRU1vP8unGozt0I59bOiafaWnIVHcgxyv25L7TQS8Py2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw21oHGAzgOWI+Qsz+oUXUBpOmRGocob3TSKmXeSKxf4jgb+Uda
	Y6eSOJlocxs0BAiAXHbV1UUSrzasYi5IE8ssiWadSx4nLQSkKLXZqt3r
X-Gm-Gg: Acq92OHLhzDA6EgvLJpbbcj6eEAyPxS5+6+iGBSHKp854HeH9/9OaOgaqYIOgnc2s36
	AFKXM9SkMUSGfP/Aq+qVwBe5UdcrUvdyf9pcdHPoyqWx4oyrY5egRWKG9/9yT+QMacufa2HEVwO
	w5fNa9J0qPhuB5JN7G1ygEM5IBtFkTNX1XUqVrwN2kqwoosTV9ZTaPYFb7YJlTgw8T2aW5zBO8o
	jmCB+kubfykm+NfnOevrBQeAaIk7CwN06GF40Ha6j40ZNlPtfKVxoBE0TBxOxVmQ4ISzc1f05ke
	Q+XN0uwFRfCQ3LLf0AGge+fOQ4v24Z6FYyEmO8KdnerI80jEn7DaZHEJPOKEjPQ+Omgg/5iccDL
	M/dCzpI442328jqmhMKtI/+q4onJJzJGkJ/O0opogAq1ZuyinGAgoL11NHG+bZd67QNZ4kx7TaT
	CKeN6pM82V0jQQ/azyBaXtNh/7Pd5RBQaHhlAmdsnqilSfnlsC6uVerYkEoNh1sA==
X-Received: by 2002:a05:620a:318a:b0:8eb:ba31:4b0a with SMTP id af79cd13be357-907bc28ca61mr1935944885a.61.1778485037590;
        Mon, 11 May 2026 00:37:17 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:17 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 18/18] perf bpf-event: Constify variables storing the result of strchr() on const tables
Date: Mon, 11 May 2026 12:40:51 +0530
Message-ID: <20260511071051.537859-19-yesshedi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511071051.537859-1-yesshedi@gmail.com>
References: <20260511071051.537859-1-yesshedi@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 187325095C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245140-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.983];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit 8bf093acb3f1f07d846c86e32308f9f9954ed579 upstream

As newer glibcs will propagate the const attribute of the searched table
to its return.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/util/bpf-event.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 91c7bfa82a50..fbaab3d3a476 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -411,7 +411,8 @@ kallsyms_process_symbol(void *data, const char *_name,
 			char type __maybe_unused, u64 start)
 {
 	char disp[KSYM_NAME_LEN];
-	char *module, *name;
+	const char *module;
+	char *name;
 	unsigned long id;
 	int err = 0;
 
-- 
2.54.0


