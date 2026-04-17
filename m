Return-Path: <stable+bounces-238428-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBW6DfLU4WnQyQAAu9opvQ
	(envelope-from <stable+bounces-238428-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:36:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B190A417795
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCDB030BD4BD
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 06:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16572327BFB;
	Fri, 17 Apr 2026 06:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oGut33ph"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15591128816;
	Fri, 17 Apr 2026 06:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776407743; cv=none; b=fRWhRVjVFA9vVPj/Y5sNfvzuQTYfAOeL1Hxx56JNTXA6T47C5iU1T2T9sPc5uM+TI93szDsNvm46wugT9b47flLJgjZjtIVV0KoDXtGD/Nr1AQK02dYpwKZ7dMr/Ge1pHu6qsiUHB6238swVMYrdbr7Di4q6TCENrM/hH80xrQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776407743; c=relaxed/simple;
	bh=uhlGKAcdJqak0pqeS4lLWbOlmQP95VHdjPR8cq8278E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dyXVd7MsI6G5SBzy0+waEnhDHtJ0eKE35bWjBBJIGeoSLn64tkU9jAFR90MbdUN/QW4OPWKHUhpYasTb+eVby8O30Bz8Y10SVnGkG+Wnu7Mpy+voHoCEtQrQS181hyMCzHdqfjY/jI7q4nIXNttDQ8ziYOQRC6ipi+U5uk5jMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oGut33ph; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=K0
	wju19S5OuVZqWd/KlWWwoyVnvimJ4E8sTVv29wXs0=; b=oGut33phEsL64aFDk5
	GzC4Qz/3656zvjzoAhUfOuK78HbkibFRfYG2lIcyqZ7bEgMHHbeG747uXmRPGMuj
	oCdb4TbS+oFnvP1zzc0L5xdk7iF/c8VquobBpTsbkmYgvzUwXbVhlXVazWYz4ivZ
	G6uFYuFOoVemOflQO8CxzB9Sw=
Received: from pek-lpg-core5.wrs.com (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnjq9y1OFpB_qPAA--.5176S2;
	Fri, 17 Apr 2026 14:34:27 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Cc: Steve French <stfrench@microsoft.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Robert Garcia <rob_garcia@163.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15.y] smb: client: fix potential UAF in smb2_is_valid_oplock_break()
Date: Fri, 17 Apr 2026 14:34:26 +0800
Message-Id: <20260417063426.1101332-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnjq9y1OFpB_qPAA--.5176S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw1UAF15AF1UZryUZw15XFb_yoWDurb_Gr
	95JFy8Gr4rXFyrKF18Cr4aqryrGw1rK3Z3GrySkay8Jw1jgF1fJw4kK3Z5A395ur1DCry3
	u3s0yF98Wr13WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNGQ67UUUUU==
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbC5RMkj2nh1HOQyAAA3q
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[tor.lore.kernel.org:server fail,manguebit.com:server fail];
	FREEMAIL_CC(0.00)[microsoft.com,vger.kernel.org,lists.samba.org,163.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238428-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob_garcia@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B190A417795
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 22863485a4626ec6ecf297f4cc0aef709bc862e4 ]

Skip sessions that are being teared down (status == SES_EXITING) to
avoid UAF.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[ Appropriate path used. ]
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/cifs/smb2misc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index b84e682b4cae..da32b3f6686b 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -679,6 +679,8 @@ smb2_is_valid_oplock_break(char *buffer, struct TCP_Server_Info *server)
 	/* look up tcon based on tid & uid */
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
+		if (cifs_ses_exiting(ses))
+			continue;
 		list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 
 			spin_lock(&tcon->open_file_lock);
-- 
2.34.1


