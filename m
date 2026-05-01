Return-Path: <stable+bounces-242500-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xT1xJbEA9WmYHAIAu9opvQ
	(envelope-from <stable+bounces-242500-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:36:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DF94AF2DE
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9115B3004D22
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3A04218BA;
	Fri,  1 May 2026 19:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP3y7JEz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10CD313E03;
	Fri,  1 May 2026 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664171; cv=none; b=f0laqe7/rjNh2ORYmo/sDqijYtzkHbhyh+pyH6HxL3j4zck3GqM21ub/cabYzWkJckY8uMbIC6eLYxtoQdsdmyo6YrJhVkPUKnPxm0o20p1cheHNA09gVB4/lzmqcOH1IG7B/xG2q1MDuVYC3xFZzWhxyLxVYPcwHOWKTlaAOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664171; c=relaxed/simple;
	bh=vzrAwLOPLiGDBXmI+xyveVGAiQKANrXvzXlyd/gBF90=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IhHHIQn5YqIbfKtQOi1xiShigF5YFjsZjUdsvN+qUlCPCOJfiumd2lWqls7IOJAchnVFs9j7FiLhT5aQ+0pKwyhMwh3yVGArHPlnyuMAryuT2sR4ONYqnj5lhxknqTvOklIJhjZtBfFmBGBFkJZ/3/V3c5Vo3XGGQew3lnFAS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP3y7JEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9679C2BCB4;
	Fri,  1 May 2026 19:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777664171;
	bh=vzrAwLOPLiGDBXmI+xyveVGAiQKANrXvzXlyd/gBF90=;
	h=From:Subject:Date:To:Cc:From;
	b=cP3y7JEz40DVWAWpXK3w9ETjDaxbbDN6LB8QmrjALVkATE2UDM7MzJzacv6CybtRz
	 J9DWFOh2AmE5+VMncCG4GJ2bet8TA1zyCZlTJVKrhU4XrVB9Snf0vdhfu+uHr8tic0
	 h7+PoAXlRsXyybLSWKc4KZuHk0+9ubXA/1vzbN21cnvB+Fw7ONyXeU2yDAgKQZfEQE
	 2BDc6ZA1ovW0+eWVjhOngSd7SgNg9UBrBmCDtF+d/DC5hp5dNnxbPWhRAJkYqip01v
	 w0LhqS+6HHOhDmcCZ4g2jYVe8MhqpFSw8dSb5YKvXN+uLn1LQzBVCTpvgLiO/ehN+2
	 2888VozV6wS1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc fixes for v7.1-rc3
Date: Fri, 01 May 2026 21:35:33 +0200
Message-Id: <20260501-net-mptcp-misc-fixes-7-1-rc3-v1-0-b70118df778e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2UBb3aT+ivgws2yLsFqaKsLYv
 xvd47ncc1ZQLsIKl2aFwm9ReSYDf2iA5j5NjDIYQ3Chc63zmLjikitlXEQJR/mw4hk9FjpidGG
 k0LfDKUawRC78P1jhCmbCbR/1dX8w1V8Ytu0LE+t0DYUAAAA=
X-Change-ID: 20260501-net-mptcp-misc-fixes-7-1-rc3-902fc2a5d499
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, 
 Gang Yan <yangang@kylinos.cn>, Dmytro Shytyi <dmytro@shytyi.net>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Shardul Bankar <shardul.b@mpiricsoftware.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vzrAwLOPLiGDBXmI+xyveVGAiQKANrXvzXlyd/gBF90=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK/MiztYizb9f8BU1SgWJWHrMqCfaetzz86uveNzImLu
 mdZgk9s6ihlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZhI9kuG/4UHdKOM32Tkl86/
 eaxj7wWxReZPRSrWPXz0am3a5NDSvliGf5bB9xa6Kk6Wj//zotpu9nmdQtVZC2OjZbSqBO9k58x
 5wAAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 97DF94AF2DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242500-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Here are various unrelated fixes:

- Patch 1: increment the right MIB counter. A fix for v5.7.

- Patch 2: set the right MPTCP reset reason. A fix for v5.9.

- Patch 3: fix rx timestamp corruption when on MPTCP passive fastopen. A
  fix for v6.2.

- Patch 4: increase sockopt seq after having set TCP_MAXSEG to propagate
  it to newer subflows later. A fix for 6.17.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (1):
      mptcp: sockopt: increase seq in mptcp_setsockopt_all_sf

Paolo Abeni (1):
      mptcp: fix rx timestamp corruption on fastopen

Shardul Bankar (2):
      mptcp: use MPJoinSynAckHMacFailure for SynAck HMAC failure
      mptcp: use MPTCP_RST_EMPTCP for ACK HMAC validation failure

 net/mptcp/fastopen.c | 4 +++-
 net/mptcp/sockopt.c  | 4 ++++
 net/mptcp/subflow.c  | 4 ++--
 3 files changed, 9 insertions(+), 3 deletions(-)
---
base-commit: 85da3965df5e6f1e1c48d2c435e140c5b66625ef
change-id: 20260501-net-mptcp-misc-fixes-7-1-rc3-902fc2a5d499

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


