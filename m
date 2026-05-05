Return-Path: <stable+bounces-243983-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAuWCDKH+Wmx9QIAu9opvQ
	(envelope-from <stable+bounces-243983-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:59:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D384C70D7
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 104E93029638
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CD33C3428;
	Tue,  5 May 2026 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlBFVv9B"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E862B3C2777
	for <stable@vger.kernel.org>; Tue,  5 May 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960564; cv=pass; b=OOK3+qmACueX5Bxg39uYkslZxmhJPwpdT01jywkW/SxnIc4ZOMP3XyOh4wAH4OezCgXSas3IVvVkr8YJ74BsAGgnVy7hitiEroWy1l6TwiySmG38O6Vkezp9W6v10eLelya4q88OQCOePbRJlHbDx4LPWNugC9Yv72//ZoDbHz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960564; c=relaxed/simple;
	bh=9mlovRsEHAoxeI23qyyG5fbABwikFIPVIBRrF6sRJR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyNlo0Ql+Y8995OaIX1FPpw/IbiI+OGfOh3ss0rEbo36Qkw0pGTx/Qqs8xQkVFXKL92xwJJecliCpB8j4PQu5mm6hXdsG9LUqn63SjrlgDpRD0k5L3oLRJo7vX2UqKdHdQypu3LFlEnwP51gOeZ6JmcRUKFTE11Z3CAXFaH3QJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlBFVv9B; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d77f60944so3026333f8f.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 22:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777960561; cv=none;
        d=google.com; s=arc-20240605;
        b=lYL/9U+0rQeeJTLgQyqWstbrsFgK1DuAiFIjhH2umAy01w9KlGImKAo5AMDAZiAc1e
         LeudJ8cKQknc6omHsUbHmlSKRoFdwjugyRkE0+i4DDW0W3KZraxawCc5nV7y4mWXXcJx
         o+6waR0sZA/LboxyEJNEjKcSPGlxoqVBuw6herDF2t66toiByilTJolq2G12wsQlMJJb
         04e0qU2RU3QLanxqSgRuOU34y3dcsAOylHAbEBKYfGDJ/zTyheyHwEsA0T63O8Y4vdjg
         GneIAyjiJUzLh8au6cIvZXzBLR7tZNdsCbmsdSZ3asYhegU9RD8q0MiE4FcbkQHdl7bA
         v6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JiffewN6wp4HO0UKxt2HUBfPX0gz1ne+Fe/6CQ+sGQU=;
        fh=KJxgvTdJD2zruf0qAG9RM3K2KeNDcRZPwHwKkD/Xi7Q=;
        b=fUqCm9JAQavusG/6Q/xow9F9eGlKwvmRuNIbk5HztQHpSE9Qk2eGC6YwjUjZTcH9/h
         U6Q6xJgVetxFoS2xsmetpsClLREBuAZAFO/bfbiIMPCOxa1096yBjeJGY3Du92+HXaSv
         LPzo6IBa6/Zoq8McsmjllalOcxdRQeHoanngL3E3CMJWW8LAoNj+XIBmHKUXVHRoweu+
         QORw1eFC4TvuxVrQKF5REdpLSZiUL3sYHQYb2PVcGDvZomx+mOMkLFyp1kDYBRDQ9WmZ
         d7WqP+AslDCuJkTucN1qxRityegimKXJ6raPak5LcMcZajvYo6aDcy/S0HLvdWTnIps4
         hAlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777960561; x=1778565361; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiffewN6wp4HO0UKxt2HUBfPX0gz1ne+Fe/6CQ+sGQU=;
        b=PlBFVv9BkkM6J3EGQxcwhf9ntjCmueIQBQuUGLvByK4wvf70DGv2LEj7hXRdq2nKqg
         jkKwzuTAidFM9BXyq7ieuefwuQ50jmcHpnCM9wtaatY0uIP3cVMACNWlbmn7WmHWb4Ut
         YTvM0/uZ+dL4QS0y1eypmUP8RnynA2FHGAe5cd+Z5Jesqn77riLFzx75tQLTbqEVWRcD
         QG+3fooaVjujkhezTKQZPla/jTJE5JhLdxf1DVz6MRLNbJJjjLaarOVYJ3fpNoryYa9B
         +pu7A1t9Y3QeqDHBTIUEu8JEftMUIeejJCRGArh/j9gRhghpR8Aol5tdarvy+KEgPAyU
         9OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777960561; x=1778565361;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiffewN6wp4HO0UKxt2HUBfPX0gz1ne+Fe/6CQ+sGQU=;
        b=FdjsllqnSjFteQf1cDh5i99sOV0utNYaWCYyoyn5cFW0zwS4GiFcO9wcfzZttiUdPy
         1sW4BgVrP9elOkW5pqcXxfDXF82FFj8KsInQOUzC8Srv+grDUcIkppOLRlzTkNBRBJ2K
         O48Q/01yj5LALXOcQlaP8S9qtAuB2QrDEk4NzSeXuZbM4F7ximHF+4KSOcVf8jnc4nHJ
         gjz2Pcs3hVdpxssrfWltXJUkgqiOdcmdMxIyqNoimRbGaLyMXEf6+ZRQZDXGGsLXbcfs
         +jLWBbnXskjuqji+JGxWkDOUHuLvqrQE6jnL4ARi9gFteQ1+08+diU4iE/yJTJ7ZaxCs
         PPbw==
X-Forwarded-Encrypted: i=1; AFNElJ8hXfCx2VDmZsKdNXvYOmoIrR+f7AT3KSqxtjXI28QhUTpPIdf9vNjoJAjeOVWuSZj0SdaOHVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz9zRWCR/dstw6Low3l817CRyuihVLegUvKugNGw42vPK+33kQ
	xa0IxUvPGIydj1akgTTjpL/0oeL6tAg/NZPKXb9Ro+SJURLtLyrg9TcRnx0J5HUFwwszArFSCOQ
	/ejKV1N0yoXMHu9Bf2PBIWpEA+Sgr7IE=
X-Gm-Gg: AeBDiesYaKjqYNLWnaWSKZzg6oHCT5zscoFokB56KnPjfImAZaR3OyXoF7D7lom7Dmn
	7HxE6HuMPxeEY7U1YeW+06aTKHWN9k7FfF7N6VMK+JHMkOY4K3JDZ/xjicm9JVFGDKCUXILchvq
	3A2evGG72Rf5Hae1nUbneprGqjVJ49Rk7kD8fJrizZkA0bO9uzg6h/qf4C+SEA2MpGNn/40bKB4
	LSjfjkIq5yzra3QImO6zas8HYKutb4uOYprw4Z7VYK9JXtYS3m5lbmkVEgEXQfkovaKwGIsMh+V
	ilCYgmFxHY4uF90XkGheYTZSfw2I
X-Received: by 2002:a5d:5f90:0:b0:43e:aefa:db84 with SMTP id
 ffacd0b85a97d-44bb63f55c0mr21257027f8f.34.1777960561129; Mon, 04 May 2026
 22:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502150918.4171847-1-maoyi.xie@ntu.edu.sg> <willemdebruijn.kernel.3269daabfa48e@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3269daabfa48e@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 5 May 2026 13:55:47 +0800
X-Gm-Features: AVHnY4Ilot4dTwSCSgdn7UVyYB0tCp9-Q17EkcOWWdYDAEvWqeexqcYYHRFeKQ8
Message-ID: <CAHPEe=FF7SKocBUUTGULg1RzW5Oq1o71POuxHReJVxM7ifMy6Q@mail.gmail.com>
Subject: Re: [PATCH net v6] ipv6: flowlabel: enforce per-netns limit for
 unprivileged callers
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, dsahern@kernel.org, kuznet@ms2.inr.ac.ru, 
	willemb@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 99D384C70D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243983-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[maoyixie.com:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Thanks for the review.

I will take the prep patch. The series becomes 2 patches.

  1/2 ipv6: flowlabel: take ip6_fl_lock across mem_check and
      fl_intern, convert fl_size to int
  2/2 ipv6: flowlabel: enforce per-netns limit for unprivileged
      callers (this v6, rebased on 1/2)

For 1/2 I plan to:

 - Move spin_lock_bh(&ip6_fl_lock) and the matching unlock from
   fl_intern() into its only caller ipv6_flowlabel_get(), so the
   mem_check() call runs under the same lock.
 - Convert fl_size from atomic_t to int. The remaining readers
   are ip6_flowlabel_seq_show() and ip6_flowlabel_proc_init().
   Both already run under ip6_fl_lock or read only at init.
 - The atomic_inc and atomic_dec on fl_size in fl_intern,
   ip6_fl_gc and ip6_fl_purge become plain ++ and --. All three
   sites already run under ip6_fl_lock.

For 2/2 I will also:

 - Move fl_free() in ip6_fl_gc() back below the fl_size and
   flowlabel_count decrements. You noted only the ip6_fl_purge()
   reorder was unnecessary. With 1/2 in place, both decrements
   become plain --, so the concern goes away.
 - Fix the spaces around the / operator that checkpatch flagged.

I will send v7 shortly.

Maoyi
Nanyang Technological University
https://maoyixie.com/

