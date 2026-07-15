Return-Path: <stable+bounces-274883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4It8O9BhV2osKwEAu9opvQ
	(envelope-from <stable+bounces-274883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:32:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D3275D05D
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 12:32:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=NlZK96Sw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274883-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274883-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E4C0E3011344
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6203418A4D;
	Wed, 15 Jul 2026 10:32:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E642BC49
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:32:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111566; cv=none; b=e+2a7S1DBNY+f9/VanVhCkNQzJjoKAwR6d8y3IldijHIt1+Iljen1Hjklit46OAVjwGKIKA/ahsi+pqq3iaVtkrZkem4UHSwBZx8UsiFaC0SXb4UCEjlZ2QiLBrEfEuwvgXG6NR5DDNtX5RqBhJKlt8SC0PANUjsBXhG/Wb7xY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111566; c=relaxed/simple;
	bh=taOqnaAI3Z87r5Ahoqtg/ssMN4JA2N6EaPbuZoaTfiQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lQYL+4EkxQYOw96ZeqzfJSaMPPNb728cAxbIHxLCVSU3e9K5g3SD84qqbwxzpUo+cTI2WHzuarsL/pDd2UOABNM5bsbNjjik1vxjll4g+HUmNe1nHtejhv4aWtkqu+ntlq97nW7zWTJ9HQW83CLyvTZjffPyzeAa36Mook/HkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NlZK96Sw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05FC1F000E9;
	Wed, 15 Jul 2026 10:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784111565;
	bh=lnx0KXcUqYHYgXCw72aA0g+axRZB3uhP+FPsdVnYNv0=;
	h=Subject:To:Cc:From:Date;
	b=NlZK96Sw/qkMtgQwVTGearF7oF7hVfwjKZPTRGJOTK4HRETjAn/VDdE7MACLNfaaT
	 b4xQ7G2CAreMvNUmSOrbNtoGRHkAabsH4cFQn9hWo/Nrm9nBb3/heyZ7NeF6T4hodc
	 eXGMaNv0UddArp10dT8Mtxpx8Z8rtGQgsLJtNfds=
Subject: FAILED: patch "[PATCH] regulator: scmi: fix of_node refcount leak in" failed to apply to 5.10-stable tree
To: vulab@iscas.ac.cn,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:32:26 +0200
Message-ID: <2026071526-gallstone-cattishly-3c76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274883-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:broonie@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,msgid.link:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77D3275D05D


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fa11039d6cdff84584a3ef8cc1f5e1b56e045da2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071526-gallstone-cattishly-3c76@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fa11039d6cdff84584a3ef8cc1f5e1b56e045da2 Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Wed, 27 May 2026 10:48:50 +0000
Subject: [PATCH] regulator: scmi: fix of_node refcount leak in
 scmi_regulator_probe()

scmi_regulator_probe() calls of_find_node_by_name() which takes a
reference on the returned device node. On the error path where
process_scmi_regulator_of_node() fails, the function returns without
calling of_node_put() on the child node, leaking the reference.

Add of_node_put(np) on the error path to properly release the
reference.

Cc: stable@vger.kernel.org
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260527104850.872415-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 6d609c42e479..c005e65ba0ec 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -345,8 +345,10 @@ static int scmi_regulator_probe(struct scmi_device *sdev)
 	for_each_child_of_node_scoped(np, child) {
 		ret = process_scmi_regulator_of_node(sdev, ph, child, rinfo);
 		/* abort on any mem issue */
-		if (ret == -ENOMEM)
+		if (ret == -ENOMEM) {
+			of_node_put(np);
 			return ret;
+		}
 	}
 	of_node_put(np);
 	/*


