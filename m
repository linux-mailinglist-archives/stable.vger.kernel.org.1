Return-Path: <stable+bounces-255676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGj+IbWjGGrClggAu9opvQ
	(envelope-from <stable+bounces-255676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7F25F8726
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7023D3026A6B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEEE2D9787;
	Thu, 28 May 2026 20:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o1FmvdQg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC73282F17;
	Thu, 28 May 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999581; cv=none; b=HrVyYZAfnseoF3SQdP+HK853E4uTIjeNsn6neSTXsUZCer2Q0Tz3kChrVb+jg97rgtvLrfFqTftjoqwKQY58bUyZFBrE1BxctmnU1T85cZlPLBfsGRkTE2nf2SJKuX4vlTeEaK8N00xjJm7gWpmatVS0gKD2K1ks9iR27NmJPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999581; c=relaxed/simple;
	bh=XaHCSlsWypVjo5y4M09dZ4z4PlMDLApKWDe+Ud+okdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNu6iSReUmR/DzZD2TgWn3U9zGFqzaV9r9bbowG4OogbYzNTxqQy/3d1i8xjnxHBXkykBNi1iITLcCLRbmycvd7vv9NpoNWDsgfaQdJK7flkYdi7St0LP6fp/6+q5bSoV/PJs8hg/5rwW2bkcHr1b0IAR8+VZI4qJ0oQJel06mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o1FmvdQg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE701F000E9;
	Thu, 28 May 2026 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999580;
	bh=/oHkkEYh/U1gNoFsFadNwHMyfvJBxzaKLQsctU4kFik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=o1FmvdQgbdP025aTnyU0jD2MmsmJRyQRN123tYoNpY6kzgx4Z+wBTDZ1NW+NqaUHN
	 dEklg2JyrMxNhjc+G71G0FbPKeDlCLVF093Ck4pNDOteMbF7sIapAYC2DSqZIPgPaO
	 u/Gv0ZpSbz4mKKT34twgxDJvLc+BzEWkaxvZpCrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zilin Guan <zilin@seu.edu.cn>,
	Dawei Feng <dawei.feng@seu.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 080/377] qed: fix double free in qed_cxt_tables_alloc()
Date: Thu, 28 May 2026 21:45:18 +0200
Message-ID: <20260528194640.690221507@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-255676-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,seu.edu.cn:email]
X-Rspamd-Queue-Id: 7F7F25F8726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1038,11 +1038,13 @@ static void qed_cid_map_free(struct qed_
 
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



