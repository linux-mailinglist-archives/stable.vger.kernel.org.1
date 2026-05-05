Return-Path: <stable+bounces-244179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFfPGlEH+mlGIgMAu9opvQ
	(envelope-from <stable+bounces-244179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:05:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE5F4CFEC0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C422130A9418
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C25480DCD;
	Tue,  5 May 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK2k94Zd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DFE175A87;
	Tue,  5 May 2026 15:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993287; cv=none; b=kxZo0kiK5nTVks1wSV0OnmQ4bML71PR3zcb9A7bFGKQ8Y5dGLSpDtx10GsRQ8MDfFJ0iPIy9rSUytwrcBLokD3U+ZLyejpZdPMT/qhb2jE2d0sT4CjMQ3tMQtfWtMBUDgJtFdT8sWgebOyNKAx6q9wzhfNooye/oN8FSDQR4WX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993287; c=relaxed/simple;
	bh=RfIY+/4lIX0lJsO9zD2c8kAfjhuWI0FcPTJxp5L6K2c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Br50WjpHGy5uNO9GKE++EeGYCXNISJTwmNpGq15nRePA0Hc41tGEkZTzY4yUL6kGVMmkZ9N+iwRkm9EEqJu21fztGLJNbYDk+BTPIUQR7qD7Tb2EWh31vmbSrrUmlz3CAGwlAs+gMzOPCFUl+H/DjySKpw4Z3t8pzoQX7XFDI+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK2k94Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13F4C2BCC7;
	Tue,  5 May 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777993287;
	bh=RfIY+/4lIX0lJsO9zD2c8kAfjhuWI0FcPTJxp5L6K2c=;
	h=From:Subject:Date:To:Cc:From;
	b=DK2k94Zdh8M4TXW65NOS8s4UF/jQ3lKoUwgV+0371pKtdcTZlWDS36CQt2f8g04y2
	 ngv4ztlii5cfRu1vHcKycRsAaTXjEQy0qUAmNtGjlsRMQmV3tE9n4XEgYoojmWuiAB
	 3qnd42mwqFL0W8tzMTUOmYnHe1VHQ2QnR4AvsuY6BvWFQuV3zq7oYnNCX+Uzx+/VH+
	 ucaYyjK7vexqcdUIBqBbxm4sqtSNuMfQO9pFZ4kWCB5lufWqGvNVpgJrYDObwaSrpc
	 8OiC5xhtQwo6E8Xh/xOPDQ0VmCAYR3ucMq3pacO2Y7MdQlquk9yrOTmglrpLsIBNv/
	 mYMCunvr4qT5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 00/11] mptcp: pm: misc. fixes for v7.1-rc3
Date: Tue, 05 May 2026 17:00:48 +0200
Message-Id: <20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcswdJW03xV8QHm656QmPIRSmU/
 runPs6yMyspikDp2KxU8BaVZzLwu4bi/ZJuYJmMqXXtwe1dzwmV51xj5jzzVRYoB/ZcYsfop8G
 HIXTOgSyQC34H809kHp3/o77GB2L9ZmnbPnXE0AaDAAAA
X-Change-ID: 20260504-net-mptcp-pm-fixes-7-1-rc3-e4d81787300e
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RfIY+/4lIX0lJsO9zD2c8kAfjhuWI0FcPTJxp5L6K2c=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/sVmtTQ7qefTggk1ry2n+B4+9mLduuSC5qlii5OQao
 adSTa3CHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABNp+83wP3BXlmmV4DoePpOl
 11gvPz0pouR/MMSye97puzWMFdqy/xgZdvM/CX6k37rR8+WPb8+0sxoi0/kKF4QWvT7a1vPMc9E
 iXgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: BDE5F4CFEC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244179-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Here are various fixes, mainly related to ADD_ADDRs:

- Patch 1: save ADD_ADDR for rtx with ID0 when needed. A fix for v6.1.

- Patch 2: remove unneeded exception for ID 0. A fix for v5.10.

- Patches 3-5: fix potential data-race and leaks during ADD_ADDR rtx. A
  fix for v5.10.

- Patch 6: resched blocked ADD_ADDR rtx after a more appropriated
  timeout, not after 15 seconds. A fix for v5.10.

- Patch 7: skip inactive subflows when when looking at the max RTO. A
  fix for v6.18.

- Patch 8: avoid iterating over all subflows when there is no need to. A
  fix for v6.18.

- Patch 9: skip closed subflows when looking at sending MP_PRIO. A fix
  for v5.17.

- Patch 10: properly catch errors when using check_output() in the
  selftests. A fix for v6.9.

- Patch 11: skip the 'unknown' flag test when 'ip mptcp' is used. A fix
  for v6.10.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (11):
      mptcp: pm: kernel: correctly retransmit ADD_ADDR ID 0
      mptcp: pm: ADD_ADDR rtx: allow ID 0
      mptcp: pm: ADD_ADDR rtx: fix potential data-race
      mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
      mptcp: pm: ADD_ADDR rtx: free sk if last
      mptcp: pm: ADD_ADDR rtx: resched blocked ADD_ADDR quicker
      mptcp: pm: ADD_ADDR rtx: skip inactive subflows
      mptcp: pm: ADD_ADDR rtx: return early if no retrans
      mptcp: pm: prio: skip closed subflows
      selftests: mptcp: check output: catch cmd errors
      selftests: mptcp: pm: restrict 'unknown' check to pm_nl_ctl

 net/mptcp/pm.c                                  | 62 +++++++++++++++++--------
 net/mptcp/pm_kernel.c                           | 13 ++++--
 tools/testing/selftests/net/mptcp/mptcp_lib.sh  | 16 ++++---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 20 +++++---
 4 files changed, 73 insertions(+), 38 deletions(-)
---
base-commit: 07d99587396024932e02474c3a5bede71d108454
change-id: 20260504-net-mptcp-pm-fixes-7-1-rc3-e4d81787300e

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


