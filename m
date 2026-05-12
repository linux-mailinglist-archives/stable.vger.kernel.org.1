Return-Path: <stable+bounces-246566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cML4BlxxA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B23BC5279A9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B489132CA7B0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F441349AF5;
	Tue, 12 May 2026 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lB6FOQ4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8CF352F86;
	Tue, 12 May 2026 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609556; cv=none; b=KW+tnkpLilUPQyvVKKqJ7UI14Vn0YYjVYUWjQ7rUvX/O388QV7xyOJXmB+wM6s/2r7+Lx0zYJiKHLbuLIyrnhFnnCxmOLpr1cWC5Da3PRJHulmgQFS5KNe26walJrBW0vjw1+awQc7MgB4XdBVegKXzyTmUeeXOur8wCJFAsLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609556; c=relaxed/simple;
	bh=/jHY/82Pi3OvOkGcZUyfK/sCNJYiSbYMa2i3v74XIks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP4eeuMPhinjs02j3XyevuBmmaVvcFqFY5c3/eG6tA4ljXbDvP7WREgfj7p38VpVk0u4EOoxy1retfgMZ8ePIPC0GnMtJHxGcqOdeZ7Rj5DPlP9Z5bK1988GI4gm19YIXyklFPsUkzhYDhaGS+Sy8fDv3BlZVEWIaAKFb1Gyhus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lB6FOQ4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD42C2BCB0;
	Tue, 12 May 2026 18:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609556;
	bh=/jHY/82Pi3OvOkGcZUyfK/sCNJYiSbYMa2i3v74XIks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lB6FOQ4macnC0EWOPaRGO/kzpTSXrIqtUIeRxHlgmPF1K+/PmEmCl/HJ7zf/E/z8g
	 fDQUuV23ETUHCmlS66qJPQehOh8XaMfFw8/l7+R55aSsd1BI3ZBpQJO/DFC1AWAA17
	 Xr58L2Qz6MNRQ5YB2MG1jidTV/C8q60jOSL0++to=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7.0 240/307] RDMA/ocrdma: Dont NULL deref uctx on errors in ocrdma_copy_pd_uresp()
Date: Tue, 12 May 2026 19:40:35 +0200
Message-ID: <20260512173945.187874867@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: B23BC5279A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246566-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sashiko.dev:url,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 34fbf48cf3b410d2a6e8c586fa952a36331ca5ba upstream.

Sashiko points out that pd->uctx isn't initialized until late in the
function so all these error flow references are NULL and will crash. Use
the uctx that isn't NULL.

Cc: stable@vger.kernel.org
Fixes: fe2caefcdf58 ("RDMA/ocrdma: Add driver for Emulex OneConnect IBoE RDMA adapter")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=4
Link: https://patch.msgid.link/r/9-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
@@ -620,9 +620,9 @@ static int ocrdma_copy_pd_uresp(struct o
 
 ucopy_err:
 	if (pd->dpp_enabled)
-		ocrdma_del_mmap(pd->uctx, dpp_page_addr, PAGE_SIZE);
+		ocrdma_del_mmap(uctx, dpp_page_addr, PAGE_SIZE);
 dpp_map_err:
-	ocrdma_del_mmap(pd->uctx, db_page_addr, db_page_size);
+	ocrdma_del_mmap(uctx, db_page_addr, db_page_size);
 	return status;
 }
 



