Return-Path: <stable+bounces-220091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF8IIlwno2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3F81C4F03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 925AA30930DE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D033D515;
	Sat, 28 Feb 2026 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOvwsfs7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFD34CFD7;
	Sat, 28 Feb 2026 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299987; cv=none; b=PhK2Af5i91hwMraeU2PXkk3i8Mr4HkWBKulv3eIw72AIO2BIe40MH0M+BUqpCVl8aK8JSZ7iGJPeo6qkH9HuQxjKw7I8LsVm9kpSFd1gKBgbKzcwR2MN2DPW/h8umu/lw4wKVM7GA6/9ERKQgRAI2bqkoV3vdJ1tXsXqDcYxrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299987; c=relaxed/simple;
	bh=YguACwKeqrdXixPWz4QFCRIZisZJoePDLuE9Nvn+DJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8oh2WEQZUUo1rd9KDjaIXureeCM3Fm0kjbFhNhG7wjT7Fnpf0FLdHwucV3MX2UVK7qp4cFBbzZ0hDPPaLL4OvVJ1mvfAC9Th1Uz2IIYD+dohwik1McUAi6Budx67Ed5mTcc9UfhMGCdg0znLTOojjNyXm9+kJ/VccV79RGS+/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOvwsfs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E48C19423;
	Sat, 28 Feb 2026 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772299987;
	bh=YguACwKeqrdXixPWz4QFCRIZisZJoePDLuE9Nvn+DJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOvwsfs7QTRpOFME2NTTRQ52DqXv1UF5XhHiOIRdKW8O7ais7DEkgjXF7P5HxyfBo
	 CkEtqx/yBSHgEaMDvAQcm07TBPYOkBcW9aQAXaSK1dmwiFsxhifS7fmG3bATfG3XSp
	 XHeLqgZhAJXe7HAdg6EUshXc6lLkb6V/IvEjMeqhrT7Pdil42y+FeUyQMtlvUP68ad
	 d1ciO1/iB+ZD+ea7arDGEo1JiKz5uDzKYoNgpH7cR/gS5W/mFj+hFqJa56sPJdOROO
	 k+cj8RLoqBMmoZ8edEF2SoGR1+gX+dcmimmqAdYmEYBnf33ZqJGqjBgG83b9Vq7Biy
	 fIGOkgfLn+stA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 013/844] perf tools: Get debug info of DSO properly
Date: Sat, 28 Feb 2026 12:18:46 -0500
Message-ID: <20260228173244.1509663-14-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220091-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linaro.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 2E3F81C4F03
X-Rspamd-Action: no action

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 069e603d8248dac98b1ef2909e2f1c4169b9da11 ]

The dso__debuginfo() just used the path name to open the file but it may
be outdated.  It should check build-ID and use the file in the build-ID
cache if available rather than just using the path name.

Let's factor out dso__get_filename() to avoid code duplicate.

Fixes: 53a61a6ca279165d ("perf annotate: Add dso__debuginfo() helper")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/dso.c | 63 ++++++++++++++++++++++++++++++++-----------
 tools/perf/util/dso.h | 11 ++------
 2 files changed, 50 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 344e689567ee1..dc202d4943721 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -111,7 +111,7 @@ bool dso__is_object_file(const struct dso *dso)
 
 int dso__read_binary_type_filename(const struct dso *dso,
 				   enum dso_binary_type type,
-				   char *root_dir, char *filename, size_t size)
+				   const char *root_dir, char *filename, size_t size)
 {
 	char build_id_hex[SBUILD_ID_SIZE];
 	int ret = 0;
@@ -563,20 +563,15 @@ char *dso__filename_with_chroot(const struct dso *dso, const char *filename)
 	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filename);
 }
 
-static int __open_dso(struct dso *dso, struct machine *machine)
-	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+static char *dso__get_filename(struct dso *dso, const char *root_dir,
+			       bool *decomp)
 {
-	int fd = -EINVAL;
-	char *root_dir = (char *)"";
 	char *name = malloc(PATH_MAX);
-	bool decomp = false;
 
-	if (!name)
-		return -ENOMEM;
+	*decomp = false;
 
-	mutex_lock(dso__lock(dso));
-	if (machine)
-		root_dir = machine->root_dir;
+	if (name == NULL)
+		return NULL;
 
 	if (dso__read_binary_type_filename(dso, dso__binary_type(dso),
 					    root_dir, name, PATH_MAX))
@@ -601,20 +596,38 @@ static int __open_dso(struct dso *dso, struct machine *machine)
 		size_t len = sizeof(newpath);
 
 		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
-			fd = -(*dso__load_errno(dso));
+			errno = *dso__load_errno(dso);
 			goto out;
 		}
 
-		decomp = true;
+		*decomp = true;
 		strcpy(name, newpath);
 	}
+	return name;
+
+out:
+	free(name);
+	return NULL;
+}
 
-	fd = do_open(name);
+static int __open_dso(struct dso *dso, struct machine *machine)
+	EXCLUSIVE_LOCKS_REQUIRED(_dso__data_open_lock)
+{
+	int fd = -EINVAL;
+	char *name;
+	bool decomp = false;
+
+	mutex_lock(dso__lock(dso));
+
+	name = dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
+	if (name)
+		fd = do_open(name);
+	else
+		fd = -errno;
 
 	if (decomp)
 		unlink(name);
 
-out:
 	mutex_unlock(dso__lock(dso));
 	free(name);
 	return fd;
@@ -1910,3 +1923,23 @@ const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 	return __dso__read_symbol(dso, symfs_filename, start, len,
 				  out_buf, out_buf_len, is_64bit);
 }
+
+struct debuginfo *dso__debuginfo(struct dso *dso)
+{
+	char *name;
+	bool decomp = false;
+	struct debuginfo *dinfo = NULL;
+
+	mutex_lock(dso__lock(dso));
+
+	name = dso__get_filename(dso, "", &decomp);
+	if (name)
+		dinfo = debuginfo__new(name);
+
+	if (decomp)
+		unlink(name);
+
+	mutex_unlock(dso__lock(dso));
+	free(name);
+	return dinfo;
+}
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f8ccb9816b89c..54e470dd07305 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -766,7 +766,7 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
 
 char dso__symtab_origin(const struct dso *dso);
 int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
-				   char *root_dir, char *filename, size_t size);
+				   const char *root_dir, char *filename, size_t size);
 bool is_kernel_module(const char *pathname, int cpumode);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
@@ -915,14 +915,7 @@ u64 dso__findnew_global_type(struct dso *dso, u64 addr, u64 offset);
 bool perf_pid_map_tid(const char *dso_name, int *tid);
 bool is_perf_pid_map_name(const char *dso_name);
 
-/*
- * In the future, we may get debuginfo using build-ID (w/o path).
- * Add this helper is for the smooth conversion.
- */
-static inline struct debuginfo *dso__debuginfo(struct dso *dso)
-{
-	return debuginfo__new(dso__long_name(dso));
-}
+struct debuginfo *dso__debuginfo(struct dso *dso);
 
 const u8 *dso__read_symbol(struct dso *dso, const char *symfs_filename,
 			   const struct map *map, const struct symbol *sym,
-- 
2.51.0


