Return-Path: <stable+bounces-250248-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHGGHGzmDWqm4gUAu9opvQ
	(envelope-from <stable+bounces-250248-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5958A592894
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D23E730A2F54
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EDA36B067;
	Wed, 20 May 2026 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vDKJz7xL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F1A3B3886;
	Wed, 20 May 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294914; cv=none; b=SgAJvSZJd47zZSb7dxs4oZVmBgbwbPOut22wRb5o9c7kc6M/Ap8fWJngONk0PXFLfEOO882+/Ir32T5rcgfAczy4Dx7MBXkmjdxdNovaNCILCvNs6dOnw/DtUCiMn2z6DXsvv2LVs+XF1LvzUMqwUDsvcR0Ie0ezQyZbZajfGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294914; c=relaxed/simple;
	bh=kIavojjj7+2xkl5kpgU+sZ4DbVg2jp8nWvQ6udu5lFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftbJ6S3J+d7tslz5kogYMQlh8AhEp5/lFVB3VSNzPfH54c7ZdrAavY5BREYZHTKmJk4qHhvyI7oDJlcn5TkMAtxzi8jCM3MFNRkYeCoY0NI8ze7T9MclpWsdDNALzY17EGsbwCSZztm1zoTLZydfokITaPuiNC3UfEP+4p6b/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vDKJz7xL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2454C1F000E9;
	Wed, 20 May 2026 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294913;
	bh=7AT/EfZVZqQu59+72RJGeEp8O92Xx5DT67DP+ccm3Ng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vDKJz7xL3M6Szf0W/sp796enoRpOihF9qNoqCGKmGFHD2dgFllaAFCCY4hAQeeMJ+
	 co5mPdD3x6dHj1kR1KzrqPzim18HnQeB2DHkxTpYLyulEJNMdEfUy7O9AA4voHV4yD
	 4wd7WQiSDnov5G8cuMITtOix8vt5JuvU9P0JImWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0221/1146] selftests/namespaces: remove unused utils.h include from listns_efault_test
Date: Wed, 20 May 2026 18:07:51 +0200
Message-ID: <20260520162153.258465937@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250248-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 5958A592894
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit cad3bf1c330274d11f25f1b7afae9b9dba13fbd3 ]

Remove the inclusion of ../filesystems/utils.h from listns_efault_test.c.
The test doesn't use any symbols from that header. Including it alongside
../pidfd/pidfd.h causes a build failure because both headers define
wait_for_pid() with conflicting linkage:

  ../filesystems/utils.h:  extern int wait_for_pid(pid_t pid);
  ../pidfd/pidfd.h:        static inline int wait_for_pid(pid_t pid)

All symbols the test actually uses (create_child, read_nointr,
write_nointr, sys_pidfd_send_signal) come from pidfd.h.

Reported-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/acPV19IY3Gna6Ira@sirena.org.uk
Fixes: 07d7ad46dad4 ("selftests/namespaces: test for efault")
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/namespaces/listns_efault_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/namespaces/listns_efault_test.c b/tools/testing/selftests/namespaces/listns_efault_test.c
index c7ed4023d7a85..b570746e917c1 100644
--- a/tools/testing/selftests/namespaces/listns_efault_test.c
+++ b/tools/testing/selftests/namespaces/listns_efault_test.c
@@ -19,7 +19,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include "../kselftest_harness.h"
-#include "../filesystems/utils.h"
 #include "../pidfd/pidfd.h"
 #include "wrappers.h"
 
-- 
2.53.0




