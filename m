Return-Path: <stable+bounces-224127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OhHFAv/r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA2824A87F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1410323B5FD
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81E3876B8;
	Tue, 10 Mar 2026 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcGMRF+x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A57387571;
	Tue, 10 Mar 2026 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141259; cv=none; b=cdrfSHr2ma9VC+WuR46zVTXg7kGLfIVf/82s1j5n4XcPcGX/6/jkct3Ktfa+uerjF+aNU6KG/esX0AipEjd6j/H0wa0XzZacmQfkKn1g6LWfikV0rPbWEh4ofXPFGyqNte7wPWv5l8IJoMTgJBAlSR+NYpFtKDSeVSZEb0maQzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141259; c=relaxed/simple;
	bh=2xp/x2edd+uKlcVu1F6ZJ0E5h7ZjvaxReS72594TdkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgPn5Ajrc0QdSm6AAN/tojBGZ6O8oKCYoDQ8i8vDUyj+fF1Zik9ZAI8qQmsYGPfmmPs46Inj7L1DJq6pq0Ie+y4XnKheXYKurUXfcQ439T1hvz5+bbKAe5elppWuxW+0uWP8fonvEk5/XL0xs4JNcibfAKJRNyIbTRPM0adbRzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcGMRF+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F44C19423;
	Tue, 10 Mar 2026 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141259;
	bh=2xp/x2edd+uKlcVu1F6ZJ0E5h7ZjvaxReS72594TdkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcGMRF+xJZz4yDTlgPuoyYEwe1ibEd8ZwgiOwyiQLU5lZfxuyubtj8kGTQ0tK4sNb
	 jteAcnyx3/ENgsmA6q/0JP/HSE0Jm1dU+oejdrt0kbcogphjUDHQRAn5uj2frrumkN
	 bNQfZXHpErhxsYwKew2xzLTAG4Ls9En4PenxLimpg/4+/6B3p4jhbnU+9IRkJVt+p8
	 NrcBXim6/BQYQRYcxIw5BUu5JNNjQqGaqaLgeHYE8bcKwWO/s6h31ZPCDXLUJYCNFb
	 jxj7zRco4pWm3Gh2TlLgtXapJhPepb4z1jkPW0Q4hhYRAPxhB7ThN8nStjuWj4x/4c
	 VZSBvMuUUcNpw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Gerd Rausch <gerd.rausch@oracle.com>,
	Colm Harrington <colm.harrington@oracle.com>,
	Joel Granados <joel.granados@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 262/311] time/jiffies: Fix sysctl file error on configurations where USER_HZ < HZ
Date: Tue, 10 Mar 2026 07:05:09 -0400
Message-ID: <2f6f88eeeff8bbb04a9378d0f3696315eaaad334.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CAA2824A87F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224127-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Action: no action

From: Gerd Rausch <gerd.rausch@oracle.com>

[ Upstream commit 6932256d3a3764f3a5e06e2cb8603be45b6a9fef ]

Commit 2dc164a48e6fd ("sysctl: Create converter functions with two new
macros") incorrectly returns error to user space when jiffies sysctl
converter is used. The old overflow check got replaced with an
unconditional one:
     +    if (USER_HZ < HZ)
     +        return -EINVAL;
which will always be true on configurations with "USER_HZ < HZ".

Remove the check; it is no longer needed as clock_t_to_jiffies() returns
ULONG_MAX for the overflow case and proc_int_u2k_conv_uop() checks for
"> INT_MAX" after conversion

Fixes: 2dc164a48e6fd ("sysctl: Create converter functions with two new macros")
Reported-by: Colm Harrington <colm.harrington@oracle.com>
Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/jiffies.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index d31a6d40d38dc..11d09cd8037c5 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -162,8 +162,6 @@ EXPORT_SYMBOL(proc_dointvec_jiffies);
 int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int dir,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	if (SYSCTL_USER_TO_KERN(dir) && USER_HZ < HZ)
-		return -EINVAL;
 	return proc_dointvec_conv(table, dir, buffer, lenp, ppos,
 				  do_proc_int_conv_userhz_jiffies);
 }
-- 
2.51.0


