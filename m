Return-Path: <stable+bounces-245128-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAfEAHuJAWpJcwEAu9opvQ
	(envelope-from <stable+bounces-245128-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CD55097FF
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 09:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FEA43036D62
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 07:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4311438D688;
	Mon, 11 May 2026 07:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxqA+V34"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C7386C12
	for <stable@vger.kernel.org>; Mon, 11 May 2026 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485026; cv=none; b=mT0QeGYBIsxjG2Kizcsy+bmzJw2pdAezsdE42fPXeYxh/uC82NQ03iIdzA3B+ALmpHkgtYJ3t3oFPnDk0k4vfkXfQe4ovblq6Qn0HYPxK998/IaMYxPpihGbk4lUrRtOVjivFT00b5kKzoVPVxEFCmvOHDI/s+ovTn27HR2+lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485026; c=relaxed/simple;
	bh=XQf3/FeoaBmhLuV18cO6IXyBZ3cqa7lrQgUfRN4w1mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0Z9Fp5a0qNltI7sobwjuLv9NCgXS12HCTmFGo4v0CrR7YZ82JUA8C8vA8WdlrXXQCVee9JrRVDdr4jSng+HUd0HA/mVWvSlzbdUTvt8sYmMs7aEF9Jrr/60bqwV1/pV/g6RAfwHR6ECr002iD6o7aBiyzb5Uqv6UGBLrc7Ar/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxqA+V34; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8f231f3b130so293955285a.3
        for <stable@vger.kernel.org>; Mon, 11 May 2026 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778485022; x=1779089822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKuYit74Tf289NdrqxvgCkfuNHCHh3wo2jZv3YeRqUI=;
        b=mxqA+V34UMu7qo0QbA+25VoJqGUNnmy20wEC3Yc74qHdCmakLvqm/wtmiMebEX5rsf
         hNDQ7UbDWFQBThcKWHxqMEzlGpwi9j7Yrzpa5yjyi1FRtlAYACncWzxoeVKcQLsoSmED
         f1+VNIVe+pnR52tGaxamNlIPuUK6+s4A5H4OQWp3FJL7YBKRTwgeGs3IaUmTTlXhBNSW
         IsdTziknL14JH9rZ+973n8ORXzp8GABwWZR7vv2yGySdUNpSluOC/M2qf4zU3iqesbBl
         XXURvcc/wMeOGoZzH2jdj/2O+HlYs6SdJRvoLCPV5VQryk6qC0bOA8uwjxLF55NyeV3c
         tY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485022; x=1779089822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FKuYit74Tf289NdrqxvgCkfuNHCHh3wo2jZv3YeRqUI=;
        b=Sodwcj0REi7DwBEFxtmfpgnY8C7eeZoPeXqVKOkgJ1vUedvmFlD1Wcy5p/t1LHex0Q
         R65p4P2I1dTCO4BbtOGJsZJuGaw0vB0pwQBhmz9XFwZJFyALD0YkLfd28nMtUfW7Std/
         jBpf7DuVwugE8GHiy6oSNu7fIrJWqLXPZHo6BwXVuKulfpQN9LnwndGzyTmlgddHjwST
         wO0h5y6N3zQTAhMz6Pp5Zl9nwyZBDkZM8ueJonH+VBj3Q6V29pcIk9Z44WcDxlqirDbE
         N/bZa541+Q2ieGmc46t0g2AS69iYOzE1D7L0BpP5KNv8GkmyisCCPYjqXjhQfqAjsdcm
         8pew==
X-Forwarded-Encrypted: i=1; AFNElJ8GtrUqWcAI27ZifLuqKwMYsLmPcNQAeZGfximB6CFbQbIRzxdw80LUp5L69rOo4cyGJvcctZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Zza6WCEeFwB97GwQB+4WcGx6/eEUPONPg2tQ6obktM+Nx5qn
	gjxNMi7l6DIxKhVrlTpaVxu6lqMmKnhj0mHG6R3dZnZEU4043S3HfRI6
X-Gm-Gg: Acq92OEf7jy+9eMsFx0xSVbwg+VjIoi4rsi7mOjG48OTzK68rTjWg8zTuCPOHUOQ5/A
	kBGYRnqxD6jpeLEbiR99Oy49sUxbmBBrlFQX8JzCDXreMEifnc3hkQs85z71W8PHnxvk/nlp27W
	6i4gb7Lai2AasF7U/Hujuw1zfF0feyPMle3K/VQsWI3nvjTNu5bopspX6fvWGp1NEgpuNfyl/tM
	okbA5CMGzLw2jQ3S0dDJFn0lFrSqs1J9lD8FO19K4mmdiSm6HmdvpKjqei9WiSsQ/9rgjRqfIY3
	v/6Surn5B/cYpNw/Mf6DVNNyvqDtG8MzJ7BoAMuuJuY/7tY/s2s+BO+KuVFZO8Hu9wwApHvFF3T
	EtPGNAF7SyFtnR0uUt/AyF99pgJLuBnFm16hfo4faVYX2aE2XYxmU+7LzGUvljI6+cDxG6NvArO
	6NIrDnABeGeNK705TNfPuErDGEAZTG1OHehud/F+XtPQPNGaHDnmt+f8Pl3yqC8A==
X-Received: by 2002:a05:620a:370d:b0:8d0:27b8:fb7 with SMTP id af79cd13be357-904d68e0a4dmr3493882785a.46.1778485022050;
        Mon, 11 May 2026 00:37:02 -0700 (PDT)
Received: from rawhide.lvn.broadcom.net ([192.19.161.250])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-907b986c371sm957371385a.2.2026.05.11.00.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:37:01 -0700 (PDT)
From: Shreenidhi Shedi <yesshedi@gmail.com>
To: gregkh@linuxfoundation.org,
	acme@kernel.org,
	linux@treblig.org,
	mikhail.v.gavrilov@gmail.com
Cc: yesshedi@gmail.com,
	stable@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6.1.y v2 06/18] perf tools: Use const for variables receiving str{str,r?chr}() returns
Date: Mon, 11 May 2026 12:40:39 +0530
Message-ID: <20260511071051.537859-7-yesshedi@gmail.com>
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
X-Rspamd-Queue-Id: 56CD55097FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,redhat.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245128-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,treblig.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[yesshedi@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.952];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

From: Arnaldo Carvalho de Melo <acme@kernel.org>

commit 45718bce7daf39c618188b70a52644bb5a2f968a upstream

Newer glibc versions return const char for str{str,chr}() where the
haystack/s is const so to avoid warnings like these on fedora 44 change
some variables to const:

  36     8.17 fedora:44                     : FAIL gcc version 15.2.1 20251111 (Red Hat 15.2.1-4) (GCC)
    libbpf.c: In function 'kallsyms_cb':
    libbpf.c:8489:13: error: assignment discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
     8489 |         res = strstr(sym_name, ".llvm.");

Reviewed-by: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/r/20251211221756.96294-4-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
---
 tools/perf/jvmti/libjvmti.c | 2 +-
 tools/perf/util/evlist.c    | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
index fcca275e5bf9..d6b04d0fd35a 100644
--- a/tools/perf/jvmti/libjvmti.c
+++ b/tools/perf/jvmti/libjvmti.c
@@ -142,7 +142,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
 	*/
 	if (*class_sign == 'L') {
 		int j, i = 0;
-		char *p = strrchr(class_sign, '/');
+		const char *p = strrchr(class_sign, '/');
 		if (p) {
 			/* drop the 'L' prefix and copy up to the final '/' */
 			for (i = 0; i < (p - class_sign); i++)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 41bbe6f85b0d..391a694ae2af 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1885,7 +1885,8 @@ static int evlist__parse_control_fifo(const char *str, int *ctl_fd, int *ctl_fd_
 
 int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
 {
-	char *comma = NULL, *endptr = NULL;
+	const char *comma = NULL;
+	char *endptr = NULL;
 
 	*ctl_fd_close = false;
 
-- 
2.54.0


