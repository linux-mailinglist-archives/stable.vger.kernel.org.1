Return-Path: <stable+bounces-260217-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMGOK2HBIGpX7gAAu9opvQ
	(envelope-from <stable+bounces-260217-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:05:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C50563BF96
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:05:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Rmjzw8Fm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260217-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260217-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7B8330215B3
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F632199D8;
	Thu,  4 Jun 2026 00:05:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B182846A
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531552; cv=none; b=aXevZpRyHkCMEO/GcD58t928m8yWaNgp926NnieGEjC7kXU0vkbGejELpJp8pWku7MgC0Rf+jXBEnYDPhl0ngtOxNfe3NY8xCLT+WvgHYBGX9fNw5jcGBaKWpfSnY+HINX8vIN0PBtPdSJ+gk8SHEXJdkuAE2HcsOn3pQA66bI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531552; c=relaxed/simple;
	bh=Lokx9tWcu3ZzjuR1RR6L4wD1itfA8HkL4WSZlCcXCPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2SHncwqdJnNG5pvT1sGBqZhgs4cLym60QM4IjxOd3LE/nI8cFX8zOJWVB73NhL654IZwGe4KebbifRc8l7K8Cnn0qTYr8vzkISy4HVb31sTjrMnTq57vWtoOobRo3JBsb5qsby5Q9jf3FPH3QZ3ES62vSpvjOAhbcNukg21qUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmjzw8Fm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A551F00898;
	Thu,  4 Jun 2026 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531551;
	bh=8ja6ZFk2OXwfX7Ldxwk6O3Y6wlqXJ9sVKst+Iu/Rw0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rmjzw8FmjNht11OHXoXXi4ycFSUm30NsUA/kqs+iOnUDv8f/BiCcsMULGUO4kdULi
	 aiqDdu31UjGQQrVUwEY3Jl06YtO/gNHnuGJGejOzM5/7WiJsxWzrvlvlb8hem4MzEp
	 33JPi1eN2JLQzhmxhwJzYvBI7iKQX91zHmclW09LeUIFnljcz++oML9mYxfTcoM93Y
	 26B01PBpl20fpWUpMssTSVHCPlBqpFUpgpsbgu6T7cbVSQscLGlInAJo9+hXctTzk8
	 0bgUzMZSEeNmzVGIYHsZKqRwQRWyvPnYbMfZxddHeXTX9vU2ionc2HVMM7mwoENVkI
	 8GQPMHTNxX5LQ==
From: Sasha Levin <sashal@kernel.org>
To: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	will@kernel.org,
	Xiangyu Chen <xiangyu.chen@windriver.com>
Subject: Re: [PATCH v2 6.12.y 0/2] proposal to fix CVE-2026-23346 on 6.12 or older kernel
Date: Wed,  3 Jun 2026 20:05:37 -0400
Message-ID: <20260603210831.item003a@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
References: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260217-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:catalin.marinas@arm.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:will@kernel.org,m:xiangyu.chen@windriver.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C50563BF96

> [PATCH v2 6.12.y 0/2] arm64: io: ioremap_prot() rename + extract user
> memory type (CVE-2026-23346)
>   1/2 arm64: io: Rename ioremap_prot() to __ioremap_prot()
>   2/2 arm64: io: Extract user memory type in ioremap_prot()

Both queued for 6.12.y, thanks (and thanks to Catalin for the review).

-- 
Thanks,
Sasha

