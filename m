Return-Path: <stable+bounces-262477-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4crxCQNUKWoYVAMAu9opvQ
	(envelope-from <stable+bounces-262477-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:09:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CD669181
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 14:09:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dk3BKe0A;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262477-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262477-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 564903016766
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 12:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D009C3BD62F;
	Wed, 10 Jun 2026 12:02:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CFA403EA3;
	Wed, 10 Jun 2026 12:02:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092966; cv=none; b=bp8OyXNZHzm8pqB0oN3h4mEZWJ14fJOUY/fwDf8HmfL0XDGK2CEkFhBKwPeGAYQqSuzazdEXRR4bFaZVLIMKn/yNNOnpCbac2n+b3xJBA4Y6/C25apAXxTZDKYvpDdklXNUoO0xmhQX1ycKNlMaxaL5wYxuua7qAB0HVXRFQoCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092966; c=relaxed/simple;
	bh=qHJf5SMQVpkibVV6P71M2cXOaVWl+86IzuhFCb4ubUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpYWfErcWe0hEcz7l0h6x3d6t/7j60I2WEpFlJ8GjuGbBKFkSRZZlGGXxQduggoXAEJRiYw8AymYnSxPYWFw+fH0kuEW6HUHVk8jns6BEknM5pa+9Gg+Hm95sEs6ZL9sMiIC3+UF/UGv8PodWfAxNiZwA3zTfZxrLCvNaeV6ufI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk3BKe0A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59541F00893;
	Wed, 10 Jun 2026 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781092965;
	bh=qHJf5SMQVpkibVV6P71M2cXOaVWl+86IzuhFCb4ubUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dk3BKe0AgK5MPXN4cXrsPuSc6gmYaFHsaauZQmj2gcbedhiMqgnrBcYTQxt5sIu3O
	 zXA5qihqi+JJZ4vB7//PA8NsNiSmuY4+qVwbINY7MQmk0MqEO61QNV5I7n5k7yTdGj
	 KJRIcVmPyi965wZmBGDrfeaoG+xwJVcqlrjdoon0CTos6miAZtgCaLtSAvKP/xOxbC
	 Z/hdW6n5jYmCa+VvkyheriU2HZOXrROG78t3Ia7ITN1ZVJrjBEagxlS5HydyM6gTcw
	 w6+iKw4/ZEikJYPhBUzcRwd4MpBtEYxwr7U4QuE7EQN5vi+LIYJMsEEJlV6BJFzqMS
	 Ydh+dUt1VCOOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	gregkh@linuxfoundation.org,
	linux-i2c@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	w15303746062@163.com
Subject: Re: Please cherry-pick commit 617eb7c0961a
Date: Wed, 10 Jun 2026 08:02:40 -0400
Message-ID: <20260610.stable-out-0001.0a78b438@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609031227.21001-1-w15303746062@163.com>
References: <20260609031227.21001-1-w15303746062@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:linux-i2c@vger.kernel.org,m:wsa+renesas@sang-engineering.com,m:w15303746062@163.com,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262477-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,vger.kernel.org,sang-engineering.com,163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD3CD669181

On Tue, Jun 09, 2026 at 11:12:27AM +0800, Mingyu Wang wrote:
> Please cherry-pick the following upstream commit into stable trees
> from 5.10 up to 7.0:
>
> 617eb7c0961a8dfcfc811844a6396e406b2923ea
>
> It fixes a local DoS via userspace-controlled integer overflow
> in the I2C_TIMEOUT ioctl.

Now queued for 7.0, 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10.

Thanks,
Sasha

