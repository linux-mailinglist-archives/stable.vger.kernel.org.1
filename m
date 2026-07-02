Return-Path: <stable+bounces-271229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cGEtEA2aRmpKZwsAu9opvQ
	(envelope-from <stable+bounces-271229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:04:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF216FAEEC
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=kpPLwh1t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271229-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-271229-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B182633DFD64
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B5346E7A;
	Thu,  2 Jul 2026 16:50:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82F339B3D;
	Thu,  2 Jul 2026 16:50:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011003; cv=none; b=j1l1E50nrl+KUU//SsRhd38PVr45AfI21t15lHZMa0BYDWgD91ZKNDFT20JHpTZE8MW8Dd3Fn/0bOaqbfeWRL9ClNcG5zbaevPVPU6roWScMEH6pZCBv12ZJV0YOvnc7Tkaf+fZSdBrNEOCFINzd8RQhszP8N27Pm6r1v1MmlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011003; c=relaxed/simple;
	bh=Z9LZ06OG8m0ZN1Eo2/bp7ydbqZCWHllaJUncKjgRjg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6oLgFDa6Q3dgqfLE7ahc7Cpfbj2Tt2kIQzCO1IlLoEOhMiHfAoKPfTjTJ+H0OR3CoG1w6Rh1cSDhDOkze02qZRw1ijIfZXOWB5/89MGIX45QBPsrLV6n85hM9wyumKRLd5NqReGFzZf7GVJGZ5WfTBczsP0Q092YI4GisELVaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kpPLwh1t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16301F000E9;
	Thu,  2 Jul 2026 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783011002;
	bh=P+kb3NoZ4NTmQ7xWVVH85UFuEgfPmsdN1ajGG1Z3/Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kpPLwh1tB+Z/ZI5TeSn1MSVxeFrV1CMZUMSVRukyruCWj2BZzEWFDmVkas1L8t8iX
	 2EMRwWHRCns9nlf2B/aNm1PEbZIkOOHdGDiIZ0bEInIcbRuSgzKRawzx6n9SI+G8s2
	 cXQUfJI3O2rkvBP9FctsxpDGGF9LvfHi58CuTqJw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhen Yan <sdjasjbuaa@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 6.6 119/175] ntfs3: reject direct userspace writes to reserved $LX* xattrs
Date: Thu,  2 Jul 2026 18:20:20 +0200
Message-ID: <20260702155118.260213596@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155115.766838875@linuxfoundation.org>
References: <20260702155115.766838875@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_HAS_CURRENCY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sdjasjbuaa@gmail.com,m:almaz.alexandrovich@paragon-software.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271229-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,paragon-software.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7CF216FAEEC

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit 5b08dccecf825cbf905f348bc6ccb497507e28e2 upstream.

NTFS3 uses $LXUID, $LXGID, $LXMOD and $LXDEV as internal WSL
permission metadata and reloads them into i_uid, i_gid and i_mode
from ntfs_get_wsl_perm().

Because the empty-prefix xattr handler also lets file owners call
setxattr() on these names directly, an unprivileged writer on a
writable ntfs3 mount can plant root ownership and S_ISUID on their own
file and gain euid 0 after inode reload.

Reject direct userspace writes to the reserved $LX* names. Internal
ntfs3 metadata updates are unchanged because ntfs_save_wsl_perm()
writes them via ntfs_set_ea() directly.

Signed-off-by: Zhen Yan <sdjasjbuaa@gmail.com>
[almaz.alexandrovich@paragon-software.com: added an additional check for non privileged users]
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/xattr.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -828,6 +828,12 @@ out:
 	return err;
 }
 
+static bool ntfs_is_reserved_lxattr(const char *name)
+{
+	return !strcmp(name, "$LXUID") || !strcmp(name, "$LXGID") ||
+	       !strcmp(name, "$LXMOD") || !strcmp(name, "$LXDEV");
+}
+
 /*
  * ntfs_setxattr - inode_operations::setxattr
  */
@@ -932,6 +938,12 @@ set_new_fa:
 		goto out;
 	}
 
+	/* Do not allow non privileged users to change $LXUID/$LXGID... */
+	if (ntfs_is_reserved_lxattr(name) && !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out;
+	}
+
 	/* Deal with NTFS extended attribute. */
 	err = ntfs_set_ea(inode, name, strlen(name), value, size, flags, 0,
 			  NULL);



