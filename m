Return-Path: <stable+bounces-222807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGv2FsSLpmnMRAAAu9opvQ
	(envelope-from <stable+bounces-222807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:20:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA811EA109
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEC9C3027D8D
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931637B01B;
	Tue,  3 Mar 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u4IEnihx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C2285C8B
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772522426; cv=pass; b=ukhzRiWtDqfDVSZwLdS1LN9ZtUQ9VY+iwcVMzxc3j5JdXmDLvY2QY2tZ/p5UGxkek9UdBVd6syKD45iGkm/dGSC2OpiuyeZs7TxAV2n7FnJSlQt9tQutttzJ7RZ66dVGXZwh7ycdBqNRA7g4+2cyPy3Va2dJ5QqcTxbHwrTpXOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772522426; c=relaxed/simple;
	bh=0BDZORDXeE++xmAA+73lTxuCVoH3yPAtI8Z07A8LRJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5I6aI1N4HuOTWlQnv695qlBZiIBAqQcLuXtQEc7lr3+j2a8zn4/Raak3Gzv22Xk9o4duRQG+g+BFhXCOO+kW9L1z25qQrR62eJRFVZCtGlwL8OUCBpMgaAZpTuPJjwbXuiAHweThiof7aG8vP1Nbd7SdfD7arHkTKj1Kx+8F+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u4IEnihx; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65f980cea07so7578109a12.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 23:20:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772522423; cv=none;
        d=google.com; s=arc-20240605;
        b=XSb0ffDTsv9k8n23OzXfccj0GupxhmW0Og3mx14msgTHeMcUidRf03vyaIhTwKcxUE
         1T8RPlqbg4+QqGNq0V7NTFgYOQd5C4Ll2j9QE2jC+DEVcPtyRq8auf94qNJQDPMfRWa6
         SodPf7o+hQCRApP82aNQncCdKIcdPBB49t5++khtFiq69X0T+AXvI4GVUus2hAbO+DWD
         xsMwogDDf+wBcPV34N/b1y2gai525aTi0J+6D0ybCxvVTuNDENk3w/1YHhG5NjnRu+do
         xKx56bNYINvdIYHE55Gwzv0vXOGLk2nncGS//Vn/KvI6sGmlQT8zDC1HkWGKPNdXTeUK
         /kZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VVdYil7W0i9u77JXtm0StCzUZz4J3OdCK1AwKZIzaa4=;
        fh=tJOpt4Pske0uFiD8WdtTHS6VEOU6DjLND/81yzqmbSQ=;
        b=TtdrFtqD8fnAx3PJblqlwALqQu8qVJ932Af0QfJfFvX3B32nasmOaItQCp7jAbMPdT
         fLNBLBkXHmOmsgu0mJnuhE5RJsAcb5H/LtoIBdEeUUnCPPc1DcB5fXIzZCv8JCoHLUZ3
         kZBPUOd874d94cEZuEBWMVjYwXuUsiyTInz5ykpp+4CAiYGzNu5+HgFlxOVhSP7DcmWN
         oftPEAmk5x4NSYqDRQ/MP9ca3nuBvKKinNSkjMfCfX07L2oOijU6/tP80zIgaP6cv/zY
         hwkx0+3hsS/GtlRHWBfYoiM8oPmBIwObd8BLenlImYIx4tqJiWdm9NtcNFT0M/FvGIix
         h2Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772522423; x=1773127223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVdYil7W0i9u77JXtm0StCzUZz4J3OdCK1AwKZIzaa4=;
        b=u4IEnihxQaTIHs86sBXZhfL32L3se/Nty19En5aSA6bdBlyks+kTWsEiqUI2IQ5G98
         9BlW8IHcreaTR8YMiP++EKtqRx8zZpLM9qOnTsfFOOA5yMkPc+0cRIhbGvGvj/0fzEIM
         VvDDMTKCoFb1f8qU4ZX3NlULvohzu5hg1lwmTtkamuFBBlNEf4lVsmUH2VHHe5Q7yn8y
         tb7oE75H5jS1yjC9cHGoN482Mzjj5i0RW5Ad1uak8ytZYnru+s9VUn9/276mGsPEd3PN
         cy+3U12kBmf9uiTFkAVO3qjqt70Gyy+oPQZFP7mEAcx9BrqACAQVmjvHJ9dRjJh9q6Vf
         GNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772522423; x=1773127223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VVdYil7W0i9u77JXtm0StCzUZz4J3OdCK1AwKZIzaa4=;
        b=Bq5I+aHSdNmxDRAFZDWKVde0OcnGo/Ijw0FA8YRLA6dSi3AgroIiV3X77nd9CeXAc5
         ZHo7sX63THNVVDry3vzn327ejldIbE0m/Oy2QtsM6J8BdqyuqnmS3mtYpSuJEpNRWrWI
         R1bGyS1YVZHsBN7hnjvgKzckZaDHlJz5kUtO64AYqcNpMXS88WtSEtWVxJUoSV9gScEo
         o3Lb7iYgI7ksrOhfDPMhvNQbGbh2vOUoVahFAlmotHGm4LvTGYKp4DtlDOXQMZqVL1GX
         Ie++2uafhhMBsB47RiQKtWOJe4pvyqf5vzAMlOM8PwMpiVQ5ysLnB6k8HJMR65aCNg6S
         5PAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiF0ufNk8EEWMjemBvWd1Iz1ApO41feFJTf1/ThYqscDiSCXRdrufUO/oc4OQMjSCtYaFdjS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIREdy4GVVgT+82ZCCRaE1ocSIaT7Cxe/LnNn4hB9JLe1+znR
	EC1bBqxM4McPZrXQL2//Y85GtO8JSqDM61+TJrXkQGuxjhl0HAc4E0I6Gu9+2Goe2o6dvKtP/zc
	fEv0B3ABdubtzRRICVJJkl8FLYJ5z2Jlqt/DzGdZ3
X-Gm-Gg: ATEYQzwRYZtV2EfZnDcinTOjLqHAPB3HdEUg3mWdp/aM9w2SNg2kGciy0uITCkhP2fq
	AdjkKY3z95JqRN875UCUnmMFhOAPpACVzNc7RR7ERIb1q9ifnJsJSM1iVEsy51T0T2nHiKcKfNr
	E9zpXBEtqn0KnrzUZRDGQJApQ4pMqhUOzo+ztB/PdoPjMzet4YS25QUcdISagn/CAC788IEHVJg
	AGTDgL+jZuLgQPcJPqdUTeuokU5vwgIOVzNziBud63b1fotJ0vdIa1+ShvqwYxYXs3QzSn/XWFP
	H0dSpM0qhTSko9xeE65nY1P2erjO+dsoueZBicRP
X-Received: by 2002:a17:907:3d90:b0:b93:a3db:a6b9 with SMTP id
 a640c23a62f3a-b93a3dbae19mr488908066b.53.1772522422966; Mon, 02 Mar 2026
 23:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
In-Reply-To: <20260303063751.2531716-1-pjaroszynski@nvidia.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 2 Mar 2026 23:19:46 -0800
X-Gm-Features: AaiRm51Ep2_L29b_JroBYwNE4zf0aj9rqC2fV9F6QzDJPa3ta2uUEeGpii49xJM
Message-ID: <CADrL8HXaTz-TS9rYiQkZ6NoRWhHm0t4Tv0t=TtDXS4purLnDJg@mail.gmail.com>
Subject: Re: [PATCH] arm64: contpte: fix set_access_flags() no-op check for
 SMMU/ATS faults
To: Piotr Jaroszynski <pjaroszynski@nvidia.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, Alistair Popple <apopple@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>, Breno Leitao <leitao@debian.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9EA811EA109
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222807-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jthoughton@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,arm.com:email]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 10:38=E2=80=AFPM Piotr Jaroszynski
<pjaroszynski@nvidia.com> wrote:
>
> contpte_ptep_set_access_flags() compared the gathered ptep_get() value
> against the requested entry to detect no-ops. ptep_get() ORs AF/dirty
> from all sub-PTEs in the CONT block, so a dirty sibling can make the
> target appear already-dirty. When the gathered value matches entry, the
> function returns 0 even though the target sub-PTE still has PTE_RDONLY
> set in hardware.
>
> For CPU page-table walks this is benign: with FEAT_HAFDBS the hardware
> may set AF/dirty on any sub-PTE and the CPU TLB treats the gathered
> result as authoritative for the entire range. But an SMMU without HTTU
> (or with HA/HD disabled in CD.TCR) evaluates each descriptor
> individually and will keep raising F_PERMISSION on the unchanged target
> sub-PTE, causing an infinite fault loop.
>
> Gathering can therefore cause false no-ops when only a sibling has been
> updated:
>  - write faults: target still has PTE_RDONLY (needs PTE_RDONLY cleared)
>  - read faults:  target still lacks PTE_AF
>
> Fix by checking all sub-PTEs' access flags individually (not via the
> gathered view) before returning no-op, and use the raw target PTE for
> the write-bit unfold decision. The access-flag mask matches the one
> used by __ptep_set_access_flags().
>
> Per Arm ARM (DDI 0487) D8.7.1 ("The Contiguous bit"), any sub-PTE in a CO=
NT
> range may become the effective cached translation and software must
> maintain consistent attributes across the range.
>
> Fixes: 4602e5757bcc ("arm64/mm: wire up PTE_CONT for user mappings")
>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Piotr Jaroszynski <pjaroszynski@nvidia.com>

Thanks for the fix!

This is similar (sort of) to a HugeTLB page fault loop I stumbled upon
a while ago[1]. (I wonder if there have been more cases like this.)

Feel free to add:

Reviewed-by: James Houghton <jthoughton@google.com>

[1] https://lore.kernel.org/all/20231204172646.2541916-1-jthoughton@google.=
com

