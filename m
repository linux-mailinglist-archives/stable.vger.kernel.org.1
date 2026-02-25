Return-Path: <stable+bounces-219632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCvcJRcIn2neYgQAu9opvQ
	(envelope-from <stable+bounces-219632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:32:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A6198C79
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 15:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3CA0302962C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B47B2820A4;
	Wed, 25 Feb 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzNRPSlb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2927991E;
	Wed, 25 Feb 2026 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029968; cv=none; b=OG+T4QnftMoLPp8N+X6yc9dogBRScdzu1kJKZk6w0MvZPWu4RzYFYnSInKJUYYt3v81Mz6xFJoja3ouqj+IH6RXiudntgrId4VLPQshSkp2omvI+1pqHX8vt/XSTBSAjVB3760dWZ3fKorpV+09QV3rwVdMhtpepQ4pUp76RLi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029968; c=relaxed/simple;
	bh=gdf8pBnOXBOpOoKt0PEusZ3Be9PkpcMHkXIHvimakX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F62Pex1b+qpX7jxlqifa+jbYow7aYFEOkXFYCap9xoUMSjQhPU9tHBW9LCnhKoShVGainqoojztJQ1tOpvrFFDkHFevvPGGMlf6eVFrD1XWy21Ii1zb6T7x5EZBfJTWnKVJcs1G7tOohM7MkYTYF6He37NrhWjkGy1c5CIGfsZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzNRPSlb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7A8C116D0;
	Wed, 25 Feb 2026 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772029967;
	bh=gdf8pBnOXBOpOoKt0PEusZ3Be9PkpcMHkXIHvimakX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzNRPSlbtwEYeX+MNyA/mE9OD29JpppNgF8GAcAfmsLH1BGZjR/yffWOV6dj+YjAR
	 bZW/q0bigJwSk2cdUa37QHt7fbHGQ6XXtZvkXIEXnEeUvWTUmyFy0GfZN93/zsLRQi
	 AEb9QNIlbbj4f3YV2TH/z/LdH1EUSRb2vVKbQrQU=
Date: Wed, 25 Feb 2026 06:32:40 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>,
	stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Re: Latest BPF selftests on stable kernels (was 'Re: [PATCH stable
 6.12 0/5] Backport selftest for "bpf: Check skb->transport_header is set in
 bpf_skb_check_mtu"')
Message-ID: <2026022557-synapse-schilling-e88b@gregkh>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
 <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
 <DGN6PFT94YHU.3S3UXTP82975E@suse.com>
 <crki45lsdj4yjmz3ix4k5scjuovjr56oexmwhhwbqeejdxh3j2@kgve6uooitce>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <crki45lsdj4yjmz3ix4k5scjuovjr56oexmwhhwbqeejdxh3j2@kgve6uooitce>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219632-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D9A6198C79
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:35:06AM +0800, Shung-Hsi Yu wrote:
> Cc BPF mailing list and maintainers. Plus other in the referenced
> thread.
> 
> Hi Harshit,
> 
> On Tue, Feb 24, 2026 at 09:18:04AM -0300, Ricardo B. Marlière wrote:
> > On Tue Feb 24, 2026 at 4:53 AM -03, Harshit Mogalapalli wrote:
> > > On 24/02/26 13:08, Shung-Hsi Yu wrote:
> > >> This patchset backport the corresponding BPF selftests for commit
> > >> d946f3c98328 ("bpf: Check skb->transport_header is set in
> > >> bpf_skb_check_mtu"), which has already been included since 6.12.63.
> > >> 
> > >> The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
> > >> bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
> > >> additionally depends on network namespace support for BPF selftests
> > >> added by Bastien, otherwise the MTU in root networking namespace will be
> > >> set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
> > >> Marlière for figuring out the dependency.
> > >
> > > Note:
> > > I have recently learnt that ideally we are supposed to run upstream 
> > > latest kselftests on stable kernels as well. If a feature is not 
> > > supported the kselftests are meant to be skipped.
> 
> Thanks you for the bringing this up! This was also mentioned by Daniel
> (Borkmann), but my experience aligns with Ricardo's.
> 
> > That is not true for BPF, from my (limited) experience.
> 
> I do want running latest BPF selftests to work on stable thought, made
> some half-hearted attempts last April on trying bpf-next's BPF selftests
> (during 6.15 phase) run on stable/linux-6.14.y, but wasn't able to get
> pass the building phase.
> 
> As far as I remember I ran into issue building bpf_testmod.ko (kernel
> module) of bpf-next against 6.14, and other similar issues related data
> structure or API changes. Pretty much the same set of problems we get
> when trying to build any driver in the latest kernel against stable
> kernels.
> 
> Maybe it can work if BPF selftests that does not depends on
> bpf_testmod.ko, and build failures of BPF programs are simply ignored
> (not sure how feasible that is, probably would make Makefile much
> complicated), so for now I'm sticking with backporting BPF selftests to
> stable kernels.

If a kernel test module is involved, then yes, you are right, those
changes do need to be backported as mix/match of kernel modules to other
trees is not something that we support.

We only want this to be the rule for when we have purely userspace test
cases/code.

thanks,

greg k-h

