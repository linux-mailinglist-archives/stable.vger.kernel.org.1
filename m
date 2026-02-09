Return-Path: <stable+bounces-215150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ+0EVfxiWnyEgAAu9opvQ
	(envelope-from <stable+bounces-215150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:38:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7477511096A
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30F7730074F5
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512563783A1;
	Mon,  9 Feb 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AQ9FCaFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15733125B2;
	Mon,  9 Feb 2026 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647843; cv=none; b=QLCBxqLF7M7p4j4E3U/cDofxt0Vl78pH8S76yGak63iaDaY9kD7SalgaBrqn7GfzrEGDH2GEPWzyt9HXH0J+jxfbqDUZotVTbW2zp2Kj7n1+IL3Y7K3HyJawcBY+A2t56VbE88ue9aPykqcNaHwV4wa+5K+tbeOvW0f2irr7CY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647843; c=relaxed/simple;
	bh=AqMttXY68TOA53ZZV5mckEBwjkf7iK7EIrs4qX2aXnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZSp7vltMfSx52wdlpOgecJGzH4mtWneocYADilyT0fyan/DQUTgr3o4dml4zXzSTL13PaYmchKIHV6I9e09FUmiJDyCOpXxeqz/Cx0/e7nL2wQJ7+GkK1Or8DtwXJ+28YH73RcRKc4xVQ9iF2U9Wnj4FzZ8djq9mBa8Uiy3/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AQ9FCaFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81239C116C6;
	Mon,  9 Feb 2026 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647843;
	bh=AqMttXY68TOA53ZZV5mckEBwjkf7iK7EIrs4qX2aXnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQ9FCaFzbvc0jlJVjPreyq45XOY7vV/da4MoTQa0WVVj7dm+PZXbG7HDxxWFM9bPS
	 WunJTEXEcuJzMuHrvm+YUibvLO5s5Sw8xJnN8OfbNM5TZwby98hWLybjmoY2nguaCJ
	 EaMpIgm8CYDuvrLheNu7aeQulbKwMEoJPW1Fsnwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/113] HID: intel-ish-hid: Reset enum_devices_done before enumeration
Date: Mon,  9 Feb 2026 15:23:13 +0100
Message-ID: <20260209142311.788980896@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215150-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 7477511096A
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 56e230723e3a818373bd62331bccb1c6d2b3881b ]

Some systems have enabled ISH without any sensors. In this case sending
HOSTIF_DM_ENUM_DEVICES results in 0 sensors. This triggers ISH hardware
reset on subsequent enumeration after S3/S4 resume.

The enum_devices_done flag was not reset before sending the
HOSTIF_DM_ENUM_DEVICES command. On subsequent enumeration calls (such as
after S3/S4 resume), this flag retains its previous true value, causing the
wait loop to be skipped and returning prematurely to hid_ishtp_cl_init().
If 0 HID devices are found, hid_ishtp_cl_init() skips getting HID device
descriptors and sets init_done to true. When the delayed enumeration
response arrives with init_done already true, the driver treats it as a bad
packet and triggers an ISH hardware reset.

Set enum_devices_done to false before sending the enumeration command,
consistent with similar functions like ishtp_get_hid_descriptor() and
ishtp_get_report_descriptor() which reset their respective flags.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid-client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid-client.c b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
index 89b954a195343..afc8d9bbd8866 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid-client.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid-client.c
@@ -496,6 +496,7 @@ static int ishtp_enum_enum_devices(struct ishtp_cl *hid_ishtp_cl)
 	int rv;
 
 	/* Send HOSTIF_DM_ENUM_DEVICES */
+	client_data->enum_devices_done = false;
 	memset(&msg, 0, sizeof(struct hostif_msg));
 	msg.hdr.command = HOSTIF_DM_ENUM_DEVICES;
 	rv = ishtp_cl_send(hid_ishtp_cl, (unsigned char *)&msg,
-- 
2.51.0




