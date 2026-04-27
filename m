Return-Path: <stable+bounces-241412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKOSKeOV72ktDAEAu9opvQ
	(envelope-from <stable+bounces-241412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:59:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552B476BAD
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82508304C7E5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 085DD3845AA;
	Mon, 27 Apr 2026 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W+Plb62i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7066315D43;
	Mon, 27 Apr 2026 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309029; cv=none; b=a1e8+2cX/3CTUpAdwliYUssPTVaHEanjgEQMqBZBYN+3uL5dyX3YIbBq5Uq/aXDJdKOJGTTPdFDCJsxFfj3o/glwSoyeGDLrNt7DzEWujlKV2eUHytv/A38VRoUWvl28nhTqQ23EhqK+Epgnk5YHEUT19EuEzezu8m7aV3FuqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309029; c=relaxed/simple;
	bh=YdMUiCz23/6/lQS7mbEjjU5lVhGEnVd0qqRQbk38lBo=;
	h=Date:To:From:Subject:Message-Id; b=Ym7xvxr20ksuiJl76GVSqb+0pPxmMEd/XkJsPDqdbwRCs9IzSBj1zyzZgzr47Krs4DUOFUvOskxXWSbw5KWoXU2R4A9nB1UyRBrlLayD6A/ZXdCNQk3d5MDgG5bc+04/M18OK5nodwgMOIpMG3io5KvR+0oVdqE3T0DUhPrB3IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=W+Plb62i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A20FC19425;
	Mon, 27 Apr 2026 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777309029;
	bh=YdMUiCz23/6/lQS7mbEjjU5lVhGEnVd0qqRQbk38lBo=;
	h=Date:To:From:Subject:From;
	b=W+Plb62igFWTVuBRkRc7BvybqZOWLlxKFCYeLy5CocCvHcLNNqFJmgbTey4qoLuhd
	 ZlTdzG/XSJg7fiZV3u7dp+F/FWkFzD4mZ5piHNZFskEVGm7ItmuNuEztOXRMiaIWj+
	 1lhANiQ8v8DA+/1e04RcdC0p34iTMmqcIp+rvWkA=
Date: Mon, 27 Apr 2026 09:57:08 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,surenb@google.com,stable@vger.kernel.org,shuah@kernel.org,rppt@kernel.org,mhocko@suse.com,ljs@kernel.org,liam@infradead.org,david@kernel.org,luizcap@redhat.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + selftests-mm-run_vmtestssh-fix-destructive-tests-invocation.patch added to mm-hotfixes-unstable branch
Message-Id: <20260427165709.5A20FC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 7552B476BAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241412-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,linux-foundation.org:dkim,linux-foundation.org:email,smtp.kernel.org:mid]


The patch titled
     Subject: selftests/mm: run_vmtests.sh: fix destructive tests invocation
has been added to the -mm mm-hotfixes-unstable branch.  Its filename is
     selftests-mm-run_vmtestssh-fix-destructive-tests-invocation.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/selftests-mm-run_vmtestssh-fix-destructive-tests-invocation.patch

This patch will later appear in the mm-hotfixes-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Luiz Capitulino <luizcap@redhat.com>
Subject: selftests/mm: run_vmtests.sh: fix destructive tests invocation
Date: Mon, 27 Apr 2026 12:03:51 -0400

Destructive tests should be invocated with -d command-line option, but
this won't work today since 'd' is missing in getopts command-line.  This
commit fixes it.

Link: https://lore.kernel.org/214fd9e4-5398-4c26-859e-c982c2e277c3@redhat.com
Fixes: f16ff3b692ad ("selftests/mm: run_vmtests.sh: add missing tests")
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/selftests/mm/run_vmtests.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/run_vmtests.sh~selftests-mm-run_vmtestssh-fix-destructive-tests-invocation
+++ a/tools/testing/selftests/mm/run_vmtests.sh
@@ -103,7 +103,7 @@ RUN_ALL=false
 RUN_DESTRUCTIVE=false
 TAP_PREFIX="# "
 
-while getopts "aht:n" OPT; do
+while getopts "aht:nd" OPT; do
 	case ${OPT} in
 		"a") RUN_ALL=true ;;
 		"h") usage ;;
_

Patches currently in -mm which might be from luizcap@redhat.com are

selftests-mm-run_vmtestssh-fix-destructive-tests-invocation.patch


