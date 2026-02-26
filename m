Return-Path: <stable+bounces-219768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPs6Glz3n2nkfAQAu9opvQ
	(envelope-from <stable+bounces-219768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:33:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 109EE1A1E29
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 734F3302A7A0
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F7238E12E;
	Thu, 26 Feb 2026 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XRw1Xcs9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DD27FB37
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091225; cv=none; b=oPGbDl72X4CLRHM3Y+1vFkN9XHEdH4vsMtIDqKawNacLKkae6nOjHfXrKHrbYKAb+D/sdzaNwrj/CxvuwJEmlt13aotgWxEPPEVbuqPsCeVDXcawFUMeYYnIlqpXztCj1aVVAqg1a11n2IIeSvt/HnS5sG+SG25gxLErjwHE53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091225; c=relaxed/simple;
	bh=eAD1ZESzfzygQ1Mv5iwydAGldrYIsIgWQRnqB+EGTpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbLC61t0lAYlByGTp+7TYY6VILf4W/O2H40J+RQaDPyDiADQMJjcafsctiO0YRtI/12IRb8O1MimswzejcKhlj6ZSPgBLld7aI1zmy8142XntyWCNj9RMorxYEFiGvPIZuRQ29HNTc5EsISDMSJKSt1QF67d5blE4LaDBvHX6mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XRw1Xcs9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483bd7354efso7074405e9.2
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772091223; x=1772696023; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kEbv/r6Z5V121fpgI9RtZaGhloVZMWh2/Wjp0l5cuNo=;
        b=XRw1Xcs96Z3Il2/XS0QHMaEPvgd3VCxniTWKZIk2KO3E0WBaJtA/pC0yOKf1nBV8eo
         xHNPNYiMQgsDXZKt3V22Ep7ObJ71RURO5vLXlDsGMSNDMMklPmQVonEOPYw42OWHvEL8
         /sM1SXOcbg/ezGaXZJzz0U+ek+CNJOiSlrpI8kzazJfsA0eiBcOwnZZMg/BSk+VunSKv
         44UAfir56UJucuAhe9knwDOPJBJp/P4CmqdRp/AD/yT25KgNDVudmXTqepQfaNqNCo9u
         L4NaM98Q2nUFSNdUWFYddZz8SelGmJZaUOWXv/HYtkfJhdsjUxm/8//TmOhRROrxbyd0
         CYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772091223; x=1772696023;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kEbv/r6Z5V121fpgI9RtZaGhloVZMWh2/Wjp0l5cuNo=;
        b=VNj/9WsZ6sXPm2CeYgf422F28onmve12skM+VHk/DNfYyeOA4DhoTog/ApBmAxQnr9
         Ml2S6attUuDuhTZIK2yHk8Sk0C6Wmo4+hovTKN7IX8hEw6ly6wxGXgpaPQUwne2NlUvL
         ULcn/mm2YbPhyYehJNRAFMlrW3dselAZRVPQCJ6u/WfXfBJHmlbJpu4bIe/GzZMApcsq
         MK1UHme88sKY5YviaGrVRTaR3Ckd1N54+OkwWiGjx0wUG827lH8Pa0PlYbA1SP+faRSQ
         yD3Qw6zBvBmspNRKdMlzy9S+o6S67tOMnlbFK9VJbsehdw28L2qLeVFzJs+NFnJ+oOUA
         Memw==
X-Forwarded-Encrypted: i=1; AJvYcCUiEndoB+wJdxw+gW/a5ARUTTMghAFXXVd4CWw3UwRdtBZ7MD/UztRCkc1B88gwQmVSR1Odgyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JJRC/tWXH8GPj5Dc8JdQNWcQ8HwjDd9cwfr4g10n4tvwms8c
	K8xf9s3Z0AtoutKWQ8US/JVTkisfi1Isu1MiLZNV09AyMV7uPXh6mTvk6d7HwtjMaoU=
X-Gm-Gg: ATEYQzyjA/u3sXBJupcMF4J3rO22MlZf6e/kB60gn8Y4ET7Zt6q3vp+GbSwKn2xc70G
	ywGVrYByeRwCsNPdiYldQ46Tx7RpuhwOUgZItPQUZfQ8WCSjZ5YaqZzh226wSHix6rGCUv2q6dP
	iKskBZi+pkMTfIH3otDs2dnwh32xZp9Z6iOzg2s4EMlok+a8Kqqqc5+HEtOJ2p8gjlNj0/D1mqO
	54Qr09sjSKMxK7CbZNVcJAo7I/YnYqQuDihaA07cNFXwhx9E0ks/sxyr23aLDKC0qb1LeXjqIh5
	mFNeGeNGJDUrMq+krF+pRekQfRy/TtqTv9GcpJAnGDD3YKmo41fyA9Dscwiben/vxry9ZEAtNzT
	XvludXyfh2VF0tjQnaCRo3m53p2JHQXMvV3FtgNjXH6xIolyta++e6/E5tmgyxe00PotD97Fwwq
	+B9+OeJVrTr0jABb1CeFM=
X-Received: by 2002:a05:600c:198b:b0:483:ad56:8d16 with SMTP id 5b1f17b1804b1-483c216ae22mr47028305e9.6.1772091222734;
        Wed, 25 Feb 2026 23:33:42 -0800 (PST)
Received: from u94a ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b03ffsm20566365ad.1.2026.02.25.23.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 23:33:42 -0800 (PST)
Date: Thu, 26 Feb 2026 15:33:34 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>, 
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, 
	stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-kselftest@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: Latest BPF selftests on stable kernels (was 'Re: [PATCH stable
 6.12 0/5] Backport selftest for "bpf: Check skb->transport_header is set in
 bpf_skb_check_mtu"')
Message-ID: <f7n6fetxwo5agf5rn56my2tkepieh6lacg4cnkgt3z7vb7q2gu@jvn4l5uzgxuw>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
 <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
 <DGN6PFT94YHU.3S3UXTP82975E@suse.com>
 <crki45lsdj4yjmz3ix4k5scjuovjr56oexmwhhwbqeejdxh3j2@kgve6uooitce>
 <2026022557-synapse-schilling-e88b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026022557-synapse-schilling-e88b@gregkh>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219768-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 109EE1A1E29
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 06:32:40AM -0800, Greg KH wrote:
> On Wed, Feb 25, 2026 at 10:35:06AM +0800, Shung-Hsi Yu wrote:
> > Cc BPF mailing list and maintainers. Plus other in the referenced
> > thread.
> > 
> > Hi Harshit,
> > 
> > On Tue, Feb 24, 2026 at 09:18:04AM -0300, Ricardo B. Marlière wrote:
> > > On Tue Feb 24, 2026 at 4:53 AM -03, Harshit Mogalapalli wrote:
> > > > On 24/02/26 13:08, Shung-Hsi Yu wrote:
> > > >> This patchset backport the corresponding BPF selftests for commit
> > > >> d946f3c98328 ("bpf: Check skb->transport_header is set in
> > > >> bpf_skb_check_mtu"), which has already been included since 6.12.63.
> > > >> 
> > > >> The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
> > > >> bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
> > > >> additionally depends on network namespace support for BPF selftests
> > > >> added by Bastien, otherwise the MTU in root networking namespace will be
> > > >> set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
> > > >> Marlière for figuring out the dependency.
> > > >
> > > > Note:
> > > > I have recently learnt that ideally we are supposed to run upstream 
> > > > latest kselftests on stable kernels as well. If a feature is not 
> > > > supported the kselftests are meant to be skipped.
> > 
> > Thanks you for the bringing this up! This was also mentioned by Daniel
> > (Borkmann), but my experience aligns with Ricardo's.
> > 
> > > That is not true for BPF, from my (limited) experience.
> > 
> > I do want running latest BPF selftests to work on stable thought, made
> > some half-hearted attempts last April on trying bpf-next's BPF selftests
> > (during 6.15 phase) run on stable/linux-6.14.y, but wasn't able to get
> > pass the building phase.
> > 
> > As far as I remember I ran into issue building bpf_testmod.ko (kernel
> > module) of bpf-next against 6.14, and other similar issues related data
> > structure or API changes. Pretty much the same set of problems we get
> > when trying to build any driver in the latest kernel against stable
> > kernels.
> > 
> > Maybe it can work if BPF selftests that does not depends on
> > bpf_testmod.ko, and build failures of BPF programs are simply ignored
> > (not sure how feasible that is, probably would make Makefile much
> > complicated), so for now I'm sticking with backporting BPF selftests to
> > stable kernels.
> 
> If a kernel test module is involved, then yes, you are right, those
> changes do need to be backported as mix/match of kernel modules to other
> trees is not something that we support.
> 
> We only want this to be the rule for when we have purely userspace test
> cases/code.

Thanks for the confirmation regarding kernel test module.

For the record most BPF selftests probably doesn't depends on
bpf_testmod.ko, I don't think I have state that clear enough in the
exchange. So with some work running a subset of latest BPF selftest on
stable kernel may be possible, just that I have no idea the effort
required. 

Thanks,
Shung-Hsi

