Return-Path: <stable+bounces-236662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M/ELZce3WmSaAkAu9opvQ
	(envelope-from <stable+bounces-236662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1761F3EFE2A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209D1328372B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E9F309DB5;
	Mon, 13 Apr 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fx2bW6wR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79BC49620;
	Mon, 13 Apr 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097481; cv=none; b=SN4dOu07SNt24gNUiNy3wxaicPFNV5laUPvL459ME0b0dSrLZK3hL237eyTElnjaqhT0+r0Zo4rdXrJSTmvMyOms0RJdtFCO2rFeN8vkS++vt94kenc/HZ2ykYjkGV7FsXzqaI0WVWkpNbQV1v+CVC4yu3+E+FYrcnZVHsfWstU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097481; c=relaxed/simple;
	bh=Ob7XQM7Xlv9kcvpLhfG9qmvt4SS0ityMwL78LjR6G1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXyAwtKlcTnW9en5s4qu9trBW+WHyGmuWmL9St227bTV7xgAzJ+VZFBeigMEhYu+WPx7M0x5ux2dEwdqnOfoGVu5d8QWP4jHGeVSOTmN02g8aSXNlylBS3pcilX/Rvuh5uG3Kx4tcQLDL3MXImvWNw3Tz8MlYZUulrREyZv/idQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fx2bW6wR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49ED4C2BCB6;
	Mon, 13 Apr 2026 16:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097481;
	bh=Ob7XQM7Xlv9kcvpLhfG9qmvt4SS0ityMwL78LjR6G1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx2bW6wRZn5DyDkvGnuhq2CExxE2N6QK5Rvmoblm+p93KheXa0Umogyl731q9rRXC
	 b88+wBl6qJBIwCvSS7jFSGjxcDfvdzVnNWJ6YIrJQAy+ZeOMz/GIfj9cx9Ls6dfAEP
	 dzlcI01uubgdirOb9ywxZhfv3jhxqciHHAvcDHBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 5.15 152/570] libceph: reject preamble if control segment is empty
Date: Mon, 13 Apr 2026 17:54:43 +0200
Message-ID: <20260413155836.144272676@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236662-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1761F3EFE2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit c4c22b846eceff05b1129b8844a80310e55a7f87 upstream.

While head_onwire_len() has a branch to handle ctrl_len == 0 case,
prepare_read_control() always sets up a kvec for the CRC meaning that
a non-empty control segment is effectively assumed.  All frames that
clients deal with meet that assumption, so let's make it official and
treat the preamble with an empty control segment as malformed.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger_v2.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -391,7 +391,7 @@ static int head_onwire_len(int ctrl_len,
 	int head_len;
 	int rem_len;
 
-	BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
+	BUG_ON(ctrl_len < 1 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
 
 	if (secure) {
 		head_len = CEPH_PREAMBLE_SECURE_LEN;
@@ -400,9 +400,7 @@ static int head_onwire_len(int ctrl_len,
 			head_len += padded_len(rem_len) + CEPH_GCM_TAG_LEN;
 		}
 	} else {
-		head_len = CEPH_PREAMBLE_PLAIN_LEN;
-		if (ctrl_len)
-			head_len += ctrl_len + CEPH_CRC_LEN;
+		head_len = CEPH_PREAMBLE_PLAIN_LEN + ctrl_len + CEPH_CRC_LEN;
 	}
 	return head_len;
 }
@@ -527,11 +525,16 @@ static int decode_preamble(void *p, stru
 		desc->fd_aligns[i] = ceph_decode_16(&p);
 	}
 
-	if (desc->fd_lens[0] < 0 ||
+	/*
+	 * This would fire for FRAME_TAG_WAIT (it has one empty
+	 * segment), but we should never get it as client.
+	 */
+	if (desc->fd_lens[0] < 1 ||
 	    desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
 		pr_err("bad control segment length %d\n", desc->fd_lens[0]);
 		return -EINVAL;
 	}
+
 	if (desc->fd_lens[1] < 0 ||
 	    desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
 		pr_err("bad front segment length %d\n", desc->fd_lens[1]);
@@ -548,10 +551,6 @@ static int decode_preamble(void *p, stru
 		return -EINVAL;
 	}
 
-	/*
-	 * This would fire for FRAME_TAG_WAIT (it has one empty
-	 * segment), but we should never get it as client.
-	 */
 	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
 		pr_err("last segment empty, segment count %d\n",
 		       desc->fd_seg_cnt);



