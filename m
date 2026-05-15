Return-Path: <stable+bounces-247323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ2KO/6hBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:33:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A86549425
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91E5030A107C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCD3D567A;
	Fri, 15 May 2026 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKcYpBSv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC993D565C;
	Fri, 15 May 2026 04:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819310; cv=none; b=P0auMTCDjUpP+KXo1fW60PlBNdEb7AYZVJsSdwawHnHIcwheDhbFoEqbfWysKuNXZPxnJ+fAs1Fr+W1DKg9qHgyJV8431onuB6cTAV3qKKZyc/76wGgnPql2ITzPef63LQdChWU56AJaLCdVGuauKy9CbYWFa64onMOlgUfATY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819310; c=relaxed/simple;
	bh=875ceNXWDGdvQ7I0OyeVxJ2mbgg70m3Ihld1Lkt9Y1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I/O3qJlDXulFPDzq5KBWdqEUAychy+FUsK0/GOj7MzMx0mbZ0vPml5Ea8pHgUI+J178ogGd2XgzYdIWEDQ+aBGE0ju5kBgPG54g1Im7X3+vG7gpiqatOKug6QoRtKznDyhgKZwv3Yk3GS9B+BTtEr3reH3bjLAQTltqAxqI5tug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKcYpBSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEFEC2BCB0;
	Fri, 15 May 2026 04:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819309;
	bh=875ceNXWDGdvQ7I0OyeVxJ2mbgg70m3Ihld1Lkt9Y1g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uKcYpBSvX67NGYAAJiRIhiQx2YK/dnm4SnL0m1U7/oFd7sl1Bw7zPqA4o7uDytI3u
	 HC43zxBdFIOslG5ZoByzMuK2f1h9vsQj+OwWHlO3Ysv4lr/WiHcmJb8zJtI41DgIOw
	 uCc+3S7zCcr3g55r5TYJphjMuaH6fT1fq8fjM4NuRLKR/xZic5Q83LGpUfeGFeIbJY
	 /2f90287P90dh4WyNs1sYlKws2Kv6xdrBmgHtsk/pwrXYrAxsbHpN2+7hhvKeptwnd
	 1QNtoT83X/8zvyjSQyaHfVV9RxPpOLw6uksvp4QS2rHgEN98CfWdpYlA+sIBXL6jR/
	 9JwQ8qU6k1JsQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 15 May 2026 06:27:35 +0200
Subject: [PATCH net v2 4/6] mptcp: reset rcv wnd on disconnect
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-4-701e96419f2f@kernel.org>
References: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
In-Reply-To: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mAbY17mEam5+3zBGBgEjswNy0Y5ydPBnaOl3wDshqq4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDLPW/zjghrSZpVUWfb6UnjICmNt5CgyUSTH
 rYaORO66saJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagywAKCRD2t4JPQmmg
 cz+OD/9eJOXbAAUcoERUNodDFeyihCarmMMy4RaW3C4Fora6evDIKN2G/IlXEWt9S046D/RX1Rb
 0P839wn5v4l3D7iH8l8akCQW9t3g1E5kbPalGiw+dnzSXZofPOwcDqtFGiIOEp+PoYZi82mIkit
 z5bxjd+Lyz0zZKdE6f1U1uJS4Tm/J/9WNdMwsX2QrDo/wZMXj/o5w6bOr9ZNmWLEzsHi2P80VCP
 Wicc96ch125DxrNGqGiWLFKk/z2I4Z1U4gUWL14JQMqGmaU7lciqQLOWTTIcc9MbKkeuwO7ca1D
 3XUH1YPr9XIOCStxMXr0F4b1v6RNdhQlUh+Ul8w6wTQehfe0p13b3xgWq/kTsW4C1jAMYA4gry5
 mqVoQkMkCHDNU3Hf39/h64/WTqesiQT+LUoL+SEf5ljU5WYBCeK0qA8ywqFp0jV/a3QEtBFueCw
 dR20A9K+Mim01VBs1jV6Psul/VriJjA1MXLvJsF4egSJvnweZadRzD4Urg0KQOt7qIcoVPVqSRo
 6ztV2hkGIKkpn8LkVQc6ikHGrLgI2S3uSs/e5I2WsifZHYAC/oVh47F1BQTqaaIjYGML0jA1TUI
 IlNrOV//qPgSL8m1TxKk9XZxfeLuj0GTkJDnHEv2NXsMj46ebqRAS8wqE3Co7SX6Y8xzB1/oiRf
 GQqNEqASBICXE2g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 76A86549425
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247323-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

If the MPTCP socket fallback to TCP before the MP handshake completion,
the IASN remain 0, and the rcv_wnd_sent field is not explicitly
initialized, just incremented over time with the data transfer.

At disconnect time such value is not cleared. If the next connection falls
back to TCP before the MP handshake completion, the data transfer will
keep incrementing the receive window end sequence starting from the last
value used in the previous connection: the announced window will be
unrelated from the actual receiver buffer size and likely too big.

Address the issue zeroing the field at disconnect time.

Fixes: b29fcfb54cd7 ("mptcp: full disconnect implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 859df49e16dc..a72a6ad6ee8b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3487,6 +3487,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 
 	/* for fallback's sake */
 	WRITE_ONCE(msk->ack_seq, 0);
+	atomic64_set(&msk->rcv_wnd_sent, 0);
 
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);

-- 
2.53.0


