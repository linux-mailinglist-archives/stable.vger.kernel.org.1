Return-Path: <stable+bounces-83805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2CC99CA00
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C77091C22688
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21325156F3F;
	Mon, 14 Oct 2024 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eo41eizd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D590A8F64
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908626; cv=none; b=doU8TvxKuugCCFp+tBf62EwC6k0Dkt35cz/RvN7528bwk4BKzOUWMgh10d7XpUqUaVKT0rWTkDHPzAhHHbWQ3X7e3EGO2K/2sPY/NjJ24toDLPDUvQzcHqh5oLD+7vp49R3xX9mFTMiA46cVxR2xPKNPrq31b1kF7IF0iTXuGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908626; c=relaxed/simple;
	bh=UODD3ylU9ucQo2DPyhy0Pn34keS/Nx/We3UN/nhx/hk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ndIUpUd/rBoUXRAz80GVV1PlpdZW4DTCiXeEu9SQH5bw+ISW4+LqGuEwjYVbkMFOYcgpoIM0onh+93TcdYwIDOGwbEGLiGDYs2x3uuofW3nD+twN+BpzFoECO5ckCEH0IdqjDGHKJjwDvX2Bv7LLN9BxdkHad8eA5HqX5afvshA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eo41eizd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1381FC4CEC3;
	Mon, 14 Oct 2024 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728908626;
	bh=UODD3ylU9ucQo2DPyhy0Pn34keS/Nx/We3UN/nhx/hk=;
	h=Subject:To:Cc:From:Date:From;
	b=eo41eizduS+EsSbh1Kb2Zezc6DX8+o69Kt7v279/9OWmM5R/t6LgP5EfhdLDsp9HY
	 xtpI0YRfkZUkYFmLN9exlOHlv7BdoGRLK8NDqwc2JevS+wimHE6civjwra/lOnfEKm
	 7smfwVc1fujrqY/BWwZSymJRQ240eGFwNDtQeRCI=
Subject: FAILED: patch "[PATCH] mptcp: fallback when MPTCP opts are dropped after 1st data" failed to apply to 5.15-stable tree
To: matttbe@kernel.org,cpaasch@apple.com,kuba@kernel.org,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 14:23:43 +0200
Message-ID: <2024101443-lunchroom-refinish-4251@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 119d51e225febc8152476340a880f5415a01e99e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101443-lunchroom-refinish-4251@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

119d51e225fe ("mptcp: fallback when MPTCP opts are dropped after 1st data")
ae66fb2ba6c3 ("mptcp: Do TCP fallback on early DSS checksum failure")
4cf86ae84c71 ("mptcp: strict local address ID selection")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 119d51e225febc8152476340a880f5415a01e99e Mon Sep 17 00:00:00 2001
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 8 Oct 2024 13:04:54 +0200
Subject: [PATCH] mptcp: fallback when MPTCP opts are dropped after 1st data

As reported by Christoph [1], before this patch, an MPTCP connection was
wrongly reset when a host received a first data packet with MPTCP
options after the 3wHS, but got the next ones without.

According to the MPTCP v1 specs [2], a fallback should happen in this
case, because the host didn't receive a DATA_ACK from the other peer,
nor receive data for more than the initial window which implies a
DATA_ACK being received by the other peer.

The patch here re-uses the same logic as the one used in other places:
by looking at allow_infinite_fallback, which is disabled at the creation
of an additional subflow. It's not looking at the first DATA_ACK (or
implying one received from the other side) as suggested by the RFC, but
it is in continuation with what was already done, which is safer, and it
fixes the reported issue. The next step, looking at this first DATA_ACK,
is tracked in [4].

This patch has been validated using the following Packetdrill script:

   0 socket(..., SOCK_STREAM, IPPROTO_MPTCP) = 3
  +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
  +0 bind(3, ..., ...) = 0
  +0 listen(3, 1) = 0

  // 3WHS is OK
  +0.0 < S  0:0(0)       win 65535  <mss 1460, sackOK, nop, nop, nop, wscale 6, mpcapable v1 flags[flag_h] nokey>
  +0.0 > S. 0:0(0) ack 1            <mss 1460, nop, nop, sackOK, nop, wscale 8, mpcapable v1 flags[flag_h] key[skey]>
  +0.1 <  . 1:1(0) ack 1 win 2048                                              <mpcapable v1 flags[flag_h] key[ckey=2, skey]>
  +0 accept(3, ..., ...) = 4

  // Data from the client with valid MPTCP options (no DATA_ACK: normal)
  +0.1 < P. 1:501(500) ack 1 win 2048 <mpcapable v1 flags[flag_h] key[skey, ckey] mpcdatalen 500, nop, nop>
  // From here, the MPTCP options will be dropped by a middlebox
  +0.0 >  . 1:1(0)     ack 501        <dss dack8=501 dll=0 nocs>

  +0.1 read(4, ..., 500) = 500
  +0   write(4, ..., 100) = 100

  // The server replies with data, still thinking MPTCP is being used
  +0.0 > P. 1:101(100)   ack 501          <dss dack8=501 dsn8=1 ssn=1 dll=100 nocs, nop, nop>
  // But the client already did a fallback to TCP, because the two previous packets have been received without MPTCP options
  +0.1 <  . 501:501(0)   ack 101 win 2048

  +0.0 < P. 501:601(100) ack 101 win 2048
  // The server should fallback to TCP, not reset: it didn't get a DATA_ACK, nor data for more than the initial window
  +0.0 >  . 101:101(0)   ack 601

Note that this script requires Packetdrill with MPTCP support, see [3].

Fixes: dea2b1ea9c70 ("mptcp: do not reset MP_CAPABLE subflow on mapping errors")
Cc: stable@vger.kernel.org
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/518 [1]
Link: https://datatracker.ietf.org/doc/html/rfc8684#name-fallback [2]
Link: https://github.com/multipath-tcp/packetdrill [3]
Link: https://github.com/multipath-tcp/mptcp_net-next/issues/519 [4]
Reviewed-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20241008-net-mptcp-fallback-fixes-v1-3-c6fb8e93e551@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e1046a696ab5..25dde81bcb75 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1282,7 +1282,7 @@ static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !subflow->fully_established;
+		return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)


