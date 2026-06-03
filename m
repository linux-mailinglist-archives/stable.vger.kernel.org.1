Return-Path: <stable+bounces-260126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HY+PMg5JIGrA0AAAu9opvQ
	(envelope-from <stable+bounces-260126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:32:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6207963938E
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:32:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XUm0r42b;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260126-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260126-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E95D5308241F
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6D3CFF6A;
	Wed,  3 Jun 2026 15:14:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B063D6CD7
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499692; cv=none; b=Zbu7ImMYK6jlTlF/KpthI0vb3hsTWUNmxAZchpUqpAIBupu/0wTlDjYx3zfboNcYG1kpbi4/zLuLKByI/usCLK6YR37PRnfTuZeiuWTE5ACLAqnyOqFfHu8lZysuG9H6sPC3YMhMRPZheUBqRwLHBAq0GXqzD/paTQNFBVadUN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499692; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw6xP4NTASOpnXziGkfxvp3V1IOZ0gEHwbGSOmnl2nAAnjlCWUscX+CyDqOPNatFXXaPzONyGqhy3tgbTNfRlr38GwQf3HFRBluttbMKVivqUu/RgQBWzRq0hkKza5XUVwPwZhPvP0eQe1uePrYmMZLX0yQw6cEU5sdxj0FftpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUm0r42b; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF971F00898;
	Wed,  3 Jun 2026 15:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499691;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUm0r42bviOvyhdsV6j/C3+/qWYJhO+7akiWaVEP/IWnLVDDBIEazHfz3Z8P2nMkw
	 uD7TaeqtIXh6h1K/oGcISs0OWZqiSW+t7qXInNgdxeSlBy/4O+1vbh1onKXWUSO3fB
	 jMZEbCevjd4cjrPhgcFXVqwSYmWVtcVdGF3SPo0Y37QAhFYSomzhGQ/zdpLJagcJQe
	 EsytQbWMN+tj3BDdRZnJKPDu+sO2KjRMsU5eXnF2o2oVuFZDyLrAOrJPZ46bQnc4x7
	 kX29L8Tx92+nLd2YNy3oTM80Ap2lwNUBERGGqOF4Xi+NEoWDBKnEQjHjZ2VJrKeuf+
	 hAHX6saK8UVhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: avoid empty VLAN responses
Date: Wed,  3 Jun 2026 11:14:16 -0400
Message-ID: <20260603111500.item046@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180450.413317-1-sven@narfation.org>
References: <20260529180450.413317-1-sven@narfation.org>
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
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260126-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6207963938E

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

