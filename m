Return-Path: <stable+bounces-218855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iH7GHuNVnmnyUgQAu9opvQ
	(envelope-from <stable+bounces-218855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:52:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C835190133
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D0EF3287E85
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52DF26F293;
	Wed, 25 Feb 2026 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXgCyXAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B119FA93;
	Wed, 25 Feb 2026 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983740; cv=none; b=G2pwFCQphWF3ScU3Q1GxkOxiiWYtBds10Jiq64ONPALOGFKvcegU9//pisj954BRAb82aC+lk1gu4Lwvl9Gs2wlOG1FhdGR2c9RICQOstt8LIiNOf/tddydWhJcWGbOf7Ojng43/bDwhNc6kf7MaqEycTveL2V3RVr89Tq1EyNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983740; c=relaxed/simple;
	bh=kB43PV4xvyih1tuWWuXF0Okoajm19XfshZZAQNeG7/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu/pNmiHWV6oHhVOsF3JrzAtF0rYHQqJu1jkTp7X3KhCQzwHGpR2ELrWWqb9mC3v+sCxGYO5O/GSLso2/vA+cNvKrD8vFPUVmeUEjooijd1zoU25IHh1MHskyzwlS2KaRQ3VGCbPL6BXIEjR4pZtR6RyQKgc/sXXZxQV9pIJwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXgCyXAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B60DC116D0;
	Wed, 25 Feb 2026 01:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983740;
	bh=kB43PV4xvyih1tuWWuXF0Okoajm19XfshZZAQNeG7/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iXgCyXAPor+kUSHc5/V33LbG4PlpUqZ7MbAXS3+qfSHfGnq+klYd44DswV3P9mYQ3
	 i3tj1gaTlB2/LPdjz+pCZXlwPoVcdABWnxduXKxwf2bfLZtJ4J4XhYkizwxDx0ttvY
	 GjRdnpTmNkfWhxfx87dQdPiiUt4rd0oqeaf40vy4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 033/641] netfs: avoid double increment of retry_count in subreq
Date: Tue, 24 Feb 2026 17:15:59 -0800
Message-ID: <20260225012349.795396416@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218855-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C835190133
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit a5ca32d031bbba5160e1f555aabb75a3f40f918d ]

This change fixes the instance of double incrementing of
retry_count. The increment of this count already happens
when netfs_reissue_write gets called. Incrementing this
value before is not necessary.

Fixes: 4acb665cf4f3 ("netfs: Work around recursion by abandoning retry if nothing read")
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/netfs/write_retry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/write_retry.c b/fs/netfs/write_retry.c
index fc9c3e0d34d81..29489a23a2209 100644
--- a/fs/netfs/write_retry.c
+++ b/fs/netfs/write_retry.c
@@ -98,7 +98,6 @@ static void netfs_retry_write_stream(struct netfs_io_request *wreq,
 			subreq->start	= start;
 			subreq->len	= len;
 			__clear_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
-			subreq->retry_count++;
 			trace_netfs_sreq(subreq, netfs_sreq_trace_retry);
 
 			/* Renegotiate max_len (wsize) */
-- 
2.51.0




