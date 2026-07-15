Return-Path: <stable+bounces-274625-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id APLtJ7jQVmoLBgEAu9opvQ
	(envelope-from <stable+bounces-274625-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6BE7599E0
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cjcXAUlz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274625-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274625-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E269D3119E98
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C5249EB;
	Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904CA35966
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074372; cv=none; b=UZrr838JH0jR53IaJxj4FNu2Z5gEH9pObp6/O8cXd1zDFZTsjFf6BHrncQpbgiFYBnbbgvvtRoXoqQx47ZaB+3+N3tiiaI3JWnRI71FQDrBdw2a6r54IX3hTjir4OYIrKRIQ4E2qBmi7aY989ebYtJYB0CKBrJ0E1KWFA8MtqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074372; c=relaxed/simple;
	bh=yMRh7zQ9pDYq80ndJOXYtGLP1SzXrGP49shMnCogRH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIWrjp/tPfcwNzOW+9pTJI+jEFXeb1w83muoNs1IG14zFH5JFS0NdTBrNPxcxmGaNygNOsc9zz9271oE36qcgkNgc2XgnnqnVMRJvR/kJiYKslseMdVMflKJ4UzDAoSusZLQRJZ2vXH8s7tSZDN5E0+lTIDgzGuFxvZ8/snBqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjcXAUlz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D8F1F000E9;
	Wed, 15 Jul 2026 00:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074371;
	bh=X1FzrdGVhLNSonwoOOc5oX8R/B+Hd4o54btgDTJuq8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjcXAUlzL+RQmBDqpzgkNqSVhwMeVatLmluwFNVvrew43aJ/NqBVZ7N6gz/13L87b
	 Ec4Ku7rP/4dimD8FSliLGZgIC88VOurE8Bbb798i2s3Mov/oBGVmDTI7cT0O4HbDDm
	 FUl43P19rVqzErzjSRVU7Mm/Co41JwUFjYuYvpDk9viFk88fpSuMfRL8FCniIIp59O
	 cOY18ps8xWGwaCcVsgpUZQpcKTCxosgzaI09onIQVfq2BPFEVbRIlsHeNzpL4fuKwa
	 tDuRpQM3T8HENpawhwmIc3lLAktWT4S8teQeCj4/kDwglXDMt72r+7incEWjiUZrps
	 r8ViT90w9JHjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 5.15.y] iio: temperature: ltc2983: Fix n_wires default bypassing rotation check
Date: Tue, 14 Jul 2026 20:12:35 -0400
Message-ID: <20260714200600.stable0006@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713152610.95791-1-liviu.stan@analog.com>
References: <20260713152610.95791-1-liviu.stan@analog.com>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274625-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:liviu.stan@analog.com,m:jic23@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E6BE7599E0

> Initialize n_wires = 2 to match the binding default and ensure the
> rotation check fires correctly when the property is absent.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

