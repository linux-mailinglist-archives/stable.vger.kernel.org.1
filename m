Return-Path: <stable+bounces-266762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f3SZA7aiMmop3AUAu9opvQ
	(envelope-from <stable+bounces-266762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:35:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8895B69A298
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 15:35:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sntech.de header.s=gloria202408 header.b=FtsliOLO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266762-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-266762-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=sntech.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 488AB3198E56
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 13:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E4E407CD0;
	Wed, 17 Jun 2026 13:30:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB743F5BD7
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:30:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703012; cv=none; b=Bx3VbIaJZKn26eoWIo1myAhMSbIkGy6UVcSolq+ravymN5lD++x9yNH/7H8mfuejoHP3K8soK65oECy1BGrXYNa4xf+ziQ8MfRDntzu2wRrdTxbji7lyPUSZrK+xYZXx/4P5hILAXUHE4L1apzIxQ4It64WUX06sNtZ10hXl4/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703012; c=relaxed/simple;
	bh=nwsJlp3bvwBftVi33E+nQ5v/Hlj7W1HC1ddCRaROFdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jmU7OOHEtSIvQUzpJ3mHSlv5lbrlFCcxKZA+8XBWlolM5AeXjHrUpYiuUquPJCzfKycgbYpYuYIGbGaBBLFBfYZEs4650isng/kNsJ6nZ/g8oh5/nFkUwFSkmuWF5SeAZwa7B5MpHkH6alWF84VDcA7+nSPWYkIBASDTirL/0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=FtsliOLO; arc=none smtp.client-ip=185.11.138.130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:References;
	bh=nwsJlp3bvwBftVi33E+nQ5v/Hlj7W1HC1ddCRaROFdg=; b=FtsliOLOlqBgXRUx5Wrtv5A3+Y
	YUEvZOvy5s4eb6LwXz3Z4+X1j6Azw5hTMQKd9wgt6LbvzhHaXaSKEAm2WSEEAq5VjClagMbYfvt9I
	9Trpj6WQ9yE4NgJLH1a+R2MtXGXmAhTubgSgMinGWgIWaqfyuqyitJM/dc6tZylRjjXU6kEaxBMfI
	3JUkYLU/CgvI6cPhGD8okOOqZdNmFuPywsLpG5yOE8yA288Mjttmra1u1aSQhkvPN2UXRuvPh2p7F
	hG9VO94sThHqFxTOBFB66Rb+26HTZ6YPGVsrMqfMq7Wb7phGglurYhaTyFse7S+KqTKGsveEZPYDR
	cNwsA2FA==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Vulns DB is missing information for CVE-2026-31456 in 6.12
Date: Wed, 17 Jun 2026 15:29:59 +0200
Message-ID: <25098130.ouqheUzb2q@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sntech.de,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[sntech.de:s=gloria202408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266762-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[heiko@sntech.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sntech.de:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sntech.de:dkim,sntech.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8895B69A298

Hi,

not sure what is the correct procedure for reporting such things and
didn't find something in the vulns.git .


Fixed in mainline in 7.1-rc1 with commit 9b25a6e3d243 ("mm/pagewalk:
fix race between concurrent split and refault")

Seemingly backported to 7.0-rc6 as 3b89863c3fa4 ("mm/pagewalk: fix race
between concurrent split and refault").

This fix got backported to 6.12.84 with commit
138ada1337b4 ("mm/pagewalk: fix race between concurrent split and
refault").

The vulnerability DB is missing that entry for 6.12 though, probably
due to different commit ids floating around.


Heiko



