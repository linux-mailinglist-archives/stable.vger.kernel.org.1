Return-Path: <stable+bounces-241740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NzZLwrq8Gn2awEAu9opvQ
	(envelope-from <stable+bounces-241740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:10:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25326489A7E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 19:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AB5730E77A8
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 17:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6E33EB1B;
	Tue, 28 Apr 2026 17:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohuwEu2z"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6455233D6F8
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395832; cv=pass; b=gIjVDQpN8hItqoDyzO7okgKr1SbaLsILFQaIZ9tc3QYT9eEIvM693JCbW2oXPBfp86wyI+wcxXbZbBcW0N5FVXdq4z0hVpYvb36SdlD5s7OeWAWNhGcQbzChw6lHND+d5jmwQEX8un8uVcRHDsV5ubLckcDCxn/cFcozwd52aEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395832; c=relaxed/simple;
	bh=1zJiD6uVVjfJZKq1rBMnu25vKAHnwzgWRAcpLmQwMq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQ1GVRcFGeOMddF6PjprXlxYUtYlkAyg02fiXJJxnX98hRSnPiuPG/X8miHGF1yqFnXE6PhwoYmxoQPds8hP/Cwjm2JHRWBxw/mTbRwzIeVRWRfVzgPV7CkqbGYglKJvamp9kUx1LnmszRjTgljAJSzswwIJ7K/cBZU6q07tNZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohuwEu2z; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d836552daso93361cf.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 10:03:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777395830; cv=none;
        d=google.com; s=arc-20240605;
        b=GdOr0w6H5hlklKcaPpysCzTsEAtPs7Q5+m+bcqAingKqp1x+DlXXQslMc9p0ocnLMC
         LU8tmHaG+i+68+CwdhtLlQ2SJGcxnd8VcQ2NdDjUSMKRDwZJdChUXqWCkcjD85L6JygX
         hq1j+GSxez7sBZRztsQPZFvvCeyMPfrjE/g4YVDmaPD/+bRyVwN+Uy1iz6AEny5MRS/0
         arTo5gh6/aBwqozcVExXiZfiM1STHhtSJm7JFpJUpWecszBrgkVhUVrj0y8YMALBYcRW
         GOOdm8IPOV16R0UvDDiICPO4A+RrUvGrD77W8cFxptk+EwJo4VlZ5NZ4ruzMbte1wxfG
         qcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vRxyUyWR/bvwIckxaxOIFLoCtm5E8wIRuhM7yIvbG+w=;
        fh=JAduZ3E3L3RBZuLec6OFGfIx/8WzXWgaTxlycCbN2Xw=;
        b=AhNMwhTPh1KvDdFzC/KEZMV3aRNuP4ABtG0gRQ/X4Ve7NbgOPZm5PVBBh9QY8WvQPB
         FjOD3VEL/tJ8STAVypmNqqQmeyDNZe7mnanhhZooJ/uOQVhZVY9JmV08V1fAnhtTkjq7
         zTMkgXBbKhj1DEXHcDcpluvJCkmiStLe4qHEzZ7lnQUMlfOxDHsVFh8uQDuxj686pgu0
         8L81pcjog5PKdZziPuyZ3aCegbDgL4nvKRc8idFz63LRDpXimuZ0XvfsdwASxR8AUilG
         az5RgYeLWSsk9jAnk3e1ZJoO9yLknTOfkOu7WKAB1z9MvkHNkrg9nrFpZpMuttDKqsi5
         Gf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777395830; x=1778000630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRxyUyWR/bvwIckxaxOIFLoCtm5E8wIRuhM7yIvbG+w=;
        b=ohuwEu2zuoLanOj4J/UNFKWZhpjBIA4hCMjV6RLRSVPnEBuDdEMyUBc8la3+5z3JX6
         +vAU5AphcxsjlJ5UJhhtbpBu2bdahnUzZiz0fNsJ6Y0VQY9vmQT+9fEU0jtwXXnXscS3
         /qC839Rs5he1T4nP1aY7jgiqYlHgiyBq7DR0qKvHagxjxs47msoLbw3OkBDdnqw6jP2l
         Atps4z+w+5Q7fifUmdijHiBOMSt551FUN6gqOW0piFYTUIGDUBcuAs7SER1/5quIgOwd
         IWXAN1qUKfAVaOEeHUAovxKIKoSiZYpRYU5icJ+N2qM6F8CYp3l1wLM7ZaENMMC2fZDW
         FiSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395830; x=1778000630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vRxyUyWR/bvwIckxaxOIFLoCtm5E8wIRuhM7yIvbG+w=;
        b=W+MvrQFDKty+Ynax23hZTfJ8VeftYopzovfzYtEMEmM3Jb8wvtDU2RfomySW7MFTnv
         DrAjocGkJn0Nq9Mo1TPalPK+2qHTfia2mI36YmdEfqYtYY08OEBT7onv18XKL6jSAdPj
         jIl4u57TGGeQiG40t3wpgLgGTI0uCYme/M2fjsPlze4W9Iw/eotQO5igZcdabD/yscpf
         HzxnucZiLWdF+xGtTO7NZqHh/NmyeaWo67vhcU1NOz0XO0sGx7WHStN3d4KZhC7FGEF1
         Jlpdz7bVGocnvuKH69cwDz747VdqSBGIbiy4gnYv6q8AjTw6gEdNPQ9l4EPr8s2cs64q
         G6Lg==
X-Forwarded-Encrypted: i=1; AFNElJ/sWQI/WeQKyD0jKdXVDPrPrYGSSpTbL1cQB85E18PO1sAjvdSLt6jvjFFfivhgg0tZxF1Lkr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFuij6rN9dbJc0lwk3kH/2FsVoo5Izxfj9hWB4jA8uPLBuOk3H
	EuMNlppYeijIti2eW4w3x+atvIXNF0uaCaEN2/2kxmb2dnWVsMhx9AcmxrsW4ZnQBFdiUl4HL44
	AdEA9+3fMHI9TXuscv+xz4XbDguhbPO9vjSjLN2MP
X-Gm-Gg: AeBDievaz4FBno9Yqw9qcZbP9nMJEvh4DERGfSSg6CjNgMgywWI2E1b8+7e8UDXJJ1W
	IsRrMp5JfsnxaYmI+1yKw8ciBhJ5fBN+CeF/a/01qYg1mUY7XQpFNJ16sdSj/ZmtZHIwenyE+le
	WImSJoF1hCPVog8mxvVWEixghi8NVM71g9Y0C9ZJevw9D1HqojpxcePh7WCO1iS8yPZI/3XIBP7
	kbXsXh5s7KX0ExOFshZAl7y9oH3y9GPJz4cKEr8WaQn2We3ADpObDclUJwNvHxo1VmUuPZ3G1TI
	wxr4t4vzgrIZPEV25kHckyyymyrlUUBo18IQPeuI04l2YdVNQGIAJw+vOrmiBfg=
X-Received: by 2002:ac8:5dce:0:b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-5100ddca71dmr16116641cf.15.1777395829071; Tue, 28 Apr 2026
 10:03:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428103008.696141-1-tabba@google.com> <20260428103008.696141-7-tabba@google.com>
 <afC5_jrTEVRfJ77x@willie-the-truck> <CA+EHjTyTy2qLm=CbOOYR6rmjg5tH38PifAV+qAhbZxidY5szxQ@mail.gmail.com>
 <afDnCiQNJrP7UI2m@willie-the-truck>
In-Reply-To: <afDnCiQNJrP7UI2m@willie-the-truck>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 28 Apr 2026 18:03:11 +0100
X-Gm-Features: AVHnY4Iz1X_G7zdc-Gxn4ezijbkjPSVmpE0EY2ldntjmUXB-MEgat-SQsLz5Onc
Message-ID: <CA+EHjTzO1=LvBF0UFXu=ubO_-TezykxLap9c8CxxvuCT-=3SUQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] KVM: arm64: Propagate stage-2 map failure on
 host->guest donation
To: Will Deacon <will@kernel.org>
Cc: maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, qperret@google.com, 
	vdonnefort@google.com, catalin.marinas@arm.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 25326489A7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241740-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, 28 Apr 2026 at 17:57, Will Deacon <will@kernel.org> wrote:
>
> On Tue, Apr 28, 2026 at 03:36:43PM +0100, Fuad Tabba wrote:
> > On Tue, 28 Apr 2026 at 14:45, Will Deacon <will@kernel.org> wrote:
> > V2 will drop two patches (in addition to the HCR_EL2 one), and will be
> > as follows:
> >
> > 1. host->guest share and host->guest donate (kept, rewritten): add a
> >    memcache-sufficiency check during the existing pre-check pass
> >    (option 1) and return -ENOMEM cleanly without touching any state.
> >    Restore the WARN_ON() on the subsequent kvm_pgtable_stage2_map() =E2=
=80=94
> >    with the topup precheck it asserts an established invariant rather
> >    than ignoring a reachable error.
> >
> >    For the single-page donate, "topped up" is
> >    KVM_PGTABLE_LAST_LEVEL - vm->pgt.start_level (mirroring host EL1's
> >    kvm_mmu_cache_min_pages). For multi-page share I plan to use the
> >    conservative nr_pages * (LAST_LEVEL - start_level) bound and flag it
> >    as conservative in the commit message; happy to compute a tighter
> >    alignment-aware bound if you'd prefer.
>
> For now, I think we should just check against kvm_mmu_cache_min_pages()
> because that's what the host is using.

Ack,
/fuad
>
> Cheers,
>
> Will

