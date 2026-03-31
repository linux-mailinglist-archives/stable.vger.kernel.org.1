Return-Path: <stable+bounces-231972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLO1AD39y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CED836D913
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00B6530CA9DD
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EBF423A62;
	Tue, 31 Mar 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WiOQlwQA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5222F423149;
	Tue, 31 Mar 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975542; cv=none; b=BF42UPKwdSJbm+DCD9TytPdNNefukM4QJVcn/Y4HHkU/SEn25WM41q+Bx4ghRDre+QUrjuvMMoqP/hzwJLBGiN1x4vaehXbGWp9BzESna5/Omjmk2F+gFQsVQb+c+JWBUbec9ZRKOsPWmo5camDZ7M3170RD2R0N6IpH9ZKLCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975542; c=relaxed/simple;
	bh=lbnU6DfXrjZAfIcnYTfzYQ/pmg1i1+s8wgUYuO88EBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9bY7rsa8wF1p/shZznW+xVc0/4jkyMXWVQTCnksNTOWtrX8/9grSzpIFivtAhWhXULcSs/3b9IMWP1UIvdCCrp0FYaMqnK5gAEz2ZASPjpRxx0hq+aU9nOw44jOhD+GowuKMd8cBBmmIRKWPd/CStC1OvSiGE81+/5jjJHnPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WiOQlwQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40D3C19424;
	Tue, 31 Mar 2026 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975542;
	bh=lbnU6DfXrjZAfIcnYTfzYQ/pmg1i1+s8wgUYuO88EBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WiOQlwQAoXscH+I67OVeCtPhZ1sH3wiRj4AwGJwbZJvb0YAsICFQvOVM1kdF1DyPo
	 MoWKXhsr45Z+Utn+MJ4ZNjJSEJsF0Y5BefbiND3jeZYCGmnPqBoFKBh9ZbR3+dcW6Q
	 hn6iZYyOHBDRC6yVqqFQMdAO4aOgUZ2q9dJI6L2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 334/342] xen/privcmd: unregister xenstore notifier on module exit
Date: Tue, 31 Mar 2026 18:22:47 +0200
Message-ID: <20260331161811.194015903@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231972-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,kylinos.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 0CED836D913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

[ Upstream commit cd7e1fef5a1ca1c4fcd232211962ac2395601636 ]

Commit 453b8fb68f36 ("xen/privcmd: restrict usage in
unprivileged domU") added a xenstore notifier to defer setting the
restriction target until Xenstore is ready.

XEN_PRIVCMD can be built as a module, but privcmd_exit() leaves that
notifier behind. Balance the notifier lifecycle by unregistering it on
module exit.

This is harmless even if xenstore was already ready at registration
time and the notifier was never queued on the chain.

Fixes: 453b8fb68f3641fe ("xen/privcmd: restrict usage in unprivileged domU")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260325120246.252899-1-zhaoguohan@kylinos.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/privcmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index b8a546fe7c1e2..cbc62f0df11b7 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -1764,6 +1764,9 @@ static int __init privcmd_init(void)
 
 static void __exit privcmd_exit(void)
 {
+	if (!xen_initial_domain())
+		unregister_xenstore_notifier(&xenstore_notifier);
+
 	privcmd_ioeventfd_exit();
 	privcmd_irqfd_exit();
 	misc_deregister(&privcmd_dev);
-- 
2.53.0




