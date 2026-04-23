Return-Path: <stable+bounces-240448-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOp1MAnn6WnxmwIAu9opvQ
	(envelope-from <stable+bounces-240448-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:31:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 596E444F9F3
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC6EC3039812
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 09:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9D3E3DB5;
	Thu, 23 Apr 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j+HMv0Vd"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329D36682A
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776936553; cv=none; b=riPot4OYnjFaw9ylJuPQx4Rz0deRZfuBSHWZRdyv5cudqhKaaCA4WIdNYsXHn3Ld/CPmd6VVduhJcRy5YOwYffinTn+KzpX+BC9ocYZho+NWSqpROPK2dGFY0MOwp5K17Ikk5eYAw4NvdLjsGuqZkNgjfzVYUkl/DKwrumjwluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776936553; c=relaxed/simple;
	bh=GEojIYOirnzY4XB4TS8FhRxgruQ0ZVW9LyRhvu+i+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6f5HzVrEyeEeZVKiOYmdNGr2JeDUFNZSjgg59RojssrgiR67bY8uByYL7ZD1pDGRxEVRR2eTsJ1b38/gngRSJ7qrH4A/QRcSe2FySPYiXQ/8s4MVvtam5r6na7ivsqicvrww+yUJ6eYDVLW97T/nKaArlXlpb9HHnwmbRc1SYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j+HMv0Vd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso49722a12.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776936551; x=1777541351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BKpJvW7DhMmQGBTcK6buF1FQEMkYscuj/n2ufvkVhMQ=;
        b=j+HMv0Vdcks7nTfJuSx4forfCW+J9rhkYnCdryV2N+j0gjPHMRA5hMH1I4jRghI1ea
         HUlqb1zHGVJdyaARdaDn2kpCzVELxoW5bMZOlCafBOhXdFxMTrsmDGgxe7vPXgc+YoD4
         qC+TLPIzpLodyOIu8AbHuV82V7AkqBaHb7l5pR09g9blOsOAFztvuXiOpv6vJp9Oi2B6
         F6oh2MECtW9cLNbpTDPKk9uQg1dr6wjV6PHdBWNBSasKqv1GazOnRle9WiKbpypihCil
         RldZRpumOVngDR3t/fT1+jbPZU9kPudnvEMObdOLnR41t6rUitMbOTXIB0dY2VlndpaY
         SNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776936551; x=1777541351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKpJvW7DhMmQGBTcK6buF1FQEMkYscuj/n2ufvkVhMQ=;
        b=Jak3s5QK7WBR9BL0lMAYF2P9bhbn5/Frbv/KVGy/XGpO9Wve9PS7Ih80EEa/HzmXu2
         RjShFy9vn5CkOqVsRSoui0UHrvIL8OhbjjCbEtsCY7NnGDP+aw56gpqBcLX/fmddb07L
         ytikL97NRz+C5LC6i4qikwVV5DVhyoVJVqF43uQBWl6RK8QtGrciTtmEZ99D0zXrho96
         L/1ljJqcGMxQ38axeE+4dKfGzcJSlJVxkabPNjYSyrerAvvZwHL3sRy2V0YnTkiXWDuX
         06B5nDxTCcraVmcSqSaUCyp0Vuf4zEnCEha5EpY9aaAGFmvCwcokZ2nSmoVIwhaNeySD
         SiVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9VLd/RPvjf9RSxlo8/YOJk6LXc50T+ovTCun1nb3fxWgMpZAsPfFvzX6F5gMDsfjFRSWKQCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/ZqxK7rbw0BI8uze7rHOkAuQ+ddBcazNuLR2dhpQT2kSTK71
	uVvhvHVfkRkl4zx47+v4CVEuNIaXU5h+wTISUN83oYB11wncIOeAk6olNQoMeSam5w==
X-Gm-Gg: AeBDiet4bwOfMP82m31m0sCRO3hzBLr/Wgz7Dn7SNTSrZD1i3K8z2rNT0DmSUnXKvas
	TOvtlzi50BZApn37p88n0a01q8j7s+puAJvaQfomqKw+52Nq8ixkDqz2A/Gow8VHjXL+uX47LG0
	GQ1NQUevcJLg8JyRQrWah6blbpsyuaZ09kOtFSpkYQhBpOl77mwI8foAG6lJdQ4kdk8M8ocTt1F
	8Yvl1dlmume9HtvaEpadkJT19Hvz4nYcRKQ2sdnMB5jwhB1q9TqQXfDcjJXury5TP91VuJcTwmn
	zfjcAQBTjZy/Sb8ecFA4e4S9Y73FWnXcGpYS8fz7P9y9UtmkLKqiMqC3rJpJiz+1TC/PhUyymqQ
	5WnEOkJJJ82Mt0DBcgXp+v2f8PvvbC9qSdDA15+684N7ii0mg0MMh4Otwt4UhdZTdfYex7i4/YW
	X0h43VeGStBKCboTo2QJODWOe6ebDDXjtAj2Q2sRK20lo+T4J6com+VWtFaOu98w5Kr9IU6n69B
	u2UKnIxglxqRaLeNSc=
X-Received: by 2002:a05:6402:902:b0:670:7177:94df with SMTP id 4fb4d7f45d1cf-67440714a81mr250309a12.6.1776936550235;
        Thu, 23 Apr 2026 02:29:10 -0700 (PDT)
Received: from google.com (117.15.199.104.bc.googleusercontent.com. [104.199.15.117])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d5babcsm3890524a12.23.2026.04.23.02.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:29:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:29:04 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: oupton@kernel.org, will@kernel.org, ayrton@google.com,
	catalin.marinas@arm.com, joey.gouly@arm.com, korneld@google.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, android-kvm@google.com,
	mrigendra.chaubey@gmail.com, perlarsen@google.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Validate the FF-A memory access descriptor
 placement
Message-ID: <aenmYK3Y4XcqkmI4@google.com>
References: <20260422102540.1433704-1-sebastianene@google.com>
 <86bjfb18v1.wl-maz@kernel.org>
 <aejOu98q1lEZoFfW@google.com>
 <867bpy14kx.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867bpy14kx.wl-maz@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,arm.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,gmail.com,huawei.com];
	TAGGED_FROM(0.00)[bounces-240448-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastianene@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 596E444F9F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 23, 2026 at 09:08:46AM +0100, Marc Zyngier wrote:
> On Wed, 22 Apr 2026 14:35:55 +0100,
> Sebastian Ene <sebastianene@google.com> wrote:
> > 
> > On Wed, Apr 22, 2026 at 01:24:02PM +0100, Marc Zyngier wrote:
> > > On Wed, 22 Apr 2026 11:25:40 +0100,
> > > Sebastian Ene <sebastianene@google.com> wrote:
> > > > 
> > > > Prevent the pKVM hypervisor from making assumptions that the
> > > > endpoint memory access descriptor (EMAD) comes right after the
> > > > FF-A memory region header and enforce a strict placement for it
> > > > when validating an FF-A memory lend/share transaction.
> > 
> > Hello Marc,
> > 
> > > 
> > > As I read this, you want to remove a bad assumption...
> > > 
> > > > 
> > > > Prior to FF-A version 1.1 the header of the memory region
> > > > didn't contain an offset to the endpoint memory access descriptor.
> > > > The layout of a memory transaction looks like this:
> > > > 
> > > >   Field name				| Offset
> > > > 					 -- 0
> > > > [ Header (ffa_mem_region)               |__ ep_mem_offset
> > > >   EMAD 1 (ffa_mem_region_attributes)	|
> > > > ]
> > > > 
> > > > Reject the host from specifying a memory access descriptor offset
> > > > that is different than the size of the memory region header.
> > > 
> > > And yet you decide that you want to enforce this assumption. I don't
> > > understand how you arrive to this conclusion.
> > > 
> > > Looking at the spec, it appears that the offset is *designed* to allow
> > > a gap between the header and the EMAD. Refusing to handle a it seems to be a
> > > violation of the spec.
> > > 
> > > What am I missing?
> > 
> > While the spec allows the gap to be variable (since version 1.1), the
> > arm ff-a driver places it at a fixed position in:
> > ffa_mem_region_additional_setup() 
> > https://elixir.bootlin.com/linux/v7.0/source/drivers/firmware/arm_ffa/driver.c#L671
> 
> That's an implementation detail, and you shouldn't rely on this.
> 
> > and makes use of the same assumption in: ffa_mem_desc_offset().
> > https://elixir.bootlin.com/linux/v7.0/source/include/linux/arm_ffa.h#L448
> > The later one seems wrong IMO. because we should compute the offset
> > based on the value stored in ep_mem_offset and not adding it up with
> > sizeof(struct ffa_mem_region).
> > 
> > Maybe this should be the fix instead and not the one in pKVM ? What do
> > you think ?
> 
> I think you should parse the buffers as the spec intends them, without
> assumptions or limitations.

Ack.

> 
> > 
> > The current implementation in pKVM makes use of the
> > ffa_mem_desc_offset() to validate the first EMAD. If a compromised host
> > places an EMAD at a different offset than sizeof(struct ffa_mem_region),
> > then pKVM will not validate that EMAD.
> 
> Why compromised? Isn't that a perfectly valid thing to do? What I
> understand is that the FFA 1.1 implementation in pKVM doesn't match
> the expectations of the spec. If that's indeed the case, pKVM should
> be fixed to accept these messages correctly, or stop using FFA 1.1.
> 
> 	M.

Sorry, what I meant is that a potentially malicious host could abuse
this limitation of the FF-A proxy validation which is looking at a fixed
offset to do the EMAD validation. Another EMAD can be placed at a
different offset and it will bypass the validation of the proxy
alltogether.

We have two choices: the simple one is what this patch does (enforce a
fixed offset) or the second one : patch `ffa_mem_desc_offset` to use
ep_mem_offset instead of `sizeof(struct ffa_mem_region)` and validate 
the ep_mem_offset. 

> 
> -- 
> Without deviation from the norm, progress is not possible.

Thanks,
Sebastian

