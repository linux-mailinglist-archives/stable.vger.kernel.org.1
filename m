Return-Path: <stable+bounces-124471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3F8A61C24
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 21:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7335D883846
	for <lists+stable@lfdr.de>; Fri, 14 Mar 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49882040A1;
	Fri, 14 Mar 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXBuaULy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720851FECC5;
	Fri, 14 Mar 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741983117; cv=none; b=iEbAzFo2xO1AR7XGzyBSgLUetj0G1rres9Q/IkyKXKzNaA/P9QCGQl2Y4t77uA4QdYdclyAeiKgkol+1+pbjGKGXhISPrSLZ2od9tFPXT+ly2jKk/tS4n8gK9UGD0/wkmc3MRT7Dv3UPYxmOqmFjb/cY/LcqrORRrX3S5wE74H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741983117; c=relaxed/simple;
	bh=Na5JubRzixA4tE3kjqxYLK6Xm6TlXZSN2pUUwo9sIA8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mz6N6iLBlqt28cUg0YFkqFkioQntzrjwdJxPioCEfzuoG7WZz9l4BUmumIxsPNQr8rcIKitY+dWdL2q+zEAtxTAD5auDaZ4B/3mfKdJRfEo16KUvCsevdaxjqxm5sE0dsTXYFiEGKZpowe+IFAWZk5Rt6PYREq700b6tYBQ030U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXBuaULy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA3FC4CEE9;
	Fri, 14 Mar 2025 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741983116;
	bh=Na5JubRzixA4tE3kjqxYLK6Xm6TlXZSN2pUUwo9sIA8=;
	h=From:Subject:Date:To:Cc:From;
	b=VXBuaULy1Veut+/XtbVvG6R8squ+EqeeX5Tdi6jqdBOUQqlHZv+Pv00327gPmXCcL
	 gRlA64gwaH24lSdfdvC2F8GfNeeMyNZZQJFu9zEeU8GQSgqFjrDFw1WrpDHyGKhGbe
	 0/AC43bSO9Bi+OQhly/lFpBRdnc0SAwBufHCM4TGUr17R5+DwG4fjYxZR1At5kr3YU
	 ftsYhD9Ymx3vDjxXj70c/C5vIDPDi+Xi3jmunbsiDivw4QVQdgRmOyqmngyr9GOrqA
	 yJ9iFdv6alf660ygjt5slPQU8oFur3xYJEFf/wtyzVXqMrgCSPaxNMOSBR6sXz5yCx
	 /Akp5P3hIZaGQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] mptcp: fix data stream corruption and missing
 sockopts
Date: Fri, 14 Mar 2025 21:11:30 +0100
Message-Id: <20250314-net-mptcp-fix-data-stream-corr-sockopt-v1-0-122dbb249db3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHKN1GcC/x2N0QqDMAxFf0XyvIB1CrpfGXsobdyC2JYkjIH47
 ws+Hjj33AOUhEnh0R0g9GXlWhzCrYP0ieVNyNkZhn6Y+nsYsZDh3iw1XPmHOVpENaG4Y6oiqDV
 ttRkuM4U8+maZAnisCbl/HT3BG/A6zz8AY1EMfQAAAA==
X-Change-ID: 20250314-net-mptcp-fix-data-stream-corr-sockopt-98e1d4250951
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Arthur Mongodin <amongodin@randorisec.fr>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Na5JubRzixA4tE3kjqxYLK6Xm6TlXZSN2pUUwo9sIA8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBn1I2HQvlU2IT2YdAlZXT1odPvELRPHUcFlf4yH
 +dB1BspE7uJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ9SNhwAKCRD2t4JPQmmg
 c8BNEACvP8bzTKX4genl9C7lBT5Lbi87AIITZHld3QfIAPVf0ub5uG7hwgiQJqTOKTF6t/5UZKT
 jo+J3DN+UHXWFlR4asroLHjQHhMB1I/2B0+5dBuHPsOC6tLH5nNU4orPJSgPS/IaYwrOA8nnK8N
 bEZi5ckpWmmiwgMxjCVl35Nn4fpoSTE4EWgXDuPfsZ1pEHJa9riIHqwDCPWUIIj+xWZxLriVpWD
 HwAsed9eqTI8bTkfnaIPj+sJb8Ksh/JGZo3Kjj+ngNV9qaMHhfCfUtYwjYxYT3q1sFV4rYsYxiv
 ykdq/C2ZzIikTzmbYhP4Jv1E+44hdti7teXMFyYZ6gLHR4FA++3RoEO59z1qVN6elyFbmHtOaWQ
 a+8soRImaR8FK++d4wj5bN7KgliosMpXqOethM5S6uiJmjanvWZSyETa7aBHjCNzN7q9cOz4tlx
 xXQHkd4rSR3MugUAEx6/mXz6P85MlQN7CbJWA9XlLhX+Q3OFxukOvH6g6uZaegPHXRpBQUeIADC
 j8i1LDHDFElNKBpHFSydchv234UhbH4xWwA4xSaPIYL1m0uT/bYG3kne5lTC5lj43IdI8X+j7Gp
 GxQ3DvWJXXZovOb38vii6xGaaMfsJfWMyBlwAJoqEI8MPWnxNlxmtc9GjQ7GZn35L6JjsAe8AkD
 ugEXrJnH7Lz/vcA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are 3 unrelated fixes for the net tree.

- Patch 1: fix data stream corruption when ending up not sending an
  ADD_ADDR.

- Patch 2: fix missing getsockopt(IPV6_V6ONLY) support -- the set part
  is supported.

- Patch 3: fix missing v4/v6 freebind & transparent getsockopt() -- the
  set part is supported.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - Patch 1 has already been sent to netdev, but it has been applied in
   MPTCP tree first, including some small changes in the commit message.

---
Arthur Mongodin (1):
      mptcp: Fix data stream corruption in the address announcement

Matthieu Baerts (NGI0) (2):
      mptcp: sockopt: fix getting IPV6_V6ONLY
      mptcp: sockopt: fix getting freebind & transparent

 net/mptcp/options.c |  6 ++++--
 net/mptcp/sockopt.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)
---
base-commit: 4003c9e78778e93188a09d6043a74f7154449d43
change-id: 20250314-net-mptcp-fix-data-stream-corr-sockopt-98e1d4250951

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


