Return-Path: <stable+bounces-228927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOxQGqlqwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-228927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D50142F832F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6300530E7671
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B54395DB5;
	Mon, 23 Mar 2026 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n4L/8QGF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C687126D4F9;
	Mon, 23 Mar 2026 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277509; cv=none; b=H/PCmpo72oLh+PKOI0ap5t213C7PK5Xij4nq0Kd1OOGU5HTrUTBJ+7Ak4YvPhL7/S4jhDIWT7l8bzmF3wg5FVdVRUf8K672ari61dHLdy0HF7pSRUQQ4ksuIt2uVKIc3FbskLgzCw7Z8YFlYMEqkVrpAf40QyXNDQn/QEtzyg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277509; c=relaxed/simple;
	bh=VlabTOk98ggNaKlEq6t37thx/Sbj5g018pyZKYF4jD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh0Na0M64wPv04+GA1sBEtIPvEVnxjRImN7Tt1zbJEE2WQ6AoNRPXqELIhb1PWq/hIstuzE36MsjW9SJXjvbuHBJjCfbMLCq5yFD9y/aXcUTeH87ubyv5K3lav8zoKbb32URla0+o93rTjmAw9EPN8heZwc74oZl9I3oBdEJTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n4L/8QGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33804C4CEF7;
	Mon, 23 Mar 2026 14:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277509;
	bh=VlabTOk98ggNaKlEq6t37thx/Sbj5g018pyZKYF4jD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n4L/8QGF4XiBJ8PXNIp+nT4j5S8gTTSF+Aefbkw4XgTIZKHzMHWOo7gGDFkCbzc+u
	 oI64IppXSU5kB7QL1FiPCgelSriBaEGLC+bOxAHoCARonVmO/Hp3aLTOms4++J2a0P
	 6eC+FTW1nVc51SR/gUeeu+8T3R5L4RFmt9VhuekU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 434/460] hwmon: (pmbus/mp2975) Add error check for pmbus_read_word_data() return value
Date: Mon, 23 Mar 2026 14:47:10 +0100
Message-ID: <20260323134537.222862863@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228927-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: D50142F832F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit 19d4b9c8a136704d5f2544e7ac550f27918a5004 upstream.

mp2973_read_word_data() XORs the return value of pmbus_read_word_data()
with PB_STATUS_POWER_GOOD_N without first checking for errors. If the I2C
transaction fails, a negative error code is XORed with the constant,
producing a corrupted value that is returned as valid status data instead
of propagating the error.

Add the missing error check before modifying the return value.

Fixes: acda945afb465 ("hwmon: (pmbus/mp2975) Fix PGOOD in READ_STATUS_WORD")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260317173308.382545-3-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/mp2975.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -313,6 +313,8 @@ static int mp2973_read_word_data(struct
 	case PMBUS_STATUS_WORD:
 		/* MP2973 & MP2971 return PGOOD instead of PB_STATUS_POWER_GOOD_N. */
 		ret = pmbus_read_word_data(client, page, phase, reg);
+		if (ret < 0)
+			return ret;
 		ret ^= PB_STATUS_POWER_GOOD_N;
 		break;
 	case PMBUS_OT_FAULT_LIMIT:



