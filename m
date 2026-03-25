Return-Path: <stable+bounces-230323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJB9KmPWw2lwuQQAu9opvQ
	(envelope-from <stable+bounces-230323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:34:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAFF324F20
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B02232F2E9E
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B22D3CF68E;
	Wed, 25 Mar 2026 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b="hJzD8rxE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b="Cs0qrCC1"
X-Original-To: stable@vger.kernel.org
Received: from mailer241.gate86.rs.smtp.com (mailer241.gate86.rs.smtp.com [74.91.86.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8583285041
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.91.86.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439570; cv=none; b=iclbAkygmsZNFN2S1hTH2YZGPi5ljZKc6zXUWACHiCvz3fQlL/cN5VwbitbYs7T/04o+eFWRgPloKuLgIJADGrzEBpR0SBlkGFCHv31HGir+T0bCU8TjZJ+zvoQbeKv/Ou0tvDzwXxv92nlXyHmdXyVp24YXsKJMMvf9o25ACsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439570; c=relaxed/simple;
	bh=uyBuyb6eTIl2z3SHqwzKykKBS4979JGMlH/I/Iv9KkM=;
	h=From:Subject:To:Content-Type:Date:Message-Id; b=iWOlla0kiVT8+CdjlngHo4r1FWHKXujgsWkxlLUZyPEGmA1XwWg8Io4wIlpBWkk5sBizNwXQRolkHHWmH+LzsJeVSgoFBG/KCZtWqWcX9x/xXvJX7Lt35fESIAA7Qh53219rncBsCGw0pF7EpG5fpK/yo7zXg60ff0A0+lWl/nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com; spf=fail smtp.mailfrom=computergamingpc.com; dkim=pass (2048-bit key) header.d=computergamingpc.com header.i=@computergamingpc.com header.b=hJzD8rxE; dkim=pass (2048-bit key) header.d=smtpmessage.com header.i=@smtpmessage.com header.b=Cs0qrCC1; arc=none smtp.client-ip=74.91.86.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=computergamingpc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=computergamingpc.com
X-Report-Abuse: SMTP.com is an email service provider. Our abuse team cares
 about your feedback. Please contact abuse@smtp.com for further investigation.
Received: from [10.0.16.184] (unknown [10.138.12.5])
	by mtl-mta02-out1 (Halon) with ESMTP
	id c6c96998-be71-4044-8b33-f74533af0a05;
	Wed, 25 Mar 2026 11:52:41 +0000 (UTC)
Received: Received from 10.138.12.40 by Caffeine (s0-aws-app-swarm-manager-1)
 with SMTP id 821bda04-2697-4afe-8653-4ba819c774bc  for
 stable@vger.kernel.org;  Wed, 25 Mar 2026 11:52:07 +0000 (UTC)
Feedback-ID: 9194450:SMTPCOM
Received: from ObaTech (unknown [73.109.61.186])
	by s0-aws-app-mta-in-1 (Halon) with ESMTPSA
	id 821bda04-2697-4afe-8653-4ba819c774bc;
	Wed, 25 Mar 2026 11:52:07 +0000 (UTC)
From: "Computer Gaming pc" <sales@computergamingpc.com>
Subject: Current GPU and Server Component Inventory Update
To: <stable@vger.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Reply-To: <sales@computergamingpc.com>
Date: Wed, 25 Mar 2026 11:52:06 +0000
Priority: urgent
X-Priority: 1
Importance: high
Message-Id: <20262503115205558F2BAE72$8EA8C289BD@computergamingpc.com>
X-SMTPCOM-Sender-ID: 9194450
X-SMTPCOM-Tracking-Number: 821bda04-2697-4afe-8653-4ba819c774bc
X-SMTPCOM-Message-ID: 65434760-f33d-4664-a4a3-8f2f04dea3af
X-SMTPCOM-Payload: 
 86DAPoeDT0yfraNoYwKMaxFD3IOCiKZ_z0UDrwle-EMZqwP2XGOiXEozKhig6Dxr1oWSzwXtxhaiVgBRuD4AyrZQ0J1R2kzsjzGlPYBxfQ1MqP4RNC2X0kwsfB8lqawgaSnhbcZ3LYl1cLQMx3YOZlVgANVjO8hWXXWk-c6e6FV0u409m9o3bzGszctmW0MX
List-Unsubscribe-Post: List-Unsubscribe=One-Click
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=computergamingpc.com; i=@computergamingpc.com; q=dns/txt; s=smtpkey;
 t=1774439543; h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=uyBuyb6eTIl2z3SHqwzKykKBS4979JGMlH/I/Iv9KkM=;
 b=hJzD8rxEN6eKMSLTN0XRAtbhDV3AJE831qzEyvIQLMOhe7SilGqLWQjmA+0creX6Xkfih
 xn67I5vkcQUZBO4e1AeDsng3mccZbjHjFdWclVtuchZwsaUOmqVhPtpZZlBo4QmaR/k81pG
 Rp58NVlbMbCy5vDBJfu3Ti6NrC6HdJc14t0A417QKoptmF1CGK3cJ1ydddIDoR7OiQp37Bz
 FPZTyLA1Q9sk0PdH7dS2BkgIK1cB1n/YeFxYliKpTt7SIqkk/duc54y61pmpObNW72cPNqc
 lchNZf/7oqFd3fOnj6dZpFL35ls8f1EId3UL2mk9cv1k+IqfpfYT/7WcpmAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=smtpmessage.com;
 i=@smtpmessage.com; q=dns/txt; s=smtpcustomer; t=1774439543;
 h=feedback-id : from : subject : to : content-type :
 content-transfer-encoding : reply-to : date : message-id :
 list-unsubscribe : list-unsubscribe-post : from : subject : to : date;
 bh=uyBuyb6eTIl2z3SHqwzKykKBS4979JGMlH/I/Iv9KkM=;
 b=Cs0qrCC1qvy1raWhF4U/paWX2S3G5begyF9U0qvOMtzfT5CFXn/iSq2dWRWKkZdpBFC/G
 SQMUQNMivGxhTX6fkgb/oRjiFp0yPGzwNrIwqIZGDVxw2T8gVhkFkgnscs4NZg0FChcXkmi
 kkk7o0Kug9kvLPzJt7yReZaFvsPjjAySBQzncThAOpabGkyBlg0yJyqfNB4Av6zHuJ/srfk
 rggzQEkskdFKxLMe2R40h9vm7lnQVANc032+G2GaO5eZuwHNgIupizldyp176sRkh0bGgjY
 eRxRjtw3BKxxolioUokDO6YJx4MiraK+UXqTkWVw7VP7VZEIQv9DLmGBO88w==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.64 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[computergamingpc.com:s=smtpkey,smtpmessage.com:s=smtpcustomer];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[computergamingpc.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[computergamingpc.com:-,smtpmessage.com:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230323-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[sales@computergamingpc.com];
	HAS_X_PRIO_ONE(0.00)[1];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sales@computergamingpc.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.971];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,computergamingpc.com:email,computergamingpc.com:replyto,computergamingpc.com:mid]
X-Rspamd-Queue-Id: 0AAFF324F20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Partner,
We're pleased to share a current snapshot of our available inventory.

* RTX 5090 Founders Edition 32GB (90 units) - $2,000
* RTX Asus/Gigabyte 4090 24GB (45 units) - $1,600
* RTX 4090 Founders Edition 24GB (90 units) - $1,800
* RTX A6000 48GB Ada (54 units) - $1,100
* RTX 6000 48GB Ada (51 units) - $1,200
* Nvidia L40s GPU (12 units) - $3,000
* Nvidia H100 80GB PCIe (9 units) - $20,000

Samsung PM9A3 2.5" SSD PCIe 4.0 7.68TB (115 units) - $250
7.68TB SAS SSD 2.5" 12G Server Drive (140 units) - $250
* 32GB 2Rx4 PC4-2400T (Qty: 1,500) - USD 14
* 32GB 2Rx4 PC4-3200AA (Qty: 1,500) - USD 15
* 16GB 2Rx8 PC4-3200AA (Qty: 1,500) - USD 10
* 128GB 4DRx4 DDR4 PC4-2933Y REG ECC LRDIMM (Qty: 980) - USD 70

- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 P43331-B21 (Qty: 500) - USD 550
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 P64707-B21 (Qty: 500) - USD 550
- DDR4 64GB 3200Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) - USD 450
- DDR5 64GB 4800Mhz ECC RDimm 2Rx4 SK Hynix (Qty: 500) - USD 450
- DDR5 64GB 5600Mhz ECC RDimm 2Rx4 Samsung (Qty: 500) - USD 550

For quotes, availability, or inspection scheduling, please reach outdirectly:
sales@computergamingpc.com
Call or WhatsApp: +1(774) 559-1248 | +1 (641)232-4364 
Thank you for your continued partnership.
Ann Kamila
Computer Gaming PC Trading
2500 US-6, Iowa City, IA 52240, USA
To unsubscribe from future updates, reply with "REMOVE" in the subject line.

