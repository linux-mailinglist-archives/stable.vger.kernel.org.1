Return-Path: <stable+bounces-79408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E384498D81D
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B03BB21CDD
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969021D0DDD;
	Wed,  2 Oct 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lKTUvY52"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB441D0949;
	Wed,  2 Oct 2024 13:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727877362; cv=none; b=bcyuRY1fYUWAFWqyxyDtHMhl0x2SCh5jX98YRVJ5vRMjpvTbJadJlx1ybK2Dn0amJfw0yipUVMQ88MJ5vxKHnbnWNcU000lmCgnLiBeMzTQYj3TWFdGLpk1RJTh5UhE0uOCsv/gn8LDk9eLwtexFyyY/MKUlfIt+l8gTk1gQQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727877362; c=relaxed/simple;
	bh=jD68Nn6GIouzYEZtgxF940KFlBWJOEkjTKR+Cepk0RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrwY7tgs4ntREbHzXVQG62aeZm7wNzSqB5HbWAg5cn5EeCp1ST3sKqFEELGmPRZnbZPo+WopZ1mW7y+U2pCV3ZmkJRf+/88pMGnf7lqsdxYuEU5HJKlp9Uda4ifce5tZfFiy16LaM2p7vNjFNKYjq+LOECB2O59FOxxAL9hXbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lKTUvY52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70932C4CECD;
	Wed,  2 Oct 2024 13:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727877361;
	bh=jD68Nn6GIouzYEZtgxF940KFlBWJOEkjTKR+Cepk0RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKTUvY52yDggEKPniN2O0T0DjCOgVR4Kr6H4+bydzu8d0HnbiCsILvRZDOoay9v0U
	 sUv9HEBVNi8nFZNJG1VrR5e5FR5nj+RzYFnES+lJ5UR2GkuhFglPmhrLupzFuEoxHd
	 9DuhlCCMflHWhJr+CwVI/5QVhj3wG9sKKz/2YVXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 055/634] netfilter: nf_tables: reject expiration higher than timeout
Date: Wed,  2 Oct 2024 14:52:35 +0200
Message-ID: <20241002125813.276907178@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125811.070689334@linuxfoundation.org>
References: <20241002125811.070689334@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit c0f38a8c60174368aed1d0f9965d733195f15033 ]

Report ERANGE to userspace if user specifies an expiration larger than
the timeout.

Fixes: 8e1102d5a159 ("netfilter: nf_tables: support timeouts larger than 23 days")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e3ac29f75f32e..fcb68fe818566 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6881,6 +6881,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 					    &expiration);
 		if (err)
 			return err;
+
+		if (expiration > timeout)
+			return -ERANGE;
 	}
 
 	if (nla[NFTA_SET_ELEM_EXPR]) {
-- 
2.43.0




