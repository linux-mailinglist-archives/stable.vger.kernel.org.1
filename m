Return-Path: <stable+bounces-260791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qRZCGqclI2q3jQEAu9opvQ
	(envelope-from <stable+bounces-260791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:38:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976864AFD0
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:38:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DhQeUXP8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260791-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-260791-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3872A3039B7B
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9877D404BCE;
	Fri,  5 Jun 2026 19:37:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761124611C4
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688266; cv=none; b=Ne+6BirVL0AymVp8uQvFIW8mditmgmGCPDo0O828TMeoOa4ewRVcR1k1NMwC9dVf04CeBZAEjgmYkeLRjeuupYuufedCYUNVtK4MQstMmZMuoN+PvfBvpf0v9jG68zCWptZ4CPY5h7oeRXSquUKF1TEknQZFiH4Cy5icxxQqC6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688266; c=relaxed/simple;
	bh=vBn0uMOlc7dpYFaT0ln+yFEvhhfXz/A+/m2j6YXt3h0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOMkpMqIwLIE7BPl/wgvPGAU6iaHH6EnNmGcte2swtX5gC8XwKp/RumjQIaeIR7mFLcLdkQ4GiqfY3aelUHNH5pu9zFg5pnXKtWjOO6+4lXu5NCHoRFXVsPzPK3J/ZeTvwhbc3K7nV80M1xJ46VZYWoYoY9MW7rz3veM0pLCUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhQeUXP8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5560D1F00898;
	Fri,  5 Jun 2026 19:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688265;
	bh=2fi/uHqpvLmbF2h2S8R8jkh2FjhztUdxW4dQUx1/05A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DhQeUXP8aYCd1+VJTjMzHuSo76ND3xbxTksf6GWJXpeCr/z5n6+8sBmSlKuYkfDgc
	 gSS+rxoCO9NoyMTP8xvUfJWhMSwbhmipEMDcUTfJbjyteUgL2xfSmfDKy52GYf7gV+
	 zKsDw5cXOxXsG6v8M5ULyKB6Nl8Z/Si/X0B6MmPHWKGLWsC83qZAubSmr7KI+s2yeO
	 TlRiV7paW6VFEzLARL8JFfnFoO12MN1T0UljpGihcZpHoJ9Ey9GHyE6Mq3S5eaDQ6D
	 ATmyvK6oyt39ZTkrkdceRP8mfeg8daLrf3eDt+POdLeQYAu1ERhPpMZZ7pPMn7U1FB
	 ghhmOl2rRu1Bg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nogikh@google.com,
	bp@alien8.de,
	dvyukov@google.com,
	Miles Wang <13621186580@139.com>
Subject: Re: [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()
Date: Fri,  5 Jun 2026 15:37:17 -0400
Message-ID: <20260605-stable-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604003031.561-1-13621186580@139.com>
References: <20260604003031.561-1-13621186580@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,alien8.de,139.com];
	TAGGED_FROM(0.00)[bounces-260791-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:nogikh@google.com,m:bp@alien8.de,m:dvyukov@google.com,m:13621186580@139.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0976864AFD0

> [PATCH 6.6.y] x86/kexec: Disable KCOV instrumentation after load_segments()

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

