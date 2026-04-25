Return-Path: <stable+bounces-241108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jON3GVOE7GnGZQAAu9opvQ
	(envelope-from <stable+bounces-241108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:07:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C26FB4659B2
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 11:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63BD3300599B
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4B335555;
	Sat, 25 Apr 2026 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1/qG30B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DD2D77EE
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 09:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777108045; cv=none; b=t7HA8AcBGxCkSw72Hu/o+0TLsFVjuZx3WeZDL09b4Fthe70b5MtibfjE3hmBCf7cWiiWswY0ie7cq8Yvox4Uu0uBSYMQeZ8EJL9XGuAI2h25B0qKQ3y6TK65CPAPGZsUURAfXArKTBjXVAWnk7/kWGD+rYreeN7FfhpYurJJyt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777108045; c=relaxed/simple;
	bh=7FUuaQOXary9YkITEB1rV5NBVGTKkpWhFhbMQX3SKEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWki2EUD0f3PoWKqt0WpfMfYJ491vLhlFBjLi79CM2nzAdMSPiBZsPg2vF5xSfLVwAp1rIqv1d6lAAu8ZP8Iw+z4Y1/q2UsdJP4DZOp20sQ6HIRG1mNX0M2ikyPdAmU7A+Fy0hAOmmoCQWjm+zmwokm6x53+Ztxwaewg6sLxClw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1/qG30B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955E7C2BCB0;
	Sat, 25 Apr 2026 09:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777108045;
	bh=7FUuaQOXary9YkITEB1rV5NBVGTKkpWhFhbMQX3SKEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L1/qG30Bu0WlUq/Y+1UQOykFDMdtvC5rmD/RqAJg9g63X0yQ4ZK61BNigZ4f+hYZt
	 VMBDgd7gzeTEiwhyuIHiTlO565/T0C9u1Sk0iFuJ9gsJMYE4uATZrPHBBLyB3Z2c9x
	 my8QktxgUWJdmda0nimKCkZ8kXyjSWRmHALfx5NXhmkc6fug1mPFOT0+Raqs5ACisC
	 Dk3eB0Bh0uM/lYa+TQHttQPObpqnbziMElWlN+XD1EoXITZwncjYnJR9rnyMU6aMCw
	 D3n3z2LojukuJKg/aqtD2M/232AG3s2Aljs4ONGoju9Gj977F1EfWjJkb3HALYXSGg
	 8ubjm/RnubaIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] ksmbd: use msleep instaed of schedule_timeout_interruptible()
Date: Sat, 25 Apr 2026 05:07:20 -0400
Message-ID: <20260425090722.3316820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026042410-cinch-frostbite-b760@gregkh>
References: <2026042410-cinch-frostbite-b760@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C26FB4659B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241108-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit f75f8bdd4ff4830abe31a1b94892eb12b85b9535 ]

use msleep instaed of schedule_timeout_interruptible()
to guarantee the task delays as expected.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: def036ef87f8 ("ksmbd: reset rcount per connection in ksmbd_conn_wait_idle_sess_id()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 2537b52eea3e6..1b96d58183cdf 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -495,7 +495,7 @@ static void stop_sessions(void)
 	up_read(&conn_list_lock);
 
 	if (!list_empty(&conn_list)) {
-		schedule_timeout_interruptible(HZ / 10); /* 100ms */
+		msleep(100);
 		goto again;
 	}
 }
-- 
2.53.0


