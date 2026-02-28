Return-Path: <stable+bounces-220420-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH/WFrk5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220420-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F441C65FA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1F6132A68DA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486203B1B00;
	Sat, 28 Feb 2026 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZEThMD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA263B1AF5;
	Sat, 28 Feb 2026 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300311; cv=none; b=LmndeAjcXMm62lnq9HQ/LBlEiDRODE2jbNR7CKz4ADVJRPcM416R2Nbu5WEhHAx1KCamQR0x1P3JHP3faH/QmD0Z7ASqq9hB6NJ75+Opgt9y4Ksg2INF3z7OLczT0FHUw4cS5520QuddNSRGgx5JEF+Jap2I5Acp0+UhXitzfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300311; c=relaxed/simple;
	bh=5rN1791otkXld9s0yk37EK1HmhIuksVPV/oWgb5wLiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/IV7jeej2eA+gdjK7HWDg2XBpvd6gTeGkwSHx4x+eCK+ndzBcUkJPqRLQsvMrhlufuj3SB6JkF30wsre5DRJAJ3ZeFePiJ1fcrSsYup+WBanIGBm7e+q8JLpnUaTPNc8QQmf8+ZrWyHCjPDvuIx/QHE4fBDwpDFhE9pTJWiY0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZEThMD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A70BC19425;
	Sat, 28 Feb 2026 17:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300310;
	bh=5rN1791otkXld9s0yk37EK1HmhIuksVPV/oWgb5wLiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZEThMD1UFSRyIxZNo4LOoeLgyRT5n7bbFDd8foRNs6j0sntx8xIk1q6XeiLN08nq
	 aXk/b5v+LPZbHY16bJjgEUVPuZm4NIaEp5eYUI7DAfzIxoQV/i+GlzRhql9YngShYP
	 54GhnS2A9m8oj2EgvA7dqLsatZ6Iohfiqcndst/MQGPZ0TV5m1nIv4yHBxjixZPaZg
	 y3sHg/2jeSW0KYr5vF55xYZ26YLEPzhaYPR45Cj/C1ZnStMWxPb/sKP0PYXwXVdp/x
	 mRo8NTpIs/2g4kf3VDdCzgwbm5+9iAt8sBtjnEYaWNysLtwQtMdVJnvCiHkQGSqX4u
	 iaI+v/BMUsXgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Md Haris Iqbal <haris.iqbal@ionos.com>,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 341/844] RDMA/rtrs-clt: For conn rejection use actual err number
Date: Sat, 28 Feb 2026 12:24:14 -0500
Message-ID: <20260228173244.1509663-342-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220420-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 83F441C65FA
X-Rspamd-Action: no action

From: Md Haris Iqbal <haris.iqbal@ionos.com>

[ Upstream commit fc290630702b530c2969061e7ef0d869a5b6dc4f ]

When the connection establishment request is rejected from the server
side, then the actual error number sent back should be used.

Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Link: https://patch.msgid.link/20260107161517.56357-10-haris.iqbal@ionos.com
Reviewed-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 2b397a544cb93..8fa1d72bd20a4 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -1923,7 +1923,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 	struct rtrs_path *s = con->c.path;
 	const struct rtrs_msg_conn_rsp *msg;
 	const char *rej_msg;
-	int status, errno;
+	int status, errno = -ECONNRESET;
 	u8 data_len;
 
 	status = ev->status;
@@ -1945,7 +1945,7 @@ static int rtrs_rdma_conn_rejected(struct rtrs_clt_con *con,
 			  status, rej_msg);
 	}
 
-	return -ECONNRESET;
+	return errno;
 }
 
 void rtrs_clt_close_conns(struct rtrs_clt_path *clt_path, bool wait)
-- 
2.51.0


