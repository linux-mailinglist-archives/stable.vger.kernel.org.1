Return-Path: <stable+bounces-250208-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFPZGXflDWpz4gUAu9opvQ
	(envelope-from <stable+bounces-250208-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:46:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 098345926AC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5921B305A761
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA43EE1FD;
	Wed, 20 May 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iOZCAo/g"
X-Original-To: stable@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C263546D9;
	Wed, 20 May 2026 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294816; cv=none; b=fnqAzUxlQXbP3f3SyBes8GxxE3hoKw+u5Bm0hgIxWbqfBq0lg2CBQR9gRijvQHzBS9Ywa1MF0pZ4Ywh4onJQpMfeeQyKosEY957lomB489TCzucHXFpG97ITJNjOucRHmX7opWZ4HEko8BSRnKeEgAxvpu9wk9u07d9My3IkwsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294816; c=relaxed/simple;
	bh=2d5ScfYMkjkqAdd8jvTXB9vB35XMZJlsxvczlPl8KdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKDofu4wRFuChzHeXP2JEkXVPbTQGEkGTtxNjCvDL+X6l59S+Sp/f/Z1rKSYg4ayR9kOyQET9MlT2F6gF7zjOaQYgJmzatHIH8Ny0Hz3yU4N2qKexEo6iNisit8V006o/KrFG/mh9hcm9A1F6F3rOSRIKKO2ZoFwB6xuM/gmF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iOZCAo/g; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 7AF88C00087B;
	Wed, 20 May 2026 09:33:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 7AF88C00087B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1779294813;
	bh=2d5ScfYMkjkqAdd8jvTXB9vB35XMZJlsxvczlPl8KdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOZCAo/gkmSeSDjKRnX1F2G6qp9/Ox2oOPyPZ7hvSjhff2atEnxY6inkXZcVrJAQ9
	 BujoDCaZF4n2zAyhc4PLRvjosLwGkplxsH+VBpZzlwkimqmgs840YShiQPvn3V2QXU
	 V9u2HTA/VE7ATotbyM4usOM3sqrsbf+gZzk80Idc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id EB3B7AEA2;
	Wed, 20 May 2026 12:33:31 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-perf-users@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list:PERFORMANCE EVENTS SUBSYSTEM),
	bpf@vger.kernel.org (open list:BPF [MISC]),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.1 v2 4/5] tools build: Add 3-component logical version comparators
Date: Wed, 20 May 2026 09:33:19 -0700
Message-Id: <20260520163320.3073037-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
References: <20260520163320.3073037-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=dkimrelay];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250208-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim]
X-Rspamd-Queue-Id: 098345926AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit a9b451509565d40a5ca3b41c39a2b758cdbc5355 upstream

The next cset needs to compare if a flex version is greater or
equal/less than another, but since there is no canonical, generally
available way to compare versions in the command line (sort -V, yeah,
but...), just use awk to canonicalize the versions like is also done in
scripts/rust_is_available.sh.

There was a problem spotted in linux-next where a bashism, here
documents, aka the '<<<' stdin redirector, for strings to be used as the
stdin for awk. Use $(shell echo | awk ...) instead.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/scripts/utilities.mak | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/scripts/utilities.mak b/tools/scripts/utilities.mak
index 172e47273b5d..d69d0345cc23 100644
--- a/tools/scripts/utilities.mak
+++ b/tools/scripts/utilities.mak
@@ -177,3 +177,23 @@ $(if $($(1)),$(call _ge_attempt,$($(1)),$(1)),$(call _ge_attempt,$(2)))
 endef
 _ge_attempt = $(or $(get-executable),$(call _gea_err,$(2)))
 _gea_err  = $(if $(1),$(error Please set '$(1)' appropriately))
+
+# version-ge3
+#
+# Usage $(call version-ge3,2.6.4,$(FLEX_VERSION))
+#
+# To compare if a 3 component version is greater or equal to another, first use
+# was to check the flex version to see if we can use compiler warnings as
+# errors for one of the cases flex generates code C compilers complains about.
+
+version-ge3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) >= (10000000 * $$4 + 10000 * $$5 + $$6)) }')
+
+# version-lt3
+#
+# Usage $(call version-lt3,2.6.2,$(FLEX_VERSION))
+#
+# To compare if a 3 component version is less thjan another, first use was to
+# check the flex version to see if we can use compiler warnings as errors for
+# one of the cases flex generates code C compilers complains about.
+
+version-lt3 = $(shell echo "$(1).$(2)" | awk -F'.' '{ printf("%d\n", (10000000 * $$1 + 10000 * $$2 + $$3) < (10000000 * $$4 + 10000 * $$5 + $$6)) }')
-- 
2.34.1


