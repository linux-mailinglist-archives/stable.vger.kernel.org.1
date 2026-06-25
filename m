Return-Path: <stable+bounces-268334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xhVFKUMGPWrKvwgAu9opvQ
	(envelope-from <stable+bounces-268334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:43:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EF6C4BDC
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 12:43:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZX503ZcA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268334-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268334-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7A5306D636
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D123939DA;
	Thu, 25 Jun 2026 10:42:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCC3CF942;
	Thu, 25 Jun 2026 10:42:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782384132; cv=none; b=WAHri6YBwrEDZuIGJ3si1mBwdsjsra1OBqq2xT0TgUCKVHg9NEGn8IIsrsn1drrv5vpxtJoWbFRKiAvNbOFJlxXEzc1OZgLXuW86KC2cRd33Dd+OxtkUx2+TVYXrZ31NSkmhxATItVvG1ztmxr2fLNZs3h8LrmDTF71/zXSit3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782384132; c=relaxed/simple;
	bh=xYiaKsbHa4PJszD1tJWqPxsEZKpm9szbZV9x5R3aK6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJevUMmATxplGPwFIOPHnrJHn71oPp9n3cSkf3x0ZJdoiZRdxXKjDlabwhVdBbTL0Ke6wv11x/zX/7O8jYOyeviTXv8yUdyQ7WZMvDRe97JjA202hXeYj3HiRVb8ZckjwbHzgrNw8JR6CsauqpUgDaaMnCbgWyQ32vzynF9q9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX503ZcA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D621F00A3F;
	Thu, 25 Jun 2026 10:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782384131;
	bh=xYiaKsbHa4PJszD1tJWqPxsEZKpm9szbZV9x5R3aK6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZX503ZcAO4QSK+tX/zaQ3UaiwBmBcnpJFnTnGGhZihwJZNcyJY+14k7w5MfMhWktn
	 43gNGELYh5RdMLzQqHBRQqLNQVMLGVBUmPQ7nVUSE+nOnp3nAWCpV/xyWr6N3IWBVN
	 R1JeXmvciZ9XgM5X+UD56iQa/lvpVcEoWagW7OMroRWvyQtX7uS01OflX1HwoZgEop
	 MbQBIklDm5xDmCexg6Y06pDhxRsIc/u1hKhfwiKkrRN2g3p0D+XAnFNWZD5QFnO9Y8
	 xf/8h0/9fWwbyKzRuZ5ynVmb+WoRxHYRvpvh9Y5mHLWs8YV0j62F6ynW3YsJvyRwDp
	 nd7tdVnPMJBtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yicong Yang <yang.yicong@picoheart.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>
Subject: Re: [PATCH 6.12.y/6.18.y] ACPI: scan: Use async schedule function in acpi_scan_clear_dep_fn()
Date: Thu, 25 Jun 2026 06:41:53 -0400
Message-ID: <20260625054005.0006.acpi-scan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624-acpi-dependency-thing-v1-1-ec0d99e5bf0f@iscas.ac.cn>
References: <20260624-acpi-dependency-thing-v1-1-ec0d99e5bf0f@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:rafael@kernel.org,m:lenb@kernel.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:alex@ghiti.fr,m:linux-acpi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:yang.yicong@picoheart.com,m:rafael.j.wysocki@intel.com,m:wangruikang@iscas.ac.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268334-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
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
X-Rspamd-Queue-Id: 709EF6C4BDC

> [PATCH 6.12.y/6.18.y] ACPI: scan: Use async schedule function in
> acpi_scan_clear_dep_fn()
>
> [ Vivian: Adjust system_dfl_wq -> system_unbound_wq in removed lines ]

Queued for both 6.18 and 6.12, thanks.

--
Thanks,
Sasha

