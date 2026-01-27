Return-Path: <stable+bounces-211886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIIEFVQSeWkcvAEAu9opvQ
	(envelope-from <stable+bounces-211886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:30:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CCC99DF7
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 20:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 821603013038
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 19:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAB36E484;
	Tue, 27 Jan 2026 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBbjdwB6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051BA36CDE9;
	Tue, 27 Jan 2026 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542059; cv=none; b=RiRMnErWL+DuKH4QMoGeLiuNT2tVGFovTxlfVnN8chZWIpz95w4WTdiXeZ6aPf62f/3sm+Cu/b+HxMZ6sfkOFdeXiupBg96zYUh7pfYyvNKzS0GNTPCCQYFQhDQ7wkPBL7YrFENrBY88dF0HTKh3ZFnPNapPqHlhwj+XX/YwZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542059; c=relaxed/simple;
	bh=COP0u/lwYbSxYDwiP89NvONCvNiI+1U069Dv4tpuAy4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Au/8zy8f/ywrDQjIvo4MZhNkpI/zNXDqgWjWOyGgKcg9JWbvrs6a1UTQFFmLMbQCv1TcJdXa7lKRBzB/csQ5FpR2bTTVq4A21s0YGRZKA1QhnWNzS+wUKWVsO8JnHRSPnEDLpqeYJgN973U5WMFgvwlaa3G0gxhKcgz9Rg09kzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBbjdwB6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45419C19422;
	Tue, 27 Jan 2026 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542058;
	bh=COP0u/lwYbSxYDwiP89NvONCvNiI+1U069Dv4tpuAy4=;
	h=From:Subject:Date:To:Cc:From;
	b=aBbjdwB677uel5/9+Pgx7AqKa244EscJHtPfLESYsrrSkB/xR+udjb7gSV6l42of0
	 b9RwCfTVELTp4dfcjmJIsDNsdTEqVGxClHA1DdQwhmIbx5/XREeF75fjTlg7V3kQf/
	 fp7o2jbixELcjmb7B7xmoAOKMWCM7qWiv3xvL7Yxt2kwCcfkXpeQpf3FKy8JUngdeE
	 j9bPGHOT+wmXjdFKT101VRDKZ+phA6t8ODqKvbcMCje3RoFdqNsYjwHFUTX26W5eQs
	 z7pd5biu/mUNWVWTVSBuVnsWZtlhR6X7ROjtrG3UeCKCO1rYqTQknVowyShzZSxBUl
	 GqhfnEB+5Bi/Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/5] mptcp: avoid dup NL events and propagate error
Date: Tue, 27 Jan 2026 20:27:22 +0100
Message-Id: <20260127-net-mptcp-dup-nl-events-v1-0-7f71e1bc4feb@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoReWkC/x3MTQqAIBBA4avErBswiaSuEi36GWugJlGTILp70
 vItvvdAIM8UoCse8JQ48Ck5qrKAeRtlJeQlN2ilG1Vpg0IRDxdnh8vlUHakRBIDNrVtjbLa1JO
 CrJ0ny/d/7iEjGN73AwoTSo5uAAAA
X-Change-ID: 20260127-net-mptcp-dup-nl-events-64f970f274b0
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 Marco Angaroni <marco.angaroni@italtel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=COP0u/lwYbSxYDwiP89NvONCvNiI+1U069Dv4tpuAy4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIrBZfslus6LZEzy3fjr8M5MdnfFmi631+R+HHWhPIdi
 R/m9QhWd5SyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAExkmyojQ1Mk9+5tIfKflqoZ
 2fd6VVR3Z11UutQaPIl9Tsfff+wsLxgZZvD4BnxbfqJas/Hcy5/V11ZNPiXd1/3P8iQn8yxusc+
 BrAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211886-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15CCC99DF7
X-Rspamd-Action: no action

Here are two fixes affecting the MPTCP Netlink events with their tests:

- Patches 1 & 2: a subflow closed NL event was visible multiple times in
  some specific conditions. A fix for v5.12.

- Patches 3 & 4: subflow closed NL events never contained the error
  code, even when expected. A fix for v5.11.

Plus an extra fix:

- Patch 5: fix a false positive with the "signal addresses race test"
  subtest when validating the MPTCP Join selftest on a v5.15.y stable
  kernel.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (5):
      mptcp: avoid dup SUB_CLOSED events after disconnect
      selftests: mptcp: check no dup close events after error
      mptcp: only reset subflow errors when propagated
      selftests: mptcp: check subflow errors in close events
      selftests: mptcp: join: fix local endp not being tracked

 net/mptcp/protocol.c                            | 13 ++--
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 81 ++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 13 deletions(-)
---
base-commit: e9acda52fd2ee0cdca332f996da7a95c5fd25294
change-id: 20260127-net-mptcp-dup-nl-events-64f970f274b0

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


