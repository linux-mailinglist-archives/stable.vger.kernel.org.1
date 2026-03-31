Return-Path: <stable+bounces-231328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIo9G5Fky2kUHQYAu9opvQ
	(envelope-from <stable+bounces-231328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:07:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C323645E9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 805BB30570F4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3123371894;
	Tue, 31 Mar 2026 06:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="IOZDVUJP"
X-Original-To: stable@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E009A35BDCE
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937046; cv=none; b=jqTVVLhAkKRuRHk0fkYgyfqyGHIRZU3lP1nfpv7H3gEr1XLz8rw0COEzBqzTxc2DkbAyGLb+Ar9vmQOBw9EZnd6IdPoaq34eA7vuWrA7+2qbLOaU+h4dme05D8Km1wOMxN+71kOMR/OiBn8E4h7fOIi96gzzjlXJjITvWwl2PGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937046; c=relaxed/simple;
	bh=Jzz1doGAP1nA59m95CreP2yX2R8axTytC2fbCPNQgA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LpCGFr//29Vr2iAASUPKaaBdDI1ByRJiqFOTZ5p5glw3QSD6QvyXYASWyBODUSKtoZ2A4IE69/lu3hikOzLXiuqQgtP2F2j8l/PqxRaDH2W8U828gQGXMfDMuzI/euUuJ2e5u9e0jJUdkIMK2Czv44xBjYFB/Tf04m0DFGmUeas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=IOZDVUJP; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Jzz1doGAP1nA59m95CreP2yX2R8axTytC2fbCPNQgA0=; b=IOZDVUJP1sjiBLr+sF9XULc3M4
	kUZiHq6faXsm+SAUcOYRTJwi6PdnixSKARC7lHy9uL4tBpN9SN+c7YRmn279Is6aPOtUYycwOxYH0
	qUxBbzBjhlLAuQk4BpRxC4P/WfoPeVhUIfE1G/g855m8zZEssnwcJbmHLYntmhDM5W22s5SO9LYh1
	8XtClULeEWBBfMZAWLVqN0r5Lqsy0j4PchZdVLVkPuPM64uGLpQQqbC7O8qytRzRwoA2O53BsDr8f
	SL1tbkD2oJG6rkJhGUVL5rG6Jo3UA/IQMu1nzDZg9veUnpLjJYFXDbkQwuDFfFjUcW9/a/jhPYerF
	TXmsclUg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w7SCj-000IZz-1h
	for stable@vger.kernel.org;
	Tue, 31 Mar 2026 08:03:57 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w7SCj-000PTz-22
	for stable@vger.kernel.org;
	Tue, 31 Mar 2026 08:03:57 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: stable@vger.kernel.org
Subject: arm64: dts: imx8mm-tqma8mqml: fix LDO5 power off
Date: Tue, 31 Mar 2026 08:03:56 +0200
Message-ID: <5983140.DvuYhMxLoT@steina-w>
Organization: TQ-Systems GmbH
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Virus-Scanned: Clear (ClamAV 1.4.3/27956/Mon Mar 30 08:24:32 2026)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ew.tq-group.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ew.tq-group.com:s=default2602];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ew.tq-group.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231328-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.886];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:url]
X-Rspamd-Queue-Id: C5C323645E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

please apply commit f7a65b08bcf5edb95697cf7a10435a1d051c9268 to stable tree=
 v6.18.
The Fixes tag was missing in the original commit. This fixes SD card power-=
off after boot.
A similar fix for imx8mp has been added to stable (commit 5245dc5ff9b1f
("arm64: dts: imx8mp-tqma8mpql: fix LDO5 power off"))

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



