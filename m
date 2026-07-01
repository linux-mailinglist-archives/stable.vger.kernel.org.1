Return-Path: <stable+bounces-270226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JHvgGeFURWp5+goAu9opvQ
	(envelope-from <stable+bounces-270226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 19:56:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F2D6F0762
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 19:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=catnip.supply header.s=sig1 header.b=mAECChIo;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270226-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270226-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=catnip.supply;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F10F3012D2F
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 17:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE74C0423;
	Wed,  1 Jul 2026 17:56:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host5-snip4-10.eps.apple.com [57.103.76.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB884C040A
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 17:56:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928580; cv=none; b=bKvHoDXA1JRP6pu1qgkrqaJMRXbR2Mk8A7S8+jrDTg503ySIwXMDivwvRsw0hCfL0C/L26+OFI0ir8Z+ZvxqEhFOMbf3gcA3O8We7rFbMxGCBobAzpVyjyEnXtWQsTj0ZlctWLu8lOcvm465gExacAqKh+Smn7JzD4pU4c2toXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928580; c=relaxed/simple;
	bh=oBluO8Go7Ada5MaFGlyMK2kizMewkK5Ba1uEF5uWyBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APepN46ixaN6nXCn9e20w+5SNZzDm48jHSh8BmFNethB8T773hU7+2fVtxS3iSrw/se/3xqrjkT5B2ER0ER9QlifJ8Erp48Ts/KoHZP0QF4RxKDp2yMEsIwpxzVMblUyQVyUMIgEPzQ5ecWic6hivhBwzgRbnC13GWG1TTkYinQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catnip.supply; spf=pass smtp.mailfrom=catnip.supply; dkim=pass (2048-bit key) header.d=catnip.supply header.i=@catnip.supply header.b=mAECChIo; arc=none smtp.client-ip=57.103.76.221
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPS id A62011800228;
	Wed, 01 Jul 2026 17:56:14 +0000 (UTC)
X-ICL-RepId: 019f1ed3-085d-7f8e-acf0-fba0e7747b5c
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMFWwVeCEgHQwVaAFBcHA4HVgVyE1gMXQRHRUEFSQhfFBcNVk1aGUcDXhscA0wIQwFOS0ATBEkHTV8OXh8EF0YZVQRHHl1WQBkZAlEcVg1XQ1QEX1BJDEFQbFoARxdIHV0ZWW9QXRwODlYfXBlJVkAYRxteCRkVWgkKVwBAC04DWgdaA0cMTQZaGV0KQApVAkBdClwwWhlHA14bHANMCEMBTlUSBEAIVlBUHkEEVhVsCVgGUxlX
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catnip.supply; s=sig1; t=1782928577; x=1785520577; bh=oBluO8Go7Ada5MaFGlyMK2kizMewkK5Ba1uEF5uWyBk=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=mAECChIo4zyIE0v0DnJ7q6dawJowZ6VKp3cX9mZ5up6esnUtQ11tgmX/tOl35GY30R/M65UWxxA5MQNi3cjOs41Xm1ljndMum5md7JOVvPEt3yLA/bMzDijh1ivLXQI8cdJhqq6wnQSp4zDKk57pohnQy8Im0z8QvAtZdIaZS9+vIFvPWyL8apJtchfdUtTG8UTF8C0TYfVbv0nHJTvnD8qkWDbBE6Fk4LL5QsDK68VWk+JM8ZcGNQbarsjZoKEgSG9DNPkx7mSmLOXUGX/T8uBUth71s7W9dQvLvVeKbNT7cNWcR6vLIbecoaD3bz9l3VfwSNu8EJL8IKgCALD/cQ==
mail-alias-created-date: 1779453914251
Received: from jan-pc (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-5 (Postfix) with ESMTPSA id E0D4D180158B;
	Wed, 01 Jul 2026 17:56:07 +0000 (UTC)
From: Jan Kot <jan@catnip.supply>
To: sashal@kernel.org
Cc: alex@exolabs.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver@neukum.org,
	pabeni@redhat.com,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-6.12] net: usb: cdc_ncm: add Apple Mac USB-C direct networking quirk
Date: Wed,  1 Jul 2026 19:55:57 +0200
Message-ID: <20260701175557.6803-1-jan@catnip.supply>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520111944.3424570-19-sashal@kernel.org>
References: <20260520111944.3424570-19-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _g_xjTsoEF11gaND9dDj2vQmtmwVDbbu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE5MSBTYWx0ZWRfX5w5hSfh3QXnj
 woZ2A7uWowp8a9yDJ7KPZLilXu8bMQi6hv/x9jXSE6vfzLEmv32FZzJanreP4HdByjNA8kuu6jT
 tLMQM/ocQuIsSsATUFt1B97Bge3mfKbWAwIz0UVRWCYLpYjUU5k2tAvaWY7Zt6O9fQvK8GpzM3R
 Y/aACP3Soy3LycOfmGIeDwycbom0+GVVZHHd3eEsZU0WyPuluacvDYoDEaN5AJM60khfgPgxob7
 oDp9kK08yhkt3ZQzFxV8C+8DJD1KcXUpj/5XG1TwnojCe53e+rIrUn/VL4DPNKpvzf8qC/tAt8E
 CgR3jNmNJQ0/T5jJZ2QIVthgYbd9+QF4zq/s85LvA==
X-Proofpoint-GUID: _g_xjTsoEF11gaND9dDj2vQmtmwVDbbu
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[catnip.supply,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[catnip.supply:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jan@catnip.supply,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270226-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:alex@exolabs.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:horms@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:oliver@neukum.org,m:pabeni@redhat.com,m:patches@lists.linux.dev,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[catnip.supply:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan@catnip.supply,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9F2D6F0762

Hi,
I noticed that there may be more PIDs for Apple Silicon Macs.
My M1 MacBook Air uses PID 0x1903, not 0x1905.
Looking at libimobiledevice/usbmuxd for reference, they actually define
a range of PIDs from 0x1901 to 0x1905 for these devices:
https://github.com/libimobiledevice/usbmuxd/blob/master/src/usb.h
I guess the whole range should be added to the id_table as well.

Best regards,
Jan Kot

