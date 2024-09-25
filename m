Return-Path: <stable+bounces-77381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C20985C89
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611B81C247CF
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4531D094A;
	Wed, 25 Sep 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRzZN4XQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED21D048B;
	Wed, 25 Sep 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265584; cv=none; b=Qv9qW8cBxR1XosyLKNWuANrBc4Es2g9EBeizQ66DSZ7PQzkh/02AH8ZM4Ztz3df0idOMzEFe6LLnGMWugmbmEVKXr4ge20HLK5ZfFGsY0iAenDjocDvshLRMBrKayDhHP/3jtEJ2G3L7FolYmV7VJJ7/4j2r8grx/yFeR6nPPww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265584; c=relaxed/simple;
	bh=yH36a8k35/aZy1UjhKV7SrI4bspgyi3+ORHp/5gofHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdZmLtLBBFSSQnlAKZ0/rEGvY7lyfUoXHihCxI9a9BJg1aHoNLLP1Vr5NCo7gZy1eNlNsAWmqVXGhzYBsmmT8CRys//UgYUZBdWEPYezLJr5nNVw8uiEtLI/1+GhmB4Zk9hh+bl39ZjQADPm94zHpTFig0NdW3oVF25eoCAU7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRzZN4XQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DC8C4CECD;
	Wed, 25 Sep 2024 11:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265584;
	bh=yH36a8k35/aZy1UjhKV7SrI4bspgyi3+ORHp/5gofHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XRzZN4XQI911Q+z4O2rcyes7KnBiOUDuFqe98h3EQzX8SExYv4XCtcn0idnosTEqy
	 7lzASMuh8BEY8z0gJv6TOFAhfabuUt6RUBPZN4PEDPo9wd7syqWg4iWskMBa5Z5jqv
	 8EDvtwn5Dsxtd/TkfNMcRDfeSQG0JWO4iSwf4JC5DinoKQHEpBRAIAD/6qr0I0l+lX
	 uDxWGv9FJnbZ20mgvh3k8yZuD8lAx4W1yibr6h+slnyfB8WXfdWOuqMHnuenZMJwje
	 S3N6s+KZJZ4jAFBdSAcUiLazqYG1R7PysirZDninX46TuxPVvkM4MH66kqbzovweUo
	 AuZtQIutLdyxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 036/197] net: mvpp2: Increase size of queue_name buffer
Date: Wed, 25 Sep 2024 07:50:55 -0400
Message-ID: <20240925115823.1303019-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Simon Horman <horms@kernel.org>

[ Upstream commit 91d516d4de48532d967a77967834e00c8c53dfe6 ]

Increase size of queue_name buffer from 30 to 31 to accommodate
the largest string written to it. This avoids truncation in
the possibly unlikely case where the string is name is the
maximum size.

Flagged by gcc-14:

  .../mvpp2_main.c: In function 'mvpp2_probe':
  .../mvpp2_main.c:7636:32: warning: 'snprintf' output may be truncated before the last format character [-Wformat-truncation=]
   7636 |                  "stats-wq-%s%s", netdev_name(priv->port_list[0]->dev),
        |                                ^
  .../mvpp2_main.c:7635:9: note: 'snprintf' output between 10 and 31 bytes into a destination of size 30
   7635 |         snprintf(priv->queue_name, sizeof(priv->queue_name),
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7636 |                  "stats-wq-%s%s", netdev_name(priv->port_list[0]->dev),
        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   7637 |                  priv->port_count > 1 ? "+" : "");
        |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Introduced by commit 118d6298f6f0 ("net: mvpp2: add ethtool GOP statistics").
I am not flagging this as a bug as I am not aware that it is one.

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Wojtas <marcin.s.wojtas@gmail.com>
Link: https://patch.msgid.link/20240806-mvpp2-namelen-v1-1-6dc773653f2f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index e809f91c08fb9..9e02e4367bec8 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1088,7 +1088,7 @@ struct mvpp2 {
 	unsigned int max_port_rxqs;
 
 	/* Workqueue to gather hardware statistics */
-	char queue_name[30];
+	char queue_name[31];
 	struct workqueue_struct *stats_queue;
 
 	/* Debugfs root entry */
-- 
2.43.0


