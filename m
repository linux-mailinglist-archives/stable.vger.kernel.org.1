Return-Path: <stable+bounces-233919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGJGD39i1mnIEwgAu9opvQ
	(envelope-from <stable+bounces-233919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:13:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB6F3BD79B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 16:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 244EF3018BEB
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 14:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858C03D0919;
	Wed,  8 Apr 2026 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="GRxqik68"
X-Original-To: stable@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C813B6C07
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775657295; cv=none; b=ZnQIVXnor3cab/RIg0Pk4X6oEcj7Bbq3Bdwwu5jTTqAtJu9U1GotCxw7GL3Xv6WViyhWtFJ0hhz99fI+I56erVDll/O0i7wuLEFdu1HHx1QHFxlsnU2T5fxXSbRnbJROzvDgfKQiILcF5Xxg0p1i2C4VOzBr+5UFzsKGJLkpwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775657295; c=relaxed/simple;
	bh=QkY8rfsPusGI3tAKpM5AC44Ym4pvjgcYM0Jb6GcLcJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br/V1osdtdAJzoN00y0OYA+Rhd12rIYlyQf3qlJlQSrmxqPtS2PCdnkx7eC+a19lrHb2sEhQOqjsRCMGeoevHbD6GdGqNf11rLfr0iTaakRm2B0c7eYD048KS45xfu/j2YU17o8e8imIPJ7Mi4YGh4WdXBvPNTkpw92liOfG84o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=GRxqik68; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 638CeGTi083232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 8 Apr 2026 21:40:18 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=UDvmLFYVfQkRem5aHBdzktJlS1WKoSW4+JCHWTsN6Yk=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1775652018; v=1;
        b=GRxqik686OuNAh+4hstxOyRNPaax3klhmJvOmspoZ+qa+rrxEa/vwOABEYGAd5i0
         QTkKEfWCQyAmLF9YiHdIeEa5H+RRg7F/4pH6qOjDGNlil/9Gz/Ncy8ophFtycY0f
         ma/EYNokDTab5LQclfEWAb6WXW5cFHw+bbt9feIkZbOBe8vPJmoCVSYwLtV2EbNz
         EW1+psWC7oX5j2Zh7xVcZZRrK+i/1ane4WJtx8O5RuOSjSWVlISaQ+y/1LI6vHtp
         kdRt0kueh9ep/WAhLH4VbXjXtxhhNln2QKj0F5svwp70Lkv3I6qjbzBHhJoPpRpp
         zNlebvNR/lYiMwuYYkuLmg==
Date: Wed, 8 Apr 2026 21:40:16 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Matt Vollrath <tactii@gmail.com>
Cc: intel-wired-lan@osuosl.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] i40e: Cleanup PTP pins on probe failure
Message-ID: <adZMbLhLzm7Oy_sE@x1>
References: <20260407161447.43645-1-tactii@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407161447.43645-1-tactii@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233919-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,150.31.3.13:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BB6F3BD79B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/07 12:14, Matt Vollrath wrote:
> PTP pin structs are allocated early in probe, but never cleaned up.
> 
> Fix this by calling i40e_ptp_free_pins in the error path.
> 
> To support this, i40e_ptp_free_pins is added to the header and
> pin_config is correctly nullified after being freed.
> 
> This has been an issue since i40e_ptp_alloc_pins was introduced.
> 
> Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
> Reported-by: Kohei Enju <kohei@enjuk.jp>
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Vollrath <tactii@gmail.com>

Reviewed-by: Kohei Enju <kohei@enjuk.jp>

Thanks for updating from v1.

