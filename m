Return-Path: <stable+bounces-262147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id icnkF0ZkJ2pavwIAu9opvQ
	(envelope-from <stable+bounces-262147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:54:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBCB65B76F
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:54:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KCYAjcCb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262147-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262147-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C837B30494AB
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AF02750FB;
	Tue,  9 Jun 2026 00:52:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E82C3268
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 00:52:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966337; cv=none; b=anort0ROhmZrck7OOkWqBbemLoJL9ESPPTL/UeEbS4o+aTeaOfdBzXiwSXdr3A0T0n/KB7kANPU/XwB/+x8EqQ9WPGcXQMAQVYPdqBMpp91iIEBh0WJtlYLQObtP7UwKEqV+ijofPNKeqxl+oYMt602gB2CveehFShDJGbCjc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966337; c=relaxed/simple;
	bh=IZohjaCcbRIaSbWG7RnPddL8tI/1f6Qj0X0gSD2ic3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dId+9rYN9H5rtBgReLYP0zKqZESBdQnZFJfWG7XrEQebetm3sfs4brL6MbAe28Rz/8sq7HG5VGtgiGPNWDXB6KWs/zPcHYAgt877ZcXsBio7KSPahDhIfAsQ2CfcHGCf4tTVBuH+Z69XIze4qp4aVeb89tAe46YW5vrL5upRSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCYAjcCb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E5A1F00898;
	Tue,  9 Jun 2026 00:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966336;
	bh=IZohjaCcbRIaSbWG7RnPddL8tI/1f6Qj0X0gSD2ic3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KCYAjcCbBEhuVatAroBkLaKxBDloK722qCIijqfhZLL9ybBZn9/B0Qa9R+32dhhdU
	 YxsYoLlihekUNsRVi1ziJCGFU9AnxUkG1wPjPyYZwo6pHiGuYNR0Bbu4NAYjf6albm
	 wwM0pg6tdxIxu1EzwluQH6X70+3D5QDwfvfikfg05bn8UFJzVIZas8w8WJPlumxCu+
	 G1I5UVmkB7tmo+KOTkXFt/N7waXb+VvoTH71nADWMf2VBLfwcV4Q7Mr2CQnmeeCmPo
	 y+Tb2uJ2uo+vWhyOHtI3hMtRnPAMAnsupRvlWogvFeAForGIBotCzrbU2wowfZawfa
	 E0ku4Yb+7oHTQ==
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Bryan Brattlof <bb@ti.com>,
	Daniel Wagner <daniel.wagner@monom.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	cip-dev@lists.cip-project.org,
	nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 0/4] ARM: stable backports
Date: Mon,  8 Jun 2026 20:51:54 -0400
Message-ID: <20260608-stable-reply-0008@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060832-extortion-cattail-2467@gregkh>
References: <20260511135357.2786242-1-bigeasy@linutronix.de> <20260608082818.LZiPJ9ot@linutronix.de> <2026060832-extortion-cattail-2467@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262147-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:bb@ti.com,m:daniel.wagner@monom.org,m:jan.kiszka@siemens.com,m:cip-dev@lists.cip-project.org,m:nobuhiro.iwamatsu.x90@mail.toshiba,m:pavel@nabladev.com,m:rmk+kernel@armlinux.org.uk,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDBCB65B76F

> > This is a backport of ARM related fixes. This applies cleanly to v6.18
> > and v6.12. I have an updated batch for v6.6 and v6.1 because this does
> > not apply cleanly.

All four queued, in order, for 6.18 and 6.12. Build-tested fine.

Please go ahead and send the v6.6/v6.1 batch (with the PREEMPT-RT bits on
top) whenever you're ready.

--
Thanks,
Sasha

