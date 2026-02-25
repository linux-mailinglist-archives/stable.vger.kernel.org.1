Return-Path: <stable+bounces-219137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKypMPtfnmmaUwQAu9opvQ
	(envelope-from <stable+bounces-219137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:35:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70E190F23
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 991A930626DA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA07D2882DE;
	Wed, 25 Feb 2026 02:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TKrWrN5Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529A288517
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986919; cv=none; b=gBkfsh00ATBi24bM+Ku7hkwl4TYW7iGHZXUi0Pf/0MQEvLpnlpNqYqudxnQ5QJ67x6T6hvvQO8JMA8fbUNwOyBrpls/c7xY7Ec85VUfF6Hex5J5GfVq/zPozLxfk3B9MOT2uS3vsh473ucR2ObkSTAenEufiF7sPrBANAsKL9O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986919; c=relaxed/simple;
	bh=3KsyrKI8a8WuOUPKHlBrtGyhseDhoopScvHffu8IHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTUMlWz3HLQrBNNjFO7kXMG8enK8kks4PXuIAsmYjN0yXJRlRcRryUuGK1/eSLP0d6g7m8zRpMYECkr591eI0j4VmaCOpfL1802VBvOu6++rij5gRh7Oofp5eWfvFEp93fR/4zvI9b5+ohk19q7xY2ZlV+OemXbnByntR3QJg+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TKrWrN5Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso46542105e9.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 18:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771986917; x=1772591717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZGXshXHvJclcEjfMwGDZc/q9vZTX8b4lXQsjlQbCew=;
        b=TKrWrN5YNtYPsF5PHq2uYQ/UnRKcyCqlrTS6ECQmnNPFwL/ekxFEH0MATp0F0N6hDo
         aW5iou+mmYswDSBixQ6Yi5cPNWq7DxSSNXZqABJFDIIkzLKHvsV+fyZ20M5sWgj+jjCC
         ptQuXNmCJWsg2qu6y4gW3SOILyXBP9Uokih2pWVdxE2ImzMJiBEVMrEbYCRqLCs3XJiX
         xX/FANsOu+j9ZOrWdUkKZoyDzLM9pKJYEtmU8hQMO6LaSE2s3piBGHyWrbEm9/u9DbQ5
         up8OV9T3CCiSmdR35GdOPfSr7Yijaf2iIeQCmFYxpbtyCcfQzNhyUBEcjFAk588bo0nG
         6i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771986917; x=1772591717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZGXshXHvJclcEjfMwGDZc/q9vZTX8b4lXQsjlQbCew=;
        b=j1HfYgnYmNLhcbJUxDjWmPcZG3tpOofTDTvPHU7JZzOU8dMWamEYvTP9BWFSM7jPYx
         x1vZAwqP9KtWxbrfVLevIjpRJ6IB9hsLQPJKZasksw0/fwBcLWQNIKmySkNKf9acsQKD
         zRySJHkLgaQ/SNL7qgd0BlsUEt4CKQgS/eZK3PcbQa17uOoj51kYZykXwFS9J0+TXiis
         gTPuCpU8goQiVVK2rhU4Zn6LW9Y5lSj3VoYZhxoV/89I1RJ4ulx0zAzpGUp4QiBjBD/3
         RlGzv//KDuIqHqo2egeadNDinjatwv6uYk672wIi2IdCcFjWZTMjdV3Q3ra/yitDoi5Q
         uVJw==
X-Forwarded-Encrypted: i=1; AJvYcCWOzcFuOGyKs9PTM+BKmE4WBl9NZoxUtJt/6cXOWhpzNzVWthYwDe0/BCF71C+XNjHie8bUxtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuymWxZjjb+/mRi78goalCZoqBU1DmXWuFmwEmnTZYF97mUGm
	D9nO6w2LugeaE7JVESneZcZ0Cru6OxSeDjW0N93pcKW4xVkgE+ABWQMbb5TE8LkBuLc=
X-Gm-Gg: ATEYQzwdXizkCVfcx4KzvNZs6eUh137+j2KZzdcuiyGhw0fvfbxjjw37Uedj9MAsw5J
	GkE/676d5lkWBLhY0hJ1mzLXNCYwKDvbJl6Ao0IlIlTmkZ/AG81bx+22rOrmbWElGQrhW4hPrby
	5sCinAeiX5giRPzdUg9DIAlTg/dZ9OdKNHQPgjkwnWCZsTxahhN84HzOHr9IzVCSfqKgo30RA9c
	ieGb/50KXROxzCaQf8kDuJcJ3Q3QMahKGW7v+UlSLD7B2Ugv/8HvgC0UEDA7TyiReiVwx7NiQId
	RccBsr29njjMogTSj5zbBrBKrblrx+lCFbIBMCspFqPdqaXXxzwkLCPIstO67/DUL961ohik5iD
	evVKNiPlYf/88AfMenBErnnE+PVPB9qjW+Gh7O8aFH+Ln/hhWZe/Evy67CSfJ6EBNlrxrm7Lb9s
	9gDB4GLB4iCwFdkdrKvvY=
X-Received: by 2002:a05:600c:4f95:b0:483:8e43:6def with SMTP id 5b1f17b1804b1-483a95e5a97mr217123395e9.28.1771986916668;
        Tue, 24 Feb 2026 18:35:16 -0800 (PST)
Received: from u94a ([2401:e180:8d80:eebd:d098:7649:31a9:9ad7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7244dadsm12268836a12.20.2026.02.24.18.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 18:35:16 -0800 (PST)
Date: Wed, 25 Feb 2026 10:35:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, 
	stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-kselftest@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: Latest BPF selftests on stable kernels (was 'Re: [PATCH stable 6.12
 0/5] Backport selftest for "bpf: Check skb->transport_header is set in
 bpf_skb_check_mtu"')
Message-ID: <crki45lsdj4yjmz3ix4k5scjuovjr56oexmwhhwbqeejdxh3j2@kgve6uooitce>
References: <20260224073810.85945-1-shung-hsi.yu@suse.com>
 <bd0277b7-4a19-46a4-9f06-96d48cbc89d8@oracle.com>
 <DGN6PFT94YHU.3S3UXTP82975E@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DGN6PFT94YHU.3S3UXTP82975E@suse.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219137-lists,stable=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2B70E190F23
X-Rspamd-Action: no action

Cc BPF mailing list and maintainers. Plus other in the referenced
thread.

Hi Harshit,

On Tue, Feb 24, 2026 at 09:18:04AM -0300, Ricardo B. Marlière wrote:
> On Tue Feb 24, 2026 at 4:53 AM -03, Harshit Mogalapalli wrote:
> > On 24/02/26 13:08, Shung-Hsi Yu wrote:
> >> This patchset backport the corresponding BPF selftests for commit
> >> d946f3c98328 ("bpf: Check skb->transport_header is set in
> >> bpf_skb_check_mtu"), which has already been included since 6.12.63.
> >> 
> >> The BPF selftest added in commit 6cc73f35406c ("selftests/bpf: Test
> >> bpf_skb_check_mtu(BPF_MTU_CHK_SEGS) when transport_header is not set")
> >> additionally depends on network namespace support for BPF selftests
> >> added by Bastien, otherwise the MTU in root networking namespace will be
> >> set to 10, causing other BPF selftests to fail. Credit goes to Ricardo
> >> Marlière for figuring out the dependency.
> >
> > Note:
> > I have recently learnt that ideally we are supposed to run upstream 
> > latest kselftests on stable kernels as well. If a feature is not 
> > supported the kselftests are meant to be skipped.

Thanks you for the bringing this up! This was also mentioned by Daniel
(Borkmann), but my experience aligns with Ricardo's.

> That is not true for BPF, from my (limited) experience.

I do want running latest BPF selftests to work on stable thought, made
some half-hearted attempts last April on trying bpf-next's BPF selftests
(during 6.15 phase) run on stable/linux-6.14.y, but wasn't able to get
pass the building phase.

As far as I remember I ran into issue building bpf_testmod.ko (kernel
module) of bpf-next against 6.14, and other similar issues related data
structure or API changes. Pretty much the same set of problems we get
when trying to build any driver in the latest kernel against stable
kernels.

Maybe it can work if BPF selftests that does not depends on
bpf_testmod.ko, and build failures of BPF programs are simply ignored
(not sure how feasible that is, probably would make Makefile much
complicated), so for now I'm sticking with backporting BPF selftests to
stable kernels.

Thanks,
Shung-Hsi

> > https://lore.kernel.org/all/a45eaddb-9e17-4e82-8a78-a1d1f6e3d735@linuxfoundation.org/
> >
> > Thanks,
> > Harshit
[...]

