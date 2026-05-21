Return-Path: <stable+bounces-253441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBuFNmZ8Dmo1/AUAu9opvQ
	(envelope-from <stable+bounces-253441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:30:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9659E75E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 05:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47E5F3062CE3
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684B53812D2;
	Thu, 21 May 2026 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNCkzNCt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D7C358381;
	Thu, 21 May 2026 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334127; cv=none; b=KgQyflwq+x5iCGodf5WkpPXq7ZHUhmp9vx9kvXmfdjhJpxIO+FcsyWIsYXKAUkHJSwa90rF0vVG1RM+sT+scvHS1KDiD0yJ7EHAowMibpv/tBmEw+ilsdbjnEzMVtYkLM9RiLCI7iTFy//UiLfUtQHzH+8maHRwX5A9Cvu/y654=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334127; c=relaxed/simple;
	bh=XnBdZmpfxwLa+jDeESXDedyEqB5bg+1rl8o33X+EU6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXKHqY8mOuT6rzWPRYDymuKbKQ7qxUOHUKrVkiJttmcAtCCBhrkzR1oIQIPVUUNwUP/30xPZ84rNgyPamPvWUt+XfmjQz7CxuCpnPK3d2ldN52c7bsyMI89a6PtVxoPEKCJ3Bo4PaA108bx8ZPHpufPuTcZJzprpAwvR9C3cOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNCkzNCt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0D61F00A3B;
	Thu, 21 May 2026 03:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779334125;
	bh=OIk4dRGfFvsN3/kmc3RXYxUfYb/eAKjQvNSlKXbCBcM=;
	h=From:To:Cc:Subject:Date;
	b=GNCkzNCtmXevFhWGmFoHCjoycmnjQFFltUrqY4wbxbx020GLW60LfMD3xAp8irKrm
	 QPwgoScAbQ/0PiPyNIkxnmeYnKSufw/IMOI1BnyQ2lD61KgZZPOAixWmxm0r3wuezc
	 kS62PVQeO7dSb6ZFJeXj3YRv1y6e6RrxfegSz01yYOFBX04sCBZKwfgboBku5Duko5
	 XBXZ8aaOW+kJJ7THEcMyyiW2sjv09X3S1UbvMuxVirsEgs/DAN9L0o8SDhUEMHRa72
	 a4OgtwW4UItozAeFAUWXZGtHJOpsBH57YIncE5SlanSDDwouZRnMJ9kW7KDmMq67fi
	 uYhVfN7syTPkg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/4] mptcp: fix recent failed backports (20260521)
Date: Thu, 21 May 2026 05:19:07 +0200
Message-ID: <20260521031906.740857-6-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=802; i=matttbe@kernel.org; h=from:subject; bh=XnBdZmpfxwLa+jDeESXDedyEqB5bg+1rl8o33X+EU6M=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLL4KjfW5d7TfuzT37EjcF8TLw9fEdv7XREVE7dfiIu6q ddeckqqo5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCJ/AxgZOpu87vroHN33N6T4 MquV3oKXrk2bbGW/dh2eJet+XCFEmZGhf4Zz8e5Wex63vslrgvba6UtaPs77Fs3iqZm60aSOQ4s XAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253441-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 93F9659E75E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following patches could not be applied without conflicts in this
tree:

- fcf04b143346 ("mptcp: sync the msk->sndbuf at accept() time")
- 03f324f3f1f7 ("mptcp: pm: ADD_ADDR rtx: allow ID 0")
- 9634cb35af17 ("mptcp: pm: ADD_ADDR rtx: always decrease sk refcount")
- b7b9a4615697 ("mptcp: pm: ADD_ADDR rtx: free sk if last")

Conflicts have been resolved, and documented in each patch.

Gang Yan (1):
  mptcp: sync the msk->sndbuf at accept() time

Matthieu Baerts (NGI0) (3):
  mptcp: pm: ADD_ADDR rtx: allow ID 0
  mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
  mptcp: pm: ADD_ADDR rtx: free sk if last

 net/mptcp/pm_netlink.c | 35 ++++++++++++++++++-----------------
 net/mptcp/protocol.c   |  3 ++-
 2 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.53.0


