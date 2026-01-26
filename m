Return-Path: <stable+bounces-211510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJBZOc78dmk1aAEAu9opvQ
	(envelope-from <stable+bounces-211510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 06:34:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E22E1842BC
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 06:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CC0B3004F61
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 05:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FD227BA4;
	Mon, 26 Jan 2026 05:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="MpobRxaU"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-33.ptr.blmpb.com (sg-1-33.ptr.blmpb.com [118.26.132.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789572236F2
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769405643; cv=none; b=gh9F8gGbmin7aBl/mqrBRSmjMUZ8Sq5DkjKnNzK4tD2ZqdxjF0MHhNby40E1Z4vdUBC0Cl7FNAoqg0XrXMRbLceXlH9jYz0SUfbm7wjkcwrFzzpyeVl3h2NFQv7Rp09YwzjwjMXD6FWdisKf3xipj5LqaM0rCf3rLTMhEkTpIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769405643; c=relaxed/simple;
	bh=/wC5XtevS36sRDXlejWt29/7Fk//4a4NBkLTQuqkk/I=;
	h=Cc:In-Reply-To:Mime-Version:References:Subject:Message-Id:From:
	 Date:To:Content-Type; b=H0FMEDSMCSqMltASOXKlWXNaD0o5suaowwQgf8DD4ob5Skp8vyOSHfumHysHpyWhP3d0XKToioWtBDDajsm4L6vd+AN/ONenQNZ0cni//6csiK3Oc+jnORye1co+SWbGYKhfJoynkF091nDngTqeaINtMjog2oEVffAm8OeYbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=MpobRxaU; arc=none smtp.client-ip=118.26.132.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1769405629;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=VJ9LzF4Ct+myR84KeQEYhbJCkWiG0gF+QzYDvcErG4A=;
 b=MpobRxaUMn9W/2rZYXG9P/sfEVayXekpok0JH1yUrsACTq4FqLuO/mUNigPqNM+IFeJssI
 o77h8iOY7jl7XleRNsDDpXF9QYzHO/iV6utcjijAi/LIjrGM8B7nbSGn68GCQE/QMEqH91
 ha15kMmw+7mCpb+O0IQbx9DboWb/oaBxWi0Nt3xPGCes4azqw/87UuANJAoYpYVaPb/Zh9
 JtzjpNYx7fMdjg2l5xcJkIipq24zjbcvazRGrmrYhWVbvCrkxr/yUTpfAJV6Ut4wrSNHTe
 HVKoUBxHtsBJTxhrxZdszLawtZPv5JDmlHM0hPfiqQf5Pt7aohwH9pF4JbpEiA==
Cc: <stable@vger.kernel.org>, <yukuai@fnnas.com>
In-Reply-To: <20260120102456.25169-1-jinpu.wang@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26976fcbb+d7271d+vger.kernel.org+yukuai@fnnas.com>
References: <20260120102456.25169-1-jinpu.wang@ionos.com>
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH] md/bitmap: fix GPF in write_page caused by resize race
Message-Id: <ad63a8bf-410f-4b91-aa89-3963dadf87af@fnnas.com>
Content-Language: en-US
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Mon, 26 Jan 2026 13:33:45 +0800
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Mon, 26 Jan 2026 13:33:43 +0800
To: "Jack Wang" <jinpu.wang@ionos.com>, <song@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fnnas-com.20200927.dkim.feishu.cn:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-211510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[fnnas.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[fnnas-com.20200927.dkim.feishu.cn:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fnnas-com.20200927.dkim.feishu.cn:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yukuai@fnnas.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[yukuai@fnnas.com]
X-Rspamd-Queue-Id: E22E1842BC
X-Rspamd-Action: no action

=E5=9C=A8 2026/1/20 18:24, Jack Wang =E5=86=99=E9=81=93:

> A General Protection Fault occurs in write_page() during array resize:
> RIP: 0010:write_page+0x22b/0x3c0 [md_mod]
>
> This is a use-after-free race between bitmap_daemon_work() and
> __bitmap_resize(). The daemon iterates over `bitmap->storage.filemap`
> without locking, while the resize path frees that storage via
> md_bitmap_file_unmap(). `quiesce()` does not stop the md thread,
> allowing concurrent access to freed pages.
>
> Fix by holding `mddev->bitmap_info.mutex` during the bitmap update.
>
> Closes:https://lore.kernel.org/linux-raid/CAMGffE=3DMbfp=3D7xD_hYxXk1PAaC=
ZNSEAVeQGKGy7YF9f2S4=3DNEA@mail.gmail.com/T/#u
> Cc:stable@vger.kernel.org
> Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> ---
>   drivers/md/md-bitmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Applied with a fixtag:

Fixes: d60b479d177a ("md/bitmap: add bitmap_resize function to allow=20
bitmap resizing.")

--=20
Thansk,
Kuai

