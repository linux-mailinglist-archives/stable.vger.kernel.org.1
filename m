Return-Path: <stable+bounces-105293-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC11C9F7A9D
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 12:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35601895414
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 11:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397A22488F;
	Thu, 19 Dec 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFcaPXgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444D41FC7E4;
	Thu, 19 Dec 2024 11:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608748; cv=none; b=b4JgBiGNEBpS++Sg5+SrnipKMymr8OQ4igeDUXpA0jB3V4gfXdEhq0CynoqYkPw+T1rDpJ36nUo5wH938C/ECGg4Te2hAVyPSQQ7hxsNYubbJoiCt1NC3Itx4a8n2kWtxejVUqLD2auWFufQNussnvEITtK6jvF5h5PzvBycciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608748; c=relaxed/simple;
	bh=tKRlCQo1yPtpI6+IGDepdsCFpBfExBiin5ApvQ7BwcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpD6GW6T4JXPOG/Bxm8FkezcHCfCyaIfIxqqcUSv+BB3+gNZ9wAhRyqQE8jKqO4PgpwHHjt2IuqzehTBFagd6tVOCqC/P7TC6BP6LclGmUZxp5dti0wbbTAyn9YP5pta2hfx+XSo+OcT1LZ5bYX6rzznEaez6fg9CQRhlK9oUkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFcaPXgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6EBC4CED6;
	Thu, 19 Dec 2024 11:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608747;
	bh=tKRlCQo1yPtpI6+IGDepdsCFpBfExBiin5ApvQ7BwcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dFcaPXgQ7f75fkNWJM7oEiwZLSZKXIjO9fIKKReI6kgwm3m4noO+sXA9wsGVbh5QZ
	 pJ8LXuTiHwa7Bq83c5oILTJAQjNBxHLfpyxXzZxm5nete09eWshpsjk4MUQGmQVbU0
	 xmn6WohOCG8Oan8/FS1x7OXzlF4MGwC3g3jXWb5v2L2WyMPdXZd2V35yQmvfCdUWSF
	 YZR+DnjiZZXks6S0dBRFnqcmv/v5PIrqqLiNQdMS/nGr22fWwRXbAcLEugwKADw2mT
	 WTMJGvsvjjutNXlCAh/cwkMDfQEvQElDzsvtjF3ZmHENPId+Yr9bNazOYDUKCwJ+NT
	 oP+bbxa9OV0GA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 19 Dec 2024 12:45:27 +0100
Subject: [PATCH net 1/3] netlink: specs: mptcp: add missing 'server-side'
 attr
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-1-825d3b45f27b@kernel.org>
References: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
In-Reply-To: <20241219-net-mptcp-netlink-specs-pm-doc-fixes-v1-0-825d3b45f27b@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Kishen Maloor <kishen.maloor@intel.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=tKRlCQo1yPtpI6+IGDepdsCFpBfExBiin5ApvQ7BwcA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnZAdlWHYeaFy5vuTVCZbZgyLmzNkZWJkgfX2xt
 qJvmGLsSlqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2QHZQAKCRD2t4JPQmmg
 czDMD/9NDqXEvQPodr6KdQOMkEkWVXl7FKD0OqEd7se86ajLu2bU64EV+hs4KKgBNfZxUoYNmH2
 s7Swv65NUZRUZ1rRhr+hNm99PVtLcwtHcJLge6w28L5TB+fTlvtRLI1GqAclN1VNxzh4yjg3Zwq
 Zwa7MbMgiKTPSaxLK6YzroTQvE6lgvxLGXuO7arSkJjf7uNz3rKSCE9pj/bArrXexfx5Zypu6Ey
 1YGcDz3bz8/L9lBL7OZ6ClUcTjPwb+C/NR1oJRwDnBlhQkBYQJfhXbyQ9J9mYSTdw5a8JoVZxDa
 MHUEOI3IwNhw/9K0hzRZdNo5bRV+t7le/VoCrlTwDCuLieu+sJxiXj02VvAelxYEX63ZUFeLb2r
 I1xo+OWJYItjE5T7jUowWCdyvf4jiKX0Yh0xWei3KG1FryRJUGS8cFJv2zaAoFuGidA0jB4S+U3
 YzfjUJCsfwssaImDNwecmsB8w/sofE0s3ojjwVluGuqVnAwtNqq7oymyLvZixcWFEyPIO84CIBq
 ooZfdgkCkGs0xhoFCh4RTPKTHy8HQSRsqu74vAiZLWwpQ0Nxp3RVK1bUhgL1xtDP01MCZtd9FkD
 b/TyOoj1YTtIVFl3z+JStOv21T9NIn8ePmOJ4ayJiwn1ysweGaSCmtHiU9XzDIlOFKOz9+gCXXr
 1qnkkgByaIK7xjA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is added with the 'created' and 'established' events, but
the documentation didn't mention it.

Fixes: 41b3c69bf941 ("mptcp: expose server_side attribute in MPTCP netlink events")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dc190bf838fec6add28b61e5e2cac8dee601b012..fc0603f51665a6260fb4dc78bc641c4175a8577e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -23,7 +23,8 @@ definitions:
      -
       name: created
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
@@ -31,7 +32,8 @@ definitions:
      -
       name: established
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A MPTCP connection is established (can start new subflows).
      -
       name: closed

-- 
2.47.1


