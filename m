Return-Path: <stable+bounces-218403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM23OeZSnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7743618F5BA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B992E30B7754
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443F248881;
	Wed, 25 Feb 2026 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XU2EITlI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738E1D5ABA;
	Wed, 25 Feb 2026 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983218; cv=none; b=f6hcCbXR4rR4KtR7/xTbLGOxaO2ZlGnPprblnBZ+kXoZE4xmLAkPYJwXqfhElmM2uYpeurKrNGaurCevaegnFjX1MuE+N4Ixmtihkc9iAU1NKaWPoBDglxrD8uvUMmOiG5C95QrnhYdfcmpnQZPbZ5OWkpmb1sZNf3FrjE3WliM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983218; c=relaxed/simple;
	bh=lSKylEAecrg8Bf1dkNXdP+rGLPCFwkExjiixQ5Xnekc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJ5nn/ROxcqZUT+OhAwCrzHeZBHjk8Dpzym3Dg9pFN+/lAQnwAwap4l/4TwQDMs1wF9FKMa+LP9ziwNYlsydPXBJEn9F/LHgc79WMfhoN1d29CoX1oFPuEmyBpWmN75S30iF4EYCTNQd0iKsyfsAPiQGaVOoDcTilGYUABnKQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XU2EITlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA79C116D0;
	Wed, 25 Feb 2026 01:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983218;
	bh=lSKylEAecrg8Bf1dkNXdP+rGLPCFwkExjiixQ5Xnekc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XU2EITlISfcuh0YrIS+ih6n+VOAMA31gk2EuesK9bNLBK2d7S+6LFcHmpt56nTU0p
	 7SLdgnMHiGO7JY9QYFNRAc8GAkFlPwVqMmtqyE0DlKOaaaY4FrLuBFOIcAMEqqeajz
	 gLaLSOZf7jYsHExXqGeaAyTuHJt4pMhLpPOuECHQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Johnny Mnemonic <jm@machine-hall.org>,
	Lance Yang <lance.yang@linux.dev>,
	Li RongQing <lirongqing@baidu.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 365/781] lib/Kconfig.debug: fix BOOTPARAM_HUNG_TASK_PANIC comment
Date: Tue, 24 Feb 2026 17:17:54 -0800
Message-ID: <20260225012408.633734630@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218403-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 7743618F5BA
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomas Glozar <tglozar@redhat.com>

[ Upstream commit dbac35bee8fc844c2d8d6417af874a170a44d41f ]

The comment for CONFIG_BOOTPARAM_HUNG_TASK_PANIC says:

   Say N if unsure.

but since commit 9544f9e6947f ("hung_task: panic when there are more than
N hung tasks at the same time"), N is not a valid value for the option,
leading to a warning at build time:

   .config:11736:warning: symbol value 'n' invalid for BOOTPARAM_HUNG_TASK_PANIC

as well as an error when given to menuconfig.

Fix the comment to say '0' instead of 'N'.

Link: https://lkml.kernel.org/r/20260106140140.136446-1-tglozar@redhat.com
Fixes: 9544f9e6947f ("hung_task: panic when there are more than N hung tasks at the same time")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Reported-by: Johnny Mnemonic <jm@machine-hall.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fda79b..cda3cf1fa302c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1273,7 +1273,7 @@ config BOOTPARAM_HUNG_TASK_PANIC
 	  high-availability systems that have uptime guarantees and
 	  where a hung tasks must be resolved ASAP.
 
-	  Say N if unsure.
+	  Say 0 if unsure.
 
 config DETECT_HUNG_TASK_BLOCKER
 	bool "Dump Hung Tasks Blocker"
-- 
2.51.0




