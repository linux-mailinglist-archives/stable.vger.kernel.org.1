Return-Path: <stable+bounces-220693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KmWE3tDo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C421C7273
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D43C3163822
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A48D3F8317;
	Sat, 28 Feb 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6JVk3KG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1C3F8B1B;
	Sat, 28 Feb 2026 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300573; cv=none; b=dRI+C7Y3knbh9zZe3T0+YXmfNRSaE3sIXlJsFMreaUOjo5lu/BLtx64ixyR9ukQa2Cg+wwhICvA1gjq4aUp6R+IqKr+lrGLODEzhyhBQIZ50xKxZoSPXVgkhApHKYzZdNtV594T+EmwMO/Oykz2yWh85pOPhQF9iDaAZOcQOQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300573; c=relaxed/simple;
	bh=dTle06lUXDk7SlT5K/JGW0wMzFUKzTs8xoOQno5za78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDYENm5m2FVNrEX3+5jIz0o67pc7OGuWpPMLRNGQVU5BVBLqnGz4lQTvMMQdLvLJzjkP3JmrJk7Dveu7XvOwoIoR/Qe3FZjonQtV1o1WdV2/sXMyy57ABBQZesd0IAcUF1A94IIveQ8EplXQ8YYu381d+cLSNzdTDQ9eDdM+f38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6JVk3KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1589DC19423;
	Sat, 28 Feb 2026 17:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300573;
	bh=dTle06lUXDk7SlT5K/JGW0wMzFUKzTs8xoOQno5za78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6JVk3KGXALh0MnzMQ3j0DOvS9tfniQbw4MT/Yn+6GgtMSTRM1D8E+htETv0PyTSb
	 N6qBkDSJ+fl4PwKS9j/1lAvSd/LVL0FiIBETpRkwXcaZc2KFTokoxdXO7Lg4dy1sQR
	 RpD4WetflKdEcg9gMgIrm3ccbLYv/N8yX++u3wY6LCRX6oJs50SPljVBZkA/9ndjJq
	 CRilyXCf7D6msEsisAdansyv7UaMIzZJ54t1Ugpc5e/dOwFEGlVm8WGqMCweFe7d3X
	 wo9KqZ2v48hZe+6dJtn96WDKB2emPBwBIXvHPsX4d61I/VjOkALro1JmuVWY7TrOm+
	 Rdta4tuB68agg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 614/844] media: stm32: dcmipp: bytecap: clear all interrupts upon stream stop
Date: Sat, 28 Feb 2026 12:28:47 -0500
Message-ID: <20260228173244.1509663-615-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-220693-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,st.com:email]
X-Rspamd-Queue-Id: A5C421C7273
X-Rspamd-Action: no action

From: Alain Volmat <alain.volmat@foss.st.com>

[ Upstream commit 222f1279edd9008ee35b62de156ddac84e31443c ]

Ensure that there are no pending interrupts after we have stopped the
pipeline. Indeed, it could happen that new interrupt has been generated
during the stop_streaming processing hence clear them in order to avoid
getting a new interrupt right from the start of a next start_streaming.

Fixes: 28e0f3772296 ("media: stm32-dcmipp: STM32 DCMIPP camera interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
index 1c1b6b48918ee..b18e273ef4a3e 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-bytecap.c
@@ -512,6 +512,9 @@ static void dcmipp_bytecap_stop_streaming(struct vb2_queue *vq)
 	/* Disable pipe */
 	reg_clear(vcap, DCMIPP_P0FSCR, DCMIPP_P0FSCR_PIPEN);
 
+	/* Clear any pending interrupts */
+	reg_write(vcap, DCMIPP_CMFCR, DCMIPP_CMIER_P0ALL);
+
 	spin_lock_irq(&vcap->irqlock);
 
 	/* Return all queued buffers to vb2 in ERROR state */
-- 
2.51.0


