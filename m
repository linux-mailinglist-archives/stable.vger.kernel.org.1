Return-Path: <stable+bounces-191406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 57681C13810
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 09:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7BAE94F67C5
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BB82D6E74;
	Tue, 28 Oct 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gkb9fflf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0425C6FF;
	Tue, 28 Oct 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639434; cv=none; b=REjafO7pAtHmID2B6OAOILJnYOUNy4TbYSDjtmh8W45GzoezEK5NC7KcuZjfJi6LWN+vx6OvJHeLhlFd/Q0clX8zDkkyjhZ+YVPs8qdHrwzTrrlxvr2n3Rpbc47NJP1zfCxEIlfWoSh2DWX8SavAfcZ2/K188qSUIezBQlVrvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639434; c=relaxed/simple;
	bh=YQctKbpXEnrgC6pJ0qwElwn6iJJlPUjdz6XA74x5wBg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ovaJ65qKrQQ6a15k5O+L4/BIo7znc76IY3Y4jkEqSmaDsvOesuLVLpEXWstePwVpmJyPd+OEZTy/XHqFb9VDfiGFc1QY3wXz0tL9HvXVblvz6LkwEb7nuxlUP1XHs13AD6dBc3BNDaoj1mIpLRmbZH3iE54miOUuOkcnjqUrLBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gkb9fflf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C299C4CEE7;
	Tue, 28 Oct 2025 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761639433;
	bh=YQctKbpXEnrgC6pJ0qwElwn6iJJlPUjdz6XA74x5wBg=;
	h=From:Subject:Date:To:Cc:From;
	b=Gkb9fflfFkSsHc1HRyBL8VVXfwBdN27pzlaVxIrsGEG1+beyzHZJV5xjMzVwaob0b
	 2Z2MEk7uYrH8d7Wusk/VafRWVu1YCW2dkhYQ8rZDTB/437uJZrWAj5Zw+fae6Y9Iy/
	 0mI4lmtu5iP/v+dCF+MwJqSb6pOgR6is/NUiPQX2myMYM9Un/UC4JFso0L3XrJwk9f
	 8ltdWxKrdQf+ZsWlIrHPblAGJpGAkfiwd4a/MMF4S4EtbXjZ0fvAuMvQXO/vHY5QbE
	 lHn+mdiTNSFOrKRNbOQhTnjytOH3PdMyNHE+jZnopKZ1Mnb37TL7s1bD3upnVBkMe0
	 +ed88RC5LFkLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: various rare sending issues
Date: Tue, 28 Oct 2025 09:16:51 +0100
Message-Id: <20251028-net-mptcp-send-timeout-v1-0-38ffff5a9ec8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPN7AGkC/x3MQQqAIBBA0avErBtIMayuEi1Cx5pFJmoRhHdPW
 v7F+y8kikwJpuaFSDcnPn0N0TZg9tVvhGxrg+xkLzqp0VPGI2QTMJG3mPmg88qonRFKK2cHNUL
 FIZLj5x/PUA0spXyC4lNTbQAAAA==
X-Change-ID: 20251027-net-mptcp-send-timeout-7fc1474fd849
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Yonglong Li <liyonglong@chinatelecom.cn>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=YQctKbpXEnrgC6pJ0qwElwn6iJJlPUjdz6XA74x5wBg=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIZqv8f3LPyYoyqG++xrYb3loaJh7QsXpW146iU2n7dv
 QENRseMOkpYGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACai+p3hu9tDx/U3/l4IFX/0
 ycT+g+fq1ZnvSmeXP6pI5oxvtnu8luE3K1e7zqPfh3yE1mVsu3n5WbzU9etPMl8cW/VTdia78j8
 DVgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are various fixes from Paolo, addressing very occasional issues on
the sending side:

- Patch 1: drop an optimisation that could lead to timeout in case of
  race conditions. A fix for up to v5.11.

- Patch 2: fix stream corruption under very specific conditions. A fix
  for up to v5.13.

- Patch 3: restore MPTCP-level zero window probe after a recent fix. A
  fix for up to v5.16.

- Patch 4: new MIB counter to track MPTCP-level zero windows probe to
  help catching issues similar to the one fixed by the previous patch.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Paolo Abeni (4):
      mptcp: drop bogus optimization in __mptcp_check_push()
      mptcp: fix MSG_PEEK stream corruption
      mptcp: restore window probe
      mptcp: zero window probe mib

 net/mptcp/mib.c      |  1 +
 net/mptcp/mib.h      |  1 +
 net/mptcp/protocol.c | 57 +++++++++++++++++++++++++++++++++-------------------
 net/mptcp/protocol.h |  2 +-
 4 files changed, 39 insertions(+), 22 deletions(-)
---
base-commit: 210b35d6a7ea415494ce75490c4b43b4e717d935
change-id: 20251027-net-mptcp-send-timeout-7fc1474fd849

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


