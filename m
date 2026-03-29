Return-Path: <stable+bounces-230939-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id tD2QKbFCyWkswwUAu9opvQ
	(envelope-from <stable+bounces-230939-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:18:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB123528B3
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 17:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC62E3010B8E
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 15:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1D0223702;
	Sun, 29 Mar 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lannetinfotech.in header.i=@lannetinfotech.in header.b="YonEDf19"
X-Original-To: stable@vger.kernel.org
Received: from s.wfbtzhsv.outbound-mail.sendgrid.net (s.wfbtzhsv.outbound-mail.sendgrid.net [159.183.224.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327713DBA0
	for <stable@vger.kernel.org>; Sun, 29 Mar 2026 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.183.224.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797484; cv=none; b=LVWEThimwL1cTM928K3Md5BSKxPPJr9899AK3gWRmIvBpvJcJrlUdRE45ukDbqUl39UY17nlplxQ6I8MW5/MzlRQOeTsOPAR8toD/opLEcyjwUZ6/agQ4F5b8HUAAINnnC3RBe6G1V5r4ERFzINhGsDu4b7XGB1ayyzP5OTKkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797484; c=relaxed/simple;
	bh=vOSONBd7fMUsUPhEwafwXDWetzqXTSXxuRjS7HwdGEY=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=aw9dEXi5hErZox3i0dfW3Xagr3Y7rolUYhY+B1JZRfYMOj5P+jsnEjGfvNQvZNhRcEFSR9Ui+mO3GTXkEfSfpQrCroPO8pVl074k0RuHHrtg3WqvQA9KHwP+EBdwVbAW4kK/ejmJ8vwXt8Y+yfNADf4pJ7msuRZB+KG/yEMj0ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lannetinfotech.in; spf=pass smtp.mailfrom=em6446.lannetinfotech.in; dkim=pass (2048-bit key) header.d=lannetinfotech.in header.i=@lannetinfotech.in header.b=YonEDf19; arc=none smtp.client-ip=159.183.224.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lannetinfotech.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em6446.lannetinfotech.in
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lannetinfotech.in;
	h=content-transfer-encoding:content-type:date:from:mime-version:subject:
	to:cc:content-type:date:from:subject:to;
	s=s1; t=1774797481; bh=DjNV8kYctNxbX3kY7Y8U+uCwu6HaRAGUlbY7Eq+OnnM=;
	b=YonEDf19hnuIEF4p9gP2+qPSUjbpkVT3Xj2DAX0R7MbPBUpWN9uqbFK1CyZ3CduMdhYk
	uDsSwI2jQP+UZ3BMzd5EWM5naHBadq1/MuGjDr2ByK7wwmxHAlKeP1EwBEPEmiQhjEtrbr
	SopJE/Qk03Fxe/+EQFk4Q1deIw3FcdGkBVvc9CD3R3Idg+8HFV2wseTNqPByr+4Ub+g5lK
	pr5CkGKvVldTvxnCPP1MZYgEzgS2VLTAio1Dy060wDXB2cg16PqraV0iGf0cSNmQVSaaDe
	xpJbe9yFbz49xQ92ZUN9VeYM1NiCRL1dZzwxXuvARTXOvo1GdxMkmmsVnkXjdgQQ==
Received: by recvd-5d7f7ffc48-gx5qv with SMTP id recvd-5d7f7ffc48-gx5qv-1-69C942A9-22
	2026-03-29 15:18:01.301275391 +0000 UTC m=+1713766.328768381
Received: from NTcyNjYwOTg (unknown)
	by geopod-ismtpd-75 (SG) with HTTP
	id vuAyeeXpTHSw7vftELlHPA
	Sun, 29 Mar 2026 15:18:01.273 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8
Date: Sun, 29 Mar 2026 15:18:01 +0000 (UTC)
From: Lannet Infotech <pradeep@lannetinfotech.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <vuAyeeXpTHSw7vftELlHPA@geopod-ismtpd-75>
Subject: Website Design / Wordpress Development / Mobile Apps Development
X-SG-EID: 
 =?us-ascii?Q?u001=2EuCRTuXpeUEyYCP5y2En1Nblpgw3EmyEO52+QMHAbKahtdCIqg0xJGSk8J?=
 =?us-ascii?Q?XRwAToreMqUKpoBtZ3R1G2f1C1uFiHZVKfa=2FLl2?=
 =?us-ascii?Q?vgs=2FzujfYZIJebfGVH3jW5SpBbwmaLhZt9H0awb?=
 =?us-ascii?Q?DOJsqXh6nT97FdrmOH=2F1U+ZeWbnNXXVC4qQD5GI?=
 =?us-ascii?Q?go2=2Fu4Sz54hPIkyCS6zpt7UUCIFNxRlNXOtJ=2F70?=
 =?us-ascii?Q?vnhYE48SYaoWnVpTmQ+kKGTIy=2FdFCC9UF97B3fs?= =?us-ascii?Q?ZBLX?=
To: stable@vger.kernel.org
X-Entity-ID: u001.MgPV63uHDMckGre8LY6nmQ==
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lannetinfotech.in,none];
	R_DKIM_ALLOW(-0.20)[lannetinfotech.in:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[lannetinfotech.in:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-230939-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pradeep@lannetinfotech.in,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lannetinfotech.in:dkim]
X-Rspamd-Queue-Id: 8EB123528B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

This is Pradeep from Lannet Infotech. We are a software development and dig=
ital solutions firm, helping organizations with technology initiatives that=
 enhance efficiency, scalability, and overall business growth.

Our work includes:

	=E2=80=A2 Mobile App Development
	=E2=80=A2 Website Development
	=E2=80=A2 Digital Marketing (SEO & SMO)
	=E2=80=A2 AI Agent Development
	=E2=80=A2 ERP Development & Integration (NetSuite, Oracle, SAP, Odoo)

If this aligns with your current objectives, I would be glad to connect for=
 a brief discussion.

Best regards,
Pradeep
Lannet Infotech

