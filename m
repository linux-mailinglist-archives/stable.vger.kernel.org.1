Return-Path: <stable+bounces-250047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAdNIFjiDWpF4gUAu9opvQ
	(envelope-from <stable+bounces-250047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:33:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D8592131
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2F113051ACC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E233D8103;
	Wed, 20 May 2026 16:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dUeiOUIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318813D5642;
	Wed, 20 May 2026 16:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294404; cv=none; b=FnSdAd2DwyzW2cLSSzTEEEfOyTcDt6gTvYMEpZI3hAJhQYtSA++6YDeihKewd/gZG3Yaj0apdqhJJMX4q+HRhzVcjua9ow3zQKrvwkvU/RSYGwZ6gQbTT4HvaWAgQPFKTjIvMqkkQxoyk4RAKSSMLn4mUfmH9cUtEWmgkfBRDuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294404; c=relaxed/simple;
	bh=IM6Z6JnZeilOSU7sVEtFS76oaBe7+SQPOdNDc8R9QPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjMtkWuIpVPw4YsCiNYJp1BITgqh6/R9E7+C919CoaO4zMr9NUgtHcLgU3zmgjpdDVpLpgz3c3blvtBRr7y+ZCDUalXjWvWY/LL3yMmtfMK0BVyB4xjdCpFikB1VRq+l652wAeTN6wVbVX5bi5WyY2zlZcuXO36HiIVHoCZvy/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dUeiOUIJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA851F000E9;
	Wed, 20 May 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294402;
	bh=rLJ3GBOzdVYvwNqE03SDW1EF5lPyMwVSpXxJva0wwdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dUeiOUIJ6cK8xN4Jsiy6E1HT/qNWfS2hUpKh8U0zqZ+PO/szJ1nBAoPEGcUH3cLHf
	 Huy67oXybk36ODGk7B8ldBvbowNSmlHqiCpuqXHcSL1Ee1PhoAnF56B+WQb+6tccgt
	 K4fcOaIpINPcnhcmhFtU5UTAY7s3iOqoiQFRx0XA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0026/1146] OPP: Move break out of scoped_guard in dev_pm_opp_xlate_required_opp()
Date: Wed, 20 May 2026 18:04:36 +0200
Message-ID: <20260520162148.976843916@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250047-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 328D8592131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 866641666e410..da3f5eba43419 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2742,8 +2742,8 @@ struct dev_pm_opp *dev_pm_opp_xlate_required_opp(struct opp_table *src_table,
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




