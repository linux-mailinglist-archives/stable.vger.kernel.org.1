Return-Path: <stable+bounces-266175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CWjDM+2XMWrLngUAu9opvQ
	(envelope-from <stable+bounces-266175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:37:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42800694470
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="m/SXEEpw";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266175-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266175-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFDF3309478F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E424F3DF007;
	Tue, 16 Jun 2026 18:37:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33CA46AF3C
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 18:37:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635046; cv=none; b=WdOarALzMTJx29Xqi71MI7sN4a9ocPwf8SbqJgjp0cr0eCRXSr3uCI8uWiq3WsK2Y74Z4T8sZ89rop6b74+E6mmIuKGuU2WBQlWacmbbfKEKQepVtUwdzanDDpvJIfoF6E3ygdZWPfTJvie51iYTeTqXBIKSH27MNhKmCaufDDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635046; c=relaxed/simple;
	bh=PZj2PhEExW/XMbCoVcIF2FAPE9rDiiDv6veCj5ow/94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec2xRy+kyiaAVFBy+Bnh7y/SpHWiNJd+1Mys1qcqWNJfVHraTkfDehhP5SazeZDHx/MpunqN0NDVBZwKBwFceVDUX47UvbNi7ie0y8Th6bK42Bo64iHzbQg+04AU8B6w8YRYCCwBrNGIkZu9eLC/H3yXwtswgOJZeZ4f+MzIjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/SXEEpw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5131F00A3A;
	Tue, 16 Jun 2026 18:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781635045;
	bh=o5kwQyGbwZN/HYo7WG3uiylOYXq4OJItZtNKK4B7iRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m/SXEEpwU537u5xdhg9Aex7I7P5k420O2wz0DvEC4M6en6KMqbnE9uY0BfG9yQdCr
	 f2SX94n5RPmCDU415x+14tbOIPjLPDFdKivU3dSAwSekjqYJSuvWOWvm0NftmnSP3d
	 UL/OipZNUOy5kslJATWlTRTbhZQUg/2JKevSh17SspZPU5xPYr21MkuX/MB+s23g8/
	 h+sspJiungWe4jInZCim/DryUFmnQwHgwJBpvl+crQSYNuRxe8oaiJprgvcHP++kZZ
	 EDs8qkbG3JAHqev8sKnhgQcpODcxjGjehbg7nD47ZN7a8LIFg1UXNeBe8sdydKzG2/
	 GVlclo9IDRzOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mptcp: fix missing wakeups in edge scenarios
Date: Tue, 16 Jun 2026 14:37:23 -0400
Message-ID: <20260616183723.3474931-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061549-throat-iodine-b864@gregkh>
References: <2026061549-throat-iodine-b864@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266175-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:pabeni@redhat.com,m:matttbe@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42800694470

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 9d8d28738f24b75616d6ca7a27cb4aed88520343 ]

The mptcp_recvmsg() can fill MPTCP socket receive queue via
mptcp_move_skbs(), but currently does not try to wakeup any listener,
because the same process is going to check the receive queue soon.

When multiple threads are reading from the same fd, the above can
cause stall. Add the missing wakeup.

Fixes: 6771bfd9ee24 ("mptcp: update mptcp ack sequence from work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260602-net-mptcp-misc-fixes-7-1-rc7-v2-1-856831229976@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/protocol.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 70bc440c615d7f..136f010d4b26ed 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1555,6 +1555,14 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 
 	if (mptcp_ofo_queue(msk) || moved > 0) {
 		mptcp_check_data_fin((struct sock *)msk);
+
+		/* When multiple threads read from the same socket, the caller
+		 * filling the receive queue does not try to wake up any other
+		 * listener, which can stall it. Flag the data as ready and
+		 * issue the missing wakeup here.
+		 */
+		set_bit(MPTCP_DATA_READY, &msk->flags);
+		((struct sock *)msk)->sk_data_ready((struct sock *)msk);
 		return true;
 	}
 	return false;
-- 
2.53.0


