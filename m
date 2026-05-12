Return-Path: <stable+bounces-245722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBsMHoM4A2qK1wEAu9opvQ
	(envelope-from <stable+bounces-245722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:26:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E12952268A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D80193099E9C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7435C3AEB26;
	Tue, 12 May 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y69aq0ix"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EFC3B442D
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595539; cv=none; b=uHromG9UJdVNjkXojkY27zEXC7nqoGFRHCD5aDkfCUJSScj35xD0+d8f+grue2nT3LI+0o/yvtNXY7U+TNaUK7iIUaUQJyu7vfZXFaxYcwb5b3mPdsfD0CjBjaIP1lgrDkaHB5sJHSqn2acqrUA1XU+RqcYuTX7AOPxfK5BniwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595539; c=relaxed/simple;
	bh=xM+KtY/rJYpaRbLIQyffgkjfjDadpB05X626OPMM2Tg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EcFvylK3MYSGMG9ozcsf4qzwtYgsnqlkFQohtVYm7P7mDUR2/Xo8fY4qICQQ1pxKkruhmlmltq4SHueukVnSxwEjSAk4uzWqbQYfESSK+5+b67khIgOJvHKb24PcxM0Aq8tdrAGFom/j3dc8WxBCtXeoH6geYG4CoiSojys8u+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y69aq0ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1503C2BCF7;
	Tue, 12 May 2026 14:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778595539;
	bh=xM+KtY/rJYpaRbLIQyffgkjfjDadpB05X626OPMM2Tg=;
	h=Subject:To:Cc:From:Date:From;
	b=y69aq0ixLK3v5jEAX0JXhohdLYWgob52h2bTZCAj1GFbxKYL/04UxEC2TJnK0C2mz
	 acKnS2T5rwpG2B+ZV60ZarzeI4ososfm+FtgSYu00mi+Il+4ZH5bp6ZhJ14ygGxFmo
	 N5rB+XO3qyN517jYYldpFqySd/uQLmjbDUiIzHdg=
Subject: FAILED: patch "[PATCH] mptcp: fastclose msk when linger time is 0" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,kuba@kernel.org,lance@lance0.com,martineau@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:19:01 +0200
Message-ID: <2026051201-unread-unease-fea3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E12952268A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245722-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,lance0.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x f14d6e9c3678a067f304abba561e0c5446c7e845
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051201-unread-unease-fea3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f14d6e9c3678a067f304abba561e0c5446c7e845 Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 27 Apr 2026 21:54:35 +0200
Subject: [PATCH] mptcp: fastclose msk when linger time is 0

The SO_LINGER socket option has been supported for a while with MPTCP
sockets [1], but it didn't cause the equivalent of a TCP reset as
expected when enabled and its time was set to 0. This was causing some
behavioural differences with TCP where some connections were not
promptly stopped as expected.

To fix that, an extra condition is checked at close() time before
sending an MP_FASTCLOSE, the MPTCP equivalent of a TCP reset.

Note that backporting up to [1] will be difficult as more changes are
needed to be able to send MP_FASTCLOSE. It seems better to stop at [2],
which was supposed to already imitate TCP.

Validated with MPTCP packetdrill tests [3].

Fixes: 268b12387460 ("mptcp: setsockopt: support SO_LINGER") [1]
Fixes: d21f83485518 ("mptcp: use fastclose on more edge scenarios") [2]
Cc: stable@vger.kernel.org
Reported-by: Lance Tuller <lance@lance0.com>
Closes: https://github.com/lance0/xfr/pull/67
Link: https://github.com/multipath-tcp/packetdrill/pull/196 [3]
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260427-net-mptcp-misc-fixes-7-1-rc2-v1-3-7432b7f279fa@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 718e910ff23f..4546a8b09884 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3302,7 +3302,8 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		goto cleanup;
 	}
 
-	if (mptcp_data_avail(msk) || timeout < 0) {
+	if (mptcp_data_avail(msk) || timeout < 0 ||
+	    (sock_flag(sk, SOCK_LINGER) && !sk->sk_lingertime)) {
 		/* If the msk has read data, or the caller explicitly ask it,
 		 * do the MPTCP equivalent of TCP reset, aka MPTCP fastclose
 		 */


