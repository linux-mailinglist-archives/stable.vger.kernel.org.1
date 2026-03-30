Return-Path: <stable+bounces-231232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJqqEBqIymn09gUAu9opvQ
	(envelope-from <stable+bounces-231232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:26:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B36B35CCBA
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3B4E3089A2E
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665A73D88FA;
	Mon, 30 Mar 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayRrazhR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284A03D88F2;
	Mon, 30 Mar 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880480; cv=none; b=UZ1c/p845qpG/WP1Y7vArXt8HtDPF83/2LzSOA8g3f2JsqKot6t/CRqDAkcJRRvknzvhkmCwOPkNUlovWK7EpVxzog28I+j6XdCWH/THf1abyZ6SeNMcao9rciR+19kioT84KOALtrhArWWWxudTOL6LP6gao7tF1LBHfaJ1TA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880480; c=relaxed/simple;
	bh=nvI8BBEfBKOZ+08IPyUsthS0y/8g/wghIaColpb3EAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=auSSHp2t3Wwt8h+QIPIMQVH1ICOiE3xiYXXj/BAM5jlCJAUBiFYeAa7a9tkkm0L1DWk27lS5pnkZxTnLhQqpSSYndfRDGxGg75U6+EiJGyC5/wccoQWes0pfMOrWXuIw3ARDtYE/vdKIw8jNKY9HcQL1uVjNTeL8q1ZRh+Krgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayRrazhR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868D8C2BCB5;
	Mon, 30 Mar 2026 14:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880479;
	bh=nvI8BBEfBKOZ+08IPyUsthS0y/8g/wghIaColpb3EAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ayRrazhR4MhrOKdR/tg1+6JxEVV3+pJrd6D6SvLje9rqz+Te862cdPJFN0GP7W5Gf
	 ptw+3XOl4uH1BmY0gbZRLwEzSIzgBlqbntPSkXJgFRE6GsjnbU8jNabmMSgyT4Tr0i
	 dVBxAtL+z6BmG7zA4FetL0ZY8VLt/IOyG+RIZiNZzaxaaicMMM9LzmtJPM0ijYexNJ
	 lDiLweS5pWcu+rAjvoF9HEF+2sk1v/yHqQosgFJchCrFVhsi8ypdoqZr1iJOSoaA8M
	 GX9wRnn/g3dc4t4Lr9SGtrT6gICnsZhsApdWkBEfi3F7BKxzYNG0oSJT0aNJ0FBqI5
	 WJVjuPePEeH/Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Sanjaikumar V S <sanjaikumarvs@gmail.com>
Cc: mwalle@kernel.org,  linux-kernel@vger.kernel.org,
  linux-mtd@lists.infradead.org,  miquel.raynal@bootlin.com,
  pratyush@kernel.org,  richard@nod.at,  sanjaikumar.vs@dicortech.com,
  stable@vger.kernel.org,  tudor.ambarus@linaro.org,  vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: spi-nor: sst: Fix write enable before AAI
 sequence
In-Reply-To: <20260311103057.29-2-sanjaikumarvs@gmail.com> (Sanjaikumar V.
	S.'s message of "Wed, 11 Mar 2026 10:30:56 +0000")
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
	<20260311103057.29-2-sanjaikumarvs@gmail.com>
Date: Mon, 30 Mar 2026 14:21:15 +0000
Message-ID: <2vxz5x6d1jqc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231232-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pratyush@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B36B35CCBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11 2026, Sanjaikumar V S wrote:

> From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
>
> When writing to SST flash starting at an odd address, a single byte is
> first programmed using the byte program (BP) command. After this
> operation completes, the flash hardware automatically clears the Write
> Enable Latch (WEL) bit.
>
> If an AAI (Auto Address Increment) word program sequence follows, it
> requires WEL to be set. Without re-enabling writes, the AAI sequence
> fails.
>
> Add spi_nor_write_enable() after the odd-address byte program when more
> data needs to be written. Use a local boolean for clarity.
>
> Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

