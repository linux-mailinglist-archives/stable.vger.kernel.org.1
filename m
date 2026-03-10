Return-Path: <stable+bounces-224316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPMgEHsBsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CB424AF6B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA20E3049328
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6523838A714;
	Tue, 10 Mar 2026 11:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OldCqp34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBD3876A1;
	Tue, 10 Mar 2026 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142011; cv=none; b=WVXI+KqLUGfqIRcu4ajnZo8A+aotSKrIcgnP9RmaypXOOQt1svO11vMFAzSkDAMPlnNbC4+zbK0zNqDqfoxpNIO5tG9sn30NPry9gvZ2iUgSn/BzPuS2SFxUvBAmpifpvo/btx/MmaO2YEzzh5MN1oG3f7ui7GxiKqaS0mNIpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142011; c=relaxed/simple;
	bh=m9qQSJnBS9HbeKpzrLF9MpZxwn/Dc0SqwJ2wbcRHEEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX3M+y8QzQtzTPi/h2j92OzNQINCS0zY1jQ7BTLwWbbPIWrIr5IFZVPGEIRhq6vm8QsnDIgWXf+AvkElk6/m0sEsbH7g79TfO93gBG3KCU+F0+a1znnvYfDpg11FTkSO0Nygpj/OYByAcDwTU+cytOt6ptgpOMcxuLoLruAwexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OldCqp34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 216CEC2BC86;
	Tue, 10 Mar 2026 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142010;
	bh=m9qQSJnBS9HbeKpzrLF9MpZxwn/Dc0SqwJ2wbcRHEEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OldCqp34HLx+l5uoqEjSe1g8Ue1fjpjO8q7qGUNHv7f879yh49UTEtKoFD456Z9Kh
	 KWYEsRq1B0qGsLjVZFBNEM964aDBt/ayr9+yIH9EIBXpTuj7E0oQckxnYHp979M+tK
	 d5eoj206vkbr6HEsyVgVdjGZGM0mg7JlDrZsv4jGiFviY9hbJQPVZUrzSZ4wTHyDDQ
	 3qiCHoLd0R3jvHur04ntQx+rH3t4j8wAdRLhrS+IAO/74pHvgl1j3Aqzl3DRhRVmYi
	 Y+BUYJx/gInCJ5sTtmYuRYJo/Os+kllwAR3X62obSxLLiid+GmWKCNRXvAkGBbBdOz
	 +etpSqhLybreQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable@kernel.org
Subject: [PATCH 6.18 137/314] can: ems_usb: ems_usb_read_bulk_callback(): check the proper length of a message
Date: Tue, 10 Mar 2026 07:16:36 -0400
Message-ID: <e9f48599f902ac0207bb68a73fcab0d379dd61cd.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6CB424AF6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224316-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 38a01c9700b0dcafe97dfa9dc7531bf4a245deff upstream.

When looking at the data in a USB urb, the actual_length is the size of
the buffer passed to the driver, not the transfer_buffer_length which is
set by the driver as the max size of the buffer.

When parsing the messages in ems_usb_read_bulk_callback() properly check
the size both at the beginning of parsing the message to make sure it is
big enough for the expected structure, and at the end of the message to
make sure we don't overflow past the end of the buffer for the next
message.

Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable@kernel.org
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026022316-answering-strainer-a5db@gregkh
Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/ems_usb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index fac8ac79df59f..d8c881130e900 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -445,6 +445,11 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 		start = CPC_HEADER_SIZE;
 
 		while (msg_count) {
+			if (start + CPC_MSG_HEADER_LEN > urb->actual_length) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+
 			msg = (struct ems_cpc_msg *)&ibuf[start];
 
 			switch (msg->type) {
@@ -474,7 +479,7 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			start += CPC_MSG_HEADER_LEN + msg->length;
 			msg_count--;
 
-			if (start > urb->transfer_buffer_length) {
+			if (start > urb->actual_length) {
 				netdev_err(netdev, "format error\n");
 				break;
 			}
-- 
2.51.0


