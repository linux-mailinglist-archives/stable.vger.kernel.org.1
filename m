Return-Path: <stable+bounces-214905-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHjjLP3aiWlFCgAAu9opvQ
	(envelope-from <stable+bounces-214905-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:02:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3673B10F5CD
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 14:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC7BF3015CAD
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 11:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2E371060;
	Mon,  9 Feb 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="C918fV3m";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="ZilOCOJ7"
X-Original-To: stable@vger.kernel.org
Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9EE363C7C
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637494; cv=none; b=iUvCHM/1yyy7L5CWjsoiaUqahSN2+2PZGI/FiCCVfXGz1XIXr/LUD3lmcHFcAGv6wl7uuehG1jjiLjqEYQgcdEDoEMk6ih7kw/LBEpQz8VugJ6timeUa2xtfB/5Jv7qAAKVDpto1F//uUyr0gx9OZ4VW1wOjVmcaWEhT8iAPaDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637494; c=relaxed/simple;
	bh=USVlo4ZTkC1zrrk0FDDYiH1nfkye/vNWCDtbTdrP4Yo=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=HMDye5xfJIsjl3DBH7mc4ioIpttHIu20ZxxOK9btAVKA4vUSSyFBNjJLv5INTL6HT7uueu2DShrJVyVTH6C0OayPYb0h71SVrzCQOKXqmcD/2jYGm0Q7jeUO29/2kv6Sz3Q9TYLeKJrIzUJz/SoqFC8SDBFMZ8n/X6cQqQ9rhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=fail smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=C918fV3m; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=ZilOCOJ7; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=computergamingpc.com
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.133] (unknown [10.138.12.16])
	by mtl-mta02-out1 (Halon) with ESMTP
	id 9b898bdb-3812-49ff-8358-0b751c9b4df4;
	Mon, 09 Feb 2026 11:24:47 +0000 (UTC)
Received: Received from 10.138.12.155 by Caffeine (s0-aws-app-swarm-manager-4)
 with SMTP id 882344e7-5973-403a-b66b-e59d18ab74df  for
 stable@vger.kernel.org;  Mon, 09 Feb 2026 11:24:34 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [179.190.201.90])
	by s0-aws-app2-mta-in-1 (Halon) with ESMTPSA
	id 882344e7-5973-403a-b66b-e59d18ab74df;
	Mon, 09 Feb 2026 11:24:34 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Current Inventory Update: GPUs & Enterprise SSDs Available
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Mon, 9 Feb 2026 11:24:35 +0000
Priority: urgent
X-Priority: 1
Importance: high
Message-Id: <093520260224114F7917DE2B-C732E0D219@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: 882344e7-5973-403a-b66b-e59d18ab74df
X-SMTPCOM-Message-ID: 320c9ee9-528c-42af-bfd5-803a2003937d
X-SMTPCOM-Payload: 
 _HPx-OqsedF1RbivG8MaLizGVSEpGBOH-alLD9oPoarOy4o7GyDulrtdlR6CRFAYaovlCcKr7liiWNiyDYICH_CyQfsw-6wLd7f_NnidxV1zXr_dTcMgTchAZxx7aaoTzogaBgynDqJqbaifC9QeohcmTW5FRMdURUkX6VGN7f0E-GjxL1ICINngL-hGgh9w
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1770636277; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=USVlo4ZTkC1zrrk0FDDYiH1nfkye/vNWCDtbTdrP4Yo=;
 b=C918fV3mIc7u17YDOWg9F2rpYkZRcwAkQwH7y9TSwqO76VXuWCWsD3wItz/LS4bwa5jOi
 xlXxoehxSGhTZuSdh5L4BMM+Qk58oSwMdE/iIaypnnoMcGNBywpUR7CxMvHl0orncnTQH1N
 TrUN7c+9oWdxyNWOOlDuiBUp1iJiA1aH82ee6a7+KfN3Udg3U0lspuhYT0xddfP1kCKAE6K
 La4uYv8r6a3wPn7DrKtUvRW8Pp8sQCpOE0Jm5GFOeZJyr4gbQd5l8VG79Q8K4wYzVkZENc6
 wZwp1xVAiw+eiecOp9ZJk5ecl20c0CnXNhUsSSxk8s/l4MduO8R+HNTRyklw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1770636277;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=USVlo4ZTkC1zrrk0FDDYiH1nfkye/vNWCDtbTdrP4Yo=;
 b=ZilOCOJ7yOuV89FKv6ttD2oerKgwSTuVbQPWPaARL0F8fjo6ZHdWvNnY6/9KhreyGPmNX
 bzm8Pq8950VUjUI0yTAA4gSQ++IkT1Ymq33pz/NpBQSwESvt06jK26BlnUxVkvewz6zp6T7
 od7uCRApXmVtQDH5g/5R6KgOPxHuDjZlAkgekfTe5VieTDnKG3K4T4AIuUglfmn7ACluBFj
 08g78Q3slu1vXqh17h2TfTJrKdoeeF+w7cEqtjbBTLYWRh/i0QwUxECZLChm7Stizv5lOgK
 78CRSrubybjeM+ZnNEKgvf/ubE/QwW8GcQlfZ844RmdO3d/ldy8Jdyl+szRw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.64 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[computergamingpc.com:s=smtpkey,smtpmessage.com:s=smtpcustomer];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[computergamingpc.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[computergamingpc.com:-,smtpmessage.com:-];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214905-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sales@computergamingpc.com];
	HAS_X_PRIO_ONE(0.00)[1];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sales@computergamingpc.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,computergamingpc.com:mid,computergamingpc.com:email,computergamingpc.com:replyto]
X-Rspamd-Queue-Id: 3673B10F5CD
X-Rspamd-Action: no action

Dear Partner,
We are pleased to share the latest overview of our current inventory:

Memory Modules
* 32GB 2Rx4 PC4-2400T (Qty: 1,500) – USD 14
* 32GB 2Rx4 PC4-3200AA (Qty: 1,500) – USD 15
* 16GB 2Rx8 PC4-3200AA (Qty: 1,500) – USD 10
* 128GB 4DRx4 DDR4 PC4-2933Y REG ECC LRDIMM (Qty: 980) – USD 70
* 32GB Dual Rank x4 DDR4-2933 CAS-21  (Qty: 1,500) – USD 14
* 64GB Dual Rank x4 DDR4-2933 CAS-21  (Qty: 1,200) – USD 30
* 32GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,500) – USD 15
* 64GB Dual Rank x4 DDR4-3200 CAS-22 (Qty: 1,100) – USD 35

Solid State Drives
- SSD SATA 6G 3.84TB SFF (Qty: 450) – USD 120
- SSD SAS 12G 960GB SFF (Qty: 470) – USD 300
- SSD SAS 12G 1.92TB SFF (Qty: 560) – USD 350
- SSD SAS 12G 3.84TB SFF (Qty: 560) – USD 150
- SSD SATA 6G 1.92TB SFF (Qty: 450) – USD 100
DDR Modules
- DDR4 32GB 3200Mhz ECC RDimm 2Rx4 P00924-B21 (Qty: 600) – USD 100
- DDR4 64GB 3200Mhz ECC RDimm 2Rx4 P00930-B21 (Qty: 500) – USD 35
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 P43331-B21 (Qty: 500) – USD 550
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 P64707-B21 (Qty: 500) – USD 550
- DDR4 32GB 3200Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – USD 35
- DDR4 64GB 3200Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – USD 450
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) – USD 450
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 Samsung (Qty: 500) – USD 550
______________________________________________________________________

For inquiries regarding availability or to arrange an inspection, please
contact us:
📧 sales@computergamingpc.com
📞 +1 (774) 559‑1248 | +1 (641) 232‑4364
Thank you for your continued collaboration.

