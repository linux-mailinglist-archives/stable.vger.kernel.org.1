Return-Path: <stable+bounces-250212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPesAvPkDWpN4gUAu9opvQ
	(envelope-from <stable+bounces-250212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A92325925CF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 678613163EE5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6FB36E460;
	Wed, 20 May 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PBMPa+sS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985513EF0A1;
	Wed, 20 May 2026 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294822; cv=none; b=sQnRbd4+Yru7UGvVbNJQ2KaBvYW4wAJZBnUrI8Uvm5V7PZOME4w+76pkNnFUJdJlX55vi7reWVQeDduyKiHbLVdK1Fo7/K3i6vB7L7zJ9wkhOPi/hc732/TWac0e/t96YA09Rgp+4V9JsNqKUxfFn8IZqtFIP7a/fGHE40beHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294822; c=relaxed/simple;
	bh=CAITF7b+xCdJeaNUF7Y5tEG7VTsNCYqTSUP3/RGVFDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7Qjwg8iyPk6/7SWqrdG2zUtYkkTUV4LWF3YEtccPOPnhDfcEHnYDZSIvC6nIvH+eEbStdIhl2PWh9QZKAZbfSzysgbjkwKszHnrUT6AmKFQoXwQVjYxL6kVm/leS6Td6Fj1DiatXdJ0BHG2GXTFNUZn0WjiJwSeM8mCFyJpSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PBMPa+sS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CDD1F00893;
	Wed, 20 May 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294821;
	bh=CUTsPdZUDSPslwTk2X5QzjFYpXQ0l1b9uEmFhdOluZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PBMPa+sS0Pq5NJIzwn065QT9pnN8MijQaxcIPDo0/P3LwDcPUN9KDErwS8sUWP3gp
	 m41o2uQ2ZTAaObpkH4xR+GVo51zupFzelyegGLVbq9UiAYyUMwTDt2MTRI5Zv7cgm2
	 Dqxi/Swi1YMzTlC+x1SZJOQ+/1rEW3VgsjkNuJFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xuegang Lu <xuegang.lu@airoha.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0185/1146] net: airoha: Fix FE_PSE_BUF_SET configuration if PPE2 is available
Date: Wed, 20 May 2026 18:07:15 +0200
Message-ID: <20260520162152.465542107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250212-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A92325925CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Bianconi <lorenzo@kernel.org>

[ Upstream commit 02f72964395911e7a09bb2ea2fe6f79eda4ea2c2 ]

airoha_fe_set routine is used to set specified bits to 1 in the selected
register. In the FE_PSE_BUF_SET case this can due to a overestimation of
the required buffers for I/O queues since we can miss to set some bits
of PSE_ALLRSV_MASK subfield to 0. Fix the issue relying on airoha_fe_rmw
routine instead.

Fixes: 8e38e08f2c560 ("net: airoha: fix PSE memory configuration in airoha_fe_pse_ports_init()")
Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Link: https://patch.msgid.link/20260408-airoha-reg_fe_pse_buf_set-v1-1-0c4fa8f4d1d9@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 9285a68f435fe..c14cdce588a7c 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -293,16 +293,18 @@ static void airoha_fe_pse_ports_init(struct airoha_eth *eth)
 		[FE_PSE_PORT_GDM4] = 2,
 		[FE_PSE_PORT_CDM5] = 2,
 	};
-	u32 all_rsv;
 	int q;
 
-	all_rsv = airoha_fe_get_pse_all_rsv(eth);
 	if (airoha_ppe_is_enabled(eth, 1)) {
+		u32 all_rsv;
+
 		/* hw misses PPE2 oq rsv */
+		all_rsv = airoha_fe_get_pse_all_rsv(eth);
 		all_rsv += PSE_RSV_PAGES *
 			   pse_port_num_queues[FE_PSE_PORT_PPE2];
+		airoha_fe_rmw(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK,
+			      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
 	}
-	airoha_fe_set(eth, REG_FE_PSE_BUF_SET, all_rsv);
 
 	/* CMD1 */
 	for (q = 0; q < pse_port_num_queues[FE_PSE_PORT_CDM1]; q++)
-- 
2.53.0




