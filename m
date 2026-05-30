Return-Path: <stable+bounces-257596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGUpHLccG2qQ/QgAu9opvQ
	(envelope-from <stable+bounces-257596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:21:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921F60F7EB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 141FC301023D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C623242D7;
	Sat, 30 May 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2HVKSojg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350431C5799;
	Sat, 30 May 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161530; cv=none; b=pr8zrliXEnlu8qpeo+fYf9cKhtj8FgWL7cPOQ1D7rH/W0SNOTuQpOimwTfjEp/IJU4M50UnvubpiHdJa2h69BeXbT6BRVoff73cYXceubyEwi3dTPIzWp/JsSWVMtbV99RAdc9rAmG2aDrRYRbEmLEgyQec+tMni185FyyXv7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161530; c=relaxed/simple;
	bh=xqutCXFy1CU2yu4vATjTXfPBSAFimTU0eRv4ZYq+WHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdo2fREyPnbhKEHhM6ACPtKMrGycE+x/gYRPORA4BYM5jpAIq5v1Xb5//NQSvpYlkAY52iFu8CJbYoH4u3F9ZqaAU9nRPHSocwXrDYALdiFrFNRuzitYEHG0drxBZwcm4p/Id0kbTbVrSxfCcmP/92gx/rrG95TRsDNyMFq67YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2HVKSojg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD4D1F00893;
	Sat, 30 May 2026 17:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161528;
	bh=L4kr/nErAOHS9h+nb8wrB1a8yOYWr6tHjzGjIJZ0eP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2HVKSojgrm3t5lt15yR87qwg0voSb5e3TDlDg+TRp5O58ANd+gzkazKXL4gPXz7aw
	 hGbFuvbi0lqVpiovUGBjLBCLoqk3k0T5pPwNoalFy+8wVPIUG1HlAai9FNQbWjaZer
	 jYZv2nlbdnK/eBADE2l/PY1HURpskYUaTI2Ojnzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 633/969] perf util: Kill die() prototype, dead for a long time
Date: Sat, 30 May 2026 18:02:37 +0200
Message-ID: <20260530160317.929744389@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257596-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7921F60F7EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit e5cce1b9c82fbd48e2f1f7a25a9fad8ee228176f ]

In fef2a735167a827a ("perf tools: Kill die()") the die() function was
removed, but not the prototype in util.h, now when building with
LIBPERL=1, during a 'make -C tools/perf build-test' routine test, it is
failing as perl likes die() calls and then this clashes with this
remnant, remove it.

Fixes: fef2a735167a827a ("perf tools: Kill die()")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/util.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index c1f2d423a9ecb..bdb6d5e7102db 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -17,7 +17,6 @@
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
-void die(const char *err, ...) __noreturn __printf(1, 2);
 
 struct dirent;
 struct strlist;
-- 
2.53.0




