Return-Path: <stable+bounces-269385-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n+BKCmazP2pYXQkAu9opvQ
	(envelope-from <stable+bounces-269385-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 13:26:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC0F6D1D57
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 13:26:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VQ67QVI8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269385-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269385-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC34130107D4
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 11:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0080280A58;
	Sat, 27 Jun 2026 11:26:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E4C2C21F0
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 11:26:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782559582; cv=none; b=kX9lTU2Rci6gF60Oy83ZikYrEyT93u/og413NtCrRfrOLH81hB8j0JTUShK06P67uMNzKqusmN/PUKRS7dgJkqwZE2mYT7NV89FLSQearXvaG2t0hAAHDyZ8e0gAz/wBvXvJIiL8r3B1/tvkuMXJTyo1/IOMTI8UC5SQFxXQL1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782559582; c=relaxed/simple;
	bh=5RB+9jzTPZpewwSxcSkM8uNEhb/obFPOuP3WMNT2PYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuAVNdfu7GqIy8PKLBuH15abrJTonKCd1FcvYZtUyYIzKU1xEB3hhphsHpmmogs8dadQNdJhLLKLwcVcKKMJh+gr91ITR0J2Z1ckPez4wPKqbqkUSjkNtidtAjtWcTakjNtQfCAMXdzwA4uLpX/sHQ+lyLfKKe20q85o3OE493Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQ67QVI8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB3B1F000E9;
	Sat, 27 Jun 2026 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782559581;
	bh=zUs6dy7C3Ey1u+hFvlQjq3YzPcIeTGOik68VOFqqA1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VQ67QVI8pU+QryUfKRhl2v8WMXprSpNt+etDLqNyMn+Xp1psSn0TytKKlF1UZLQ/M
	 rp4PtKHZnjK1LIVUgJA2vyfXP31B1hqAtFfhGyJNxWcH7nerGR+KbxZKSC2QB8c1yu
	 zox2lRFZrBFen30vhBNaygqK3BvMpWIOlFz56FGpXivEn4JA1ImGwt77nStlr8wziS
	 Ek2UsSjMnk2wVGmAqUA6Ubt3DF5FIzTWJKlmfnamJWyq86i3Q7bsvIVcG0iFvfkgy1
	 mzwkNEcTVUSqGW6+4VfMC7Iuql2sa+WT7wBKN2uwe+S+f6Gkz1Am2O8Q0fhx0EQhHa
	 VCDidhlXtUccg==
From: Sasha Levin <sashal@kernel.org>
To: Sven Eckelmann <sven@narfation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.10 10/23] batman-adv: prevent ELP transmission interval underflow
Date: Sat, 27 Jun 2026 07:26:17 -0400
Message-ID: <stable-reply-item015-batman-adv-elp-p10-20260627@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626160952.123713-11-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org> <20260626160952.123713-11-sven@narfation.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269385-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sven@narfation.org,m:sashal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AC0F6D1D57

Hi Sven,

> @@ -939,7 +939,13 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
>  #ifdef CONFIG_BATMAN_ADV_BATMAN_V
>  
>  	if (info->attrs[BATADV_ATTR_ELP_INTERVAL]) {
> +		u32 elp_interval;
> +
>  		attr = info->attrs[BATADV_ATTR_ELP_INTERVAL];
> +		elp_interval = nla_get_u32(attr);
> +
> +		elp_interval = min_t(u32, elp_interval, INT_MAX);
> +		elp_interval = max_t(u32, elp_interval, BATADV_JITTER);
>  
>  		atomic_set(&hard_iface->bat_v.elp_interval, nla_get_u32(attr));
>  	}

The backport computes the clamped elp_interval but then stores the raw
nla_get_u32(attr) again, so the min_t()/max_t() clamping is dead code and
the underflow this patch is meant to prevent is still reachable. The store
should use the clamped local, matching the sibling orig_interval block just
above it in the same function:

		atomic_set(&hard_iface->bat_v.elp_interval, elp_interval);

-- 
Thanks,
Sasha

