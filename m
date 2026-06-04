Return-Path: <stable+bounces-260218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vGtBGGPBIGpY7gAAu9opvQ
	(envelope-from <stable+bounces-260218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:05:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC063BF9B
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:05:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dVkCecKR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260218-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260218-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEE083019113
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E53C14A;
	Thu,  4 Jun 2026 00:05:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4928462
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531553; cv=none; b=dmQFepkFmx8008KUTwmFAlX3ytVNKmZbzBvFNQFEtwbrRglFVgCr9p8FauFh0j/guMfd8eVmc0lvu0DJ7gzZajmRPntbcBKjcYJTlHONg8XLrU7KY2OQ4rDajxmc6jcPi3Mc4WzeMfLvb9iWCng3HUQfcNeijbvCAbTNvoTMRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531553; c=relaxed/simple;
	bh=Skr5uB6+9unmwr27Hg8mIVMx81Td8QVwj0cFCOTMowM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRtIb4zr5hb0PUj8H76JCags6pZoYcHFRUbG8yKTmqecGBsCk/inRMtC/1gp1bwYVWLdYSvuzq5SOfWaZvr6JhzfL4d6rRN4qgk3QXPCQD9LA2vrq9QESLgVsPuo2tu22pZcQ4eG7uj+vC3BzgVuLonIoA3RCd00hHY2E2YJwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVkCecKR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6771F00899;
	Thu,  4 Jun 2026 00:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531552;
	bh=QElHnGptHvThNr+gz3f90rSDdabt9zXLeli01lmg3Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dVkCecKRswJ4sp0M+t1eYNLbsDpITjnfa93mRyCWdv/2lPm8+2WO9WsQ3aD/32A61
	 MyLKqnGX1GMAUvwajAY4WZgofjhDgC+FoF0vGZKFZ+bZ1Tfm7M2/o9E0qgExQ4Ymp/
	 HXvCsfBKHqxZEjUGCsdwkFzh9DT54a13gJYmH5bKqDxDsRzZWY39OAZYE1r/FAoqZo
	 Ia6PY0Wbp6R0O8bzfpHzO0tcA6b1OtV/uRwb1v2JZsArRm31HqfYoodwobDvImHTAo
	 yS46SzdmIn1OHcizLw1CYpX1rcQU6Ohrb0OnrXmoFPQp9xygfR3WuDeZCAj/o1G4AL
	 nU5AC0DBC4Emw==
From: Sasha Levin <sashal@kernel.org>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Xiangyu Chen <xiangyu.chen@windriver.com>
Subject: Re: [PATCH 6.6.y 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
Date: Wed,  3 Jun 2026 20:05:38 -0400
Message-ID: <20260603210831.item003b@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
References: <20260603095025.4121308-1-xiangyu.chen@windriver.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260218-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:catalin.marinas@arm.com,m:will@kernel.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:xiangyu.chen@windriver.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
X-Rspamd-Queue-Id: 08EC063BF9B

> [PATCH 6.6.y 1/2] arm64: io: Rename ioremap_prot() to __ioremap_prot()
> [PATCH 6.6.y 2/2] arm64: io: Extract user memory type in ioremap_prot()
> (CVE-2026-23346)

Both queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

