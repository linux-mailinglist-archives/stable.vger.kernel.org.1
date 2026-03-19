Return-Path: <stable+bounces-227326-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGdpNLsZvGlEsQIAu9opvQ
	(envelope-from <stable+bounces-227326-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:43:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A472CDE23
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 599ED307EAF7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B490034404F;
	Thu, 19 Mar 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tDzcu2BF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7713528AAEB
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934858; cv=none; b=DZsxzYgl6FPalCl1HBU3VCx6t9M70YcLxCb6H1I7CRM7jZKeJRvN1BJOue4g5tSorgMPHCZ/VhkwR88279NEtLtlWq13Q/6YxOAXK/YTr+Z+ab4+M+6RkRX2Kfrcm/h7AQuRZn5Om87rdbuWLHPFUgqPVnv6FJyfAY6F0MQ32mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934858; c=relaxed/simple;
	bh=4o+vM95WN7YmCbnW6Wnhk4oIAcX9l3sokSJFJIF94Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBj8orVAfyvjLeG/oScQcXJy3qdvHKV1m9D+s49ZvdZfPpaR5qOG+b9cRC06RSzu7TjG7ALBZEytN/hdbcxVjwQTlLslRuqPGeBC1nk7Qvs6ZGOX54+FklANIfKp5WAjkg4k390g+nLo3GiEoEkzF2Pl7tN/FVjgQ47Kd4zeNGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tDzcu2BF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F38CC19424;
	Thu, 19 Mar 2026 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773934858;
	bh=4o+vM95WN7YmCbnW6Wnhk4oIAcX9l3sokSJFJIF94Gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tDzcu2BFZ132InoMh8c4NgoVyXH4aQmjYcWRAVtXCpq8Yjv5qkKGNXVx0xx/cccf8
	 Xm9WCqzOTKoUmQ1BhKV3cj/gqEKOgkhZ0Rlzn+8FudbiYHqMHZsG8qB4/KtuFW3+7P
	 61zGrqGG4TzNlzktSxYs/J7v6Bup6o0XHIJr+NUhDVokf2fcxmYoI9BzRQiPVjJ3mM
	 7iqMngFlM4CfK0t1B1IKQEiV+6C5OMbAsiroBYehJBoCnqJyd+qeDwk7kkF1V8ABtI
	 mltERFWs9D6Z5Mvv2eP+33tNrF06tEC2SwPwyIQMjOXud+SEjglH4ezVCo1yxHgl2U
	 bTjwj66qm4Erw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] cifs: unlock chan_lock before calling cifs_put_tcp_session
Date: Thu, 19 Mar 2026 11:40:54 -0400
Message-ID: <20260319154055.2633432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031729-brethren-snowshoe-607a@gregkh>
References: <2026031729-brethren-snowshoe-607a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227326-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 48A472CDE23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit 489f710a738e24d887823a010b8b206b4124e26f ]

While removing an smb session, we need to free up the
tcp session for each channel for that session. We were
doing this with chan_lock held. This results in a
cyclic dependency with cifs_tcp_ses_lock.

For now, unlock the chan_lock temporarily before calling
cifs_put_tcp_session. This should not cause any problem
for now, since we do not remove channels anywhere else.
And this code segment will not be called by two threads.

When we do implement the code for removing channels, we
will need to execute proper ref counting here.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: d4c7210d2f3e ("smb: client: fix iface port assignment in parse_server_interfaces")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 677c757fffffb..40c2034450b40 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1788,13 +1788,9 @@ void cifs_put_smb_ses(struct cifs_ses *ses)
 		int i;
 
 		for (i = 1; i < chan_count; i++) {
-			/*
-			 * note: for now, we're okay accessing ses->chans
-			 * without chan_lock. But when chans can go away, we'll
-			 * need to introduce ref counting to make sure that chan
-			 * is not freed from under us.
-			 */
+			spin_unlock(&ses->chan_lock);
 			cifs_put_tcp_session(ses->chans[i].server, 0);
+			spin_lock(&ses->chan_lock);
 			ses->chans[i].server = NULL;
 		}
 	}
-- 
2.51.0


