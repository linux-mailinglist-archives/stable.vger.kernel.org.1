Return-Path: <stable+bounces-214531-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Lp8ERHVhGlo5gMAu9opvQ
	(envelope-from <stable+bounces-214531-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:36:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7D9CF600D
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AFF230514AD
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DD72F12BA;
	Thu,  5 Feb 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kf7yf/w+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7238C2BE64F;
	Thu,  5 Feb 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312871; cv=none; b=O/vRZfDWf9duOhvWbBOq9AKxddDpGGxxVANCEKqNda47rTucgpmIdhq59/cw2iMiav3MwTnDr2fPeF1YZ+s+I1Lbv0P0neqUEGMGmcihYq3Ny91pyc1uP6hx8PU4tD8qoWMGg3ZnTxU/v7ti7rwzv7evHDBODPWAy8LH7NJBGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312871; c=relaxed/simple;
	bh=2C16gBetgYeprk8qMWPd4VtC9f+xr40ryhjM9KIq00Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FD+VFWDXmEuoKJZU78bXgcLTgdR6na7SnYIqhcAtOQ8tes2H03ltghtgkqNz5ruNvglpistS/ttw57UAIO1RsxBBhroj50raE1/AyLhY96tf36XjTCVRJWupVLSyHfb70PaN4WVnwOUTKIMGJEVbqKhgmVV9TYEMSxDrtjfkYvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kf7yf/w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71217C116D0;
	Thu,  5 Feb 2026 17:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770312871;
	bh=2C16gBetgYeprk8qMWPd4VtC9f+xr40ryhjM9KIq00Y=;
	h=From:Subject:Date:To:Cc:From;
	b=Kf7yf/w+xVTMSXALSpMBjZEM5+9KulzLgbhPaAmI0NZ1s882hZqgIp16o4Aqzk6Vb
	 g7+74uXyMaZq9CyjqkFhe83dSqxNv6JKy1O6j6Ai2vme/k7+netnAIt1M6wVmazSZ6
	 r69y3XUIWTwINf/l0kXfc2yFoFefGWAcfGtVr722PjqYWYrCyUPZYwoTd5TxVOIaUT
	 hiOTnKEnUdH3p3H/lWgtN3gd23y5fqZHa+wQz8XFh8jA5aOnVI9DNQOHRHLRiNpRRy
	 7xLnjyDYoZmulR957gNAN+V7EqvRLditkQM9AbWD0Ol5c9lmVA6U98PxLCHrbNXQD6
	 FP4c4GhNESxpQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/4] mptcp: misc fixes for v6.19-rc8
Date: Thu, 05 Feb 2026 18:34:20 +0100
Message-Id: <20260205-net-mptcp-misc-fixes-6-19-rc8-v2-0-c2720ce75c34@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJzUhGkC/42NTQ6CMBCFr0Jm7Zi2kRFceQ/DotQBJkohU0I0h
 LvbcAKX7+97GyRW4QS3YgPlVZJMMQt3KiAMPvaM8swanHFknLlg5AXHeQkzjpICdvLhhIS2Rg0
 VkicKFXnruitkxqx8NDLiAXkKTTYHScuk3+NztUf0J361aDC0ZVl3LbWl8fcXa+T3edIemn3ff
 1IfGbTQAAAA
X-Change-ID: 20260204-net-mptcp-misc-fixes-6-19-rc8-6a66c86a12f7
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, 
 syzbot+f56f7d56e2c6e11a01b6@syzkaller.appspotmail.com, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=2C16gBetgYeprk8qMWPd4VtC9f+xr40ryhjM9KIq00Y=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJbriy0WeYXLrFO663/Ks+w4KbLjCWzbl6Iuphc6/lBq
 eLU+vvrOkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACbi3sLIMHfyyVZG5oXzp2/R
 nTz3cdZv39wCvoPb1Rg4d8g/XdGov4nhf30s04XLn8vdli+5LZgr+105vnbqbeHKB2cMNi5+o6V
 1hBkA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214531-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,syzkaller.appspotmail.com,infradead.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f56f7d56e2c6e11a01b6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D7D9CF600D
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
Changes in v2:
- patch 1: clarify commit message (NIPA Review assistant)
- patch 3: also modify mptcp_pm.yaml (NIPA ynl)
- Link to v1: https://patch.msgid.link/20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org

---
Matthieu Baerts (NGI0) (4):
      mptcp: pm: in-kernel: always set ID as avail when rm endp
      mptcp: pm: in-kernel: clarify mptcp_pm_remove_anno_addr()
      mptcp: fix kdoc warnings
      selftests: mptcp: connect: fix maybe-uninitialize warn

 Documentation/netlink/specs/mptcp_pm.yaml         |  1 +
 include/uapi/linux/mptcp_pm.h                     |  2 +-
 net/mptcp/pm_kernel.c                             | 29 ++++++++++-------------
 net/mptcp/token.c                                 | 16 +++++++------
 tools/testing/selftests/net/mptcp/mptcp_connect.c |  2 +-
 5 files changed, 24 insertions(+), 26 deletions(-)
---
base-commit: bbf4a17ad9ffc4e3d7ec13d73ecd59dea149ed25
change-id: 20260204-net-mptcp-misc-fixes-6-19-rc8-6a66c86a12f7

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


