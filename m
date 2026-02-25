Return-Path: <stable+bounces-218937-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJgqLO5Unmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218937-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 262A318FE51
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59484306C007
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9598279DCD;
	Wed, 25 Feb 2026 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fJf/AObx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA624677D;
	Wed, 25 Feb 2026 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983835; cv=none; b=DrBaYAIrQ/tHeyc1p5hPJlO7UL9E+4WLMcO0TyUbw6JzmTtSwB7bJQKMF9RIizU54jvY9yBwuQZ3oYI0E1znnFTrCx/eq0/EQ6w8STSGPg/d9TRi3ekjSUwEDfAShhXGqRn05rTSbbkhMdWoVsg3PmTbfJM1RsRS3u4pKBR4VBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983835; c=relaxed/simple;
	bh=UPbEM0wOoadFE6QJouIjw86MUiYhvgMcliXTHVY/RIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKUPYc7Lq39lPNzbC3MNUTNdky608TJragW6lshWDWw8jq1r+/AmttJKQJungx4/GErLbRNKbzxva+/hSG79blHCTyQlYsji/HBare/+KsUPfNC+dGQFH/NHeIwXrg3q9URdjac3k/j8cGY3+ovnry5OYZZEybs31UlvgYiV7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fJf/AObx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34949C116D0;
	Wed, 25 Feb 2026 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983835;
	bh=UPbEM0wOoadFE6QJouIjw86MUiYhvgMcliXTHVY/RIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJf/AObxvoldGaapDCImY0IsZN5QbpalU2F1eikaYPOvCU6B+xHibjwEFMSt8VQAL
	 u8TwKS9c7wEkosd6HJb079f0I00Al+Ru09Wy6T4eWA6WGVzLX6VFNDGQqEqf+u+8dy
	 44BXm1y62jbgpAAcj7PXZjmngN+NYta1Zw1O6yo4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Andrea Righi <arighi@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 115/641] sched/deadline: Clear the defer params
Date: Tue, 24 Feb 2026 17:17:21 -0800
Message-ID: <20260225012351.916701328@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218937-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,infradead.org:email,arm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email]
X-Rspamd-Queue-Id: 262A318FE51
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Fernandes <joelagnelf@nvidia.com>

[ Upstream commit 3cb3b27693bf30defb16aa096158a3b24583b8d2 ]

The defer params were not cleared in __dl_clear_params. Clear them.

Without this is some of my test cases are flaking and the DL timer is
not starting correctly AFAICS.

Fixes: a110a81c52a9 ("sched/deadline: Deferrable dl server")
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-2-arighi@nvidia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/deadline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c7a8717e837dd..72499cf2a1db5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3591,6 +3591,9 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
 	dl_se->dl_server		= 0;
+	dl_se->dl_defer			= 0;
+	dl_se->dl_defer_running		= 0;
+	dl_se->dl_defer_armed		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
-- 
2.51.0




