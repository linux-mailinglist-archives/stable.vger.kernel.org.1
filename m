Return-Path: <stable+bounces-261392-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EC7RHdxIJWpCGAIAu9opvQ
	(envelope-from <stable+bounces-261392-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:33:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7113B64FC47
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:32:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fiDW6rxD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261392-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-261392-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE8F23003715
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23A31FE47B;
	Sun,  7 Jun 2026 10:32:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E14E3112A5;
	Sun,  7 Jun 2026 10:32:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828373; cv=none; b=QSdv5oNbrMeHrFsBvuFoKk+neelQ9NdD26m94d2upZSm/CheLgJnId45XpB4IjCFimNCoLUveugRq5k7RnZC0KS3I6l00wcuAPjLyJnjybemIT5f2QPSjO8jSxS3qFoxtbgRBne3uWQ13wae8Vm/F2s1D0iLiBZQgvOzORwUI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828373; c=relaxed/simple;
	bh=bBggSPtYdOSJaAk5oUyVCTqHaMZW9coYkr2beBmm6ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRdLdbllspCkL4e2FbLoefI+N5A07WFxncNWa3aukdVTmscgveeHHChlCfJENhgfTVjQDsxaQrG2lslkSmnt0/z5jy89cXdpzVfy7lJV4/YJ7NrDYmQl5vpBHm+/PNRcuXuvK4cMwnJcNsaXaW+NtYqqxdmRqZBDFrLKu3mA90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fiDW6rxD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C516C1F00893;
	Sun,  7 Jun 2026 10:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828372;
	bh=qwXd5RSeQoj1SCPm7BZ+Ovwynp4kQDhj9tohEAW0ers=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fiDW6rxDJSxiHPXcPEhyjhiwEGjHwVbN5nsiGrSdEzQ+7RsdAMwj47ch272b0Rxbl
	 TuwLtP8wI3e4RIIi64EcN699dM2/hI8y1ktjHEa1MRM2Og1pXTyy9D6RxBgDZfyPmd
	 QmQa6h4+LTUTm/k1z7UhCisneJ9EtOfqntpRKGVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Amit Sunil Dhamne <amitsd@google.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.12 133/307] usb: typec: tcpm/tcpci_maxim: validate header NDO against RX_BYTE_CNT
Date: Sun,  7 Jun 2026 11:58:50 +0200
Message-ID: <20260607095732.633573370@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261392-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:heikki.krogerus@linux.intel.com,m:andre.draszik@linaro.org,m:badhri@google.com,m:amitsd@google.com,m:stable@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,linaro.org:email,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7113B64FC47

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit aa2f716327be1818e1cb156da8a2844804aaec2f upstream.

A broken/malicious port can transmit a CRC-valid frame whose header
advertises up to seven data objects but whose body carries fewer than
that.  Check for this, and rightfully reject the message, instead of
reading from uninitialized stack memory.

Assisted-by: gkh_clanker_t1000
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "André Draszik" <andre.draszik@linaro.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/2026051350-sitter-canopener-9045@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -186,6 +186,15 @@ static void process_rx(struct max_tcpci_
 	rx_buf_ptr = rx_buf + TCPC_RECEIVE_BUFFER_RX_BYTE_BUF_OFFSET;
 	msg.header = cpu_to_le16(*(u16 *)rx_buf_ptr);
 	rx_buf_ptr = rx_buf_ptr + sizeof(msg.header);
+
+	if (count < TCPC_RECEIVE_BUFFER_RX_BYTE_BUF_OFFSET + sizeof(msg.header) +
+		    pd_header_cnt_le(msg.header) * sizeof(msg.payload[0])) {
+		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
+		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d for header cnt %d\n",
+			count, pd_header_cnt_le(msg.header));
+		return;
+	}
+
 	for (payload_index = 0; payload_index < pd_header_cnt_le(msg.header); payload_index++,
 	     rx_buf_ptr += sizeof(msg.payload[0]))
 		msg.payload[payload_index] = cpu_to_le32(*(u32 *)rx_buf_ptr);



