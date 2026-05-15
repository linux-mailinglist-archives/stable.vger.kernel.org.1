Return-Path: <stable+bounces-247320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OgXHDGhBmoMlgIAu9opvQ
	(envelope-from <stable+bounces-247320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:29:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2594254933C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 259BD3074C7D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 04:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375593D45D0;
	Fri, 15 May 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOqOnXq5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525C3D0BE5;
	Fri, 15 May 2026 04:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778819285; cv=none; b=PC/Gwo1es+Xf/u5/aVEQqf7P5HPBtpElLSrNYcx0TIfu/rXUS17TjaqugNQkjHNnoY83n0ZXHYjx/NnGvaTG4eRPZu4rlMUvj7H9xh0Ej6td3+ZMQ97K7kEeg9GfgKHs4f4dUFT2kU1IzZZDnSvBGSJSpg0OgbjAEymHr97NVS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778819285; c=relaxed/simple;
	bh=eaholhXH0T0ZCPDy0hweKNhPYJD49AxYHdU2Laz8nkc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qBt6A2MIvJRFcqb361gdk4toOSR7iNbQcm1E3fyz7saocmX1O7OZyTamZNDRw9GXZMdYcmUBGAd/FcCs6VRYMMG8HXt3/3aJK0AbIvHL8nTodul74GLXISdD+ThVHZg9FChWAhEbQ5ItVNhBzG8S0D7mNL4KF19FX7LXKeIuMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOqOnXq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69BBC2BCB0;
	Fri, 15 May 2026 04:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778819284;
	bh=eaholhXH0T0ZCPDy0hweKNhPYJD49AxYHdU2Laz8nkc=;
	h=From:Subject:Date:To:Cc:From;
	b=BOqOnXq5Txa8KVIj/z/bHSP47kS3TWb/b8ssziqfPDsCZ8maiBD61HfLUGJhbSGKX
	 DDitz6gt66Fg6ooGTNIU0D4V8he+Iib96KzJ0r3aIJ0i/2atdFDm4sAFKLVxbmJu1B
	 O/V05O7eKI7dfadaLk10h6z1bttl1I8pBdccMUEGMH1SHdJq7dcGDik2c8aN+6DlHE
	 qMIMh6BRzt90ABXX1KSxuRXnPvP0ea8+veI+flJ6kmq8EIKDTrI7hW1G9+s94sR+Hk
	 yBkpsIoslhKetw1FbLyR61kgOiPW6Sjt4WpTwpmHd4q45c8T1aKLDw1CbB6AdN+quz
	 mXp1WrOWsvWVw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net v2 0/6] mptcp: misc fixes for v7.1-rc4
Date: Fri, 15 May 2026 06:27:31 +0200
Message-Id: <20260515-net-mptcp-misc-fixes-7-1-rc4-v2-0-701e96419f2f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6CMBCFr0Jm7Zi24Sdx5T0MC1oeUJVC2ko0h
 Ltb8AIu3+Sb772VArxFoEu2ksdig51cCuqUkRka14NtmzIpoUpRSMkOkcc5mplHGwx39o3AFUv
 2JmeoMhddm6NThpJi9jiAZLhR+qT6dwwvfYeJu3jHBhvi5D/HiEUe8H99i2TBBVBURitdQV8f8
 A7P8+R7qrdt+wIp4SrR4AAAAA==
X-Change-ID: 20260511-net-mptcp-misc-fixes-7-1-rc4-e2640fd4ef2c
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 linux-kselftest@vger.kernel.org, Eric Dumazet <edumaze@google.com>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, stable@vger.kernel.org, 
 Li Xiasong <lixiasong1@huawei.com>, Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2824; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eaholhXH0T0ZCPDy0hweKNhPYJD49AxYHdU2Laz8nkc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBqBqDK2ccR0WHe8pCzPWkNS2G3tWtzMFqi13UcF
 rKTja/mZzaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCagagygAKCRD2t4JPQmmg
 c/BLEACxsyXw+ngszNAvWlGIs0SmvxMWFvGKvUo2AClf0UkJ4gHuHoJxux/UiW5ircEpN89XPs8
 UYE8gvcBPR7t+tKK4ETe9yXBBzhGm7q8maJasFK1SpSAfHWBF55qVD12XgF/ru/JagZBCh+NW8L
 DE7ZxwbKb09nMAfir30HoxSnW/IGgQbJ5VkD1V28n1jYLg49mohUC00WBBXa7ESxZpGJWJ6t9MF
 e4Fu9MTum5k3Rjlh7guPQNiGO1bJc9e7rpvVBzWGklL7JQ+N1VXCgZKlSPnPA7VzJzMUJcpKdkt
 TK5rH9ArAk5cavMjjd205Hs1lqVn22lN8eo/dJpHpS4gLYIaHF2n8KgtCtCe36P/zuHB2TByh60
 oFVrqR7uzq7ffH9ve1AzCdKJbYRYo3Rkk6+I03VsmyUy4HYr5VQPf+glKFxv2qTykk5zPwd5MjT
 LM+d5ljwnukn9HsdEVYsOKW12wYX5gvCIqTDt0LIXkepnMP3HYe/pu+5/8fqmQCvE/w3Qfh0D9N
 S5uwq4pkBBriJu/rxaQ9+JoRVUbtdR0b1M4mWKof3mK0t76yvpmE0wE31WotMfPoHxAJ1unssZD
 te0IOuCitqkGn8iOumFBjhQMZlU4vRveYj1YvcRGm/oOdq07VCZZExO9J5iLmaF9oA6I4rQpmVd
 KiwSLH+qoFeVOFg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 2594254933C
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
	TAGGED_FROM(0.00)[bounces-247320-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,msgid.link:url]
X-Rspamd-Action: no action

Here are various unrelated fixes:

- Patch 1: avoid dropping partial packets. A previous version has been
  sent a few week ago. A fix for 5.10.

- Patches 2-3: stop ADD_ADDR timer when an ADD_ADDR can never been sent
  due to insufficient option space. A fix for v5.10.

- Patch 4: reset rcv_wnd_sent on disconnect, just in case the next
  connection falls back to TCP. A fix for 5.17.

- Patch 5: update window_clamp when SO_RCVBUF is set during the
  connection. A fix similar to a recent one on TCP side, for v6.6.

- Patch 6: avoid wrong time being displayed in the selftests when using
  uutils 0.8.0 which contains a regression with 'date +%3N'. It doesn't
  fix an issue in the kernel selftests, but having the fix is helpful
  for those using uutils 0.8.0.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Changes in v2:
- Patch 2: note for sashiko-nipa
- Patch 5: remove 'inline' keyword (NIPA) + update Fixes tag (Jakub)
- Patch 6: new
- Remove Eric's duplicated address with a typo (not sure how I did that)
- Link to v1: https://patch.msgid.link/20260511-net-mptcp-misc-fixes-7-1-rc4-v1-0-5ee57cb2b7eb@kernel.org

To: Matthieu Baerts <matttbe@kernel.org>
To: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: Eric Dumazet <edumaze@google.com>

---
Gang Yan (1):
      mptcp: update window_clamp on subflows when SO_RCVBUF is set

Li Xiasong (2):
      mptcp: pm: fix ADD_ADDR timer infinite retry on option space insufficient
      selftests: mptcp: join: cover ADD_ADDR tx drop and list progress

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: drop nanoseconds width specifier

Paolo Abeni (1):
      mptcp: reset rcv wnd on disconnect

Shardul Bankar (1):
      mptcp: do not drop partial packets

 net/mptcp/pm.c                                     | 56 ++++++++++++++++++----
 net/mptcp/protocol.c                               | 25 ++++++++--
 net/mptcp/sockopt.c                                | 10 +++-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh |  6 +--
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 31 ++++++++++++
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 10 ++--
 6 files changed, 113 insertions(+), 25 deletions(-)
---
base-commit: 5db89c99566fc4728cc92e941d8e1975711e24b5
change-id: 20260511-net-mptcp-misc-fixes-7-1-rc4-e2640fd4ef2c

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


