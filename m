Return-Path: <stable+bounces-259869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PuYqM50fH2rpgwAAu9opvQ
	(envelope-from <stable+bounces-259869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:23:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C58631092
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 20:23:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ofujh7yz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259869-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259869-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FC71302412F
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 18:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7CB394497;
	Tue,  2 Jun 2026 18:21:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D98391844
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 18:21:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424508; cv=none; b=hvsXPZe9BolywTkLFoxZb3RCDpHxHfoc2qVsOzOR8yzSxhPZUbmwk+BpMMFiZRE45qXRtehxEbDPxrDsoMCneqtRxVa31h4KbBrKVhGa6Ci3bdqpmmryBDHsd0QOXX/LcNakuTAKs/3DxL1apvVIPUXt3XCD7CjVB9nTpxj7uyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424508; c=relaxed/simple;
	bh=sqdMMtbY/26Ox2S6GXMK2cy1LPLrxXhmCSEHrefBhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TsmLma9Uk1PfhSrUgzFIiRMyZZAFy20EpIC0OR7CbnwkHcruJ9IERZAji4guXF+59s4ocB3HEbQsHu1pj4QAhYXa039ndIZQYhSz8ZQXYtRkFtTcTHZvEDL1+SyEvLZ1U8ACPrXs6gNhGOScj8GAesQYJNzLEhTHuj4Uzm8tUT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofujh7yz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AFF1F0089A;
	Tue,  2 Jun 2026 18:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424504;
	bh=79x/bdmRuLluYzncV824n3s3KlSyYxd6NcKkgpckguA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ofujh7yzAqQnwZXJPK237kfZ/iQSy5ISS4hIYMFe3/dFSkcshdg+eiAmomanS/OA5
	 6hZXvUzIurueNNxTGAnZeHvmyCLSjyzIKBneFqGUNnbBThyinU9xI13FFOWMQo1KXQ
	 proHp1KNPl1MmzqmFm1x7xnIJTMZmXCS0rpnHFiJZe/Rw3pGaJoS05CN1VBng6wysL
	 A0yTKMxIj5fVMyKDpKNpZ87lia/yuGNqQIRRHhqdYj0VAKfSedMAEp5F7KEk3MNdi8
	 wp0RGn8MSB/eJZDnEqjzJmFepSRUcrMz8K+m0Jnu70XV3/xR/CblYzqxZMwS9sWuv9
	 yj5UfWJsVFdoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Iago Toral Quiroga <itoral@igalia.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH 6.12.y 1/2] drm/v3d: Fix use-after-free of CPU job query arrays on error path
Date: Tue,  2 Jun 2026 14:21:22 -0400
Message-ID: <20260602180900.drm-v3d-uaf-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531210323.1637818-1-mcanal@igalia.com>
References: <20260531210323.1637818-1-mcanal@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:mcanal@igalia.com,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:itoral@igalia.com,m:kernel-dev@igalia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259869-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 89C58631092

On Sat, May 31, 2026 at 06:02:01PM -0300, Maíra Canal wrote:
> [PATCH 6.12.y 1/2] drm/v3d: Fix use-after-free of CPU job query arrays on error path
> [PATCH 6.12.y 2/2] drm/v3d: Release indirect CSD GEM reference on CPU job free

Both patches now applied to 6.12.y.

-- 
Thanks,
Sasha

