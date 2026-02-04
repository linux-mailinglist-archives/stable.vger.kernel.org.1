Return-Path: <stable+bounces-214332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INTXELp6g2nyngMAu9opvQ
	(envelope-from <stable+bounces-214332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:58:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1E3EAA9C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 659DF300D4C6
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 16:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1277833F374;
	Wed,  4 Feb 2026 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcK07/Gf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCC32D7EC;
	Wed,  4 Feb 2026 16:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770224265; cv=none; b=hKsoOJRUGwNH+YCggIzav5sOTBQOl7aG/v3/2PmUAUse9Cw8lsnIx6/TtZ7V/8gWTbr4/2X4b1oMr9vm5pku12Fwz1VPbQS+1g9Q2hrIoWWzg3inB3sJa3Yv1Ud17lUoTk3Yr7KOhNJVFHN6bCKCrlEK8X0+MKIjiQVs5TOVO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770224265; c=relaxed/simple;
	bh=cBviwNx3dSB5yXIQBO6E1ifjNsWgF2O9bUxOR5Mi1d0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LaQxK6UCOPAqR/bBBcmvqaEEYKC9Ax1dMzc/gPpXqkaa2JaG9klM3dFrXP4WQQhIREA0+1b7p2CdajU6jAJsPf6MkRac0LnJXU4Qc5V4PG5gOCK3KLSa4elG7P6OGmZnGqkhxQvxILJSkw0Ztqp9rcLPEEfMtNX1DWrziOCiFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcK07/Gf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB25C4CEF7;
	Wed,  4 Feb 2026 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770224265;
	bh=cBviwNx3dSB5yXIQBO6E1ifjNsWgF2O9bUxOR5Mi1d0=;
	h=From:Subject:Date:To:Cc:From;
	b=YcK07/GfCSiVkJ7OjAV0FGIhkCdKi/Y0qSZCj3rf9cYWhmLjFLnjg8mNDWlyTq07s
	 iqoW2+yUB5yv2UiysvAl/AXBYzbPQH3ImuEyu2P/9iEC/LyxXuo6mfBFGKLYoesbPe
	 QMdHh/USmzF6jZWUM1+L+HwWvaplVkkavQRqLONJU2Pfb64KiwFCKTEDuXVJ87e/Ne
	 NFjqypb/CNj5Yvx4rFeE7ZaAV8dvHTrFytKasql6Al6P2hJ6UpTGTPp1b/5qZ0Mp0M
	 Edv+zALuKhpjG0839dn0v1WFc3aNoM12an8K4XZzQllNUYw1+LvlIk2una4I8s6ttB
	 ahkF6uXQAUa2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc fixes for v6.19-rc8
Date: Wed, 04 Feb 2026 17:57:24 +0100
Message-Id: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHR6g2kC/x2MQQqDQAwAvyI5N7C7lKj9ivSwpFFzcLtsRATx7
 w09DszMBSZNxeDVXdDkUNNvcYiPDnjNZRHUjzOkkCik8MQiO25154qbGuOspxgSxhEbD0iZiAf
 KMc09+KM2+Ru+mMBTeN/3D86HHVt0AAAA
X-Change-ID: 20260204-net-mptcp-misc-fixes-6-19-rc8-6a66c86a12f7
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1638; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=cBviwNx3dSB5yXIQBO6E1ifjNsWgF2O9bUxOR5Mi1d0=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKbq1rcz2Vc6ju7L54z4ryifvyZ138EbfqzNNSWiQrFM
 OQFntHuKGVhEONikBVTZJFui8yf+byKt8TLzwJmDisTyBAGLk4BmMidi4wMi/6WRj683FH1+6dn
 +jSju4/Px2lXF19a45q6+Nr65Ykh2xj+x8Z8O16f9GeFlbPu6/vdbGfqHJYvF9LPz2y6kXOmpLC
 THwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214332-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f56f7d56e2c6e11a01b6];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C1E3EAA9C
X-Rspamd-Action: no action

Here are various unrelated fixes:

- Patch 1: when removing an MPTCP in-kernel PM endpoint, always mark the
  corresponding ID as "available". Syzbot found a corner case where it
  is not marked as such. A fix for up to v5.10.

- Patch 2: Linked to the previous patch, the variable name was confusing
  and was probably partly responsible for the issue fixed by patch 1. No
  "Fixes" tag: no need to backport that for the moment, but better to
  avoid confusion now.

- Patch 3: fix all existing kdoc warnings linked to MPTCP code. No
  "Fixes" tag: they were there for a while, and not considered as
  important to backport.

- Patch 4: silence a compiler (false-positive) warning in the selftests.
  No "Fixes" tag: it is a false-positive warning, only seen with some
  versions.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (4):
      mptcp: pm: in-kernel: always set ID as avail when rm endp
      mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()
      mptcp: fix kdoc warnings
      selftests: mptcp: connect: fix maybe-uninitialize warn

 include/uapi/linux/mptcp_pm.h                     |  2 +-
 net/mptcp/pm_kernel.c                             | 29 ++++++++++-------------
 net/mptcp/token.c                                 | 16 +++++++------
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  2 +-
 4 files changed, 23 insertions(+), 26 deletions(-)
---
base-commit: 7576bd9017e35379db1ab1ef6b0e1d570eb28429
change-id: 20260204-net-mptcp-misc-fixes-6-19-rc8-6a66c86a12f7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


