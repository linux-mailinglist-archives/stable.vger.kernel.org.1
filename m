Return-Path: <stable+bounces-265077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8a7PKiKDMWoalQUAu9opvQ
	(envelope-from <stable+bounces-265077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DB692C72
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:08:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="XO/nodHD";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265077-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-265077-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6BF730CC7F5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD14657CF;
	Tue, 16 Jun 2026 17:02:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F6472767;
	Tue, 16 Jun 2026 17:02:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629361; cv=none; b=TLpY9V8pwiNeg089SbcAStK7OwFOgT7QtQeUH0q6dWaXSvviQjifxF7a/YE8XW0cprgDJKt9G6R+3KnC/hc97qk/y/+DZPYcOds4BlK2zxdmL/cTYcNsqW5195sW6uk7oU4HNGN6PvGhxNusq4e+gg0U6jxV0hm1l/rTwxF8r6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629361; c=relaxed/simple;
	bh=XUt3KUx6xY8sZYyN7qDH8LObvW7Ka/gAN3UKG33Vh1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdxAIItjJ+eeNr6fvZgRXRb1e2Yi5ibFnWHRkr1KsCFpi2k1oXKIEyBYsM5Iv9XGUAYHaYsYoQTZZfzEsRv6DzfYFna7EchM2XsGig9ooiD3Jy84wDSXuDfV3UeggZv8XStJRr7qvjF0PFsrS/uuvVTkUB8rhth7Ejjw1Trlz18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XO/nodHD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148921F000E9;
	Tue, 16 Jun 2026 17:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629360;
	bh=L/jeg9LYXI0KE4W760SHvH7hOhdtkM2/mevdEbpNRQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XO/nodHDUNrZ56oZvMmDiUFTlV5aqKOwbiS/UmIp3VNNK+M/XD9kqmAlkEZlWfcY3
	 rrv6sIseyg+CZkhFXh+ja6Xr0zwHdvlNNwouInUoetOerto98NAxdfjYpuJHxWdrz3
	 L2Mz3eMMxrhfv9cHGudsm4FBh5UOKQMN/gIWpDBk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 253/452] tools/rv: Fix cleanup after failed trace setup
Date: Tue, 16 Jun 2026 20:28:00 +0530
Message-ID: <20260616145130.942358719@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265077-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:namcao@linutronix.de,m:gmonaco@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E8DB692C72

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 33ec2269a4155cad7e9e42c92327dcaa9aee59a7 ]

Currently if ikm_setup_trace_instance() fails, the tool returns without
any cleanup, if rv was called with both -t and -r, this means the
reactor is not going to be cleared.

Jump to the cleanup label to restore the reactor if necessary.

Fixes: 6d60f89691fc9 ("tools/rv: Add in-kernel monitor interface")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20260514152055.229162-5-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index ced72950cb1eed..64ae847313f6dc 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -655,7 +655,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	if (config_trace) {
 		inst = ikm_setup_trace_instance(monitor_name);
 		if (!inst)
-			return -1;
+			goto out_free_instance;
 	}
 
 	retval = ikm_enable(monitor_name);
-- 
2.53.0




