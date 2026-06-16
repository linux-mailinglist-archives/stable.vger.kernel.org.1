Return-Path: <stable+bounces-265769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MgvfJ6OPMWr9mgUAu9opvQ
	(envelope-from <stable+bounces-265769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:02:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 186A6693BDE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:02:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=U6uOP3Ou;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265769-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265769-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BB8314A01D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF5D3CFF55;
	Tue, 16 Jun 2026 18:01:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B13D5252;
	Tue, 16 Jun 2026 18:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632890; cv=none; b=RsTTtHcnZ9/kWDYZ01wmFKeu+ajtULEvetKs5HMRZsv0c/abx+MSGbMO/rz+HyPsoHJuk94vYEEL9JXicejovkRCdHm7hg9jb3qR5f0oJijkCsxKsQceiJ2eKMWhiS3xTmZ0KYD0WLaXnL3TbJs5g873wlGWkkBwa3uCwVBnfa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632890; c=relaxed/simple;
	bh=gEzo6PX+pZyDdKnRiLVsGHUWEwmsPDFKC+mr1hmdnXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiLwRnzcjtI5RdD1T+oUnoWigAl1fjbTXj+V0c6ELZ2JlA4G/HSuL7t+tLHK/vOsJ2U9EH/nlXBP9ni/MlcdljRiJSFmRZ7UMsRCCW9qcwd//vHyfZZVcG3FIR7AC56h9R58c4KBk/la6ft1/+2DlnfoBjqLNUQt4qm2ozJKvOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U6uOP3Ou; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F051F000E9;
	Tue, 16 Jun 2026 18:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632888;
	bh=9h0Ae3l0e9qvOLqUnYa5749jo2bKZivW9H+cAeO7Aik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U6uOP3OuA0Ig8eE8QIf48KvuZd+g3q2ll3DJGiXiYTUcNiaMcqb9FsaGGg3EEbHF/
	 LgJsV96RVfHF1v6jaCJuf+yJpm2TKjcDa4HtvzWQiqgHVLeIFe1wo4dxTkoE6pkpNH
	 RvAPsmKP1v1ru7R+lruos79+dF88akAPlhE9HyCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh@kernel.org>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.1 496/522] perf parse-events: Make YYDEBUG dependent on doing a debug build
Date: Tue, 16 Jun 2026 20:30:43 +0530
Message-ID: <20260616145148.984816767@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265769-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:irogers@google.com,m:namhyung@kernel.org,m:adrian.hunter@intel.com,m:alexander.shishkin@linux.intel.com,m:cuigaosheng1@huawei.com,m:mingo@redhat.com,m:james.clark@arm.com,m:jolsa@kernel.org,m:kan.liang@linux.intel.com,m:mark.rutland@arm.com,m:peterz@infradead.org,m:robh@kernel.org,m:bpf@vger.kernel.org,m:acme@redhat.com,m:florian.fainelli@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,vger.kernel.org:from_smtp,huawei.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 186A6693BDE

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

commit d4ce60190e08d84f88937019defa5e3d23409ac1 upstream

YYDEBUG enables line numbers and other error helpers in the generated
parse-events-bison.c. These shouldn't be generated when debugging
isn't enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rob Herring <robh@kernel.org>
Cc: bpf@vger.kernel.org
Link: https://lore.kernel.org/r/20230911170559.4037734-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/parse-events.y |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -6,7 +6,9 @@
 
 %{
 
+#ifndef NDEBUG
 #define YYDEBUG 1
+#endif
 
 #include <fnmatch.h>
 #include <stdio.h>



