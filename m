Return-Path: <stable+bounces-272281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7zOuJJTxS2rUdQEAu9opvQ
	(envelope-from <stable+bounces-272281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 20:19:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC83714692
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 20:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=hNIAns4+;
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272281-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272281-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135E83030109
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61884302F2;
	Mon,  6 Jul 2026 16:17:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6337FF5E
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 16:17:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783354653; cv=none; b=dS3Gk32iKU7LsWAy7GgMoOIpIiq1ohu/GOtnsETUTHguC9L0tDG4ptDqaiCQqdRVglqyhzQ7oyBlaowYJlHfx01jeoA5EOiTkQtc4QzmN58MffVFKofCcfJbYNr3JKzX6PAkc6vZAb+FFhaqg/ngvptzchoUtlYO089W3kL3jLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783354653; c=relaxed/simple;
	bh=G7/Rq6x4qK/s/0ukf/XPAzi6mDI+d+8xFFJYWcIDSnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTiyWgee15FPbCFNhss3vLuUUW9g60zaoNgd67M7Ouzl16MezahDxxbNehqOs380J8VEOjAWZvVh8xUYg/7fMqloA7VhZ/Zqc1aNxZ0Wr+g0jbja5hEeFNemsGE2iQ/0Fqz3udH1ZNova66y3QtdjLrir+ggtB7Ws4XrMF2renA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=hNIAns4+; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=Q6TnNJxglyiOUlwz1+rqzlNKomb7yKNuiARfJmiELgk=; b=hNIAns4+nEHA3e63UsyljX5Sfy
	BzoA87RKBUmzmY/pF7xA7lJQ15AQh70MLIQXFFLnKcIqlKPTanSaLwlpYeYabKXNQmN6flfIVDZiZ
	XOt3gRYAKOfbckwOUV6NEkEcOdh68iMX5wL0VkPecRADebRMx4VjlOaeQk8lecMm0U+tURlOBAsL/
	c1IHve4nUjI9CLgzfV0dGRw/1ivYV0w2KsUEUApN9CA+8I2Nq1vhFy0TfRlvZgCyV1S6IaluNdCKS
	BsUePqOFiuSUqmtiGS8UUEKSPega0gR87mweW+/J/k/Dr4uqDRapf1hH0u7bu2QNw+NIAUqjerU4D
	qYs2drAg==;
From: Heiko Stuebner <heiko@sntech.de>
To: stable@vger.kernel.org
Cc: heiko@sntech.de,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 6.12.y 0/3] Rockchip GPIO driver resource leaks
Date: Mon,  6 Jul 2026 18:17:10 +0200
Message-ID: <20260706161713.2676365-1-heiko@sntech.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272281-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:heiko@sntech.de,m:quentin.schulz@cherry.de,m:heiko.stuebner@cherry.de,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sntech.de:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cherry.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DC83714692

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Patches 2+3 resolve resource leaks, while patch 1 is structural
change without functionality change, that is needed for 2+3 to
apply cleanly.


Marco Scardovi (2):
  gpio: rockchip: teardown bugs and resource leaks
  gpio: rockchip: fix generic IRQ chip leak on remove

Ye Zhang (1):
  gpio: rockchip: change the GPIO version judgment logic

 drivers/gpio/gpio-rockchip.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

-- 
2.53.0


