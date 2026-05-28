Return-Path: <stable+bounces-255163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEkMJDqeGGpAlggAu9opvQ
	(envelope-from <stable+bounces-255163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 186215F786D
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 21:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001713138E61
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 19:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5F32BF5D;
	Thu, 28 May 2026 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GpmiJiRs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC0318EE1;
	Thu, 28 May 2026 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998142; cv=none; b=hwviStV8HkUSjWIGS4wj8tkcVIo/jP77LIRDv4rML9A2xMcyozf6nhKZt6oaVGS3hxHUSx+3wIKdx+hgxEbZJ7TwiGheR8EgMlDOC5gY0E7CuHjvIAfRIzgpykdXNzOUUE0Qxs3jMBDOQWBYuEETDxcoCOI5b9n+cv8/MwJ9qNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998142; c=relaxed/simple;
	bh=LVf18o7FgzuuZGAPxuLaN2cWkZw0her7+TP5LuWrzGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6oGFmohLCqT4ZiyGI5tz+Ncpr3GN5lh0EdJmaQYhEb0/mVpgPX8MNELLQjRmOUFbpbvp0nhm1/g4mBs9hr/2h9E4tM9mMmaTqsnqAnen7rWLZKQVT2DvEtEUN86ORFKxVQ/2lMSQi/CIztx8kHYk6pDjkd2MI3o9+okTM+OYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GpmiJiRs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4951F00A3E;
	Thu, 28 May 2026 19:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998141;
	bh=XdKwsJU8QYfBh7u7ROXqghqD9TYRpbrHV2l0G1erAAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GpmiJiRsnAKDQdrB3k3XBu3SHPaOSZ/Wr0gQy4otew/gWa1bV7acru8nzUDQi0k9+
	 fdK5epC22qvm0kPiiskXfhWIaUsnX0xq5KMz0HtSIRykrrB+uJbedqhqFdh14Dclyn
	 jhE+xdga35xfdIuQKi/bCCpiMngr6aOJbeSK/Eec=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 7.0 067/461] qed: fix double free in qed_cxt_tables_alloc()
Date: Thu, 28 May 2026 21:43:16 +0200
Message-ID: <20260528194648.860955056@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255163-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,seu.edu.cn:email,msgid.link:url]
X-Rspamd-Queue-Id: 186215F786D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dawei Feng <dawei.feng@seu.edu.cn>

commit 2bccfb8476ca5f3548afbd623dc7a6980d4e77de upstream.

If one of the later PF or VF CID bitmap allocations fails,
qed_cid_map_alloc() jumps to cid_map_fail and frees the previously
allocated CID bitmaps before returning an error. qed_cxt_tables_alloc()
then calls qed_cxt_mngr_free(), which invokes qed_cid_map_free()
again.

Fix this by setting each CID bitmap pointer to NULL after bitmap_free()
to avoid double free.

The bug was first flagged by an experimental analysis tool we are
developing for kernel memory-management bugs while analyzing
v6.13-rc1. The tool is still under development and is not yet publicly
available. Manual inspection confirms that the bug is still
present in v7.1-rc3.

Runtime reproduction was not attempted because exercising the failing
allocation path requires device-specific setup.

Fixes: fe56b9e6a8d9 ("qed: Add module with basic common support")
Cc: stable@vger.kernel.org
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
Link: https://patch.msgid.link/20260520070323.2762379-1-dawei.feng@seu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -1036,11 +1036,13 @@ static void qed_cid_map_free(struct qed_
 
 	for (type = 0; type < MAX_CONN_TYPES; type++) {
 		bitmap_free(p_mngr->acquired[type].cid_map);
+		p_mngr->acquired[type].cid_map = NULL;
 		p_mngr->acquired[type].max_count = 0;
 		p_mngr->acquired[type].start_cid = 0;
 
 		for (vf = 0; vf < MAX_NUM_VFS; vf++) {
 			bitmap_free(p_mngr->acquired_vf[type][vf].cid_map);
+			p_mngr->acquired_vf[type][vf].cid_map = NULL;
 			p_mngr->acquired_vf[type][vf].max_count = 0;
 			p_mngr->acquired_vf[type][vf].start_cid = 0;
 		}



