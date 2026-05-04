Return-Path: <stable+bounces-242903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IF79Bk5c+GnatQIAu9opvQ
	(envelope-from <stable+bounces-242903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:43:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640564BA6CE
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE793300FEE1
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653C3451A6;
	Mon,  4 May 2026 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1RX8xQKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A87E344031
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884229; cv=none; b=mhWPW31wkzJTB5pFpuevU5yV0l4EmowWH6itjHS/ZM0piKlfC8JhCplBTxTTyHjV+kNKu0mFK6hkcuVdpKFMVo3fQo8vqL2s0+h3qUNuI5+YxDW2nx5DX4bA9ig5qxplf8oY451ajLXC0BHlsVKTk5G2Y++zj/qSwmBK+lIMbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884229; c=relaxed/simple;
	bh=eSuiTBP3j7I52SCEv6ESOoX4ityxGa/8B05n+g+4tVc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L0NrdfN1R4TgvD7RghA0soeL4ymvfcfU+2H6uAqW9SbrkF6K8iNOZfVZWKdikm8FvZmEgFjOBf2Ii/J/NGXz2A5WOtqmMptmZdQkEZomfH0vnm0U1yj/+L16IrLOoLjbfAO0RE2CDL4OyQT4JL66ekvg/7Lh8amPaBw71E+k9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1RX8xQKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F36C2BCB8;
	Mon,  4 May 2026 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884229;
	bh=eSuiTBP3j7I52SCEv6ESOoX4ityxGa/8B05n+g+4tVc=;
	h=Subject:To:Cc:From:Date:From;
	b=1RX8xQKdFuNZBzRjEklP7TMywGiqXW//7MBz5hy8ej2zCD064bisx9zUhHOI12UCd
	 gsTZF/PJ1Mo5H9IamG28IN3Ds62fBiQyBAx8VFC/LmDZsH/T91iioMSK0OcwW01QW0
	 1EouolHifDo03yA+vi3sk4MyiaLx+smUYzPuZs1o=
Subject: FAILED: patch "[PATCH] mptcp: sync the msk->sndbuf at accept() time" failed to apply to 6.6-stable tree
To: yangang@kylinos.cn,matttbe@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:43:38 +0200
Message-ID: <2026050438-creature-dropout-abce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 640564BA6CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242903-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,kylinos.cn:email,msgid.link:url,gregkh:email]


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x fcf04b14334641f4b0b8647824480935e9416d52
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050438-creature-dropout-abce@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcf04b14334641f4b0b8647824480935e9416d52 Mon Sep 17 00:00:00 2001
From: Gang Yan <yangang@kylinos.cn>
Date: Mon, 20 Apr 2026 18:19:23 +0200
Subject: [PATCH] mptcp: sync the msk->sndbuf at accept() time

On passive MPTCP connections, the msk sndbuf is not updated correctly.

The root cause is an order issue in the accept path:

- tcp_check_req() -> subflow_syn_recv_sock() -> mptcp_sk_clone_init()
  calls __mptcp_propagate_sndbuf() to copy the ssk sndbuf into msk

- Later, tcp_child_process() -> tcp_init_transfer() ->
  tcp_sndbuf_expand() grows the ssk sndbuf.

So __mptcp_propagate_sndbuf() runs before the ssk sndbuf has been
expanded and the msk ends up with a much smaller sndbuf than the
subflow:

  MPTCP: msk->sndbuf:20480, msk->first->sndbuf:2626560

Fix this by moving the __mptcp_propagate_sndbuf() call from
mptcp_sk_clone_init() -- the ssk sndbuf is not yet finalized there -- to
__mptcp_propagate_sndbuf() at accept() time, when the ssk sndbuf has
been fully expanded by tcp_sndbuf_expand().

Fixes: 8005184fd1ca ("mptcp: refactor sndbuf auto-tuning")
Cc: stable@vger.kernel.org
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/602
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260420-net-mptcp-sync-sndbuf-accept-v1-1-e3523e3aeb44@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index fbffd3a43fe8..718e910ff23f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3594,7 +3594,6 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 	 * uses the correct data
 	 */
 	mptcp_copy_inaddrs(nsk, ssk);
-	__mptcp_propagate_sndbuf(nsk, ssk);
 
 	mptcp_rcv_space_init(msk, ssk);
 	msk->rcvq_space.time = mptcp_stamp();
@@ -4252,6 +4251,7 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 
 		mptcp_graft_subflows(newsk);
 		mptcp_rps_record_subflows(msk);
+		__mptcp_propagate_sndbuf(newsk, mptcp_subflow_tcp_sock(subflow));
 
 		/* Do late cleanup for the first subflow as necessary. Also
 		 * deal with bad peers not doing a complete shutdown.


