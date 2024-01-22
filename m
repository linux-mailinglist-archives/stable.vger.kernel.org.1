Return-Path: <stable+bounces-15287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E62838505
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7273DB291F9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B1E745D8;
	Tue, 23 Jan 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHqHFC7d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847236A024;
	Tue, 23 Jan 2024 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975448; cv=none; b=ZdFfYaZwdImO+2/KyvYoEROsdhmQktwb/LAWSrOCsbTiSyMbMZsVoE8wKR5/efVe5+I+jJRna11Yboic/nSqCjDqfXxr+IDwXhoaZZe4OVR0Vz74NOUKwhdMX6owC7oMoccRUDNHcUTBON8Wu/0wsmJ/4l1tSfn/ei6hhxGudPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975448; c=relaxed/simple;
	bh=OrKk9yYcOOt09DtiUFGogMNLG1jV54Wsoff2qvap3Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzHNfQTX6ktzSYCDV3ewArP0dVeIU9Rf+IRNnJ8ZxS4Lq2KViQYBntDv2sO/jFVY7JCEX5VAXoej7JKC1lX1fJ+JqCb7W66lhpqmFU/l/KkNYDthyHtLcnwh60UUMolRT0UVgHYKyi4iQwE3B2JHkVGVzdfFzd/K1j8fg6+8OoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHqHFC7d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B12CC433F1;
	Tue, 23 Jan 2024 02:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975448;
	bh=OrKk9yYcOOt09DtiUFGogMNLG1jV54Wsoff2qvap3Og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHqHFC7dYU9RFcbK6ap0wz7eNgPzXy7pHZphHHEHlorp8H/VgUMto6v16sHiNTinF
	 TR8K0KFwdoesLdcnDnY+tmKaa4Dh7U9iryx13uNC0pfkGAsJyxE8gRMiLenZwEbhBo
	 e0GbtqUg450z2X7VDXbCTc6QRUsYMVDbKkVYAiKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	lonial con <kongln9170@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.6 404/583] netfilter: nf_tables: check if catch-all set element is active in next generation
Date: Mon, 22 Jan 2024 15:57:35 -0800
Message-ID: <20240122235824.344659912@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit b1db244ffd041a49ecc9618e8feb6b5c1afcdaa7 upstream.

When deactivating the catch-all set element, check the state in the next
generation that represents this transaction.

This bug uncovered after the recent removal of the element busy mark
a2dd0233cbc4 ("netfilter: nf_tables: remove busy mark and gc batch API").

Fixes: aaa31047a6d2 ("netfilter: nftables: add catch-all set element support")
Cc: stable@vger.kernel.org
Reported-by: lonial con <kongln9170@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6431,7 +6431,7 @@ static int nft_setelem_catchall_deactiva
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active(net, ext))
+		if (!nft_is_active_next(net, ext))
 			continue;
 
 		kfree(elem->priv);



