Return-Path: <stable+bounces-241431-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EARaLSa/72mLFQEAu9opvQ
	(envelope-from <stable+bounces-241431-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:55:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1ED479921
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB15D3023DB4
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 19:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890941C31E;
	Mon, 27 Apr 2026 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvE4vnr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196773909B5;
	Mon, 27 Apr 2026 19:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777319684; cv=none; b=LZ5TWryhwMnxmGQE/lyJF8mawcl4HJ/nvtQKqJBGf5dgpvLrL8HQheF4Qy6D1BkpRpHE7DKocP7cCETQeo49lUoZpurYQ8h2m7Ut6Rd4O0d/ocl9rR6TI3nPlTB0AuSRbbs7AiD9PmOOaJIUYwaJos3iD+c5SCxxDwjksgwhJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777319684; c=relaxed/simple;
	bh=LkOJN2JyBEjfjEVDRBcI3nbg/osylkGzwxFnqtwGwx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gEgeG3Cfd9x/I237o1aI9fH4XTQIN/72quN78lWwbS1rsVyUrqFVcvPHt9x57Z4b/cEYeS4jg2TY4sadnkISjvMGjONV9IoFuySypCqF+5R6BHtQM1b1RkFuDmHWcSRiEd8CilTRYamfTBkF8JMTz+8YLsJJ7grSwIviVfp5FH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qvE4vnr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D555C19425;
	Mon, 27 Apr 2026 19:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777319683;
	bh=LkOJN2JyBEjfjEVDRBcI3nbg/osylkGzwxFnqtwGwx8=;
	h=From:Subject:Date:To:Cc:From;
	b=qvE4vnr89iK63x8UdnJBM8PQyO8zfQFKm36gYubuBFmW9vKROBpMEubeSKouWiYYL
	 HAIUO3R/UevPUEVQswuorQ2mrs8RpJDxOfcQm5PEEIwVjapVOxH7BwKU6MkF5DaVM1
	 WoltWM2YcL5YUCoywImmtd/Kld6LA/vavgnLMLibzBCoE9zK8mUVhi4LKXfZIKKPcw
	 oqrECDhnGu+i5IdAMQ/R6z1Va62PuejXDKK6FwJM4AByQXO2bebgZRKOS7kLpEmSbC
	 FsyNh/V/lI34+GSd4hkWjNNNe5/hj1NwkfPzNp3uhuJiIlV9kSadXbETNxUHcRZVYe
	 zkRcDxxpDOyPw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/4] mptcp: misc fixes for v7.1-rc2
Date: Mon, 27 Apr 2026 21:54:32 +0200
Message-Id: <20260427-net-mptcp-misc-fixes-7-1-rc2-v1-0-7432b7f279fa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2cBahhn+ytiDplEzWC1NFWHs3
 436eC73nA1MqorBqdugyktNH9khHDrg+znfBDU5Q+zjsR8iYZaGa2lccFVjvOpbDAkDVo4YKMl
 AxGnkAJ4oVX4HL0zgJsz/0Z6XRbh9w7DvHwXwkbqFAAAA
X-Change-ID: 20260427-net-mptcp-misc-fixes-7-1-rc2-17de477cd8c1
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Lance Tuller <lance@lance0.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=LkOJN2JyBEjfjEVDRBcI3nbg/osylkGzwxFnqtwGwx8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLf7/u7hH/SfCu/swJcu1tWHuZJPbD5yXFu079z+T8a3
 1dcwRG5vKOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAi0UsYfrOtqFlgk335yLFp
 WjULoiO/WPPdu/sgnzP4Eqt0pftTmx+MDE/SzqxYFT99mm/O11upbpVn2Wd+U9bfVrxjqsOv10w
 JrSwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Queue-Id: 2D1ED479921
X-Rspamd-Action: no action
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
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241431-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Here are various unrelated fixes:

- Patches 1-2: set timestamp flags on 'ssk', not 'sk' (typo); Plus do
  that with sleepable lock_sock/release_sock. A fix for v5.14.

- Patch 3: respect SO_LINGER(1, 0) by sending MP_FASTCLOSE at close time
  as expected. A fix for v6.1.

- Patch 4: reset fullmesh counter after a flush. A fix for v6.19.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Gang Yan (2):
      mptcp: sockopt: set timestamp flags on subflow socket, not msk
      mptcp: fix scheduling with atomic in timestamp sockopt

Matthieu Baerts (NGI0) (2):
      mptcp: fastclose msk when linger time is 0
      mptcp: pm: kernel: reset fullmesh counter after flush

 net/mptcp/pm_kernel.c |  1 +
 net/mptcp/protocol.c  |  3 ++-
 net/mptcp/sockopt.c   | 12 ++++++------
 3 files changed, 9 insertions(+), 7 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260427-net-mptcp-misc-fixes-7-1-rc2-17de477cd8c1

Best regards,
--  
Matthieu Baerts (NGI0) <matttbe@kernel.org>


