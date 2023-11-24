Return-Path: <stable+bounces-1225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A87D7F7E9B
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A3528233A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499DA2FC4E;
	Fri, 24 Nov 2023 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KL+WBReO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECB628DC3;
	Fri, 24 Nov 2023 18:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C66FC433C9;
	Fri, 24 Nov 2023 18:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850869;
	bh=AWP4BSjS+9UIH2C2LBZIYPc3kUFB5W1xwCmEBbeDVyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KL+WBReO8+AKT4XhsNP89xjPMeX1BJvvdM2YdlnZQa+ol600rqrGduiP144bpcF/a
	 k/9U6e2SWxC2n4MlzdyPJ4LD/uk9DN6rXQRK31qgEUWA8Om1KdlNYmvwbFNS+iODMl
	 vJa8SKzupsvhsDEqe0ZJDtgGSO95kB8pa1IZAx4c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 197/491] netfilter: nf_tables: bogus ENOENT when destroying element which does not exist
Date: Fri, 24 Nov 2023 17:47:13 +0000
Message-ID: <20231124172030.420475264@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit a7d5a955bfa854ac6b0c53aaf933394b4e6139e4 ]

destroy element command bogusly reports ENOENT in case a set element
does not exist. ENOENT errors are skipped, however, err is still set
and propagated to userspace.

 # nft destroy element ip raw BLACKLIST { 1.2.3.4 }
 Error: Could not process rule: No such file or directory
 destroy element ip raw BLACKLIST { 1.2.3.4 }
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Fixes: f80a612dd77c ("netfilter: nf_tables: add support to destroy operation")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8776266ba1532..398a1bcc6ea61 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7202,10 +7202,11 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 
 		if (err < 0) {
 			NL_SET_BAD_ATTR(extack, attr);
-			break;
+			return err;
 		}
 	}
-	return err;
+
+	return 0;
 }
 
 /*
-- 
2.42.0




