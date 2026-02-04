Return-Path: <stable+bounces-213485-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAMMLV9dg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213485-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:53:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5BE7857
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E3E3012C6F
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D445280CD2;
	Wed,  4 Feb 2026 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjVqcXod"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E7327FD56;
	Wed,  4 Feb 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216497; cv=none; b=YUW3RQxNx993nXViKwj4ctZtrc1VrgQ7WAwcim58vT1+NT6SecVqxsudKJvEY0bJj3VgvUylOEV29OJ9r3fP9rx2K7IE2F3BA1a7q5DQN8INK15KMxyCHSZn5W0EdwUHby9Ixh+z5xKaiDiquqbOZ2GBFsaYI+zXYXXr/Zln1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216497; c=relaxed/simple;
	bh=igbz/sw+7D2pFsU6w6fsQ0eKUgWekH8/teSmaYAaL5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n2KH1ILeCfsiLerERz7DJv3JaWgwKt8iPIinyNENDwviflh5UJDVHkXzKhDKBLjJWoTphqnmx83u2mWJc4XZbLuAA4GCbVVr7juht2M0gHDpA9eDldv7+kPdOy0gc6fYAW+LqxNuVq9+LHZNnkz1o0OEBzjGWsxrR0zhnK6hbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjVqcXod; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C48CC4CEF7;
	Wed,  4 Feb 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216496;
	bh=igbz/sw+7D2pFsU6w6fsQ0eKUgWekH8/teSmaYAaL5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cjVqcXodzsWWHQKhZ/QEkwL/7jkOhcuREG5eWR7MHtdzuDaEYu80IB8BAVbQ0kcVZ
	 SBN4jXKJjZDlj5I8MtugxGFGmUs4h22fFewitwPdvm4I4DFsgxj0paG2Wf0SrIC8sb
	 HmyOsoXlAJqllqybXvsTlpFHOfRw58tVzQtWvsMU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10 098/161] octeontx2: Fix otx2_dma_map_page() error return code
Date: Wed,  4 Feb 2026 15:39:21 +0100
Message-ID: <20260204143855.271802380@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.755002596@linuxfoundation.org>
References: <20260204143851.755002596@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-213485-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 1AD5BE7857
X-Rspamd-Action: no action

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit d998b0e5afffa90d0f03770bad31083767079858 upstream.

0 is a valid DMA address [1] so using it as the error value can lead to
errors.  The error value of dma_map_XXX() functions is DMA_MAPPING_ERROR
which is ~0.  The callers of otx2_dma_map_page() use dma_mapping_error()
to test the return value of otx2_dma_map_page(). This means that they
would not detect an error in otx2_dma_map_page().

Make otx2_dma_map_page() return the raw value of dma_map_page_attrs().

[1] https://lore.kernel.org/all/f977f68b-cec5-4ab7-b4bd-2cf6aca46267@intel.com

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260114123107.42387-2-fourier.thomas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -562,13 +562,8 @@ static inline dma_addr_t otx2_dma_map_pa
 					   size_t offset, size_t size,
 					   enum dma_data_direction dir)
 {
-	dma_addr_t iova;
-
-	iova = dma_map_page_attrs(pfvf->dev, page,
+	return dma_map_page_attrs(pfvf->dev, page,
 				  offset, size, dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (unlikely(dma_mapping_error(pfvf->dev, iova)))
-		return (dma_addr_t)NULL;
-	return iova;
 }
 
 static inline void otx2_dma_unmap_page(struct otx2_nic *pfvf,



