Return-Path: <stable+bounces-219516-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBpLOB2hnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219516-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:13:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6431931C3
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6394D320AFA4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252C31A807;
	Wed, 25 Feb 2026 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E7xQt6N+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844A2D73BE;
	Wed, 25 Feb 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002767; cv=none; b=QwfLVnSH2CxNRogk1oAT5Q+kvhMRSrc0ExSz2PTR0V1tJ6gsdAG6Z2dOmGUWgK6nFFv/ykY5a2gKt+Q0JfyvNkmBaFhEcfPhl6UtjGFgUKtWkQ0CglAagnXgXtO8a7I4cBtRpMYMKmPBMPeHy/qMirTQj/DtXj3tGH73e2r4n7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002767; c=relaxed/simple;
	bh=zS9HUu7/zYuBJ8mXCTvHr3FvfDIQcx/PBPauXKb/hnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=afX+TRCQg5MpNW3e/aJL06eQRYkTdQP+weMG24kUy/ozLNyBhaHW55ghBmThmaKItyTdyAYuxs8v2QL10zOpEx70RgUu41rWe18h319RfEJCPb4dMfMt6rlLg9kBJqgMnqoofO1+DjhgCoF1DPqUqKIcQcT3/2mn77ieG5bycIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E7xQt6N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11B4C116D0;
	Wed, 25 Feb 2026 06:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002767;
	bh=zS9HUu7/zYuBJ8mXCTvHr3FvfDIQcx/PBPauXKb/hnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E7xQt6N+STBuyxcG3rInHxdL9noiB//pc48+xXDvIz1QwQlvY+N5zGxsUF/a5RMEp
	 J5ie+rSTS8gCLLZlTSsudlvQYga57BrKKOLqyVHbZRST8Rojd/HXr+OEOQBeWmWJdT
	 v+nPKWtJ6b6hzBHrNmjkhn6+MMWESd6CoMQEelPA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Georgia Garcia <georgia.garcia@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 571/641] apparmor: move check for aa_null file to cover all cases
Date: Tue, 24 Feb 2026 17:24:57 -0800
Message-ID: <20260225012402.356666330@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219516-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,canonical.com:email]
X-Rspamd-Queue-Id: 5B6431931C3
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 4a134723f9f1ad2f3621566259db673350d19cb1 ]

files with a dentry pointing aa_null.dentry where already rejected as
part of file_inheritance. Unfortunately the check in
common_file_perm() is insufficient to cover all cases causing
unnecessary audit messages without the original files context.

Eg.
[ 442.886474] audit: type=1400 audit(1704822661.616:329): apparmor="DENIED" operation="file_inherit" class="file" namespace="root//lxd-juju-98527a-0_<var-snap-lxd-common-lxd>" profile="snap.lxd.activate" name="/apparmor/.null" pid=9525 comm="snap-exec"

Further examples of this are in the logs of
https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2120439
https://bugs.launchpad.net/ubuntu/+source/snapd/+bug/1952084
https://bugs.launchpad.net/snapd/+bug/2049099

These messages have no value and should not be sent to the logs.
AppArmor was already filtering the out in some cases but the original
patch did not catch all cases. Fix this by push the existing check
down into two functions that should cover all cases.

Link: https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2122743
Fixes: 192ca6b55a86 ("apparmor: revalidate files during exec")
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/file.c | 12 ++++++++++--
 security/apparmor/lsm.c  |  4 ----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 919dbbbc87ab6..7de23e85cd5d0 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -154,8 +154,12 @@ static int path_name(const char *op, const struct cred *subj_cred,
 	const char *info = NULL;
 	int error;
 
-	error = aa_path_name(path, flags, buffer, name, &info,
-			     labels_profile(label)->disconnected);
+	/* don't reaudit files closed during inheritance */
+	if (unlikely(path->dentry == aa_null.dentry))
+		error = -EACCES;
+	else
+		error = aa_path_name(path, flags, buffer, name, &info,
+				     labels_profile(label)->disconnected);
 	if (error) {
 		fn_for_each_confined(label, profile,
 			aa_audit_file(subj_cred,
@@ -616,6 +620,10 @@ int aa_file_perm(const char *op, const struct cred *subj_cred,
 	AA_BUG(!label);
 	AA_BUG(!file);
 
+	/* don't reaudit files closed during inheritance */
+	if (unlikely(file->f_path.dentry == aa_null.dentry))
+		return -EACCES;
+
 	fctx = file_ctx(file);
 
 	rcu_read_lock();
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 5fc99fe8d38a4..be3678d08ed23 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -524,10 +524,6 @@ static int common_file_perm(const char *op, struct file *file, u32 mask)
 	struct aa_label *label;
 	int error = 0;
 
-	/* don't reaudit files closed during inheritance */
-	if (unlikely(file->f_path.dentry == aa_null.dentry))
-		return -EACCES;
-
 	label = begin_current_label_crit_section();
 	error = aa_file_perm(op, current_cred(), label, file, mask, false);
 	end_current_label_crit_section(label);
-- 
2.51.0




