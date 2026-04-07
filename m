Return-Path: <stable+bounces-233484-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IApGEopg1GnltQcAu9opvQ
	(envelope-from <stable+bounces-233484-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:40:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A53A8BFF
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2C2313004DA5
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3C8222584;
	Tue,  7 Apr 2026 01:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="RRLDCk6H"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBCE19995E
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 01:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526018; cv=pass; b=DJKIFxqVkoxf47Vl1FgO11Dqe5aqOIo0Nue70Ea94Slme481nwsQeDrwSmLSgwgVgQQe9vWFXW1ldbjYs19opgUAsCFz/CIuzpTQPzq5IXf/Rmewe59kp2NvoXoiZfdQYobePWwoG2P6EV1IzvlQEOxERVuK/lGCqXxOJDOh/UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526018; c=relaxed/simple;
	bh=XXMW7relNtjI3OlVKlyi+Ft3JX4ZesBdNhaW/5GXYrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KHD7p57whx6himQ1jeqqtz4rDE877VZMWFmYzeYadVbHmnQsjPonR3pbB4bBLNaMLUwFdIO9aAb3r6E/Bpz1lkCeF87Y2UufDY8OD+4SYcCLQwVmJIdPX+cl9WCUrdp7VX9FBjSg4AKLt2vkF3GXUhg9R+L6I6okMNPZ26EZZ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=RRLDCk6H; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79c20063a32so46684867b3.1
        for <stable@vger.kernel.org>; Mon, 06 Apr 2026 18:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775526016; cv=none;
        d=google.com; s=arc-20240605;
        b=kgSFseMMzeOgNOIS3n71P6BFUU0GYeCDNZiIfpAxcsU//sVT5vKTrG9XMwOGrryc/G
         2b5DqjvxaW6tQA3xftVG6ybqdXJQFVJyH61+kLD4FhRSjwEZ826Ca1XDRdm3rQsKjFd2
         Ir5AUWQS2VsXe869+MR+3b96YGjgDLu+NSJ+R7vkxL0dwO5jvWMB79aqpFEOxAw0VmQu
         S4l1sOYvxsW5czZ1dzVyn5AGgXrBwEVgeYj0O4rFas+u7blcyFRfqYxZKfKBBd3IyMyt
         vlCRUTapTML9iTKEH6xtYNAl1MJ7je/ikZkqnh9P7SF5JvfuCJL2IKJkclpBeh3vk8y7
         5eew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LvWAUmXAZy3o2BWzlw2ffM4oCsS5sbyymkwh9nuK7C8=;
        fh=D0aCkwiHqq48KQdDDNrNBwoM7ABaQu/MPyJbr2Zq/C4=;
        b=OPsd3Vl8OGI8dqCkKGmb28JX3NJqnaFvuZ76u4C6IdXspo5ByW/ryHFmXcZn5rKNPt
         QzESFfaml79UiGMOtGXJXeFyvuJRVPcK9Pe2A+Giz2M3R/nzIzsIZckmcnh9P4VYdZPc
         WDWN9yj7uH9VmXKbx3NFXtbLw021a4R8J+8V+ksVq8NBMzCFpOeIbaAgza1US59q9iWY
         NKu+eVQhZLT7e+Uc0OIPscfpFWalvMx01bV2+5SFW2kCD/6UNH2fgddQcmIJ1jSDnBBX
         t/QlkVmgyVoBYon4tRciKCL2k8WIxHojC5lHz2g8XaB2W4cN5HRoNw5Z3Ka6H1vggOk3
         pfPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1775526016; x=1776130816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvWAUmXAZy3o2BWzlw2ffM4oCsS5sbyymkwh9nuK7C8=;
        b=RRLDCk6HPm0ToVH/7GZnG52xqS2J4QlFgnrAmHzSth08gkyCAys1q/+5gS8mUSDaoj
         KRK7mPPkUBsfCBXJSaYI6cqUBjhPFe/sOwr+hZH8b/8zeaw6dvpCI7KF7zhz18pyLYWV
         7Wr5hdp3/7Z40Vze2H8aM12jsNoVgE5r1Y3g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775526016; x=1776130816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LvWAUmXAZy3o2BWzlw2ffM4oCsS5sbyymkwh9nuK7C8=;
        b=LpAmyCsW2eRar2xF6KRG2ZDlqKAj6nQmx5zdvMnF5GgryY3olHJmZbjc5z6Xq6M2ds
         2OBiKi3Dt8VKZTwDSR922U9jqzMBe4qo7ixxCinOWCUuBI/94LqtZy48j91aB5ocW2XD
         olVxwi1/ARqSl1QK9YW8zdaGYHCGlL8zEx5CAFjZL4Rf9zTKHh0YOA+Y0OZM5PbotC4+
         Q/c3TAYXGw15xmap6cszqsQYCMAZgtgTvk9Sp49sA7ZjIyj3Cimw9m1qQp1ONlspJaWk
         lAWoJHTncXErcy+jpe0mqf67Bq83pmMlLcG6+/5H8b+BrCLhfn0/bnViLm48b2gyoKoV
         S2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXtc6R2nxUSBA8N8+JsYDpF33PlBfY8q5blvnW1CTLOWmdiFj0aaxcBOUxzZN6WhMFvs3LzTIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMGxjYIlkKawfLBlRkV2xaOZ3yjNinjsSRAhm8GZciJ9mCckTG
	q+VtABT/+wrfWy6qkZ0APkWX5FS9J8dxc+j1oKpHr+LKjUmihYkZJRsYx7ZJX4/tVWUDxH23beN
	YipWSVsJyihpaqLTcEbPQz/f+vlGXsX97+rZtgGglxw==
X-Gm-Gg: AeBDietRvGzkPEn4WV5lClWY/kTfgFO/vEdS8ezjbaNxkPPQHML0pszNxC0n5mrl8EC
	fmzCUmUWkKVzOeV6utV5jFB+iiLvYJ04SXWIlIaklSP11BigAb0V76LJUmVWo2yTjEXK3rYruWW
	TEMwpwG49PEknmfzL3qp/uvGtfc9qIhfTL31MnRGD+F2grhdgeiOXnpdW8MD1vq4/TI63WR1/2e
	/Ns55cJ1PA4Vh0S8hPJBp+sk1a9ixPlsjyjyTUgx+7BOOoTxbEdR8AWBQTxFcwAPnC80KrU8vfL
	0X5GzaumQrhPNYZpK7XmiOW058sBmKR59jZsWapFwEG9FOnMODyr2z+OzByckvl+8BtDPbgEW/p
	XjVe+vDDD/Xu1hTVdXcGi8CwbkSluzNVvISGbAuGHXBfKL3Wspj2DzPzBnJ4aBz4=
X-Received: by 2002:a05:690c:6b12:b0:79d:fca8:f7ef with SMTP id
 00721157ae682-7a4e175268cmr123222207b3.22.1775526016081; Mon, 06 Apr 2026
 18:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAJpGJTztK=BTvr6s_e4epJffKchmXmqba82wxE_SOXUN6FWYg@mail.gmail.com>
 <20260407011210.GM2551565@ziepe.ca> <CAAJpGJQXnMjhC4C7Z6bAQJN5y48fsbiwPd3YF5vft+1MBNFLVQ@mail.gmail.com>
 <20260407012726.GN2551565@ziepe.ca>
In-Reply-To: <20260407012726.GN2551565@ziepe.ca>
From: Sina Hassani <sina@openai.com>
Date: Mon, 6 Apr 2026 18:40:05 -0700
X-Gm-Features: AQROBzAsvhI6uzGy87ToxM_BIezPmb4fV0dxfq2d7djAct_KKN9qJE6yw7wH9-Y
Message-ID: <CAAJpGJTNKxCfcZxgDj_sZYUozrOe=vxbWUUi4PVwdfvGx=WEfg@mail.gmail.com>
Subject: Re: [PATCH v2] Fixes a race in iopt_unmap_iova_range
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: kevin.tian@intel.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Aaron Wisner <awiz@openai.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233484-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sina@openai.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,openai.com:dkim]
X-Rspamd-Queue-Id: 482A53A8BFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 6:27=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, Apr 06, 2026 at 06:17:24PM -0700, Sina Hassani wrote:
> > On Mon, Apr 6, 2026 at 6:12=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Mon, Apr 06, 2026 at 04:07:01PM -0700, Sina Hassani wrote:
> > >
> > > > io_pagetable *iopt, unsigned long start,
> > > >                 unmapped_bytes +=3D area_last - area_first + 1;
> > > >
> > > >                 down_write(&iopt->iova_rwsem);
> > > > +
> > > > +               /* Do not reconsider things already unmapped in cas=
e of
> > > > +                * concurrent allocation */
> > > > +               start =3D area_last + 1;
> > >
> > > area_last can be ULONG_MAX so this literally overflows to 0. It is wh=
y
> > > I formed the suggestion I gave as I did
> > >
> > Yes, in which case the  if (start < area_last) that follows will catch
> > it. Are you suggesting I compare against ULONG_MAX instead?
>
> iommufd does not have any overflows to 0 and rely on it tricks like
> this. You should just compare to the existing iteration last
>
Just to confirm that I understand correctly, like this?

+               if (area_last >=3D last) {
+                       break;
+.              } else {
+.                      start =3D area_last + 1;
+               }

> Jason

