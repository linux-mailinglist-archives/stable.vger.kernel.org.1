Return-Path: <stable+bounces-246035-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPTHCIZqA2rF5gEAu9opvQ
	(envelope-from <stable+bounces-246035-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:59:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99560526724
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2AA131869A9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711C83955D7;
	Tue, 12 May 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2FhDstj6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B13955D3;
	Tue, 12 May 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608191; cv=none; b=BjZBoMls+kHSiY7cnP5uCtW7+OYN7C6eGjdvQ7HYreEFZorPFJcGHHk6otAMYA+78NOD1A1YtxXGrhZ+dpGwNCqGBam9uEq+llnC2TvWYZFmGV+gDJxwHVZ1CYOQ2cz1Lprw9TQtmByE7tYQDHQ9lG5CSt2Jh+lX7x4oDIJ6MT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608191; c=relaxed/simple;
	bh=45UwNRNK7vHaVCTVPrQAm3wQXmvNC6JoGZJrQqCrC7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIMDNfdmqF89siXjJnRxZ4AapqpvIo6KbZ2jo83EBxrnaU02ZvSe1n/XMHaJ3z7LtJRvVo08dIxmnnmtem0Yu1J5lUf8vFkc22IeFDNFFWF1BJeT1bRwdyDxujOuF7GZq3dN0JO+dq8FP1uuLo+HRB3vHIm1wREuo0xv2Dn5WcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2FhDstj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADFFAC2BCB0;
	Tue, 12 May 2026 17:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608191;
	bh=45UwNRNK7vHaVCTVPrQAm3wQXmvNC6JoGZJrQqCrC7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2FhDstj6W54Om8t9/KjfZksGT4godOGYQnfeKEvk9BjASyToBWO4JAU8xXL0sgae0
	 avXH8UpUPWAhrIOf4coNWqCVrJCrTgfkS13QSFsGKXYY+sFG4wwBBf7VJn0mA6PetB
	 DWcvXMWeqKF/wMkvk0M7Tp3UTf/SMvlaNtfXx7NM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.12 153/206] RDMA/ocrdma: Dont NULL deref uctx on errors in ocrdma_copy_pd_uresp()
Date: Tue, 12 May 2026 19:40:05 +0200
Message-ID: <20260512173936.104310353@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 99560526724
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-246035-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,nvidia.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

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
 



