Return-Path: <stable+bounces-260222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LzEZA4PBIGpm7gAAu9opvQ
	(envelope-from <stable+bounces-260222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:06:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 991BA63BFC3
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YkBCi6tt;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260222-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260222-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 572763010DC8
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96B738DF9;
	Thu,  4 Jun 2026 00:05:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE723E571
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531558; cv=none; b=eID7fETlw8e4wrBbUQQyG++PJ4/i3EV+XDj0kPL60jEUpMyUbq4fTWe6Qek5xMJY8LK1vyfeMuqgj7LobcD6GzlwwqQHYQ3nxPx8BYsD1PTW1goBWYyC1nKy3wDVixg3ep1u8h9/MpXDpS0oQBLNhHlRkdn7ToPXKHOagl/fkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531558; c=relaxed/simple;
	bh=GgmheByney1OihNYaZYbLrg5n9zOQfrCE6ReLiThJoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDL2VBUfYlzcXeujj4Ig0XgmQV4JMr8RUA8nONV7h6aw8Pbnb+eHqVc2+x3hQkZxskqoYZ872vvQEIXgJumtUzLAAgomjySZchd1EnVZ6aw5sU2EOh0BmB/XP/wVNra7O3YOdL6Ps7OSCEJOxidp8ugFey6p1+X1X8ZgZ5oMzMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkBCi6tt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54051F0089C;
	Thu,  4 Jun 2026 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531557;
	bh=G99AG0ZMOLBvwwUAbtYp0zrPRiOlOeE8a20icqlcGDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkBCi6tt0RgKw0jNUvicHvxyApQvxkLYJ+NvgJ2sZXUZ5Sgp+mWztKKTxuwDhXGfb
	 JXv7Lp8ZIRa6P2ov4JdhKWTxjz8D6llWc4LjNIGyLR2KDhACOGr+vDTCSo+W8hRBUC
	 05vgIh4VGAcj/U2/7/Sfse3b2xZ4pkUka28N4Uq0DEFkLyA8TGJ3qSg841d5LPGlVr
	 YhReQ4qHuObwkEQTLa4LgzuwypdLxrhLCehd+KcBz2KWyXU6QrZzyYyyP1RzcL8ZJE
	 uzU3Ws+gOb7vnGY0NbPwMvCtr5o0K0zsJNSsoGtZf+FI4UaozqUSiwTPcYZT3plfgu
	 3WGxI/advmTfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with pmbus_lock
Date: Wed,  3 Jun 2026 20:05:42 -0400
Message-ID: <20260603210831.item007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602020629.613997-1-sashal@kernel.org>
References: <20260602020629.613997-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260222-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:abdurrahman@nexthop.ai,m:bartosz.golaszewski@oss.qualcomm.com,m:linux@roeck-us.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 991BA63BFC3

> [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize GPIO PMBus accesses with
> pmbus_lock
> [ open-coded each guard(pmbus_lock)(data->client) as explicit
>   pmbus_lock_interruptible()/pmbus_unlock() ]

Queued for 6.6.y and 6.1.y, thanks.

-- 
Thanks,
Sasha

