Return-Path: <stable+bounces-224445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPeKCC4EsGkWegIAu9opvQ
	(envelope-from <stable+bounces-224445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C32B324B796
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD26A324F12D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3238A71F;
	Tue, 10 Mar 2026 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XG1e+b1W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A5C389E1D;
	Tue, 10 Mar 2026 11:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142178; cv=none; b=R2XCEyOvCAbfSKLrBml8xwxyxsy5QbbZxz03srZJwYULfRaNps1NsGWVBjBK49Yf40/jggWbAAyvnzxdEVz2zQAPQWxgTjxcW077tbvig4RtO7UIOQ2cmyfH1IC/n04UmWQ7OLAF/KM4nz8KW40jkSIUoA66kMbAxEmPczoxQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142178; c=relaxed/simple;
	bh=WWd5tGYvYbEzsfIutDg1J8sEQmxr4WR4epsyN200upc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg5OXHDMFHJvM4NMxHcUHv2H4U1C4O4x2RO2j7emApDEqykK51kDDCW9P6j8CpbEfxcl2sx5WW7A/+QGO7spp3ks9MyqHtHElTJPphVTB0tQUyF2N6qZaGFpqd6ezVEyJ9JHQ3kb1ehiVi+B2HISYivOAXdIiz3p0WcPF0zoTFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XG1e+b1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49229C2BC86;
	Tue, 10 Mar 2026 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142178;
	bh=WWd5tGYvYbEzsfIutDg1J8sEQmxr4WR4epsyN200upc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XG1e+b1WkUp4kg+7HvcvbWHRnvY4B2q/qyuiApglpLrq8pq4KKhxR9Du7lNP2vzYM
	 pXFPlQMjVznnzbFMcZrFYLqCFkd69rRHgpjCADBin9bv56wbO/MK/YcCsV41FcYQS1
	 X8yLeKPRYPhSrhRusvYaGk0QM3+bU/ib+JgjVYPKcbOEXp3e96UMF5YMWCfS+JEHty
	 2byUHeRkVVlD46VKnw4nloPpAk9m/es0MF1aC36iiweyFvfSVEHYaTYha1lBosrI0s
	 E2UnxWX9G1SrmQQVLSJSBCT2EMZpGgZEQu8xtCcb/p+jHp/QxQ4BY3lcocr1DxgSNb
	 JLitT+8btZyQQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 266/314] smb/client: fix buffer size for smb311_posix_qinfo in smb2_compound_op()
Date: Tue, 10 Mar 2026 07:18:45 -0400
Message-ID: <08640a940462cc4df143e1b85a2bb3cd632df346.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C32B324B796
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224445-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 12c43a062acb0ac137fc2a4a106d4d084b8c5416 ]

Use `sizeof(struct smb311_posix_qinfo)` instead of sizeof its pointer,
so the allocated buffer matches the actual struct size.

Fixes: 6a5f6592a0b6 ("SMB311: Add support for query info using posix extensions (level 100)")
Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 5c25f25aa2efb..a5f9f73ac91b9 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -322,7 +322,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 							  cfile->fid.volatile_fid,
 							  SMB_FIND_FILE_POSIX_INFO,
 							  SMB2_O_INFO_FILE, 0,
-							  sizeof(struct smb311_posix_qinfo *) +
+							  sizeof(struct smb311_posix_qinfo) +
 							  (PATH_MAX * 2) +
 							  (sizeof(struct smb_sid) * 2), 0, NULL);
 			} else {
@@ -332,7 +332,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 							  COMPOUND_FID,
 							  SMB_FIND_FILE_POSIX_INFO,
 							  SMB2_O_INFO_FILE, 0,
-							  sizeof(struct smb311_posix_qinfo *) +
+							  sizeof(struct smb311_posix_qinfo) +
 							  (PATH_MAX * 2) +
 							  (sizeof(struct smb_sid) * 2), 0, NULL);
 			}
-- 
2.51.0


