Return-Path: <stable+bounces-231329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBksEpRky2kUHQYAu9opvQ
	(envelope-from <stable+bounces-231329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:07:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E865E3645F0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 08:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192F0305870A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 06:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C402372B52;
	Tue, 31 Mar 2026 06:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="O1xvW3l0"
X-Original-To: stable@vger.kernel.org
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F49A372B5E
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937068; cv=none; b=gujBiYabFD/I/Pbjohd/72Q0oudY39k6MVE9Lxbum0VKvvOfTEvdlPqUv9BSndxJPADIwFf473PanS701aaJ1DrE/AQfjmda5EFIqJY+A1FGLwBxGRaGfznAVtTvgQJYJ23UuvNXeP+NufNsl1a5bYCQ/AntUmqaGahZvLVmAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937068; c=relaxed/simple;
	bh=agtgIlOQsZm2zh4n7wBYd5dISphherL/IzqbkXQUIMU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TD8ibqMrvdSBa3FxHZhSf/oa8xOYwx8QWrUkse/yPm30PXDOuaOTL1it/kOgIDHm5yK5KF6PNLjyDd59aTVVUUM3tbzwJlU9kkvBEyV5wnuUAUuE7WiFuX3nXvReo6c0FpRkZyRtRkM/civ+9BEYYTggldVlTk+n6kVbNi+HfzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=O1xvW3l0; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=agtgIlOQsZm2zh4n7wBYd5dISphherL/IzqbkXQUIMU=; b=O1xvW3l0ohtPngrJ5J+9osV3gW
	1xxjBuIMtKNf2kvYHPMWUzziaZzQ6fZxy8Z7IqCgQ40t9iot+58//1n9kxPMVXEVnUTikBvjpwoLC
	mmGhYgsbIV5QtwAIIfDdFwzmOAEx/b5Y7p+TjQ+7TtAcClUsIzzOKwMQ8su70jj0PZ9G3T+RorG/N
	TS4ySALmjOQ7DYoKlGDuk3JoTbg9zwq8xOcvWlRP1Ny8Y6YWiZncKWnthq0xcr9k365f2hHv0ivzN
	ihcAKmCEft7eoRibsCWmG4qxNv7DguLAOi4Y0nlTCjGFoLOBtBK/405x8UjXBF1VMTBcqFPujdt0q
	R2GDXkWQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w7SDA-000IcM-0N
	for stable@vger.kernel.org;
	Tue, 31 Mar 2026 08:04:24 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <alexander.stein@ew.tq-group.com>)
	id 1w7SDA-0003WN-0d
	for stable@vger.kernel.org;
	Tue, 31 Mar 2026 08:04:23 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: stable@vger.kernel.org
Subject: arm64: dts: imx8mn-tqma8mqnl: fix LDO5 power off
Date: Tue, 31 Mar 2026 08:04:23 +0200
Message-ID: <6256700.lOV4Wx5bFT@steina-w>
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
	TAGGED_FROM(0.00)[bounces-231329-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.stein@ew.tq-group.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.895];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tq-group.com:url]
X-Rspamd-Queue-Id: E865E3645F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

please apply commit 8adc841d43ebceabec996c9dcff6e82d3e585268 to stable tree=
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



