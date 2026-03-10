Return-Path: <stable+bounces-223854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLIEGOHxr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:26:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC708249587
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC57317B78D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601344CF22;
	Tue, 10 Mar 2026 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXdZBRDl"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6918444DB69
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 10:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138260; cv=pass; b=s68CGC+y2wMf5MbLKceTm9tb8CNtL5ShCSjzdtRZXDwxHnBH22rzFg9HGnRSGibXi/PuFivNkt6EVmqYnFILdPcvBU7XBekEkC5VYyeqA+j69q1mE4uWlhWJ4m1g+tGdhpaoCmGor+jpqB6mWtaKC2Z/OAHvbS/JTD6TFsjiwiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138260; c=relaxed/simple;
	bh=kpIywL6/B0VmcSqv+O4ei+ncP93YXxlEM6TGb1h4X2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVSl62TgEvueuTRbaktbmUIyndRadBYkKntOoFXAu5O/pzNrxclCLL7YZ61O1b4c934kRT5L4JfK9znQ34Sr7EYwNKEIa0qz4Ze3K3Hjfxc4KjnJ6JdfVrumwyOeBQFjvB1j9FbbGYrrcZPReJubSAIpf7h9ZiIHT34l8eJJtng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXdZBRDl; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2be0711f493so4071536eec.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 03:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773138258; cv=none;
        d=google.com; s=arc-20240605;
        b=i8yUL16AeYEsXJmLQ0G0G0RaIcedAJUo38t9XzJsaeIPVXFEhbxfKZbaJAfYq+bavF
         cL2+WiqSeB8NvwzdUSl2Xxl8WjktMKt9guDLyoyfUJNmxwirwk4XWjwCWAFE+uePfvV2
         hD4lx0E/iGlAW3G2GClMf4Fb4bceybi5PQF8ZlVAkD26m8kWBY6/ci9VV/JS9pcRICip
         tpUMgUveaLexSI7yzg4mvbkb9Z859ZuTvdcGdK6N9VCQNBUSk88mpGNR9+nb0FunjJJd
         hPd8YNxBNhfE2BruoDbVkK2xvn4pZK3DsYrl8BaI+Ii53lrJgmKqbffJ/DRwz8tlEdbB
         TARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kpIywL6/B0VmcSqv+O4ei+ncP93YXxlEM6TGb1h4X2U=;
        fh=KaRjfUwIf/NwFlHRkn2bc/io4LdG22P24d5vHb6xL9g=;
        b=jSMnzcKSjsLyTIdhgvctVfBZGroZoy9nA09rdIPRR8MidIne+nw0Nf+OccknrtuWjj
         2iBKxEVqbFwtRUmpWcQTTYjgs1LT5s65FeCgjBNwzUIHorTon8JGdDC4a/9tTZcSBJRs
         eaW5kPOAYcih/J4X6Vcy6DashrFrhrhiFt8DFX80qyAUYUFfX3gN3JGoGqrboVtPkKjA
         hCQ4lqFU4VFaqEu6+a5ixpvxEVWDf8JbeVrtpakXO7ObJY0AbcL37+JwAeaLnSLOgDTX
         XavNSpkmouYBL3/lf5u6sJo9J3KnPAB7Y3zHfJuderjoBTlnBwhD7GhbjI9QdtJvG0Cg
         Dt5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138258; x=1773743058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kpIywL6/B0VmcSqv+O4ei+ncP93YXxlEM6TGb1h4X2U=;
        b=CXdZBRDll9jZC5niXwmNOougpV0dzX1LM+cI4YJssmFY/TB9YJObzBmU6rugUNxwRh
         jYPxiEr+svQaldC5u/YQoStX5m2tbFCsZshRrHkG7B2Rh6tW7wqYyzPwO8rs92PfB+Ta
         INwR4TdOHpUn4aPYSbyvOkbkOkUvNqwZG1wgLASNZpg2RBxe3/hM3ABGjuVNby7EExyE
         C97E1LqE3xBa8DM1Zb/eKCG1XOn4kOBvZ5wzmxAk4H424DnAOa+sN+CisEs5fMCCxfsW
         BhI6w9rWoBz+DOgALeyL66yEjUQHE8PE/dHnP3a4DF5QxUPmLuLA+w4/jVJq3YJFRZui
         lHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138258; x=1773743058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpIywL6/B0VmcSqv+O4ei+ncP93YXxlEM6TGb1h4X2U=;
        b=hkwUGE9IL1/lRW85BstJqo346HTEIQeGqlrWNWVmReM3V3JgiVBumPSoL83EmHZrs7
         HCLZHLnC1qZ09ERsNrWnESPVDwzlUDUqtvZgAM7AlzByddLQIAsyAhwB3lJQQ35A3vNH
         SF/Vldeh7s0PDVQSxjLfzP40KpQdEB3xvu8wGmtt6ymp8mJUZ01TghlNiipcuwgQOBQP
         2f3IOqp0fXQC4y4CnXJLhjbchD12XJEblE+sJCeTlscj1HNqvKN25cRQMJBRlwlqJdS5
         ZN192ktyLFUJVEpWR7Vo4ngHUb5obISk/nI9tapMLB7fZUuSRj2hKcr2Tsw9uKFKuT3t
         LUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEEVNB3bCGK9TkS8zuUDZWN18M7VoES+BeqzsRx5mp+Ob0x3YBlucTQH/1zINgB6KXT4Qe3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6XB7eVlICBoYELxhrAFWVo2Kgc0ZcupQ8BTi0aSk8Nu6PHjR1
	tkfpbp+r/alInMAOh5LLOZMF2SiGg01ncIQtkQigas+h2KLmXGFNC40ud09MoxS+JsqVMNVWIPz
	XkozG3xg7GHs06ei6cwt6dT+GHghPsxCikNGH4rbxvCms
X-Gm-Gg: ATEYQzyIe2YnzMBv2XoI4Z1PKw1+KZGgKUufGi5POCW/fXOY144L6rWXSo2ma3+uMyU
	mR2FKNO5G/tVNHeVvosbIP+wlvQ3m6s585pcZdJgmmBR9vZx8wgX0+hDVhv6BMHrqHLtp5GrQUR
	IuOqlamau3Oeosf1cLv45d+X+jPwtsCJTtONzJ/3RbkVo8O/AOA+etNP2fkZz3GaY9U/lySEuKw
	DjhSOmbLQYRGdx2S53nimJSMi75DW9Z10EEIDCnRAhZpIELkAUqh6Z11MTlkpYcQO8L61I/6m0D
	XTu5cD+d5kcA7EFXNriMDmWpkaDKz06Vg6ekNkxasnTC910YW0ri
X-Received: by 2002:a05:7300:8810:b0:2be:69b3:2de4 with SMTP id
 5a478bee46e88-2be7a0b02a7mr855584eec.6.1773138258338; Tue, 10 Mar 2026
 03:24:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306140332.171078-1-jianhuizzzzz@gmail.com>
 <20260307143542.179953-1-jianhuizzzzz@gmail.com> <ae1bd46a-c5b6-4b74-b861-eefca84979ce@kernel.org>
In-Reply-To: <ae1bd46a-c5b6-4b74-b861-eefca84979ce@kernel.org>
From: Jianhui Zhou <jianhuizzzzz@gmail.com>
Date: Tue, 10 Mar 2026 18:24:57 +0800
X-Gm-Features: AaiRm523sIf-ybDdxVnbdZHg6GtAPEP78OhXdQFf7b9-RPc2RAly0CqnAXnY_xM
Message-ID: <CAEgWzV6ZzVY=vz5=v=pMWYkanzd9q5XtRRjo35DHtCxrS66Nrw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/userfaultfd: fix hugetlb fault mutex hash calculation
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Peter Xu <peterx@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, SeongJae Park <sj@kernel.org>, 
	Jonas Zhou <jonaszhou@zhaoxin.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EC708249587
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223854-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianhuizzzzz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 05:47:26PM +0100, David Hildenbrand wrote:
> It's hard to put my disgust about the terminology "hugecache" into
> words. Not your fault, but we should do better :)
>
> If you're starting to use that from other MM code then hugetlb.c, please
> find a better name.
>
> Further, I wonder whether we can avoid passing in "struct hstate *h" and
> simply call hstate_vma() internally.
>
> Something like the following to mimic linear_page_index() ?

Agreed. I'll add hugetlb_linear_page_index() in include/linux/hugetlb.h
with hstate_vma() called internally, and keep vma_hugecache_offset() as
a static function in mm/hugetlb.c untouched. Will send v4.

Thanks!

