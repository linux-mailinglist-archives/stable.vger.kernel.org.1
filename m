Return-Path: <stable+bounces-256113-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JENNoypGGrclwgAu9opvQ
	(envelope-from <stable+bounces-256113-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE45F9805
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CCCEA30CBDF8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8974833439A;
	Thu, 28 May 2026 20:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TLhuTfqx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B13016E1;
	Thu, 28 May 2026 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000793; cv=none; b=mD+h6brmemjTpCf67MsjW/GWXSlTawTyW7n/+kgjQN5Y/zAF7X2Vt69+IFoyocpgr+MA1WR6OTtHtobz/Ppm9Q5epvciKDHvnLB6A0JrmY8Byr79ksCiJWg8/qbWRSUsQaJvPyyHJcX3OLpQTV1FTxye0WKmmWtZBVTxGSiFcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000793; c=relaxed/simple;
	bh=ZQGv5ncwIeRBW8fFb1acx57r7HM/1o1w2Zu+YQdEcM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7olXVmRZDF+lcH+tRhT4fQ3iDP31Lek5BoVSrR45z590gSlcl/lnuHuRmBUVg7WKB0Tm/IIzsbqC5tuFZs4DcUcrKeYxJq0IgDX1IQHTmvpYZm5f/vAn+sdS7vUje73zyKq3jwm00LWTZ5rr6e41AjKc8dQMytEit/KTF3TJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TLhuTfqx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD8D1F000E9;
	Thu, 28 May 2026 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000792;
	bh=MYNKj3UEDV+289DDNWt2KRNj7qh61NvPCC7SnB5Bqi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TLhuTfqxoktwi7DC4IIkqD7ryYuaPuWpNtcdy86N5xwUcg9Ra4r9r1WS09V8HrM9S
	 2JJx4zHV2LCIxxPTdjDlsuHz6BGaoGDLVQKnT+omcV+wOqqWqSrGaZoIOeP0EOvISI
	 TV2zpAcy58rOYqYCRVPEw+tbj6E+L9HBOUKgBEss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 133/272] hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
Date: Thu, 28 May 2026 21:48:27 +0200
Message-ID: <20260528194633.102598020@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256113-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nexthop.ai:email]
X-Rspamd-Queue-Id: 84AE45F9805
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

commit b86095e3d7dcf2bf80c747349a35912a87a85098 upstream.

adm1266_set_rtc() seeds the chip's SET_RTC register from
ktime_get_seconds(), which returns CLOCK_MONOTONIC -- i.e. seconds
since the host last booted, not seconds since the Unix epoch.

The chip stamps that value into every blackbox record it captures.
Userspace reading those timestamps back expects wall-clock seconds:
that's what the SET_RTC frame layout documents (datasheet Rev. D,
Table 84) and what every other consumer of "seconds since epoch"
assumes.  Seeding from CLOCK_MONOTONIC gives blackbox records a
timestamp that is only meaningful within a single boot of the host
and silently resets to small values on every reboot.

Switch to ktime_get_real_seconds() so the seed matches what the
register is documented to hold.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-1-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -432,7 +432,7 @@ static int adm1266_set_rtc(struct adm126
 	char write_buf[6];
 	int i;
 
-	kt = ktime_get_seconds();
+	kt = ktime_get_real_seconds();
 
 	memset(write_buf, 0, sizeof(write_buf));
 



