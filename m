Return-Path: <stable+bounces-251216-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ/gITQWDmpb6AUAu9opvQ
	(envelope-from <stable+bounces-251216-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:14:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16535599545
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195F83297AC8
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB9A372691;
	Wed, 20 May 2026 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Spx2aMv2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D8B3DC4DA;
	Wed, 20 May 2026 17:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297403; cv=none; b=k3xakmoRubDfloQclSq1rskBorZbXgbz5VrIHYQv7DJk2PHCj3VqAg4VVXTz8Nvs+9noDqJI/mdClgvVpbMyheEquAosxbYCmkyYXttLlQbXMORbhea1W20v/Z7JcfsQz1bqr8sujwvj+IP0rK2att6HO7dhPMDxNphlCepcQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297403; c=relaxed/simple;
	bh=9IKl3NTpmZdrZRzB/N/HPDK9/+/Lxw9HwC4LGeVmVDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B2/Gh2arhiyEZevukcEAOeNTP0YdaKC6ZXCMpr4LE3JQe8Ty7tRLjvcoKNhXg2HX3p8bABHgUNAcjI+utdl5b/GdLzyVcZ2zBCI61gUJKlj2W//ziLWnqEYugv5MwXTPKmUw7+vFEq2dJSbxVOAVwZbTtwV0a8XsLjNWhkmVdxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Spx2aMv2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7021F000E9;
	Wed, 20 May 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297402;
	bh=Cp3ZyUqpvZ0bdNKCOHjla6dS10YvFgEgKByyak00wcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Spx2aMv2bT7/h23u5YnDnYl4b4YK0NLnQikpT0SZXiULjUkNJ0eZ0/02zmkGwmTUZ
	 /VFyAKwRUb2oVL0TUbGlJ342EhFOLP21Y1+c9i2ap9Gapm81X8NqWI18JypKjFcLGQ
	 NbYxloouceyNe1phl/DM63eZpTXEPPQMTTcNmSlM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 019/957] OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp()
Date: Wed, 20 May 2026 18:08:22 +0200
Message-ID: <20260520162134.977680055@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251216-lists,stable=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 16535599545
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 3d2398f44a2d48fb1c575a6e0bc6b38f3e689e22 ]

The commit ff9c512041f2 ("OPP: Use mutex locking guards")
unintentionally made the for loop run longer than required.

scoped_guard() is implemented as a for loop. The break statement now
breaks out out the scoped_guard() and not out of the outer for loop.
The outer loop always iterates to completion.

Fix it.

Fixes: ff9c512041f2 ("OPP: Use mutex locking guards")
Reported-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/opp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 775d4a36f2f54..157c84b689feb 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2741,8 +2741,8 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
 					break;
 				}
 			}
-			break;
 		}
+		break;
 	}
 
 	if (IS_ERR(dest_opp)) {
-- 
2.53.0




