Return-Path: <stable+bounces-234261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIZpIpic1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:21:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAE73C0789
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6976A303703B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723637C10F;
	Wed,  8 Apr 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iD+LwjUf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277EF3B3C11;
	Wed,  8 Apr 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672401; cv=none; b=IddIqo+wNp/7KFQGBHFWJ2NsoxZNkdt66OQ6aKDBhxCIBZFmAlvkO0VaCmPJ0K7gX42X0RQ3Lxvw/Pwsy5oiET9qr22xXXmte2BE0VBk1O1EL+SU8gTIOp9CKMT5jQ8BaDtkvTULw3Da1jr/DacBHPDkoEdJ9J7eXtC+0Fy4FuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672401; c=relaxed/simple;
	bh=hn4Jp0EF01/x43L1DYpLqEnBHw7H+iMNiL4pq0QTqSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqDjK8H/gO8yib3+XjCn6PUH9hdDHq4W98BGyztUyZij7rv9hmA63oNyjVRdZlmTTY+VNFmsyd+4eOHilOpsuD477azHKP6uyfUlzGJxyx5kwvE8KR9HAhpqjI6QTOtUTZ2qz6EmFdv39mzW/8OXeoLNKrt/CPtQF1Ev4at3LJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iD+LwjUf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B065EC19421;
	Wed,  8 Apr 2026 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672401;
	bh=hn4Jp0EF01/x43L1DYpLqEnBHw7H+iMNiL4pq0QTqSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iD+LwjUf4qC17e6497s/GvDi5GAO32nP0dMRgCT/UaUlUveoA5gx/HB8MImnB+H8v
	 W4jCYoXp8ANX4jnuiA5puBAdiKOImBTeLZuS8jcxA9rXFlHkHoWnSCUt1b9ZM9ffhY
	 4qp+deT9DD4LGsN1WDppXYVIVM+xtbl2zcbTtMKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1 306/312] selftests: mptcp: join: implicit: stop transfer after last check
Date: Wed,  8 Apr 2026 20:03:43 +0200
Message-ID: <20260408175945.203442878@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-234261-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 6BAE73C0789
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

With this kernel version, the 'implicit EP' MPTCP Join selftest ended
with an error message:

  115 implicit EP                          creation[ ok ]
                                           ID change is prevented[ ok ]
                                           modif is allowed[ ok ]
  TcpPassiveOpens                 2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       315                0.0
  TcpOutSegs                      617                0.0
  TcpOutRsts                      1                  0.0
  TcpExtDelayedACKs               289                0.0
  TcpExtTCPPureAcks               6                  0.0
  TcpExtTCPOrigDataSent           306                0.0
  TcpExtTCPDelivered              306                0.0
  MPTcpExtMPCapableSYNRX          1                  0.0
  MPTcpExtMPCapableACKRX          1                  0.0
  MPTcpExtMPJoinSynRx             1                  0.0
  MPTcpExtMPJoinAckRx             1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  MPTcpExtMPFastcloseTx           1                  0.0
  MPTcpExtMPRstTx                 1                  0.0
  MPTcpExtMPRstRx                 1                  0.0
  TcpActiveOpens                  2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       617                0.0
  TcpOutSegs                      315                0.0
  TcpOutRsts                      1                  0.0
  TcpExtTCPPureAcks               308                0.0
  TcpExtTCPOrigDataSent           306                0.0
  TcpExtTCPDelivered              307                0.0
  MPTcpExtMPCapableSYNTX          1                  0.0
  MPTcpExtMPCapableSYNACKRX       1                  0.0
  MPTcpExtMPJoinSynAckRx          1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  MPTcpExtMPFastcloseRx           1                  0.0
  MPTcpExtMPRstTx                 1                  0.0
  MPTcpExtMPRstRx                 1                  0.0
  MPTcpExtRcvWndShared            1                  0.0

That's because the test was waiting for the end of the transfer for no
reasons, which ended after a timeout with an error. In this case, the
stats were displayed, but this error was ignored: the end of transfer is
not validated in this test.

To fix that, stop the transfer after the last check, similar to what is
done in the other tests.

Fixes: 699879d5f866 ("selftests: mptcp: join: endpoints: longer transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3429,6 +3429,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 128 0 0 slow 2>/dev/null &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3441,6 +3442,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+		kill_wait "${tests_pid}"
 		kill_tests_wait
 	fi
 



