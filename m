Return-Path: <stable+bounces-222855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCMoLJTApmlDTQAAu9opvQ
	(envelope-from <stable+bounces-222855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:05:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F731ED5C2
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 12:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B65D3110C1E
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B473CF674;
	Tue,  3 Mar 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijI8TL7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4B3CB2FC;
	Tue,  3 Mar 2026 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772535401; cv=none; b=lW2bBg3rz3gZ3t6YEKUfXO1nMf+2eOAA5wf8LNIz99KErFohDrk/LdACc8mnT9qWMuH7SDvS4G1dbCYgTawbJOx0UIAcmv8qJRgMMZCu0HLMqDphhaxfv1D0XUvZ/WgKQ5LaWGy8eVJhF3SirWtEpXpXzWLraRoTUF3HpYjchcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772535401; c=relaxed/simple;
	bh=3hIjxPBplMqBbUMZCyZ/eh+tqQIDphwx8R8DneO0OWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ueWqp3o4XxLURBtUPB4SsrmFxe8TR7JRNHdMiYrNS4A/m+iiML5KbDUal9khK6YZlI4j+1NwARUUsbtsV6TzyjDjEI+JaM8Y1FvjCtj6+IbqEL30iYtEfs6nYHHHvJpNYpAa688TVXwLLcDRPhmYcuzal8602g3PWcXmTTT3kOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijI8TL7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1FBC2BCB3;
	Tue,  3 Mar 2026 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772535400;
	bh=3hIjxPBplMqBbUMZCyZ/eh+tqQIDphwx8R8DneO0OWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ijI8TL7pvMYOQTZ8/vo8iKSNIrmdB8c86WQoRavcdg/i6s7431YJlcWsCGvykFpHa
	 kF8MWIDUIgW55B1t0rzM69RvzPAiI/uBQ06HpLEFU4F7Lc5nmh7v0fNzYPww0pB+M0
	 gKtoPN5ePGcTYQ0ush4kWGXCU2XHqoyD/STCVCA4I/kpng6wrLJoX8pploFx3j3OTw
	 y2JzY8/fUSye0nl3zfVR6gtWnV8z0bKHtjhLm+e+V7i/aFRN7To9xm1cGVkq2GLZSw
	 NmGb8Xsk6JzjUTcMlQiJGCMGDazaz0tR74m1lD0JzaASkgIeU+stqW+6z82ffD5JL9
	 8Awc5tiTINXLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 03 Mar 2026 11:56:06 +0100
Subject: [PATCH net 5/5] selftests: mptcp: join: check removing
 signal+subflow endp
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-5-4b5462b6f016@kernel.org>
References: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
In-Reply-To: <20260303-net-mptcp-misc-fixes-7-0-rc2-v1-0-4b5462b6f016@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3hIjxPBplMqBbUMZCyZ/eh+tqQIDphwx8R8DneO0OWM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKX7YtIPrYwQoSLc4cS/6TlEkmGB64u9X/9paTsy/76p
 pdR05PLOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACYim83I8CaE/5RiQrtaYt/E
 0h7P3E9T3gZM/f34oFmAVqX/zNvatYwM66YdScp3PrzKcPLyBSL2Qg4LJ196cvnIXd7ErbP07oj
 84gIA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 11F731ED5C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222855-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This validates the previous commit: endpoints with both the signal and
subflow flags should always be marked as used even if it was not
possible to create new subflows due to the MPTCP PM limits.

For this test, an extra endpoint is created with both the signal and the
subflow flags, and limits are set not to create extra subflows. In this
case, an ADD_ADDR is sent, but no subflows are created. Still, the local
endpoint is marked as used, and no warning is fired when removing the
endpoint, after having sent a RM_ADDR.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 85df533a787b ("mptcp: pm: do not ignore 'subflow' if 'signal' flag is also set")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 058ad5a13d24..a3144d7298a5 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2626,6 +2626,19 @@ remove_tests()
 		chk_rst_nr 0 0
 	fi
 
+	# signal+subflow with limits, remove
+	if reset "remove signal+subflow with limits"; then
+		pm_nl_set_limits $ns1 0 0
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,subflow
+		pm_nl_set_limits $ns2 0 0
+		addr_nr_ns1=-1 speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 0 0 0
+		chk_add_nr 1 1
+		chk_rm_nr 1 0 invert
+		chk_rst_nr 0 0
+	fi
+
 	# addresses remove
 	if reset "remove addresses"; then
 		pm_nl_set_limits $ns1 3 3

-- 
2.51.0


