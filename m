Return-Path: <stable+bounces-215795-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKhwJE1xjGn6oAAAu9opvQ
	(envelope-from <stable+bounces-215795-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:08:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E47124165
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4A9302F70B
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 12:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7973168FB;
	Wed, 11 Feb 2026 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="sTO/PP+W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="fl1z4zBE"
X-Original-To: stable@vger.kernel.org
Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309AA3161A5
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811688; cv=none; b=ZgvVzEg0PnHGyQWBXJQP0ECl1KtnYpxzUzQz2U49Vby/aUyEgHrTh0WuwOR9ayyPYvcDplQ4whSeQTf3y5rDF224thwrX66mhtGBI4E45Lp4cFM0NLbN+leKJmcVmbWsICac/P8O7wHx4VYIyA7sg4lxFzQYCbhX/kkOiqe09Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811688; c=relaxed/simple;
	bh=t2cBevOyd9JIK916n953nVYCkRCH2RBmBxccrtCoEfY=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=FEVqfEF4X8JXNcDORUR/muxk8/gQn63SPYTNKxyYOL1KIqB1QHbYHLycazO62ESh3G78pAkU1G0RL8owGfvTVTT6TVOf6HmvmGWVFsKwNxPf6JXbPeHraWsdUYc9vB7Bz9rX/eDsVLDx+DRBQZ0ixMZkt5LHrlwe7Djkl+SevBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=fail smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=sTO/PP+W; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=fl1z4zBE; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=computergamingpc.com
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.109] (unknown [10.138.12.33])
	by mtl-mta02-out1 (Halon) with ESMTP
	id 685e3620-5939-4205-90f2-830b70e21fd2;
	Wed, 11 Feb 2026 12:08:06 +0000 (UTC)
Received: Received from 10.138.12.155 by Caffeine (s0-aws-app-swarm-manager-5)
 with SMTP id 2c9ad2f4-9d90-4b1d-944a-7e9e0a745fe0  for
 stable@vger.kernel.org;  Wed, 11 Feb 2026 12:07:22 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [170.75.255.147])
	by s0-aws-app2-mta-in-1 (Halon) with ESMTPSA
	id 2c9ad2f4-9d90-4b1d-944a-7e9e0a745fe0;
	Wed, 11 Feb 2026 12:07:21 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Current Inventory Update: GPUs & Enterprise SSDs Available
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Wed, 11 Feb 2026 12:07:22 +0000
Priority: urgent
X-Priority: 1
Importance: high
Message-Id: <11222026020712DFDF0D17D8$F4C69AA868@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: 2c9ad2f4-9d90-4b1d-944a-7e9e0a745fe0
X-SMTPCOM-Message-ID: 1f6ecb8b-f09b-4ade-afb9-6b0818cc75a9
X-SMTPCOM-Payload: 
 HpGyLXcBPoQjhGTRxGPtqeAE_lv_sNpY_MuzzxFmMOP5u0UgTUcjWvbmAQBYnGrGNV1RDuEKXuzrMqh58DiAWqinnMn6V-zHpg6USerHEJcsh_RRAmhLBm5kD4jtVB-5M0-Ay68e9fz3Mxqd-2CwSLfDeLIMGNKS1QZghuf1fNMtiqvsj9SXVRdgjOQu32YG
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1770811665; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=t2cBevOyd9JIK916n953nVYCkRCH2RBmBxccrtCoEfY=;
 b=sTO/PP+WjZqIkG/0Rs6nRmguYoz0h2PIx965QnUMhj9MT9+yyesJGCwDtYA/efZPbgFhr
 /GoeBzQRRXyXyOuB/EEoPNlRBx5NxSOVqHtsFXNJiRpFM1tGPaTIaPFi1Yxp/9OfavPJ4fl
 z+0DDhCUxMXvafPNDCSkb6d4g/dIsyBl+/Hz8kdsgLZht7nwdHVzj4GXN1FOBHak39zhex0
 Ji0CFKHR99YqItjiXi1xe6RxZFCXA7ThKHaFU5+NIKS+E0U4xKVKF2tfPDVbzyDYJt8Mrg8
 VkUaHzSQTi799IGHWd3lY94BWIs+npoFjSD3LZIjHzRYUqfzeJIqZfOh839A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1770811665;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=t2cBevOyd9JIK916n953nVYCkRCH2RBmBxccrtCoEfY=;
 b=fl1z4zBEr0vusrCOdksdjsjOihRqfw7W02xx1Kgp47Nhv51j3ZamP3ZySqS40cLJzxD4W
 KGQo14cpdA9Ci76hr/fkUP+pGTLwMUzcgbpdqFt+eNGccIMO3Utum6FtyyJJfLv1qdMGuPD
 PvBMv5zdKZdyJM7vVT0Qg+0J80WidLOgMDJElZbTqtkL8YNoQ1SDsynsxBf6/UOhmMzHiXU
 kTVQkR514cLsUha/7h9mcahxyPoy1AD1Rifvv4OZEH17wfZ8pfxYAPw7DEydBE62NpH9ZpC
 35IPKYhkV35w6hKXoMA/nwUPl+SqsO4bRsbKXiwICOoaLfdIlJWnJX7WNL3Q==
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
	TAGGED_FROM(0.00)[bounces-215795-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5E47124165
X-Rspamd-Action: no action

Dear Partner,
We’re pleased to share a current snapshot of our available inventory for
immediate dispatch.

GPUs & Accelerators
RTX 5090 Founders Edition 24GB (90 units) – $1,700
RTX 4090 24GB (45 units) – $1,550
RTX 4090 Founders Edition 24GB (90 units) – $1,700
RTX A6000 48GB Ada (54 units) – $1,100
RTX 6000 48GB Ada (51 units) – $1,200
Nvidia L40s GPU (12 units) – $3,000
Nvidia H100 80GB PCIe (9 units) – $16,000
Storage & CPUs
Samsung PM9A3 2.5" SSD PCIe 4.0 7.68TB (115 units) – $250
7.68TB SAS SSD 2.5" 12G Server Drive (140 units) – $250

For quotes, availability, or inspection scheduling, please reach out
directly:
sales@computergamingpc.com
Call or WhatsApp: +1(774) 559-1248 | +1 (641)232-4364
Thank you for your continued partnership.
Walker Brown
Computer Gaming PC Trading
2500 US-6, Iowa City, IA 52240, USA
To unsubscribe from future updates, reply with “REMOVE” in the subject line.

