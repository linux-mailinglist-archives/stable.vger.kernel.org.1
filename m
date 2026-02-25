Return-Path: <stable+bounces-218423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMyOMb5TnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1294B18F9E7
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94FFA30CF405
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191C20C012;
	Wed, 25 Feb 2026 01:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GDsMLzZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA58918B0A;
	Wed, 25 Feb 2026 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983242; cv=none; b=SfQxVSc5MMxoIikP1yZcvVeiZCcwMG/FrKSGPZtgGUNMfrrxCcip2mAz7P47Wt7hP31YGxMBZ2b7VJ+9U8b7bn6C+J/wMSvJJswTaAcv6TjzZQNuA5WlAwcnU4YDhq2qqoP5m+ru5ezSGh3UfKhk9uzXx16bs/OVt4e+3HNnJLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983242; c=relaxed/simple;
	bh=J1F6NtwHY4SVimAIHdjQyHXdtAS0ZjfBL4BHOFBXogQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8+OoQc/EzZdAr7kzzio6yaEFOQ+F4y8u7OUXeDf+VU3cmGFN2wH/jS0pDxU10I37+HO1jRAxil/O+m6c/u1P9m8UOsBKe7w+t1/hUdEgz0MPkhYa/IACPi2VyA3DppL+0GiFeb35lCNNttUCu1nhsHNIzG5gwem/0cwBT+Qj+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GDsMLzZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82426C19423;
	Wed, 25 Feb 2026 01:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983242;
	bh=J1F6NtwHY4SVimAIHdjQyHXdtAS0ZjfBL4BHOFBXogQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GDsMLzZg+WTvwdt9QiD83UoSNR1At5Vg5XHgUnXNd2bSXP6cK61uRdGUtJikH3ewc
	 HAdXEUZRRV6SdPf9pO/gy2DIHx/e096hbsj9kGzgT0lmwNPGwnPLf4ymkjp5s3ydtL
	 9do4VXZ56ZQdj8yu9HGgY2OVx97iO+YRKz1Il6sY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexey Gladkov <legion@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 384/781] ucount: check for CAP_SYS_RESOURCE using ns_capable_noaudit()
Date: Tue, 24 Feb 2026 17:18:13 -0800
Message-ID: <20260225012409.116490688@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218423-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:email,linux-foundation.org:email,xmission.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1294B18F9E7
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ondrej Mosnacek <omosnace@redhat.com>

[ Upstream commit 0895a000e4fff9e950a7894210db45973e485c35 ]

The user.* sysctls implement the ctl_table_root::permissions hook and they
override the file access mode based on the CAP_SYS_RESOURCE capability (at
most rwx if capable, at most r-- if not).  The capability is being checked
unconditionally, so if an LSM denies the capability, an audit record may
be logged even when access is in fact granted.

Given the logic in the set_permissions() function in kernel/ucount.c and
the unfortunate way the permission checking is implemented, it doesn't
seem viable to avoid false positive denials by deferring the capability
check.  Thus, do the same as in net_ctl_permissions() (net/sysctl_net.c) -
switch from ns_capable() to ns_capable_noaudit(), so that the check never
logs an audit record.

Link: https://lkml.kernel.org/r/20260122140745.239428-1-omosnace@redhat.com
Fixes: dbec28460a89 ("userns: Add per user namespace sysctls.")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
Reviewed-by: Paul Moore <paul@paul-moore.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/ucount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 586af49fc03e4..fc4a8f2d30965 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -47,7 +47,7 @@ static int set_permissions(struct ctl_table_header *head,
 	int mode;
 
 	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
-	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
+	if (ns_capable_noaudit(user_ns, CAP_SYS_RESOURCE))
 		mode = (table->mode & S_IRWXU) >> 6;
 	else
 	/* Allow all others at most read-only access */
-- 
2.51.0




