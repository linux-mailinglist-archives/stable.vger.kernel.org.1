Return-Path: <stable+bounces-244435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK4/B+11+2kpbgMAu9opvQ
	(envelope-from <stable+bounces-244435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 19:10:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E9C4DE98E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 19:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23605302D97D
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71304A3405;
	Wed,  6 May 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgeHaMlh"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2204BC005
	for <stable@vger.kernel.org>; Wed,  6 May 2026 17:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778087281; cv=pass; b=lakQ4iR8D4NwaGOK/5DfdYB9qp+ThCXkUj8DAGNnOZW6UHvcTmMBitRlwSbpidDLIRztKjk6Wywi+P7YTR+aELbr0SZaFdhiPiPTbobMuAiAbFgx6TJCHQZ1bbH5HVtigH1VRD4Z2GqDXNVMXhUvJ5ttQJ5j/AVHbhd5w5mPxJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778087281; c=relaxed/simple;
	bh=iJM1KHmjIZ05feWWOBSzK5MzppaF6eNDe2/g69UBMwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ua6Hc/F044polYhFSKQ7GuMJhfs62XxtiU5MqWSuu68mDCjfQKFIMPuRxVEiTYRMoD/whcpfighfr7/fklSSuBR2Ykbe/UX/5LfkJRfmd/aOe1QzSaEdkqcRdXg/Rtx9c3Y/tL0QJmyhCjcms6zyCDxHK9gIc2xAmfV2Xu2PvwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgeHaMlh; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1309f4ee973so3490534c88.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 10:07:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778087259; cv=none;
        d=google.com; s=arc-20240605;
        b=W7rzFBJdGXLoGWWxpGbowLYN+1lmgrV37Y8sPEfJ+MaX6YG/mLUrvogJ1kfwU7xhFJ
         /nzQaxTFaE19/MgtCBRjAs9vZyXAH7vNlzoSCsLFjclGEb629A0TEfFg+hMGZgmEySN7
         pEGHx5nMH2tLRyzWWA6lGsWn/xraq2Ai1HOblmTm3ivAR9l6JgnAsmwZM79Q7UUZbUKH
         OcHGrihQSLHRlJoeCmeHzqjX9qrgVvj4z247E7ZKyKCR+Vyp+yyAAXtOXMbl+rrCvkSv
         bM54BWu0ZR6fnWzHacE9b/InH50IlAW9LweLYZuQS9hki5oEe4WghKCG7BrBvZos/7kY
         uNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q/v9MQFgIlffWIKDfvYVkIbMIOBfG0NkHQjEHrpEJtA=;
        fh=VYA6bVvNIfPxGtjB37wnygP7uNgAHsilL76wZq1YZkQ=;
        b=BQjSe5Rwqb3xqFCa6ewU2P4Edp9q15KeXOBzcxVsUA2MNXFj6s/L6a3erp52PTtAe8
         hIaDA5GqSGXOybtvk2nrWd/i2puRceQa6qR2cdnMJP7Rx9KOY9QbxTuJGbT6y9zn8dRS
         tMUvUsxZqO3MdqTxT9GLPmXsILTsZqGH9sBBpicuNO0+057G9ucsCaQDOutKzPsrkBfw
         0mAm5SoXMI14MSk/FUcVxhdEakDy2ADyNxnokBIJCxSTn5PCR/EMKOKCfFtnGv5xE4Lk
         jWddzCl3WIK5HjaXGNtfQdynJbwvBN7Jco/gDhbt7UBNC1zgPeAq4QXCvEwPauYFtghU
         mz/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778087259; x=1778692059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/v9MQFgIlffWIKDfvYVkIbMIOBfG0NkHQjEHrpEJtA=;
        b=JgeHaMlhpxcfihV2bxQVluPHWaJhlHv/K+I05cO6JicjQXzmZXPzRHqW5EdRXnnC+t
         kIznZjod8kcAZ2XtlWWmNgp9Mf+mRh8blLtSUUFF778/SVEsdECxCFbgN2nFWCPeaMMP
         QvHwZMC3LtBa0AssumkYr9W/Ntp62zXO4mBGup+RMAflm8X1C7KmkeqrX+2ITQbciEVO
         eGNegO8jSxNnWCAdLC99/FO+jd5tApgnSdqHC1GG3EtBqDIFq2x8IXO30ImQ4z4oNx++
         745lHODgSRdqgQENxCCJUZu02CstJYspKqlVfJ1o2y9ykx35QxbgCcntA3P78L545Shm
         Byrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778087259; x=1778692059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/v9MQFgIlffWIKDfvYVkIbMIOBfG0NkHQjEHrpEJtA=;
        b=iwJHo7VzCwF09p/ESJmZS3R4lKeIqYoPLo4MesANS/xUGpIEnGivHQag8uGlE8N2TK
         YSZUBYA5PSZ3sDAX7+BwgCEvxarNBIp8hHBf98X8Q6d/y9F/PJFGYTezTAQ+SPCmu7SX
         iK1YypUIm3sk9av9Zsvj8Rle5T+PAUsHfNLCjeLb6YLbanrbs7OjcUVMfrVggvkeeolB
         UKHGeGPX5awE3F7rNI4R9cRsEujV94GQqBUsjfw3CAGlFXSf+SBei5f82gC1uBiEZlWc
         1nRh1gdLEawKWIZtMQEyzM5I0bWGVUS4P/F1x3kndrcoPvXoVsELqGko3gamVC1xNaB8
         d48w==
X-Forwarded-Encrypted: i=1; AFNElJ9L6lxaUaxMPpll8/mRs/yKmAHkdkhDfORrUlT3Wd+cNxgK37HRMGu0vu89SpqfL6s2yOwKrrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZa/FwcvDAXTr286BVIgGKFTnjJVQAd47GiElPa0/iCOkEg2+Q
	Rerc30Gf07bp1+NWYGxKr2cEfkPL1eljCrTjH/4OP7C4M+dlLFSj6fkPVvklEUdhJIx1jaVnjYj
	kTfkb3DB+MJ3zOADTykn+cT2vUVyjNVc=
X-Gm-Gg: AeBDieuPlmZ93IdG0BOsL3LIXzRzdhmS6lNCJvyzum5PrYcctrkL8mfyXU32C7cLyA8
	tNvdZs9hz2qqDYNp+7zAvBnGjVX5ehaTX0NWAUR5H3oa2eff1eZ8pwp9EjlgTlJMsyUrjdh8FeJ
	Z2s4O7Yu4LOcAztgPkf6+BfgXzZ9tQay0alkUTAPjp+k9m34Iw7xDVNZ3MbxOec3MHhn7ERdxrj
	NR7N0dgZmaLrhQ2Hy9/ATXiKQfcfDLFEpb4sjClc7z/cCwZt+X8Orv+WE35s8+2ajqu5llwKNhk
	er8j//KDZVlErg0R7Fy6HdfgMhQQYPSk1GitKTt+q80P9JHAUsonAShx/hmIkgslR/2cvInuvdH
	BC5kOA4JjANB4XIPK5nQzfwifznyI+Mka6PswgiGp55fJdg91
X-Received: by 2002:a05:7022:1e10:b0:12a:b932:81d3 with SMTP id
 a92af1059eb24-1318e7f7469mr2001823c88.26.1778087259155; Wed, 06 May 2026
 10:07:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506141040.1368918-1-s-vadapalli@ti.com>
In-Reply-To: <20260506141040.1368918-1-s-vadapalli@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Wed, 6 May 2026 12:07:12 -0500
X-Gm-Features: AVHnY4JssmbmMVgWYy_rr3kP7VA-rHrBRjYoeKWuuDrMj3pK-MCy7FEMX0YQL8c
Message-ID: <CAOCHtYjJRmr5LhRePqaOomjVHb=o+B8-3+6BN89Xx9erwRdcng@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] TI: K3 DTS: fix USB Clocking for Compliance
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, josua@solid-run.com, 
	w.egorov@phytec.de, matthias.schiffer@ew.tq-group.com, d.haller@phytec.de, 
	francesco.dolcini@toradex.com, joao.goncalves@toradex.com, 
	emanuele.ghidoli@toradex.com, ernest.vanhoecke@toradex.com, rogerq@kernel.org, 
	eballetb@redhat.com, afd@ti.com, u-kumar1@ti.com, stable@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, luis.parga@ti.com, srk@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 75E9C4DE98E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244435-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robertcnelson@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,ti.com:email]

On Wed, May 6, 2026 at 9:08=E2=80=AFAM Siddharth Vadapalli <s-vadapalli@ti.=
com> wrote:
>
> Hello,
>
> This series enables Internal Spread Spectrum Clocking (SSC) for USB
> SuperSpeed configuration. This is mandated by the USB Specification
> section 6.5.3 Normative Spread Spectrum Clocking (SSC).
>
> Series has been posted as individual patches for respective boards since
> the Fixes tag is different for each board and needs to be backported via
> stable.

While yes, that's true for stable branches.  Since these are so
similar, wouldn't it be best to push them to the board soc family
headers?

(Either way, I'll be backporting these for Beagle. ;) )

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

