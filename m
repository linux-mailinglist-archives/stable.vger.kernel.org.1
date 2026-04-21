Return-Path: <stable+bounces-240062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNjeGkYn52nV4QEAu9opvQ
	(envelope-from <stable+bounces-240062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:29:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114A043792B
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45622302305F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994463876C7;
	Tue, 21 Apr 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvHt2g/t";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVhqt+Lw"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F88C37F8A1
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756518; cv=pass; b=GW6F7TO4S8HPy5hbEzZL5GPVGcMxuV6uvJZyDagd4lHdqekCI5tPaeJ0hONmOBkGMMX5qaf1f0kxfmtWO++CvtWUrC470cq3mbqFkcJ3ajkCWo+scvvUr0rkC4QpNP2riTPnCqaj8576ibOkmoRkKp/TB4acb3A3oigwAMNvM6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756518; c=relaxed/simple;
	bh=wwmZXFfudo6vtD8Qyo2Fqwkv5D5eNldWMhPAPtQB018=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYiO94Yepam6WPNWChWEtaDyKsffjlfHQ3li8iarwWbc4NlfLCjbjZPHfcGQ2yrFA9ZsxAgmLRzGF4gjoSS41vZ2LeggEvY3CI/3OTxc3xAy7Zf+mao28Bfm5XMuDwRfbiHIEa+x0qpdZqnRFUJ5IcpjdC9aVYKbzb5Y0Zr04Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KvHt2g/t; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UVhqt+Lw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776756514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
	b=KvHt2g/tIVJh3J2mpQlP5ias2laAXuaEHgBAzD4o+/vj3v6EQ6+lNWxEN8EIGbmbjAvpte
	I6Uhz7bZMrY5MZweV8wcyyV6uCqOa3/7LobyLG56SSFhi7jY77hL3BUlMOVrgYW4xIyh3h
	o+w1mRA7v2Q0NIIAW9NH+sZC4IjH64o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-IGvcpNqzOLG3W2pHo0WR3Q-1; Tue, 21 Apr 2026 03:28:32 -0400
X-MC-Unique: IGvcpNqzOLG3W2pHo0WR3Q-1
X-Mimecast-MFC-AGG-ID: IGvcpNqzOLG3W2pHo0WR3Q_1776756511
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso3961922a91.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 00:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776756511; cv=none;
        d=google.com; s=arc-20240605;
        b=VPhQcH4gh3SUQdlOvsY3nhmgX8/DoyDCZUKlUinvn+hBsUf5zQ8r7K6IXSI1Ncvc4h
         lejEM4FqjYdvS9JPGd+CmsZxSU+OIUOMJzW5dqDImBns9yViZdzEzHm/0FM94AMDdVCb
         odWriq0iL66bMiseJHodouUQCMZ2609RkJfnML09ifEeVeXdowpR7eA2eoI/pX6LaFhT
         +1s4mkP1yQ9s9QgXQGCobzkK9Byss/VUx4O/fCpj2bqeXC9EmS5GMHmmGstHDZDZFvJZ
         zP9/5d3cnQNyZBnqW5xZ7NWGLbQFieGN1fWCgIqUmBPxEFD2ew+TT5HZ2tLqLh81pOeC
         ZooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        fh=2f/robnAfG44msVEjEvRlqfgp0hfArCVlp3+UVrA05k=;
        b=WBBxIQEUq4BYX2xN64k5mL55UO5WMOEtwxfCS7t5Zxm5it8DHk3DJam9DB1qLC090G
         05dYyVr4yXqLyHoFGyu66BgVzhS0deDv5JpJTBHSTNFQoRQvnhn4EBUMr34RwQm2vov2
         pMJXYZG4J868elGZaHaE44erdf2yQRDE3NuEf34XvYsHz4MQeBtgzx5Dirw6BUdkpcZ0
         cWaoAzlkoIHjXeQzpJ5YzSkWZW1c24LiBQe+OoAPwTAv5+qXU0PYCaX080HCKEMI49Az
         ZBwoZhpcso9/B08cibhblG9Xtv5rd6uh+BzSFgISz2M/wc+jXd2ltZ/ZkhNSVQF5ZNUP
         yHgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776756511; x=1777361311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=UVhqt+Lw4Baw/TvCDHMwBfj+G//AE5fZSaVch46WkQSV0EJ2vD14K+JTJrykSxPJQ2
         E3fsjwrXJj6s01fnM/PNPCM0SdQ+mw3x4OQbr76RZl30XbA/OPFShjFr6r2vCSm7glW8
         rCF+6sLQbURLm4mP7nv56qyzY8WbRY1zjjceMc2L1ZWrc7IdnRLiMAuT1Tb9PjvzlXOj
         JzdIfAxMcXgJjoGXjKXRfY9Mg4uYN1vZ+UV2WrZQ7Q7D/2svRUwyTXXYLZUBZm0zB8HI
         F1V8i6s9F74GroTnyEeVbT9RsL3ZlM8N90uMX0d04FBcyK8FX5UNB0eUwTShubuzQyVC
         QVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756511; x=1777361311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NxogECpqiNsO+aGXAiC6wMG+jNg2PWSddJ9oGiQTNE=;
        b=EfGTwf/Y2+BGlATt1dc5TjDzTNSC6J9xRlaDwW+2OwtTy9uSlVr9jEn9IH6+y7FY0K
         fB9LGlb938q4oFLxpiUKSvyf8b8oXzCXqN2Ek6VIbVcj9hhiIOGYFxFlnkn2sLWeSe6F
         t/M6iOl1gSuCPDq2+FR7vqfEcCoD5CHhBWj5hsux8wYItG+dds18bpPqwjWwIF1wRq+4
         pb87IaxUTesubvZ2WKzwAipAk3ioR5HlyUiuwTd0zo1FJ23dE03lRRL8Ebfx/7jbOTfd
         FLtd5/tejUqWOGn6wpWngv72oGO5qTkKRmqbKlHhVmJMc45dE5BxayCKCVoRN3q2GNjr
         sGcA==
X-Forwarded-Encrypted: i=1; AFNElJ+8Av102wg7R3V6GnZPOrGyuEweswOsZlbZFrmD09nmihirXYB/4b+3GTs4eGzK0UmwIODHKao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzd7Eqpg1DRO/z7ve0K92hkzrquQMKOOhD9mWRQsNBK901tbHL
	LGC6lrhydOJULtxnZ6GhlTicMKkdUJ+FoljUQz8W+jxgEiMa2VefFw62SNs9tn2l35WaU+xko7A
	1CMOHEjX1Bz/KyyHUyJzUQpCwVGu3G1CH2F1MOVeAnqtHpTTC4EHqlQxk830Hycn4vWrnCe5V2g
	7fW4N4+L3pYeHyD8WtZ50pfIigLsmIaZWD
X-Gm-Gg: AeBDieuAjFUEOhjTkVRzaWMLVb+z9VmgtWIlm6+EJMqKKHhifgbCCj42wU+18n8JO/j
	SgvstKw1nG1812zi+2ddQH/MCwfL2M8Bk1Y+UY5J6Hstldp/J4IdafSpzzBnvPXwjY/5bFD7KQ7
	APfyh8hKUk0dptX83Mq3pK39YT2w0LaksL4bzB+fikhEJJHVxhOIDaHPNGnqdPV1ATX2+0rhQUN
	G/YStBjZ0Uyxgo=
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id 98e67ed59e1d1-36140462ad9mr17177832a91.18.1776756511183;
        Tue, 21 Apr 2026 00:28:31 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0e:b0:35e:5ae3:298a with SMTP id
 98e67ed59e1d1-36140462ad9mr17177809a91.18.1776756510684; Tue, 21 Apr 2026
 00:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416191433.840637-1-decui@microsoft.com> <177672238581.1802062.15838493180057695674.git-patchwork-notify@kernel.org>
 <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB69214CABCA0DCD597040F849BF2C2@SA1PR21MB6921.namprd21.prod.outlook.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 21 Apr 2026 09:28:19 +0200
X-Gm-Features: AQROBzDJwpjJV5oYDv9Ov-Jk-nnVA6bAoKM78g-QgMrimqa9KxhcXRiVCwSyCjw
Message-ID: <CAGxU2F6DVcLDLg3dT5DsDmsaOuhOcD+4VSG5dqXcFRwsN1NZ+A@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] hv_sock: Report EOF instead of -EIO
 for FIN
To: Dexuan Cui <DECUI@microsoft.com>
Cc: "patchwork-bot+netdevbpf@kernel.org" <patchwork-bot+netdevbpf@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Long Li <longli@microsoft.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"niuxuewei.nxw@antgroup.com" <niuxuewei.nxw@antgroup.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Ben Hillis <Ben.Hillis@microsoft.com>, 
	"levymitchell0@gmail.com" <levymitchell0@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,davemloft.net,google.com,redhat.com,antgroup.com,vger.kernel.org,lists.linux.dev,gmail.com];
	TAGGED_FROM(0.00)[bounces-240062-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdevbpf];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 114A043792B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 at 05:13, Dexuan Cui <DECUI@microsoft.com> wrote:
>
> > From: patchwork-bot+netdevbpf@kernel.org <patchwork-
> > bot+netdevbpf@kernel.org>
> > Sent: Monday, April 20, 2026 3:00 PM
> > > [...]
> >
> > Here is the summary with links:
> >   - [net,v2] hv_sock: Report EOF instead of -EIO for FIN
> >  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=f63152958994
>
> Hi Jakub, Stefano,
> I'm sorry -- I just posted v3
>     https://lore.kernel.org/linux-hyperv/20260421025950.1099495-1-decui@microsoft.com/T/#u
> and then I realized that the v2 had been merged into the main branch :-(
>
> Should I post a new delta patch(with a Fixes tag against the v2) based on the main branch?

Ehm, I'm not sure about the process but if it's merged in net tree,
maybe we need a follow up patch.

Anyway, let's wait for Jakub's or other net maintainers' suggestions.

Thanks,
Stefano


