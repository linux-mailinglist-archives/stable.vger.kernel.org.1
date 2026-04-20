Return-Path: <stable+bounces-239940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kfQMLkVq5mmBwAEAu9opvQ
	(envelope-from <stable+bounces-239940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:02:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E249432697
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E16231075D1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987C134B1A5;
	Mon, 20 Apr 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrhIjLKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427C34AAF7;
	Mon, 20 Apr 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701982; cv=none; b=A8Dkedicup69Q9xGtFeJOov4THMv3Lam33Ue9w2fyzKRcpuEPvgZf4QYJkZH6yBKIWbMKihAO2gKr6KC0rw0RVW2BVYT5af1azI8P+iCfgTi2Dt6s9UtRf8EgOgJBOexDNfRJU13h95IPDOqHFvQwXuSVQ4YMblm12VJQtNtJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701982; c=relaxed/simple;
	bh=V907ZH/w9z2dvPzXc2YXpulBRdGMgFTtktBPYK+GEd4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W5of5NoMcbKp+3/HX2d9rwSDkruzL3VY0XogxiTHbwfuAhflDEwwAeCJ8zvsVDywGNXgG391CDA/BQs1pXLm3RiL93usWrCsI4NmE3vLSKZne0jc6EFxxt5NZpGHkSTnj/ZM8xTrs7MND60ZiXZRVf8JFQNKUhhvI/3a234b/wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrhIjLKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A141AC19425;
	Mon, 20 Apr 2026 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776701982;
	bh=V907ZH/w9z2dvPzXc2YXpulBRdGMgFTtktBPYK+GEd4=;
	h=From:Subject:Date:To:Cc:From;
	b=nrhIjLKdxGKQNX/9M7a069uEQX8z1qclV0Zlgs12/6DaP1ZRd8JPaetz8B/yD3Q5f
	 Sg3tE7ppFi0cZ6+uTWAnsk6Mr0cRSVgGnlzoy2nJpFX8WncCeqxGbbXFi9ER5lI11q
	 8haV5QmRJ+g49ykxcBmtstlMtpc+CLdzQJWYmXBMWW6ZhzVrYhklLBxgtGLAGMfKnC
	 /uwp3huO7OpzcmyAjpVhZNhFRlnYtNsqrd1OeFfomSykZy9ZS1ze78coz8siniWXrB
	 qrL+wlJ/S/IG2w+HVn/w6SgplVo3Ed4Qt2BIjLaEW7/NAMMXqxgCnZsSOKvPr7lEpl
	 ot5iV2eyonPXQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/2] mptcp: sync the msk->sndbuf at accept() time
Date: Mon, 20 Apr 2026 18:19:22 +0200
Message-Id: <20260420-net-mptcp-sync-sndbuf-accept-v1-0-e3523e3aeb44@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QrCMAyF4VcZuTYQy9yYryJedFmqFYyl6cQx9
 u6revkfON8KJjmKwblZIcs7WnxpjeOhAb57vQnGqTY4ch21jlCl4DMVTmiLMppO4xzQM0sqeKJ
 +8F0YuKUeKpGyhPj58ReoT7j+R5vHh3D5wrBtO0PsY96FAAAA
X-Change-ID: 20260420-net-mptcp-sync-sndbuf-accept-5079a6f9c407
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org, 
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=786; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=V907ZH/w9z2dvPzXc2YXpulBRdGMgFTtktBPYK+GEd4=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDKfBUl+fhWbYntc4HmJnH1Lb3VP2R+eL4KzLe5wc4ev8
 3uYL2fdUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJFIHYb/EZ0ZcpJCs9d1yTBv
 1Ei2+tN+zlx2Tl3u+W0eitP/XLfZzvA/S6heovNKXuKhugRhdgem7zPbVuqvMk/7YH72q86HrJt
 MAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239940-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2E249432697
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On passive MPTCP connections, the MPTCP socket send buffer doesn't have
the expected size at accept() time.

Patch 1 fixes the regression introduced in v6.7, while the following one
validates the fix in the selftests.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (2):
      mptcp: sync the msk->sndbuf at accept() time
      selftests: mptcp: add a check for sndbuf of S/C

 net/mptcp/protocol.c                      |  2 +-
 tools/testing/selftests/net/mptcp/diag.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
---
base-commit: 0cf004ffb61cd32d140531c3a84afe975f9fc7ea
change-id: 20260420-net-mptcp-sync-sndbuf-accept-5079a6f9c407

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


