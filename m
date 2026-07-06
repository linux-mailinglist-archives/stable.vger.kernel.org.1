Return-Path: <stable+bounces-272245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fmvDAinWS2qLbAEAu9opvQ
	(envelope-from <stable+bounces-272245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 18:22:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBF27132B6
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 18:22:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="GW9xBX/g";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272245-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272245-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC99930B8B63
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18025378833;
	Mon,  6 Jul 2026 14:08:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79512D77E6
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:08:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346907; cv=none; b=bgudLyePVu+BZ2pKEPHKSXzW3jcXf2oQ9vZjb0jk/f9JZaq22OYOSUn5Ox34CtHNW8zKHqAZj+f0NKNWcZH4MDWjOXAjw9wGooWDwGeDU8pbhcxkjLOrk/Za3ZlZ6Eg+rW31Mm/Dt/zWY8q+i3fqbWTJwIaUjO0AZ5JubxYwxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346907; c=relaxed/simple;
	bh=A2wEBq7haRvyyYFDduzvrF3a7EoG3ML2m5Z5pdX6ODk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mukTnDeH+ru9mFToS96yu6JBmVzveBTUPLoEKJNZFhv8KG3kDdbXgacw8yVkcyLyu/PgO3K8kPJYF6Yfs5AS4Yh3iCtUORazMZvm3aKT5u5DuIakzcBU97FjrhC5nW28fP1rRBcTWMWf59fG89iYQGH1pDTzGZmiuFxLmn77e7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9xBX/g; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D01F000E9;
	Mon,  6 Jul 2026 14:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346906;
	bh=FBzjemYg90Nxn5nzt/y7u04GheU+ePAAh3kEJQJo2ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GW9xBX/g6QHrKqfW8MYauZDpoDTCR7YBHaIBjgNuzXmvEuCSHGXiV9vYfcrGzxi9/
	 CO93GJDFm5YJGicwutNfou98kDS/AOXs4/7lH/Jg9ykmWuVvQBxWdBYmsomHip651l
	 9JzXSxndvqiuswfE18EL5w2JhoUY1SqFnCq2gmRye1H85VSzN9JvbrAGInscHvpJNd
	 14FppeuXsclcsyfnl219gKr9KNOt5wPRQ/mUVvWHTDr9fv/kmXEEPvSwHJ2RWLRUn2
	 WRBWWVuCA0zSCSBPC+bJLaZutCs/idls1ZvYzPKxoE18vI6xtxaJ6q48o3kGx5P9ur
	 IQlGBfID+N+Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Ron Economos <re@w6rz.net>
Subject: Re: [PATCH 6.12.y] drm/amd: Fix set but not used warnings
Date: Mon,  6 Jul 2026 10:08:17 -0400
Message-ID: <20260706135124.draft-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706044046.1099672-1-re@w6rz.net>
References: <20260706044046.1099672-1-re@w6rz.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:yangtiezhu@loongson.cn,m:alexander.deucher@amd.com,m:re@w6rz.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272245-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACBF27132B6

> [ Upstream commit 46791d147d3ab3262298478106ef2a52fc7192e2 ]
>
> There are many set but not used warnings under drivers/gpu/drm/amd when
> compiling with the latest upstream mainline GCC:

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

