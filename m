Return-Path: <stable+bounces-250612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD84MhESDmoJ6AUAu9opvQ
	(envelope-from <stable+bounces-250612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:57:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 445C1598EE3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3E3137AD510
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A8356762;
	Wed, 20 May 2026 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FpoGp6g+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B749323B61B;
	Wed, 20 May 2026 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295866; cv=none; b=c0hgdBmm7+kiWXEmhBca1VpWvpN8gNct6lkiwn21mP/iSijR3MUTMaJopGEoD0V8QRSpr2ubc7QVyr3FKzx4O+mTnp18nL0DFIEsJPugABkKT4MQuLAy1KjzJoKDV4enLPUzR4Kbn26pQ5Cj12weMsPRXx5fvSgXjrhzFiZOcfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295866; c=relaxed/simple;
	bh=taHbNHkHhSohkGe/wclWpfFNm+xmRMgjovpvdWjKpkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbU1jI6yfKdji6pZ1mRsRFm+dNixrJxOXqIdLqA6GGtwz+D5sHRy9v6rjWpQ6mr0WdjQtnDa+KZbdWSVXNcjmnoIUWXFQ8jtcAihvGtZupIKLhV0ylw/QX0JR8aaYXU6+4v7hg7T7ak7l9U8hikH8bF8hBfij5+EZR0C2qNMhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FpoGp6g+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298C61F000E9;
	Wed, 20 May 2026 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295865;
	bh=ACWc7DiHZ24rXx19m5CWgzl/k36h0f+Q4xOx0K6No/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FpoGp6g+6v+Pgj36QU8YExdQuliZA2LIQQd8Vt7WJHqgxLZzvuU5NaOczHC7xPVfL
	 SfmLK1GplmoFTCFabMqoqdP5J7jxCAD0D9uF1FWdMoa78ac6vGlq8AFdX9BjZy2d4Q
	 EvLWobD1U4T7U7f+ctapHAaYWNfNDcjmay5u8BF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tim Michals <tcmichals@yahoo.com>,
	Tanmay Shah <tanmay.shah@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0582/1146] remoteproc: xlnx: Fix sram property parsing
Date: Wed, 20 May 2026 18:13:52 +0200
Message-ID: <20260520162201.351724610@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250612-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yahoo.com,amd.com,linaro.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Queue-Id: 445C1598EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tim Michals <tcmichals@yahoo.com>

[ Upstream commit d116bccf6f1c199b27c9ebdf07cc3cfe868f919c ]

As per sram bindings, "sram" property can be list of phandles.
When more than one sram phandles are listed, driver can't parse second
phandle's address correctly. Because, phandle index is passed to the API
instead of offset of address from reg property which is always 0 as per
sram.yaml bindings. Fix it by passing 0 to the API instead of sram
phandle index.

Fixes: 77fcdf51b8ca ("remoteproc: xlnx: Add sram support")
Signed-off-by: Tim Michals <tcmichals@yahoo.com>
Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Link: https://lore.kernel.org/r/20260204202730.3729984-1-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index f949749e50b0c..eb5f714de2bff 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -1007,7 +1007,7 @@ static int zynqmp_r5_get_sram_banks(struct zynqmp_r5_core *r5_core)
 		}
 
 		/* Get SRAM device address */
-		ret = of_property_read_reg(sram_np, i, &abs_addr, &size);
+		ret = of_property_read_reg(sram_np, 0, &abs_addr, &size);
 		if (ret) {
 			dev_err(dev, "failed to get reg property\n");
 			goto fail_sram_get;
-- 
2.53.0




