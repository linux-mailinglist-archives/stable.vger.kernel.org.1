Return-Path: <stable+bounces-92834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028129C6142
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 20:21:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE5F61F229F4
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 19:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48B321B45A;
	Tue, 12 Nov 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9y5NWEC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F35219E47;
	Tue, 12 Nov 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439140; cv=none; b=sw2B52P1tan6P3J6kf1ooKe5Q6XttcM66qsxOn52QP8RDng4NV/ujxJc3rJzy9YQ8xL1yXMaGQR3Ayz/qSBC6FsTFy7DnFMJM0pYAazi2Bd0mgbYXgXVG9/dyvikCM7g0XLU820XPBptXlyuPpeD9XGJITPTP/fy3rKG+bD09gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439140; c=relaxed/simple;
	bh=g/gbsWd8fhwoyqT2FxBJClkryyLXaAzRPJ4kz1+rAQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3jKLc027CNxmdUu4lL6tncuVD8JBFfF1K3VwUkF6jSxBUs8TzBrC6R9LL2J7iats0faBReJZP0ha7oTNi71odobZtKpEqCD/e/mLYgh7ScUInm/mya/QlCu8/aoJbrXdHS2Wfw4nd1NhUUctRz9toTSiP49P34TBdtKF73ZwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9y5NWEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5074CC4CECD;
	Tue, 12 Nov 2024 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731439140;
	bh=g/gbsWd8fhwoyqT2FxBJClkryyLXaAzRPJ4kz1+rAQs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9y5NWECVt36S1pJfBpPMEgQ4r6v24VWQqWiQCh1gjGgYOJtgHXP173JqLIJFUxyR
	 rnMaku86UVgZ29QODrrqjblg3G81yN0cJxfIAVSf7mQPXZ1JLb8LGU3oVZ1pbh0EaC
	 mdWR6nZUYvrF+KDCHutWiAZavyj6xwiRmCo7cS0n2oELX8kCYcIY41lS95AZXUMpAs
	 a3bO+inqETiJdzJBhywr4zRqIVvrLG4xuScnzcLPP+5Czt6KO4rMY2ydo/KP8oeta6
	 AMFMeEMQSZ8gDu9S4hNVNPkosPj5qkgGcsl8E014jjbrmBaP305nfdMGzKAZFCQFaY
	 PrHb3roZ1Qp+A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 12 Nov 2024 20:18:35 +0100
Subject: [PATCH net 3/3] mptcp: pm: use _rcu variant under rcu_read_lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-net-mptcp-misc-6-12-pm-v1-3-b835580cefa8@kernel.org>
References: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
In-Reply-To: <20241112-net-mptcp-misc-6-12-pm-v1-0-b835580cefa8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kishen Maloor <kishen.maloor@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=g/gbsWd8fhwoyqT2FxBJClkryyLXaAzRPJ4kz1+rAQs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnM6oVWI78RYZjhBSzAJ9i43Zzj6B5XBHtI+8u7
 jRX8SWKoV6JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzOqFQAKCRD2t4JPQmmg
 c/DTEACPJSoP9uUyllHdYQNBOBZ5L87YTE9Uw76HQCk3yT2kV6najF7R8gd4edofctVsmIZ09j1
 7FGtDWFgvMAFZU/KWBA0zZcz4vgJuaIyDwdBCZn6tsLN4ivym3lc+Exwvwy0l3ffUyCkyiBNV+h
 bEhgT0GfR8i2qDi5k+jNSWWMZZX7dAqoWH0IM5mgwvS7kRdENi6YG4BN5oSzBw0ViqcAXdebCo5
 7fuoZRFS8DY3w4dBDDj6QM3MWZOJNuUryhoCp96q5hNShz6yf5K1V0+DKZPbb8LWlCUWwxQ73wK
 VgIzJla0pCqqqO4VgKG/4TRgjAsboWlGWDbAhqvyu0FbgG/r9QD93FQUq+8GLv7pHcDovTnr5D/
 XD3KpeS1kw0xN3l2UGrC4ycaOiFuSJrebxYCjCfhUkNra5VkVoOlI/f33FlCStmZcNJz9HAGivC
 dktMkSY1uaktqbHzw1IeQIly6Joku7ZWCC6YShBwoE+LmBRNqsG1SmI9naJETFtG9DY7hRtyJwr
 yhDkGrS+HkmX0sz4T8IPVLmxnEmAZhYjdGNtnN1gy+qdy/fSeEKKAXlH6dkflIB0dJ2j8LhTpnN
 Bb6oXqhvpwpsSYUljx3BjobnamLs1vRfJ7D9KF2jCv0IVw+hJo22L2bFy16C3nWh6wqE2FjoG05
 DV18/19kehirnBg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In mptcp_pm_create_subflow_or_signal_addr(), rcu_read_(un)lock() are
used as expected to iterate over the list of local addresses, but
list_for_each_entry() was used instead of list_for_each_entry_rcu() in
__lookup_addr(). It is important to use this variant which adds the
required READ_ONCE() (and diagnostic checks if enabled).

Because __lookup_addr() is also used in mptcp_pm_nl_set_flags() where it
is called under the pernet->lock and not rcu_read_lock(), an extra
condition is then passed to help the diagnostic checks making sure
either the associated spin lock or the RCU lock is held.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index db586a5b3866f66a24431d7f2cab566f89102885..45a2b5f05d38b0e7f334578f5ee6923a8ff8f7b2 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -524,7 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
 {
 	struct mptcp_pm_addr_entry *entry;
 
-	list_for_each_entry(entry, &pernet->local_addr_list, list) {
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list,
+				lockdep_is_held(&pernet->lock)) {
 		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
 			return entry;
 	}

-- 
2.45.2


