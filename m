Return-Path: <stable+bounces-267547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jpwtAeTrN2qpVgcAu9opvQ
	(envelope-from <stable+bounces-267547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:49:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A29766AAF85
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 15:49:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H+hPFnIs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267547-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267547-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E66113028B56
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 13:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F24436826B;
	Sun, 21 Jun 2026 13:47:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49F35028D;
	Sun, 21 Jun 2026 13:47:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049677; cv=none; b=oF4AJmke4tvD7r/TwbPur2Q9leQsvWSNhda4K9nXJh9AzM1pPv9Sr3aVxnc+U11+uz6B5/m6PeNi/SFqX3A1i2jMTnFb1HU9srTxt5cAMZFMdcj+ervCn6W/cycMzb5TYclBwKNVvbPBou4gEtceVYNWJIKZi8WR0GDPHdm607E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049677; c=relaxed/simple;
	bh=rn/40Cz3ydH6DtFXROpHHGcx8CDx5Qjk9GglDltsYgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l2G1tMP0NskGFCEh7n8V5kAtqHD5zBLHKfIGmd2PtdGqvLCKtgDB3B0+HFHulbm3knrvTMvFT1omDFWP2jULK+VhggcfT8hkJxFC5KT/sZa18Kpvmck3Wab2u2ups31/tuB44uHgPInCeFzuxJg6iVRh1YlKlcXHZWXPtvDZMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+hPFnIs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B380E1F00A3A;
	Sun, 21 Jun 2026 13:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049676;
	bh=OiF5vRmu/i6aQ6nb5HlbPva5iq5PHrNps6OyrcPIClM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H+hPFnIsvxqVOn/mVmh9u+mtwgvP/eWZqaZaHr84O+Uaa1gKvrR/KJ0y4r9QBDV+Z
	 bXpYrZHY8uGMcONqevG4dNtoSawJiBqPOPbyXuXFJTxWtTlBe6may6lwuQwkF4JF0o
	 VcqrcK8PlaKY5Fo4Lhv91gWRHxqxAe+385qgPHNbZ/pGMwGJCGXMEAQI9hPyQ6H8tp
	 s0JmOEsyTf6C064c/apNR41k0SkXk+mzrxxPQuokin8lcn89JYC8mofxnp/8OMWayi
	 UGhW9UxE+liQi5QQkxYFigmmFxpQU3Z49YshEnixnqf764ORTk/qURa3GaYUK/jU8P
	 U4FjaH26eIDaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Elizaveta Tereshkina <etereshkina@astralinux.ru>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5.15/6.12] iio: light: bh1780: fix PM runtime leak on error path
Date: Sun, 21 Jun 2026 09:47:42 -0400
Message-ID: <20260621133722.0004.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619143443.678491-1-etereshkina@astralinux.ru>
References: <20260619143443.678491-1-etereshkina@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:etereshkina@astralinux.ru,m:jic23@kernel.org,m:lars@metafoo.de,m:antoniu.miclaus@analog.com,m:linusw@kernel.org,m:ulf.hansson@linaro.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:Stable@vger.kernel.org,m:Jonathan.Cameron@huawei.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267547-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A29766AAF85

> commit dd72e6c3cdea05cad24e99710939086f7a113fb5 upstream.
>
> Move pm_runtime_put_autosuspend() before the error check to ensure
> the PM runtime reference count is always decremented after
> pm_runtime_get_sync(), regardless of whether the read operation
> succeeds or fails.

Queued for 5.15 and 6.12, thanks.

-- 
Thanks,
Sasha

