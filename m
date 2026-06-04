Return-Path: <stable+bounces-260224-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +/T6ADbDIGq77gAAu9opvQ
	(envelope-from <stable+bounces-260224-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:13:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5E563C03D
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 02:13:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h3trhrGF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260224-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260224-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28D730AAEC3
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 00:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC0518EB0;
	Thu,  4 Jun 2026 00:06:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66329199D8
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 00:05:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780531560; cv=none; b=ekbb9tWa2kY/2EYPI6gpDBBTLFtkhWHIovPVm0xlyZ80O0qphRlUdll17CjCZSSISBtkrdIU3FWLHkqulDiI9fs3w8jztCmdfqMOKpSm8kjfcUhB44CxFLI+NER4paoqfxKkVIx9zMpGdrVW45kVF9g/zw4quYuEKQLth4ZHQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780531560; c=relaxed/simple;
	bh=MNgNmIcvyyOUJvD4Y21N43+835RVttedKsDQrM/FLz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGRZzaZjDLXHRIAnd9HAD5v7xZFYTYcVQdC9xsrHdv1Hr3wXh4HU73jmiEFEWM80QwXqQmZNShvGm8p7BLcYyMQ+UZIeLSyF8vlC2vHyNrvBXOlALol70iebMBjyjpWNrMMZE+dalh9N8mmJSGnKTZKWsGHxr0YLqGFh3h0OQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3trhrGF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956C31F00899;
	Thu,  4 Jun 2026 00:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780531559;
	bh=RzgQbkT8A3NYki9D9wiFbfYv5h/9eo1H4c3CU0Nuq5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h3trhrGFXQGbp8uqkYw1nwYNLRvkxoHYy455DXk+09sHDS7p0awVvC3QXd9jLBg9N
	 S6NrOXlIUAvpe7m4GMMGFD7exyf+IUwuP93q7BHiBZssYTcPgo+FK0pfsjFimINAx/
	 nEMu+em5Vd0NoX1JaKYBIyxF5FsqXbyWYWzL1esRJUYFMP8053mAetd7Lim6fhsAGW
	 XsOQYMBVH8zVnC1xQC8yUpqdFZpe8V9n4EbB5whey2l6G+4DyH06yTE2a0mobbqwJQ
	 ki2aSrgjI6bamDPScnoCt1WVQBEp9x6k0ITm5UpADQD+xHqJH7NPoj35k/MOlMFANf
	 4xKncd0lnH1/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with pmbus_lock
Date: Wed,  3 Jun 2026 20:05:44 -0400
Message-ID: <20260603210831.item009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602020601.609941-1-sashal@kernel.org>
References: <20260602020601.609941-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260224-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:abdurrahman@nexthop.ai,m:linux@roeck-us.net,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D5E563C03D

> [PATCH 6.6.y] hwmon: (pmbus/adm1266) serialize NVMEM blackbox read with
> pmbus_lock

Queued for 6.6.y and 6.1.y, thanks.

-- 
Thanks,
Sasha

