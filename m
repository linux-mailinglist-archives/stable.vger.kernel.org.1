Return-Path: <stable+bounces-220085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKSPAUUno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EA01C4EED
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AAE330B92BA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087C7342511;
	Sat, 28 Feb 2026 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKB5ykSG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE934250D;
	Sat, 28 Feb 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299977; cv=none; b=V6KFZfo08Psh6tkJtle0x0nZGqD6JSG+GyrqhTBwZtahRkjbenLOT4Z0eInwnkCL5WQ8QCX4PIgyHU+iYj1x3x9BYFpR2Tapw7I99t1ZzDYIH1rtBBtX9jCL/v5peDjAP8uZ3dYUKtWubEd/jekhlKoJmnKf0P7Ys9I0XmsZiF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299977; c=relaxed/simple;
	bh=krid9cOIMHTsvZ7Qjdu//AWrJ+QyM9fIZuFb2ch7s6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBlb20Y6dDZQ6tEZBa1tchVkO/hYL5ps02vvAzjU7x31y1/ozUegkZh5n+6gWRc2Mgm/VXg5o6dpYK7vf3/xCcCd5zvSnF5lyjmuMPgtSp7xnnlCB7nGWdZMZ09VcnVDyfM2Msr+79NEXf/Pm1UL3dyHF4YFYJH0DWbOqveFFag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKB5ykSG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED57FC19423;
	Sat, 28 Feb 2026 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299977;
	bh=krid9cOIMHTsvZ7Qjdu//AWrJ+QyM9fIZuFb2ch7s6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XKB5ykSGvHqRdhLsAf9ZlK63PHe0KCIXa2OF9xYsV+CCYIJb5/tIRZS3Oe7PRC453
	 YysnhuW0ps1KIEBPqVxcl/huMNZv7cxPIdw12RkuD9eFs6Os0EjRQfw3hAHqdv9uuw
	 L8XXt7l3bEbvyStjdTY+02wVhxA3F8xMS1+MRQBvpMsHRSgCP0QoNDOzS8pQr+4JJg
	 hjc9jL6dHEK8WtMfNqy8cP8wU6SQP0ZMhD1GutL33fjeSrmF98CDGVWks374Zx44M+
	 BoQed6j2GDG2KKMIELYmAPN06jLqm7ZBW751jeS/ubWZgnAh6H+hza2cMh7KvbjkQu
	 f+oCkLu+jAAwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Tony Jones <tonyj@suse.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 007/844] perf unwind-libdw: Fix invalid reference counts
Date: Sat, 28 Feb 2026 12:18:40 -0500
Message-ID: <20260228173244.1509663-8-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,linaro.org,intel.com,linux.intel.com,gmail.com,redhat.com,kernel.org,infradead.org,oracle.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220085-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,linaro.org:email,infradead.org:email,oracle.com:email,al.map:url]
X-Rspamd-Queue-Id: 75EA01C4EED
X-Rspamd-Action: no action

From: Ian Rogers <irogers@google.com>

[ Upstream commit f815fc0c66e777c727689666cfb46b8d461c2f99 ]

The addition of addr_location__exit() causes use-after put on the maps
and map references in the unwind info. Add the gets and then add the
map_symbol__exit() calls.

Fixes: 0dd5041c9a0eaf8c ("perf addr_location: Add init/exit/copy functions")
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Tony Jones <tonyj@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/unwind-libdw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index ae70fb56a0572..3ff427a49e4c5 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -136,8 +136,8 @@ static int entry(u64 ip, struct unwind_info *ui)
 	}
 
 	e->ip	  = ip;
-	e->ms.maps = al.maps;
-	e->ms.map = al.map;
+	e->ms.maps = maps__get(al.maps);
+	e->ms.map = map__get(al.map);
 	e->ms.sym = al.sym;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
@@ -325,6 +325,9 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (err)
 		pr_debug("unwind: failed with '%s'\n", dwfl_errmsg(-1));
 
+	for (i = 0; i < ui->idx; i++)
+		map_symbol__exit(&ui->entries[i].ms);
+
 	dwfl_end(ui->dwfl);
 	free(ui);
 	return 0;
-- 
2.51.0


