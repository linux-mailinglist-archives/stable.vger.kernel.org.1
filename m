Return-Path: <stable+bounces-260874-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rd5UGpMTJGrb2gEAu9opvQ
	(envelope-from <stable+bounces-260874-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 14:33:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07D64D6C6
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 14:33:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cUO8jNXO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260874-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260874-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 928693019053
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 12:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6863C38E8BB;
	Sat,  6 Jun 2026 12:32:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B81B4F09
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:32:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749126; cv=none; b=UDpmHybxlnjxMcPXM7pq/9hzvVavdfUwgnde/vuRK6EyhHvZEZNLO653dM7m8qcBL/oJH0vZeeGPJFoXYMhk1Fw014jDeF8BP5ATZ/iBylzFK5hGWURDRsuJZP8YGhDt6sA3vDNd3mSs2oP9aDO8oL7mtJ6uWM6SLoZ51RbfRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749126; c=relaxed/simple;
	bh=qR6fMcrHkJBRToUbrXzIyn9u26iwhJq8WGTAaFGzfb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxWCZTHsvf8Dhen6aahzE8P2KhNAQ7p2a0eNPs5uieTniSVN9p72gbWR4cVBBqyMUjFSSID5/+ogSc9pjx+xP6uI6pTvP4EBvqzxnIMFLx1xVrAUJQA3eHYOGXhbfbGekFjRTrgqbks0QXWvOvBGuq2zm2E77/YM/+upGRKe/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUO8jNXO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE4A1F00893;
	Sat,  6 Jun 2026 12:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749125;
	bh=DzJVjJYl1rkzFO14LSU3qT3sLCpLtf6oVvxBnN30dGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUO8jNXOKXvbsdvw/gMRDfKdJtT9vayMqW//hyFkcCjSlTOyERR+z/P0Xyb9zQK97
	 G2uMoOANLKeIOcsxGSp5e7C1bR+FgKirBVIno/nrFbKOCNPPYde6NXFSLQMJ/lLmws
	 hFzDgSc1GT6rCXB/H0PoobfmbHGR9OfrsNnlssqMeZiR46ND6JF+pMJBXupbodPuMQ
	 UZO+4O0bOkQwkF/HqrGHFUPlgOK4cwcbYsSSqBHK1vgZ5gW1pM/XncM/CUK9HxGNAo
	 kQkk7qcXAKOlSJQqq/ImZVX2V+svPSQX/zk6HFnNzyEv0Dq3JeEkd/HQolCJHq/aUP
	 22Z6kWaQQuzDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prasanna S <prasanna.s@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] serial: qcom-geni: fix UART_RX_PAR_EN bit position
Date: Sat,  6 Jun 2026 08:32:00 -0400
Message-ID: <20260606123200.2861082-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606123200.2861082-1-sashal@kernel.org>
References: <2026060451-jubilance-margarine-a3fc@gregkh>
 <20260606123200.2861082-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260874-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:prasanna.s@oss.qualcomm.com,m:stable@kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,vger.kernel.org:from_smtp,qualcomm.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC07D64D6C6

From: Prasanna S <prasanna.s@oss.qualcomm.com>

[ Upstream commit ca2584d841b69391ffc4144840563d2e1a0018df ]

UART_RX_PAR_EN is incorrectly defined as bit 3, which triggers false
framing errors (S_GP_IRQ_1_EN) and causes received data to be dropped
when parity is enabled and the parity bit is 0.

Define UART_RX_PAR_EN as bit 4 of the SE_UART_RX_TRANS_CFG register, as
specified in the reference manual.

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Cc: stable <stable@kernel.org>
Signed-off-by: Prasanna S <prasanna.s@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260428-serial-bit-correct-v1-1-9131ad5b97d8@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7074fbddd51b1f..77fbac55aea740 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -43,7 +43,7 @@
 #define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_PAR_EN			BIT(3)
+#define UART_RX_PAR_EN			BIT(4)
 
 /* SE_UART_RX_WORD_LEN */
 #define RX_WORD_LEN_MASK		GENMASK(9, 0)
-- 
2.53.0


