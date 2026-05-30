Return-Path: <stable+bounces-257838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIKbLIUgG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:38:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC2661011B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD1E63050222
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EB43403F9;
	Sat, 30 May 2026 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LrHxxDWl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEC2E7379;
	Sat, 30 May 2026 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162339; cv=none; b=CljD1PMXWnDPpLN3x4/hTdc8NU2OV1NXLFRRMUj3W1IuvGsOtGs6csOU97R1C6kcSt1qc6P6k/EnZoXmba0srx9oTh+T94TST/6StjQTxbJBsaBlKNd5CjxuWL1vctogg0oyv21we168re5JmcBE0nll2hqlNXgPdJN2QYZzHvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162339; c=relaxed/simple;
	bh=RoptnGs2RpJaJ+YDXPdFusHsg5W14nl0iHPHC7Z3cig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duXWHH04LNClSc5p1t06OTsEM5N47SFQiOychhgYFoj7l0sIjp21ZyuubBSiUq3NG7yfW2DCNWIXgPdpyGCfrSptcCQZCk8fv4m4uCvD5gbM91QywP6oi+Op0PXKCU6+HeW0Lo9pbcbQDDfKTIeYzSQtgPNwoRZNe/flYyRccMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LrHxxDWl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67B81F00893;
	Sat, 30 May 2026 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162338;
	bh=pbUiKbDE+dvqxK81sDuJn3YktqpC5HU6FExS6ee6GqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LrHxxDWlgB9aiVsAAv1sHc2JYDZnFdKFn+Dnm6W0YVXaHXZG/6EgMAmLY8/7voYov
	 ceBUxlJAWtttQtznBqCMRaHf/TYAPz5YU5eAPSjTGRn+pB/OvMpIN8y2494U0YVZ2h
	 7S1qRWGWHO+was3jWEhZhwpnSRhT2DZ2MMirZ42c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.1 891/969] hwmon: (pmbus/adm1266) reject implausible blackbox record_count
Date: Sat, 30 May 2026 18:06:55 +0200
Message-ID: <20260530160325.308597467@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257838-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nexthop.ai:email]
X-Rspamd-Queue-Id: 1BC2661011B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdurrahman Hussain <abdurrahman@nexthop.ai>

commit 4afca954622d672ea65ed961bed01cf91caa034e upstream.

adm1266_nvmem_read_blackbox() loops over a record_count that comes
straight from byte 3 of the BLACKBOX_INFO response.  The destination
buffer is data->dev_mem, sized for the nvmem cell's declared 2048
bytes (ADM1266_BLACKBOX_MAX_RECORDS * ADM1266_BLACKBOX_SIZE = 32 * 64).
A device that reports a record_count greater than 32 -- whether due
to firmware bugs, bus corruption, or a non-responsive slave returning
0xff -- would walk read_buff past the end of the dev_mem allocation
on the trailing iterations.

Cap record_count at ADM1266_BLACKBOX_MAX_RECORDS (introduced here)
before entering the loop and return -EIO on any larger value, so a
malformed BLACKBOX_INFO response cannot drive the loop out of bounds.

Fixes: 15609d189302 ("hwmon: (pmbus/adm1266) read blackbox")
Cc: stable@vger.kernel.org
Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Link: https://lore.kernel.org/r/20260515-adm1266-fixes-v1-3-1c1ea1349cfe@nexthop.ai
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/pmbus/adm1266.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -46,6 +46,7 @@
 
 #define ADM1266_BLACKBOX_OFFSET		0
 #define ADM1266_BLACKBOX_SIZE		64
+#define ADM1266_BLACKBOX_MAX_RECORDS	32
 
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
@@ -362,6 +363,8 @@ static int adm1266_nvmem_read_blackbox(s
 		return -EIO;
 
 	record_count = buf[3];
+	if (record_count > ADM1266_BLACKBOX_MAX_RECORDS)
+		return -EIO;
 
 	for (index = 0; index < record_count; index++) {
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);



