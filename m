Return-Path: <stable+bounces-249377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPqpC9JmC2qnHAUAu9opvQ
	(envelope-from <stable+bounces-249377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:21:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E3F572D03
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E70F301E202
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BDC3890F8;
	Mon, 18 May 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oC82EE9a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C553382383;
	Mon, 18 May 2026 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132064; cv=none; b=ANiEmqY0EnCye0GTz9JP69rr8ivHEI9+r3fPBrq6HVmuqtQzRjaCJ94qCH5IrPgrYTJjKOevulZx4c4ceByy5PYM3o/WkUU5QN5dzMEfSzeRR0I8SB9PQS511gm77kWyo2KwVekdYHDUKH7dAAuAh1RT/6rxP+R7TUVirgn6vWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132064; c=relaxed/simple;
	bh=VVi36MaIcMpmXO2pTePxfZQYLgCz6lO1mEvbzN8lcwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0vE2aYDzB4ViJpGMF95MYC34LjBEpXPze2iF7cbR8JO6FbIEqet/w8VVWiO4XqXRodUJtNZBRbEty/WGQU/nLtokdXKeW8cqXbarwf65TF40mSyIyQDVXjfNbd0U5vERDcPVdFjjd0Bw0DwyxTa5RC8Gmt19qwsQWrE+bnFj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oC82EE9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1731FC2BCB7;
	Mon, 18 May 2026 19:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132064;
	bh=VVi36MaIcMpmXO2pTePxfZQYLgCz6lO1mEvbzN8lcwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oC82EE9a8H3zhVsVatoigkVvWGCDHj3SnmMI+CLXLlBwhhhWtwT+/+7U0ueGekhCU
	 TR8pzHbjNv9MlMxtbTAZ4Tw/lZgBWSv3sqwiDAyAGqiobawL0QF1bkvkLPaqm9ScAO
	 wm+wqTyomNQO4mjUvlhnwx8cEC4jH7HRlexxfs01OCda+ZQ3ZFZ9OQ32UNxXRbsLl2
	 xTY9E+5H0MitWgTI6gaBPzJxj+3NHD8vOWb9Tv5tGvIQw7oeeO6qqkmkX7s1oRIldi
	 dpkAhEN5RfQ4f8tt2LV+d4+M0oh0h4RuWSR5P5Kh5gpHS8W50Wq6hLhj6qK4I/O6c6
	 RpeZoJwNdWFIg==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	ardb@kernel.org,
	herbert@gondor.apana.org.au,
	patches@lists.linux.dev,
	stable@vger.kernel.org,
	dist-kernel@gentoo.org,
	kernel@gentoo.org,
	Sam James <sam@gentoo.org>
Subject: Re: [PATCH 6.6 404/474] crypto: nx - Migrate to scomp API
Date: Mon, 18 May 2026 15:20:50 -0400
Message-ID: <20260518155236.reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87y0hha5dw.fsf@gentoo.org>
References: <87y0hha5dw.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249377-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 79E3F572D03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026, Sam James wrote:
> This fails to build. I think it's this patch. I did try figure out why
> but I couldn't spot it when comparing branches (and all other branches
> are fine).
>
> /var/tmp/portage/sys-kernel/gentoo-kernel-6.6.140/work/linux-6.6/drivers/crypto/nx/nx-common-pseries.c:1023:35: error: initialization of 'void * (*)(struct crypto_scomp *)' from incompatible pointer type 'void * (*)(void)' [-Wincompatible-pointer-types]

Thanks Sam. The root cause is that upstream 980b5705f4e7 ("crypto: nx -
Migrate to scomp API") was written against the post-v6.6 simplified
scomp API (alloc_ctx(void) / free_ctx(void *)), whereas v6.6 still uses
the older alloc_ctx(struct crypto_scomp *tfm) / free_ctx(struct
crypto_scomp *, void *) prototypes. The migration was pulled in as
Stable-dep-of for adb3faf2db1a, but that fix does not actually require
the scomp migration.

I've dropped all three crypto/nx commits from pending-6.6 in this cycle:

  - 268ae55a4c4fb ("crypto: nx - Migrate to scomp API")
  - b94588f5a6971 ("crypto: nx - fix context leak in nx842_crypto_free_ctx")
  - 6923cde8dc1d5 ("crypto: nx - fix bounce buffer leaks in nx842_crypto_{alloc,free}_ctx")

The bounce-buffer fix (adb3faf2db1a) has been re-queued as a backport
against pre-scomp 6.6 nx-842.c (using the same adaptation already
shipped in 6.12.y as 910bb34b801d3).

--
Thanks,
Sasha

