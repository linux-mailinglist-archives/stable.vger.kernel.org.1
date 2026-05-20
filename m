Return-Path: <stable+bounces-252319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIgzG8v5DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-252319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C5A595976
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE18531181C1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB23FB072;
	Wed, 20 May 2026 18:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lMlGYaUa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FBD3F7AA9;
	Wed, 20 May 2026 18:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300365; cv=none; b=DgtaWKW3IEaG6Plzdp98hIoQ1dqlZZYDozmAz5la3YvMOu4yIbtW8AIlFN+D0CQlUX+0e0ckil1yWNvS6gtgyE/t9ieaTXOQgAm9tf+iyglR962gTUpkA2BUvR1AdJzAFFvrgzAjYtQnMTcM6+dxO9gEv/NYomLJc8owsSDxiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300365; c=relaxed/simple;
	bh=myL0ZE0dEBX2BtaklCf/iKd4JwvKFDqzGcqFHYLN/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3Tc8Gu+t/Vzjfv6noEL3z3xsQWPOAO6P1UL2p3pzcM7aENICcaZQLmiuJOYvbguUYvIw+eRw0pmwTksM7aa5xbVeuH8C2nKibGQbis+pf2B4FpqyU2wKhJtknYmVS/7hqvVpbtS+XrMnuuoWZnDD2y8wOQlXqIVdAEsQoaYSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lMlGYaUa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0EBF1F000E9;
	Wed, 20 May 2026 18:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300364;
	bh=5RHMIPM9Ff7AJ7fi1E90kB4guJzudk7p8jKPvFaWGIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lMlGYaUaOUZTMh9IJi2pYC/6oa64ds38qbEBwBS+IiQMjkaFUmNLr83BzFTayYM4i
	 cRo7MHiF4mblWz/dnBPPbEy9CrdolJjrqcZ+IzfmwGI4URsdQRUAeg+2GXsOF+vTQF
	 ct6mGvzKNibp2FaO5jvqBNjauBeQCnTO8dPHz1us=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Carlier <devnexen@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 147/666] selftests/sched_ext: Add missing error check for exit__load()
Date: Wed, 20 May 2026 18:15:58 +0200
Message-ID: <20260520162114.394324483@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252319-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 15C5A595976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 1d02346fec8d13b05e54296ddc6ae29b7e1067df ]

exit__load(skel) was called without checking its return value.
Every other test in the suite wraps the load call with
SCX_FAIL_IF(). Add the missing check to be consistent with the
rest of the test suite.

Fixes: a5db7817af78 ("sched_ext: Add selftests")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sched_ext/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/exit.c b/tools/testing/selftests/sched_ext/exit.c
index 2c084ded29680..b4a8dd630b550 100644
--- a/tools/testing/selftests/sched_ext/exit.c
+++ b/tools/testing/selftests/sched_ext/exit.c
@@ -32,7 +32,7 @@ static enum scx_test_status run(void *ctx)
 
 		skel = exit__open();
 		skel->rodata->exit_point = tc;
-		exit__load(skel);
+		SCX_FAIL_IF(exit__load(skel), "Failed to load skel");
 		link = bpf_map__attach_struct_ops(skel->maps.exit_ops);
 		if (!link) {
 			SCX_ERR("Failed to attach scheduler");
-- 
2.53.0




