Return-Path: <stable+bounces-267647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DtPELkGOWpolgcAu9opvQ
	(envelope-from <stable+bounces-267647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:56:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA256AE76D
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 11:56:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Mkdfdwmz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267647-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267647-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88C7230036E9
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00F369970;
	Mon, 22 Jun 2026 09:55:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FB39A7FA
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 09:55:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122112; cv=none; b=hbY/wyNs3uIqy44lFnX/4Bd/2Ay6d4LbbMdz3Vu4arURQUgrMXsqDyj5Tuc5lV4u9nDWmPBLjv0oBZspCeQ/UMnMDo3v2XbipaXiNFTxJLtmkfq6T6oLxfvO7eoPdgNuUdmCqYXy9YwK4cpo6VF9kqrx1+c3SyhlEnagV6RZEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122112; c=relaxed/simple;
	bh=22NiOE2gMGGnQ8QJedCdcB66z2sCqgnYoka8Hw/b4j4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=uUcUb4jjhb9KqdSNxP9z5rfzYCgBOkxUbBeMODyQyHbcWRW1eguXUqK7nqtNM1WTnWqJbpjVHsWLeELUVBTpyU0FSPe88qlLwt9ommHs83JdlV8m8S6/gw6+Zu4c1c7TzWSJqv7LHWgbrhK07uErpvpcBNjGvGLa8o6vpG3AxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mkdfdwmz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD591F000E9;
	Mon, 22 Jun 2026 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782122111;
	bh=EIQXIFZQ7Fv6o3MA3NeTORGu/XgvCk+YOy4a+ZvIj0A=;
	h=Date:From:To:Cc:Subject;
	b=MkdfdwmzGbpYAbqJi++XfSsLmU4lZLLOy5t9OAD4yQM4K2wgoS0A4wJ4iuPWh/xYX
	 YWhErycJCcQUl7vW73UEBno6uAggx6CND3qIJNaDWTUif8xtxjCWobUkacxQ9ZR8K0
	 b2YM4xAL8IGpxL0c2fdiZhsCzxfkqwRB7OtjtTYo70QLgElWNfpcwDNfxhdV0IFbfp
	 A20WOV6FuDYLoRefGrDVA/igPdzGuJMxCTM0O0kicZtYQKSVfc69bjSdHetkiKszYK
	 F9tITaKFs5NDrj2Nz2Uunk1Yl4HAA8aWOA+d+IDE5DUUIMidXQxOHNZUwn9Q7Xy4+X
	 XN0p5c2rJmO6g==
Date: Mon, 22 Jun 2026 11:55:08 +0200
Message-ID: <20260622092400.929691694@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch v6.6.y, v6.12.y 0/4] debugobjects: Various backports
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267647-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:longman@redhat.com,m:bigeasy@linutronix.de,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCA256AE76D

This series contains the necessary backports to apply the recent important
debugobject fixes to the linux-6.6.y and linux-6.12.y series.

Thanks,

	tglx



