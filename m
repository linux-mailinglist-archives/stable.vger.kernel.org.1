Return-Path: <stable+bounces-84219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBCF99CF0F
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 16:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264D31F23D27
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D051CACFA;
	Mon, 14 Oct 2024 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gte61xFI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F51AAE1D;
	Mon, 14 Oct 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917244; cv=none; b=F1bbkwtYxo3MdtIHuf5SEtadYj93TP+Nwvwo4KP3HMn+fdr1SaoQl7arkKkjthkdJst4vrTXlgwjiscUtG8J/2XQtsPR6cXr4ZsM0DDjAqe61V09v50CM+aFInSMcKXirOxY4YinRUQoA9T4XL0fFT7Quxz1+hNYzS82jQMI0T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917244; c=relaxed/simple;
	bh=HA87h1RVDgDAY1HPMG2MOVGENoySlfWc+50diodKKok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7CzKtVa05JlOGJ4hUl9zNh5uAal5erfdL373vhxj6sWgCiWxTv8kyY9efixuYqvRIPKRTX6GJYY4rTsrTpIeg0xb+8Ii2a7rSaEEsdcRoOsfIB8Luf38ypDMIgf/+8IhOVxACXkt2p3yL3AfteXDBUORW/SwwGkkKJk5pcuzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gte61xFI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38702C4CEC7;
	Mon, 14 Oct 2024 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728917244;
	bh=HA87h1RVDgDAY1HPMG2MOVGENoySlfWc+50diodKKok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gte61xFIUe/FwqxO3d5kAq40VcD/b4RZHxFLyj5XZddveh+4AdkUgQCn1a2520cxX
	 /dWNfp4sOD8yfzpw1XHdNKQl91vFkCrPHjGt09owzlER/cv3qqw+9YJuL4J9LhFIg8
	 l1+Rd8kzOpzvxrfa+0A7GiepljUsO7JJDkZ65imw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Paasch <cpaasch@apple.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 194/213] mptcp: fallback when MPTCP opts are dropped after 1st data
Date: Mon, 14 Oct 2024 16:21:40 +0200
Message-ID: <20241014141050.532580154@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141042.954319779@linuxfoundation.org>
References: <20241014141042.954319779@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 119d51e225febc8152476340a880f5415a01e99e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1247,7 +1247,7 @@ static bool subflow_can_fallback(struct
 	else if (READ_ONCE(msk->csum_enabled))
 		return !subflow->valid_csum_seen;
 	else
-		return !subflow->fully_established;
+		return READ_ONCE(msk->allow_infinite_fallback);
 }
 
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)



