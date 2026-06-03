Return-Path: <stable+bounces-260114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nr8MOZZPIGo50wAAu9opvQ
	(envelope-from <stable+bounces-260114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:00:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5763980B
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Py/1l4H4";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260114-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260114-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA63A311F3A0
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FE83C276B;
	Wed,  3 Jun 2026 15:14:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBF23D45F2
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499680; cv=none; b=jNf8yeEdO/FZtsUWYToB73N1T7Uyzk6yYOzrbRs25LRPR7lY0cvcuT4f3uAcrNHxwYhNUVVC4TJbBL/VeolOfa9pCSDji3uE931pJOsvujiSJFVDZRRJqG+qpQpp8u8EzfPcP3xWugJxeA+y0KzJgd0u14JwtIZL+uPsn1SnQo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499680; c=relaxed/simple;
	bh=LxgTUKbn8KNhLGRhBso8SsMhr0Dzs7JAPcOk+R2tsBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWnMWpz56SgSs8ESSYSda5PXVUpukQlSkjoHPKtnkH0YqQ6RElt87MZXmjOQJLwmMaTLg0LEjgkFcdLBDbt6U8P/A6NiFhWDuRAOy28+nKf6vUBW31UuyfjkeyNn6NqUrSs6eR1sX44TPYAkflX2FGGIvGeyYbVoT+xzA9ceYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Py/1l4H4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE31F00899;
	Wed,  3 Jun 2026 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499679;
	bh=6ujqYMqXB0/i41pw2tThC/BzMjS9s70+BOjvuc2SkhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Py/1l4H4khFDnLB1PhkTxBkd6jshmSWTldby2no0x4qqj4vlRfCEFyzi40F/FsfXe
	 2wq85ysiKOr/BOxdQOyq8+/KlyXBNINVaEEkb1831WRYWqC/zr9hnAe1qrowVX02tc
	 8d8lMwjfnVSb7gus2nStUiimDgG+HI6LZbd1pXhZ4QXMsJieF805d4dLZA7KSsUdxm
	 183V4Dcg3Fs9XZd9VUBnw2yEueNJ+/HeqRsAsp9jm/qoasiGF9VLxkqqk5XKkHqo/n
	 7T7KPTFh9sPY6zM7xx4yVkw2f/yF6E+c7ZkDznYEJWjZQU9jQH3nTY32chs6moSTXu
	 Zq0Z2WRfUdNyA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	yuantan098@gmail.com,
	steffen.klassert@secunet.com,
	zcliangcn@gmail.com,
	lx24@stu.ynu.edu.cn,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	Miles Wang <13621186580@139.com>
Subject: Re: [PATCH 6.6.y] net: af_key: zero aligned sockaddr tail in PF_KEY exports
Date: Wed,  3 Jun 2026 11:14:04 -0400
Message-ID: <20260603111500.item010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529060945.4813-1-13621186580@139.com>
References: <20260529060945.4813-1-13621186580@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260114-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,secunet.com,stu.ynu.edu.cn,lzu.edu.cn,139.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:yuantan098@gmail.com,m:steffen.klassert@secunet.com,m:zcliangcn@gmail.com,m:lx24@stu.ynu.edu.cn,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:13621186580@139.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E1E5763980B

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

