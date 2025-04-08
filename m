Return-Path: <stable+bounces-131176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BCBEA80911
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEF74E2436
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C8277021;
	Tue,  8 Apr 2025 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E1LLGgV3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F10526F45F;
	Tue,  8 Apr 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115694; cv=none; b=OsuMQD6mkYH+Uu12yd9NE05SZJnwuu1EYu+QD8BafnNbGLzDz0XyuHnJZ3C9KKWL2FO1Itzt3/TKLyHftk/Bo1EHhjsuH8KmktqTyuZTXPAqOIVqAEbhSLO0Rz1aDAkCOTiQYTZ2UDsDB36rpZNbVYduB3mbMSf33Iv6CAuCYOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115694; c=relaxed/simple;
	bh=ym+q3y7HWrIEW7mV9f0jyJkrBBJNCNoC/zhLFhhs4Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUcO7+Eb5i045oRVBItDH3IICdfu35pDxWUpwbOuK9UPcy3sofb46c8boGsrkmYmoTx1MUky5TFwZvaJ/hwyNOTCJ262TP2OP3CJw3TklpNYyeowos0RaWnqpinyLvRxbOftG6oaNr21ADeqhmXtb6KN+0ZiFwWoEbWHuSqgbeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E1LLGgV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D63C4CEE5;
	Tue,  8 Apr 2025 12:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115693;
	bh=ym+q3y7HWrIEW7mV9f0jyJkrBBJNCNoC/zhLFhhs4Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E1LLGgV3vxwx8xl9oc72cAkh5h66cEDjigaADwQSJ5qVTzLfRODn7CuEKKkJxyfGc
	 SaxbDT2LA1Pdn/M4irVFkdLVlH8rmGBC6aqpb99o+s/TouwI3RHl1dDyCu+2oOXTw1
	 BvYo+gAuSTmobQ5Mn8umlpLzsNxrPaYFeEKgg1Ig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Markus Elfring <elfring@users.sourceforge.net>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 068/204] RDMA/erdma: Prevent use-after-free in erdma_accept_newconn()
Date: Tue,  8 Apr 2025 12:49:58 +0200
Message-ID: <20250408104822.359176010@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cheng Xu <chengyou@linux.alibaba.com>

[ Upstream commit 83437689249e6a17b25e27712fbee292e42e7855 ]

After the erdma_cep_put(new_cep) being called, new_cep will be freed,
and the following dereference will cause a UAF problem. Fix this issue.

Fixes: 920d93eac8b9 ("RDMA/erdma: Add connection management (CM) support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/erdma/erdma_cm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.c b/drivers/infiniband/hw/erdma/erdma_cm.c
index 74f6348f240ac..1156ae62c4683 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.c
+++ b/drivers/infiniband/hw/erdma/erdma_cm.c
@@ -704,7 +704,6 @@ static void erdma_accept_newconn(struct erdma_cep *cep)
 		erdma_cancel_mpatimer(new_cep);
 
 		erdma_cep_put(new_cep);
-		new_cep->sock = NULL;
 	}
 
 	if (new_s) {
-- 
2.39.5




