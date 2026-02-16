Return-Path: <stable+bounces-216697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BVMNs0jk2kX1wEAu9opvQ
	(envelope-from <stable+bounces-216697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:03:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EC914466B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 15:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 903E53009895
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8D310771;
	Mon, 16 Feb 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHifOcj6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrioTlSY"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7B3101A7
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771250633; cv=none; b=fu/tgPqSLCDh7bjSOhFjNfTXt1DqvJBWfIFBFv8yYb8Y9MY1Aqqj9KQVyyYEqFuIVaVQrRFYo5ZA/EDb/+X/EplsguN4lYOyoKhY6yRurEd3gNSkIkYX99sok6BJHTsWWz8DMOe3ScmiyyJCWQRwzICkmhvulUFkz6Mddera2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771250633; c=relaxed/simple;
	bh=qvgtxZHIyxGZTtSdGu40CUd9mGNaZbI8z3wr2u95YMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5qrpS4Zu5XyRwhQdCY/ta5K4cLUrFxoSmzvaGnWRziTRlxIWFD+9h3GHrd8HStEEzVDR3W8XcMqOsTHCgY3okDVD0cz0Ln3aX7MYXT+dsoOiPBw8paRizODt1Pio9FEt9junvXBcrUhXIkp751tfTmrGN9PFKKGrER81GeAOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHifOcj6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DrioTlSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771250631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wgbev9M35IzSPMmROskqj3DwY+teLZJngKA0ChkN4m0=;
	b=IHifOcj6KdoRn84i3K8WOiA75sjEY0d5uLGwmouR15q5f30K1Ij7uFmeucP73MWri3IJj+
	PKNywR2Y1VPmRjIrq1YNDjXg2wrMkBEjn/J/KbTiYouo61RQBljy6m02AEIsUAO/JdvPnX
	J6sF4B4sZXwe4mV3W+ApmIHH1Yn4zS0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-SAobLsfANwCTsy4vQd7-YQ-1; Mon, 16 Feb 2026 09:03:50 -0500
X-MC-Unique: SAobLsfANwCTsy4vQd7-YQ-1
X-Mimecast-MFC-AGG-ID: SAobLsfANwCTsy4vQd7-YQ_1771250629
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48070c21420so38404615e9.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771250629; x=1771855429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgbev9M35IzSPMmROskqj3DwY+teLZJngKA0ChkN4m0=;
        b=DrioTlSYFzlxXCytb0RyMn2bL0Wu9oQaKOuPGQkeb062Mb4mFprNNm73zl3obNkmPF
         5ZLfpt4wKMVG8+gcL+1H0OhJ8ogjIQ+uEw5/B302QbCZweaHCuI3Ei+/r0cGO13yB6gi
         8EM7tBdLwS1KT37fhJacVaTWGilIu2sZ/JqZ82qFKV7nK973RGWImgFWTufspEs3arDB
         6yFgOGnAvjMtqJTj5WcBkgyJnFuVHXupXURP39CqFh3gYLOQYAoIIPC4GzWz9Bm8Wwlj
         do0hyKXp1QNHQjove2mh7o8B0HLj9pSGj1x3BLrzq7Nscy3sbB8f0g5RAE12naIIQLTy
         r6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771250629; x=1771855429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgbev9M35IzSPMmROskqj3DwY+teLZJngKA0ChkN4m0=;
        b=kes0B5peXkPTcg2DbqMiPxkqBsFXWpok5AiJ+ryobkqVy6stpj957nMsfLItRE4ciq
         OHbNStSmPNYU9GyTl//lnUfPsYRaWcpp546T7Dk2OKg1axwKdp0TEi4VQy2f242yJZmA
         oN8w1QEd9rk6ANXilxg23UyNeAACVpzlGyvjC+FmaJcWwlUcYJ4Ey+iArttMx+U1WAH1
         phLpSxGophZrcmg2v11n1WOvP6TLFsaXzHkXMkn0b+9hbN9ZjwpM0RL0NGoEGfC26I35
         7/Iws4bAog80yWPpH+lf44RlI1qOdRi6Ohwv/noOiGIrbmeczjzV7YALTZG5xNBvacoh
         la3A==
X-Forwarded-Encrypted: i=1; AJvYcCXIt/Iv+E+ZvsaJgzyjacHolu+OwZzvJTctbgNJ+pfaO+ciUA9TcSCGI4Zywd0r2NV7HpGd2nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVU6NnaY22EHu6vL9A5CsOParXXTBhkQnDKTYxVNbHO9wjuRZ
	9hd3e8N6U0ymFaOsBwIhHpmtR2ui6BH/oRYeAHMRGFkRVIXCB5uI2cbQ1zNXTAsgnouWfytUmsZ
	vk2jxvDVb6vkxIam1mVxxrRmRjoy2y7eeAkpjNDZizBSKmsufRhY36WNE2A==
X-Gm-Gg: AZuq6aLUfcPASN1IJyxFRdRNtb4iPyWT+4g/g51u0qQiVd4tfyuH4QaqzJrhODFwK3+
	4alJwwJMbFdbTbWnk6/+n7prnP6wySgV82lS7kNc88umJgoKnVDjU8TbNQMN600+CCHIcSudS0V
	r/EtFJujJt3hgTgsgy1kUVqpYQ9DGyOfIZFEKnt8pexja5ZBU1Q3ZBlhFdYoQ/sM2yp/mbyv8+O
	1pRdj+5P51BIXvWPplVr36JYxGkhl+FPn0Xa7kc/hDF1Y7aZoPQOVWl/81xefnIjhMsodOr53G3
	59TTTN7efZipX238vtFVFnoJb0mAX3icn1UH5ci8IAtGSc5MlJaEDSKiaTMpqedwf0FI1lUR16O
	Nn5Ori+sTOJ5tfIc3QIQMIbPAWUGlzYxf2Sqcs33F37/Rpf55wUIIW2JSKr8E55eybiMfgm8=
X-Received: by 2002:a05:600c:3b87:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-48378da53a2mr143994935e9.13.1771250628182;
        Mon, 16 Feb 2026 06:03:48 -0800 (PST)
X-Received: by 2002:a05:600c:3b87:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-48378da53a2mr143994065e9.13.1771250627605;
        Mon, 16 Feb 2026 06:03:47 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a02a79sm180910655e9.3.2026.02.16.06.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 06:03:47 -0800 (PST)
Date: Mon, 16 Feb 2026 15:03:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: Address -debuginfo build regression
 with RPM < 4.20.0
Message-ID: <aZMi3Sg-7Z6IZ99d@sgarzare-redhat>
References: <20260210-kbuild-fix-debuginfo-rpm-v1-0-0730b92b14bc@kernel.org>
 <aY8wyR572eZYWVJY@sgarzare-redhat>
 <20260213191138.GA2131983@ax162>
 <CAGxU2F7FFNgb781_A7a1oL63n9Oy8wsyWceKhUpeZ6mLk=focw@mail.gmail.com>
 <20260215212901.GA695045@ax162>
 <aZLTsduMY7H-QoA2@sgarzare-redhat>
 <20260216114227.GA213868@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260216114227.GA213868@ax162>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216697-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96EC914466B
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 06:42:27AM -0500, Nathan Chancellor wrote:
>On Mon, Feb 16, 2026 at 09:25:25AM +0100, Stefano Garzarella wrote:
>> Oh, yeah, I just tried the following change on top of commit cee73b1e840c
>> ("Merge tag 'riscv-for-linus-7.0-mw1' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux"), so without this
>> series applied:
>>
>> diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
>> index 0f1c8de1bd95..86ca327ebccf 100644
>> --- a/scripts/package/kernel.spec
>> +++ b/scripts/package/kernel.spec
>> @@ -50,6 +50,7 @@ against the %{version} kernel package.
>>  %if %{with_debuginfo}
>>  %package debuginfo
>>  Summary: Debug information package for the Linux kernel
>> +AutoReqProv: no
>>  %description debuginfo
>>  This package provides debug information for the kernel image and modules from the
>>  %{version} package.
>>
>> And I'm able to generate RPMs too without errors!
>
>Great, thanks for confirming! Does it still work with:
>
>  AutoReq: 0
>  AutoProv: 1

Yep, I tried this (compared to the previous email, just to be sure I get 
you):

diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
index 86ca327ebccf..f5d0fa34c51b 100644
--- a/scripts/package/kernel.spec
+++ b/scripts/package/kernel.spec
@@ -50,7 +50,8 @@ against the %{version} kernel package.
  %if %{with_debuginfo}
  %package debuginfo
  Summary: Debug information package for the Linux kernel
-AutoReqProv: no
+AutoReq: 0
+AutoProv: 1
  %description debuginfo
  This package provides debug information for the kernel image and modules from the
  %{version} package.

And I'm able to generate RPMs without errors.


>
>as I notice that is what the %_debuginfo_template in /usr/lib/rpm/macros
>uses by default. I suspect that the automatic requires is where things
>explodes and I think we do want the automatic provides because I believe
>that is how the "this package provides this debug build ID" generation
>happens.

Oh I see, I also have:

     #	Template for debug information sub-package.
     %_debuginfo_template \
     %package debuginfo\
     Summary: Debug information for package %{name}\
     Group: Development/Debug\
     AutoReq: 0\
     AutoProv: 1\
     %description debuginfo\
     This package provides debug information for package %{name}.\
     Debug information is useful when developing applications that use this\
     package or when debugging this package.\
     %files debuginfo -f debugfiles.list\
     %{nil}

So I guess I tested the right thing and it works ;-)

Thanks,
Stefano


