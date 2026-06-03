Return-Path: <stable+bounces-260127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pQ5pLrdQIGqA0wAAu9opvQ
	(envelope-from <stable+bounces-260127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:05:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EF56398A6
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:05:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V7+W+qWf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260127-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260127-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F9ED314B276
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7C3D0929;
	Wed,  3 Jun 2026 15:14:53 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC573B6BEC
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499693; cv=none; b=laEArbvIEtjMuZwoxmxtXxbISs0r3Mgl1lOL93hclR2CZKlL+e9hIKUoCbgtsnQGQbhVT6UYdcPos60PyWAyjwYf8bNw4HaXEkAwj3F9wiIMjuMDFHX3og/w6R39vUrSS+7YbTd5BNaqcH70MKs/CiweYxfY3SKq8Gp/QxsfwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499693; c=relaxed/simple;
	bh=ThKjbUhLIvgxllQQs5xWIY0UL8bsv44XQePYMtNwC38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fda/Y+68gThzC/T8G9xkmqaQyM3yacDZ66rs1wjZ5CqWpnPi+08YYsyRAMEHga+lyGKL41o8AjBC5ZwNqg+UrPm27t8kl76PQlvJhp6SLfKwWd5pLJ04Ck08yTxJO5i0OXeiCAT7boRe3P7JAphGmL763GpUdi/pgqxNsMdag9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7+W+qWf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1FA1F00893;
	Wed,  3 Jun 2026 15:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499692;
	bh=PGy8UqhAM3zbEkvdrizI+kRrBIWM19hQLCmOZSeRCw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7+W+qWfTZ2UtiyM59DQX7dgfIyBKf/tmm1xY2eJA/5kqeuM9R7qmjKhV3Amv3l0x
	 TdntTl3axbN9PfNaFws9ue9G7KI7z2WBCvZh/I/UbjHJ5eOEsyEHX0kUKlGpUNFj7q
	 CAt0jtbMZy+WOdyC0byNhO2hQo1JcWEQ57Qa0SA3Ueh+elQzYwX9ZZz//jiml2KthO
	 D3+e6OX3LjfI/NY6mNAsGVYx6jtXpu8WM1SvdZsjzqqRWiICh5dFyeftlZsb4ycA8W
	 g8e4D7hyboxHI+D2WoF0AWcWrG4sfc/U60DxHEarNBjngIv10eWdROj6GAe1UqmM/g
	 VQUkK3AFdTKtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tp_meter: avoid role confusion in tp_list
Date: Wed,  3 Jun 2026 11:14:17 -0400
Message-ID: <20260603111500.item048@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529180905.414737-1-sven@narfation.org>
References: <20260529180905.414737-1-sven@narfation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260127-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 18EF56398A6

Queued for 6.6.y, 6.12.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

