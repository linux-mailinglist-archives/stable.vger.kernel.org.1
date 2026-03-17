Return-Path: <stable+bounces-226529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE4kKB+MuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3085F2AF2F9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DB2831B9494
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECA93E3DB1;
	Tue, 17 Mar 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hKeJa3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126032FFDEA;
	Tue, 17 Mar 2026 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767098; cv=none; b=E3MNw0LWDSRh1WMxuMg1MMl3NoMw/P+4le/nm9PAvD+Q1EXPgZ4kg1TjgThJJz+NvgaaEpcGAf1BnRxIdSl1Gi2UywfAHjAuQsXnzcPOaeP0babWV7N0nVgooJzDkkZaYlcx5Vcoy3TBLJZwgMwyz1M/7cP0P7QU5Bs25KETWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767098; c=relaxed/simple;
	bh=2mUsQ32Y0b0PvsAUoUTQ532Hb67LtJINrDLCrT/m5yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0YyNnwsv6fuA68ZSw+zdipDk4W44Axr9aRBY/TVPtFU0ObLcBEBvJVHKy6+wzZP4mzsiI7KOAp6Q/Ph6rtvjZPLka9RYxP13kESycikO9WA2WtVgBQcepWhUyWVLY9qWU5soNOLLyRIQtnl1g9+D5OXZ4IJjzRrmbaRqhDBr/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hKeJa3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175C8C4CEF7;
	Tue, 17 Mar 2026 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767097;
	bh=2mUsQ32Y0b0PvsAUoUTQ532Hb67LtJINrDLCrT/m5yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1hKeJa3h1OqAGP5arwogv0ostCxxp2l42x1LHqERuKVDKRwVSdKk5+gkFHsxhl+de
	 CQov0ZxlIL1nyV28em4yvknxDH1P+2FPCvpRSMEhZcAWfpIeIYRkjSqXnMrV/nTRa9
	 oLGaqO1xPCfopNQHmF/vp5JCGrBnMfzymiGvcLF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangshuaiwei <wangshuaiwei1@xiaomi.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 014/333] scsi: ufs: core: Fix shift out of bounds when MAXQ=32
Date: Tue, 17 Mar 2026 17:30:43 +0100
Message-ID: <20260317162959.889075830@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226529-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email,acm.org:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xiaomi.com:email]
X-Rspamd-Queue-Id: 3085F2AF2F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangshuaiwei <wangshuaiwei1@xiaomi.com>

[ Upstream commit 2f38fd99c0004676d835ae96ac4f3b54edc02c82 ]

According to JESD223F, the maximum number of queues (MAXQ) is 32. When MCQ
is enabled and ESI is disabled, nr_hw_queues=32 causes a shift overflow
problem.

Fix this by using 64-bit intermediate values to handle the nr_hw_queues=32
case safely.

Signed-off-by: wangshuaiwei <wangshuaiwei1@xiaomi.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260224063228.50112-1-wangshuaiwei1@xiaomi.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ufs/core/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 403f8989b1448..fe1425ea6718f 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7078,7 +7078,7 @@ static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
 
 	ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
 	if (ret)
-		outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
+		outstanding_cqs = (1ULL << hba->nr_hw_queues) - 1;
 
 	/* Exclude the poll queues */
 	nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
-- 
2.51.0




