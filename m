Return-Path: <stable+bounces-254169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFJ2EexrFGoTNQcAu9opvQ
	(envelope-from <stable+bounces-254169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:34:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AE55CC54B
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2278C301BC1A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E142E8B82;
	Mon, 25 May 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lijcsd3X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A1D2C21F4
	for <stable@vger.kernel.org>; Mon, 25 May 2026 15:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723197; cv=none; b=rct4CmF6akMW1ZNOfQEJ1oSANsO3ZytfHQgYD7y43j9j1XnviwV1mUO3AZhFOvVc6gOoqcaiJ2MbaENtElkAANi0kuwsSnOvSTlGasUGoDasCH6M5Sl4dbSn9eqym4jwGRN6KXphHTIQRyrEl58YYyI53+pv+s4+IGFu1zNKFjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723197; c=relaxed/simple;
	bh=NgTPmQg9vvwftNfUjlnPinbt7p00aJbCXqKRixaNytI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHsIoL7ODLILm/7slgTVXxs/wV6DAHOZkXFytj0/HHjMluUFq7mw2kcZ4n5cUN8NtzpCu2/e3Yfq3t/ls/OmfWPLZtSH8Im6b7VRO/1GYaYACMHLiFeN/WUh/F/kisgFtToGmIBEuAXnIr5mC4EXvt1n1tIIME0Uon8M9723pYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lijcsd3X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E2A1F000E9;
	Mon, 25 May 2026 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723196;
	bh=Udn6MzHSaARtrwCEvRIWMKm6fKt+ZsiZtaf+r0vBYn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lijcsd3Xu8YIDfoTk/vHeDEGjXlGKlceS/VWGgPmlxiq0wv3GDdn1/vtTRRUdt7Ea
	 xDYMX8Ytzhk0UcN+75a1mONsjhTZb/yxtpJvJqx8YUgX0uQQ7Y4yoMMctn7fdH72yD
	 uRZY76OmKxrZEej+VU1bj7Q+fopD5IRr+R4TDnJUy9nRjZGFMr8DSW4mB+LqCPivA/
	 UKuq7n7OI8O5SAtIei6zXRHk99ii4ksO4K0JbL/QtPkACsS/hliZ+5NUUpm/C9uzMp
	 zmyDx8oPti+VNC5o9C53jMGreBMXZVoMUG6lyik8UzUDof+vK2Vh6Yu19KNlAVnpmj
	 YyhnLpmTVhAJw==
From: Sasha Levin <sashal@kernel.org>
To: vladimir.oltean@nxp.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 5.15.y] net: dsa: sja1105: fix kasan out-of-bounds warning in sja1105_table_delete_entry()
Date: Mon, 25 May 2026 11:33:04 -0400
Message-ID: <20260525152512.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525031840.5358-1-681739313@139.com>
References: <20260525031840.5358-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254169-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: B8AE55CC54B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 11:18:40AM +0800, Rajani Kantha wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> [ Upstream commit 5f2b28b79d2d1946ee36ad8b3dc0066f73c90481 ]
>
> There are actually 2 problems:
> - deleting the last element doesn't require the memmove of elements
>   [i + 1, end) over it. Actually, element i+1 is out of bounds.
> - The memmove itself should move size - i - 1 elements, because the last
>   element is out of bounds.

Queued for 5.15, and also picked to 5.10 since the Fixes: commit is
present there too.

-- 
Thanks,
Sasha

