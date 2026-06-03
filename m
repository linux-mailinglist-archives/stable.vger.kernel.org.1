Return-Path: <stable+bounces-260116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /8OuG2FHIGr7zwAAu9opvQ
	(envelope-from <stable+bounces-260116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A6639255
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oYYne5xY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260116-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260116-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45623307FE2A
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C2395AE3;
	Wed,  3 Jun 2026 15:14:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29B3BED0F
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499682; cv=none; b=h/AeaDee8ldhGzDFpkU40MA9Hr2GuxwnWH/QrHUulRv1vXZCSaTKdp6/Q5sU/LlUZ8wcfXU7HOP7Ch5UpmasaVuqCV/VcStRd6sutU+k2+zoQI3TVrDmkgUFxhrYKHxNs4wvFwyJm6P51LQateqSE0XsxOYJZ0Tqn4nw6eBRMTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499682; c=relaxed/simple;
	bh=2qqO/o06S/omlXQidaM5gm0NG9gdole6XRt8XDUnMXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJH7bfx/bDH854VOEMk+CcJpx0V1uOt0Xx5nNCYeKEW5DVg1ZifN0RrKNoFi6Lvrpc6irEqBljgm+NiLNtqFx3x8f7sIpk6690KT/VMJNvjD6tydCk0/Q5kbEApGgFi2L1Np0d7A4zf+A9IigrDWm3sNI1+ueW/Y07vS7APQKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYYne5xY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F91F00899;
	Wed,  3 Jun 2026 15:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499681;
	bh=YdwffdwQaorbwRmse8wNngbWN3R8ZAVKeUQ0ovQxCXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oYYne5xY91IOeYejCe04nbAraPtlrauEh3z1+dd0PktSkvlQFLXk35FtC8COXFOTh
	 YgZDW9Q2Qcf3yeeQuFqvG5JL8nA7WaYa1QoPNaLODwvv/Va1q51oj5dbNAAmPeVFkK
	 aEBZ16OqOfka9DZzHCpJaJUxQuLW+t04/m9kccQ19B6MSfQNUxFsfnL1s3E06oFRtK
	 pnBHWVWIIYmMa7pMQj/gIXCQp3704ZMtdTjFz02el1sNOPwC8OG1Vmhk26s+j1bR+B
	 K5gaUSar/Q6VxhFQciFQVkg3n9AffssOUKipPKayHOTppRkiy39Qipv25mim0juzAn
	 EZGdydU167esw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tt: reject oversized local TVLV buffers
Date: Wed,  3 Jun 2026 11:14:06 -0400
Message-ID: <20260603111500.item015@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180300.412724-1-sven@narfation.org>
References: <20260529180300.412724-1-sven@narfation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260116-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 480A6639255

Queued for 6.6.y, 6.12.y, and 6.1.y, thanks.

-- 
Thanks,
Sasha

