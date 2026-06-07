Return-Path: <stable+bounces-261259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qamnJQNHJWo/FwIAu9opvQ
	(envelope-from <stable+bounces-261259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:25:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD964FA2D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=FdvLbKDQ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261259-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261259-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 748283021673
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6D3242A4;
	Sun,  7 Jun 2026 10:24:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0E8202C46;
	Sun,  7 Jun 2026 10:24:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780827867; cv=none; b=FDnVOH8bh830zUJAUn06c9AIFkNZ+K+Urg27tz3J5QlgLsMS78Hi8MRwdcBqyjjqCQNEqj/5PqS1VgF9cFOMWPAmGso1awun7ZiB/Bqu9jIsLKVecPx2CGahZLH2lGPN5/uGMIApMgSlA80Lptzw4AQevFl96hDLgLSWok1wv54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780827867; c=relaxed/simple;
	bh=ZE7gFe8+ScEdExJCmjtYl9NNgq/aW/xnV3I/u9Fzxac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeqO8LXrm9ypPa72zHUBwKHUok/ftTxZkVsnV5baZThXoKkttADH7JXez+cooFrUTNA9S+iIB23koTZ1tzfnm/tGd5u7IVT9w1VL+2oJcxgPgpdcAjwzU5tK8NGVyoizscIijJyd6FXc26rGm2ScaIhHG9F9kc4dU7lMFvTsH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FdvLbKDQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD801F00893;
	Sun,  7 Jun 2026 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780827866;
	bh=gG44QvGdWak8cX85xw7b2ZoWJbFyQ5eXm2bZSFc5rIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FdvLbKDQbUvcAVcYkrhVDQAk1FN5TSfdNfJryY6Hl1d/UsB7b9XXxB+TJqNx0skju
	 9/1/mG80NE5Awe1vGkm0nTpO1hM/N0pvuXQJ2864ZwOVBvPCmK+TxHZ0SW9kosoxh7
	 hqVpfpFaKuB6MSIAUqs/ArygGn8J5HBR2EPQksSw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Nathan Rebello <nathan.c.rebello@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Abel Vesa <abelvesa@kernel.org>,
	stable <stable@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH 7.0 128/332] usb: typec: ucsi: validate connector number in ucsi_connector_change()
Date: Sun,  7 Jun 2026 11:58:17 +0200
Message-ID: <20260607095732.807985620@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261259-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:heikki.krogerus@linux.intel.com,m:bleung@chromium.org,m:jthies@google.com,m:nathan.c.rebello@gmail.com,m:johan@kernel.org,m:pooja.katiyar@intel.com,m:yuanhsinte@chromium.org,m:abelvesa@kernel.org,m:stable@kernel.org,m:abel.vesa@oss.qualcomm.com,m:nathancrebello@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux.intel.com,chromium.org,google.com,gmail.com,kernel.org,intel.com,oss.qualcomm.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,msgid.link:url,vger.kernel.org:from_smtp,chromium.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43AD964FA2D

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 288a81a8507052bcfbf884d39a463c44c42c5fd9 upstream.

The connector number in a UCSI CCI notification is a 7-bit field
supplied by the PPM.  ucsi_connector_change() uses it to index the
ucsi->connector[] array without checking it against the number of
connectors the PPM reported at init time, so a buggy or malicious PPM
(EC firmware, or an I2C-attached UCSI controller on the ccg / stm32g0 /
glink transports) can drive schedule_work() on memory past the end of
the array.

Reject connector numbers that are zero or exceed cap.num_connectors
before dereferencing the array.

Assisted-by: gkh_clanker_t1000
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Benson Leung <bleung@chromium.org>
Cc: Jameson Thies <jthies@google.com>
Cc: Nathan Rebello <nathan.c.rebello@gmail.com>
Cc: Johan Hovold <johan@kernel.org>
Cc: Pooja Katiyar <pooja.katiyar@intel.com>
Cc: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Abel Vesa <abelvesa@kernel.org>
Cc: stable <stable@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://patch.msgid.link/2026051351-truck-steadfast-df48@gregkh
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1370,13 +1370,22 @@ out_unlock:
  */
 void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 {
-	struct ucsi_connector *con = &ucsi->connector[num - 1];
+	struct ucsi_connector *con;
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
 		dev_dbg(ucsi->dev, "Early connector change event\n");
 		return;
 	}
 
+	if (!num || num > ucsi->cap.num_connectors) {
+		dev_warn_ratelimited(ucsi->dev,
+				     "Bogus connector change on %u (max %u)\n",
+				     num, ucsi->cap.num_connectors);
+		return;
+	}
+
+	con = &ucsi->connector[num - 1];
+
 	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
 		schedule_work(&con->work);
 }



