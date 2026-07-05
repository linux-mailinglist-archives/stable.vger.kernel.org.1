Return-Path: <stable+bounces-272077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pw6vMlhrSmr6CgEAu9opvQ
	(envelope-from <stable+bounces-272077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:34:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3670A4DF
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 16:34:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i5rtwtgR;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272077-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272077-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE925300D872
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D4217659;
	Sun,  5 Jul 2026 14:33:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798364207A;
	Sun,  5 Jul 2026 14:33:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262033; cv=none; b=k698GF7ah/83avyfOObNw8lbnvXPXwfgPmU/4ITJNGSP27vRwMHyHISpeya7x5hkKZtRIApVTKvmumpwh/V/ieER+FjGAsDHFZ/qfBu8lxSKCDbDth3fDZ50cdG7k9ACNmAx5Lw3abeXnAuiJo8yFIovFHBHVTYtwCzr0GDHmAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262033; c=relaxed/simple;
	bh=OiDtkJsieqRUiUEt2xafKLxCnchfXTrqpIfWiz0Dtv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NxKaHu+uGFt6cTnhK8pZ8d37uNyXqyF2LQTTa9CVKuQncg+ZXXyxW8fYXHvbts53VVj4m5Dt927VHkJJ8zK7sBjsoYjyrtk467Hb0pGm4/IGPfaldhIxNbBQdIhZsa8Pn2QWBvCPWRIsTtikLLs051hOMir4kBD57OnrRZ14LQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5rtwtgR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366991F000E9;
	Sun,  5 Jul 2026 14:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783262032;
	bh=1iWBF/ZAjE5MrNiAFWR6Vk6YDuxQRd+A/EYrbtPoUfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i5rtwtgRwcARVVcvo8V6v3rm+bcI4TkZVpFSGdDyK44XAc472y0diWmh+IZjAZoiF
	 +c72lZxrOl75kIX93K2PrjiHLaHMJifCcAes9Ms0U7hJdO0cZIk/6dSgsaZWOzAUtj
	 Lw8Fd0qkrCkEGptY+Veg3/2R9/TfkE678o5X6brZZOK5pau7zajP4omBA1fLHWnlqD
	 ZBMcFba72IITi1yWN2AXZsGSPKUF1sdD4cy4gw7SyTMElT+Uw9c/i7wFtxHyEbMO7K
	 g58xnajxKWBUMUnDPrRgh5gaYFc73mr2ADytBrVcNWVUifOuUVsw3fUsn8WfrmwCHX
	 IcAHPfyoMrzZg==
From: Sasha Levin <sashal@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.12] bcachefs: avoid truncating fiemap extent length
Date: Sun,  5 Jul 2026 10:33:48 -0400
Message-ID: <2026070510-stable-reply-bcachefs-fiemap@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <akkdYigsmB8tJf6T@shelob>
References: <20260703114813.113406-1-mdmitrichenko@astralinux.ru> <2026070315-stable-reply-0028@kernel.org> <akkdYigsmB8tJf6T@shelob>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272077-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kent.overstreet@linux.dev,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:mdmitrichenko@astralinux.ru,m:linux-bcachefs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FA3670A4DF

On Sat, Jul 04, 2026 at 09:49:11AM -0500, Kent Overstreet wrote:
>On Fri, Jul 03, 2026 at 10:05:22PM -0400, Sasha Levin wrote:
>> Thanks for the patch, happy to take it if we can get an ack from the bcachefs
>> maintainers.
>
>Ack

Queued for 6.12, thanks!

-- 
Thanks,
Sasha

