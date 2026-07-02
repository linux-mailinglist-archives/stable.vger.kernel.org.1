Return-Path: <stable+bounces-270284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sKMUN1OzRWqLEAsAu9opvQ
	(envelope-from <stable+bounces-270284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:39:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD276F2A69
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 02:39:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WGdRa5Fw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270284-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270284-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE983058143
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 00:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588FF274B44;
	Thu,  2 Jul 2026 00:38:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7F26056C;
	Thu,  2 Jul 2026 00:38:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952723; cv=none; b=j4yNOZaIPpMdfZp6lQB/qkPTs4dmjEt6o8iNVMRfOsP4+rSRqtaLrTZumULz+qjBJEneEWBT57fywAKlzbNJyyNAf713tAeYWv3l/xJP6w1d58dJtDQbEdvDe6eYxhWfUqyYLMQKyqa0+bMMPlTMgVjlza2MByVn3Rr0gfdAs+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952723; c=relaxed/simple;
	bh=KVBH37kHK2Qz1ppns2binekf7nxXneGxiYGJArf39Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QGBc7KTo7dLdnp2zaejW7CuImo7h2XpoZjMn6RdMBKVzMokg8WX008gz38Va0iVgCUy3jsfv8pkNYhKT63e74aHCVX7JN6l0rz8Mj6+FjbGg1DI1KogynW6Vq3hk7VRsE1xRSUntJ+SQUdPbWcRrkNMdTvuDMyoPNd8hceSmsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGdRa5Fw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F581F00A3E;
	Thu,  2 Jul 2026 00:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782952722;
	bh=FwU9jtKSUKMl/sbUhVAEup6JZyGjMrOu416Td6SVJyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGdRa5Fw6zDSubA5nRRSS2gvL9dZT9p5OFlItsA+FyYVWSQupSKq3Xood4+zCZwZX
	 gvhroc8TXpsyPinXAS+EzSubi5y5yGNSro/c8IQkfwW2ogwOonAXHMmHiMPv55Sz7m
	 sWT6T/yW9cWEb8YfuPm8pA3YW4Cu9ATDBnPqMCfItTzvoQSV69vcLCXjYvAjufM0VY
	 qHJyDOUnqtr4c333xWgOiCWNqb6dBMkhqFFpGdHCvJwEpDMr85p9iBHeqFabFGC6pK
	 f033sYw9wom96yTqAkOFmrV7b05a03NsF/EwQGLZrBLPFZcKH0fOsPzj5/mNU8Qy2l
	 J6cPKiYnviZYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuto Ohnuki <ytohnuki@amazon.com>
Subject: Re: [PATCH 5.10.y] ext4: add bounds check for inline data length in ext4_read_inline_page
Date: Wed,  1 Jul 2026 20:38:26 -0400
Message-ID: <stable-reply-ext4-inline-510-20260701193800@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630164255.51218-2-ytohnuki@amazon.com>
References: <20260630164255.51218-2-ytohnuki@amazon.com>
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
	TAGGED_FROM(0.00)[bounces-270284-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:tytso@mit.edu,m:adilger.kernel@dilger.ca,m:linux-ext4@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ytohnuki@amazon.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BD276F2A69

> Add a bounds check after computing len, returning -EFSCORRUPTED if the
> value exceeds PAGE_SIZE.
>
> The upstream commit replaced a BUG_ON(len > PAGE_SIZE) in
> ext4_read_inline_folio(). In 6.1 and earlier, the function is still named
> ext4_read_inline_page() and the BUG_ON was never present, so this patch
> adds the bounds check directly.

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha

