Return-Path: <stable+bounces-244828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NHpC9tR/mntpAAAu9opvQ
	(envelope-from <stable+bounces-244828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B64994FBCE9
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CEC33061C82
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB76423A79;
	Fri,  8 May 2026 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZS6kziJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C7A423175;
	Fri,  8 May 2026 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274715; cv=none; b=havQkR3AnCDzqpmxrI7yjiTIerOPKP0Mr5u4/wklfdqUWodqA7MvnalC4ycVlfROh2kZXCd+I4jZI4bYHycuk6C3dEsWdSjycilU+kTt8+yG621TVbhczkJGdoN5JL7Gm/BKQAAJ/OA7sdoI7ndwPo+/3LhwBCefQUTcD1TguWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274715; c=relaxed/simple;
	bh=6VYHAqxnTdB0b36hQDwg4tju8hdb4LgW1/UP/487aJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5L4SKbFD5Lk8wf6cTmImFLHjnhZAjwkpq8/ntbnVo4/84r7fYi7MlRQ/comqSo3rNLVsUJxB24hSc2v561l8TtB1sDEgs6Tn3suG1MqkPH5a+l3MpbeLH8Ozu5O+jUOksX/ITVerb56jKimCqF5ZFtnQDFaEGk3VKdJju3j2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZS6kziJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FB2C2BCB4;
	Fri,  8 May 2026 21:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274715;
	bh=6VYHAqxnTdB0b36hQDwg4tju8hdb4LgW1/UP/487aJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZS6kziJ5bAJcG6tZM3RkAPHktOU1Zw4uDB98pucRe5GiaCi9oH7hUm4IIEwvZRlP
	 kx7+bihl+pI+pgIraGoBvK65m+CpW68acIsRUxewi3pD6r6M4g8q8HOsxbbbdp6e9F
	 yszl8turFkcyzUYx92sLcSWitlkfxw7t8YLaG7FQ3PuJwRFcq9owAf0t0mCZTLNZDt
	 H9Rk8BBkxN9NWKO6SuMetIpxr9JbKAB/oxWvT0R1gL606zEAEkJRa0nP4EbeWQdVRp
	 i4xagij2PyjQyo6x27g+cwUy77+MHxOrQchn+S6jDbTQh6mA16YCtS5l9LMwqGFvqI
	 JTc9pFdhSoBUA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	Felix Gu <ustc.gu@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Wenshan Lan <jetlan9@163.com>
Subject: Re: [PATCH 6.6.y] spi: meson-spicc: Fix double-put in remove path
Date: Fri,  8 May 2026 17:11:42 -0400
Message-ID: <00cc93668291ce91-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507081457.19427-1-jetlan9@163.com>
References: <20260507081457.19427-1-jetlan9@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B64994FBCE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,163.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244828-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Subject: [PATCH 6.6.y] spi: meson-spicc: Fix double-put in remove path
>
> commit 63542bb402b7013171c9f621c28b609eda4dbf1f upstream.

Now queued for 6.6, 6.1 and 5.15, thanks.

--
Thanks,
Sasha

