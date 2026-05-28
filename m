Return-Path: <stable+bounces-255508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMvcFzyjGGrJlggAu9opvQ
	(envelope-from <stable+bounces-255508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:19:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B97135F85EF
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BA9314A3C4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958C33F5BE;
	Thu, 28 May 2026 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N3toR/h5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295833F5B4;
	Thu, 28 May 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999108; cv=none; b=pqr5wlXXrrzEoX4tiV9Z7wQ03vDoZ+dt0YU0JMy9On9ns8yz9NYuYf3RWQDB8dCyQxf1+Sg78A2m8+sJySY+you0BIhoi6L45uscW4bdqxJckeZjPBx1xvANSY2dEbQreEpIDVU29SV+7QTfFuhpwdQO5CTnIw72Z6bSdaRMwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999108; c=relaxed/simple;
	bh=ELezFeciqlLRzpJSR/Qm/kpuZ93nC9qvyddUncH7IJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYLpZlXlurQH/vG7JstyPAoC//Febig3qOOOjUJlmD0M8FWpUvRFFVJeA0OYGkyzx416e0JDp9UV0H9mUPcxEmE9Ju5lXqCoS0psqDEn+DCKXP9yElAyHVu3Z0WKwxW1bbZXDt9KuSAeIYAenZkYaXr7ODbkHDIObHUZbFrRn+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N3toR/h5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242CE1F000E9;
	Thu, 28 May 2026 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999107;
	bh=MGmwGBg0rxxGIfXFe/tDSiVVjiKWdMCcz5B2ab4HxUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3toR/h5bg/FZF+lXTJBsP95nkESvhD1PY2v1GW59WbEnSZxfpzo3ZciWZKMZ8kTX
	 wMw5hzecjiRDC2OACQQwQDE1U0al/Sgbng6ralkfSbA4u7rGRQ62luC5UNb68M7JbK
	 Lc0yixR2rJDp8KYH8JLbD8GUAP6ar1nc4DJwXxuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 411/461] erofs: fix metabuf leak in inode xattr initialization
Date: Thu, 28 May 2026 21:49:00 +0200
Message-ID: <20260528194659.385800675@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255508-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,bytedance.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B97135F85EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia Zhu <zhujia.zj@bytedance.com>

[ Upstream commit 79b09c54c6563df9846ca3094bcfd72082c3e1d7 ]

commit bb88e8da0025 ("erofs: use meta buffers for xattr operations")
converted xattr operations to use on-stack erofs_buf instances.
erofs_init_inode_xattrs() uses such a metabuf while reading the inline
xattr header and shared xattr id array.

Some error paths after erofs_read_metabuf() leave through out_unlock
without dropping the metabuf, so the folio reference can leak.

Consolidate the cleanup at out_unlock. erofs_put_metabuf() is a
no-op if no folio has been acquired, and this keeps all paths after
taking EROFS_I_BL_XATTR_BIT covered by a single cleanup site.

Fixes: bb88e8da0025 ("erofs: use meta buffers for xattr operations")
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Fixes: bb88e8da0025 ("erofs: use meta buffers for xattr operations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 41e311019a251..df7ea019526d7 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -89,13 +89,11 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	    vi->xattr_isize - sizeof(struct erofs_xattr_ibody_header)) {
 		erofs_err(sb, "invalid h_shared_count %u @ nid %llu",
 			  vi->xattr_shared_count, vi->nid);
-		erofs_put_metabuf(&buf);
 		ret = -EFSCORRUPTED;
 		goto out_unlock;
 	}
 	vi->xattr_shared_xattrs = kmalloc_objs(uint, vi->xattr_shared_count);
 	if (!vi->xattr_shared_xattrs) {
-		erofs_put_metabuf(&buf);
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
@@ -112,12 +110,12 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 		}
 		vi->xattr_shared_xattrs[i] = le32_to_cpu(*xattr_id);
 	}
-	erofs_put_metabuf(&buf);
 
 	/* paired with smp_mb() at the beginning of the function. */
 	smp_mb();
 	set_bit(EROFS_I_EA_INITED_BIT, &vi->flags);
 out_unlock:
+	erofs_put_metabuf(&buf);
 	clear_and_wake_up_bit(EROFS_I_BL_XATTR_BIT, &vi->flags);
 	return ret;
 }
-- 
2.53.0




