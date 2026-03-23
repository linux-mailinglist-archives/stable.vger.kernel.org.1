Return-Path: <stable+bounces-229120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qO2hBBhtwWmqTAQAu9opvQ
	(envelope-from <stable+bounces-229120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:40:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15B2F8976
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 423F33388BEC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14A4277CA5;
	Mon, 23 Mar 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L58oU5F8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E492777FC;
	Mon, 23 Mar 2026 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278122; cv=none; b=fsyUO9K+HO8qQpfQM4E6RuNkPYBIzX2L3I8iOEHLm6PYuwDtzoHQA2U0ccMwP0y5fihReGY5Z5mnF2x5XIUrjakoHPWXZFhFJN4QqL+wF7Tv8wAC0mOhfIcJt0DIn4MHOTHXBJyBjUIqC1XCNjFVfZPmHPlWTl9MAxdvjyDS018=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278122; c=relaxed/simple;
	bh=KXA6nFLoJORx+LK4Dgs0zeB6yCPyVWYkXZO3eLboSrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdZNZpO3r84+KreflQgkITM2rmsSEuUKhs7GBQxmKQIPL2zEsoc14lneFWJMhY6WW6MKIWPmk6CpHC1d6hthL1Pm2y+8tjlS/l/bAcpzgVX5Iq0FdU/Cl85drYLUuttZX2Pwm1RDb2P4MjsN/IGZ8ZnDP6Q7T2L2hSDKJZMfExI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L58oU5F8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6414C4CEF7;
	Mon, 23 Mar 2026 15:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278122;
	bh=KXA6nFLoJORx+LK4Dgs0zeB6yCPyVWYkXZO3eLboSrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L58oU5F83FYMtshT0Sgbl18aS9UdJE98asob4s6VVasA75A8huCnPzSOL1RKkfbPK
	 7VEyBiwzOYIJdhTe47yecTI08YmIgfIcCfUfe6LChYJeX4ZUrAfveBVY/FE5WgGAlI
	 LNfVAI2FQ2M5eBzrC+mZ5BL38JiuGWPEi1rkNJCk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	wangshuaiwei <wangshuaiwei1@xiaomi.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 208/567] scsi: ufs: core: Fix shift out of bounds when MAXQ=32
Date: Mon, 23 Mar 2026 14:42:08 +0100
Message-ID: <20260323134538.983785866@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229120-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3F15B2F8976
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 4b34f65e6d8e2..d109a0c8f75ff 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -6960,7 +6960,7 @@ static irqreturn_t ufshcd_handle_mcq_cq_events(struct ufs_hba *hba)
 
 	ret = ufshcd_vops_get_outstanding_cqs(hba, &outstanding_cqs);
 	if (ret)
-		outstanding_cqs = (1U << hba->nr_hw_queues) - 1;
+		outstanding_cqs = (1ULL << hba->nr_hw_queues) - 1;
 
 	/* Exclude the poll queues */
 	nr_queues = hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
-- 
2.51.0




