Return-Path: <stable+bounces-241445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDY9C/7P72nZGQEAu9opvQ
	(envelope-from <stable+bounces-241445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:07:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A60547A84E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1BE930276A8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 21:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B473AA4E7;
	Mon, 27 Apr 2026 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etu/cg4+"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CBC348463
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324019; cv=pass; b=MM1FzCNKCejgfvRxmuMeIMpK/BS2b0x5WjvfOYwttWZKpatx2SsmkGukokVYzc+fwJwFFIX2+SgeptIH1BIb7feUZICNxoxxHnL48ZM5m8P4YjCU41WeP7YSFn18qAxon9h1VI4cR9aG0s3bbu85sCwkYcV+ayt2gmXCHBvg9Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324019; c=relaxed/simple;
	bh=kQTJwACJn02W/7niIQjpCu5qTgIczf4ObEbsGMcqBNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOg2h+NDQiw2cjDu4kGVUaqNrP6J/T+u2ohFPc3HBJCvb83M4QdBve5hDAdxGGa0BKxv14tt5V1+z7vp9roFeHOOR9CioIAS0m2npNaz6Y6kUKjI3bkChBKa5NQR25dLs2S4jANetWAbvtm6RzqIJrjaa/ow3J5c0e3178oKJ8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etu/cg4+; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a525aedb24so10292241e87.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 14:06:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777324016; cv=none;
        d=google.com; s=arc-20240605;
        b=J4bBPRg5C9kCVOHYRNw2JjdgMU3xz7J986F5DKGu0OUq0fwE6oLczvv/OVNIsDKy34
         aoSLOTsPM0GyposIiql84OvwLJH3W5cbhnEkaIFgbTf73cRTiM9jl/l4Bj6P7h7eBbvz
         EJF2tAcfieHBrxOTscgadxBTw3ECEmU3C0gRzy9NA3a9OiuVPp6V6wWmVLjowAdiPqHc
         Hhe5qQxIsw1WWQ4LDmE3Xee/1ew0zkzi5u5cnBOmSEew7Myx/a9hmnhbGdN/z8G6ZDqq
         GsVRwEaxHhLsrqIt2qEOzwyc2ulq5ECTZAAhSaG834USAXHdpltj1G78p3BjGCQT3Ank
         nY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kQTJwACJn02W/7niIQjpCu5qTgIczf4ObEbsGMcqBNc=;
        fh=HQp+y0cpjvnNLbECfXuQFs2dnRXErSCkykFUhfR09Iw=;
        b=Qo2sYuVRXHtM5Y/tOJ2fNb8UYxNw4x6mkrGBQt65g8AEo5kFQ6D69wIVa5n3uTAUl/
         giPu195MA+ZSrSwEVpIRcXFoR+sXhUwFOr03YDQbijw+o7ZqKlsXA/O+j0LglP9rcwAy
         3Mk8PsTrcGEhQCl085J9kvuDZ/TYLTPunPW644/Lidhta8i1A9lc3GB+81anwjnGS9yp
         qboYDwUMYcxLcJdguw9LaBFN0+HUpD5eiefYW6894thUPaHy5HimeG8YPEJanVxm2MyZ
         u+JroOtgGHIcllPE24cTwbFozF82rw8SFoYCJqoEAQtB8q4gRN032Qf4XqqRD3MEvSXW
         PeEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777324016; x=1777928816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQTJwACJn02W/7niIQjpCu5qTgIczf4ObEbsGMcqBNc=;
        b=etu/cg4+2ra246xUx/btKHgQB3erb8yk2i0pDWzdCol7h19fw0RRGIqvnpa2xpa7Ps
         RiI5foP7yFP4FRD5RJOzTRynBOWIBoEkXK2XomQ4Xhy3ex9PHOOT/49U4xXE9Wh2V4Ne
         oShUXvlI7RYkR8Wclna2oqQcdQbth4fTJ+WrW4rYhxl3ZmLjs6sR68AvS9o5m+eohVEv
         loBxKJw4obiz7XYe8fVfp8xaQpXrzRNntfdaUwCWYnt5L0ItnQCXBMpJ6BXtLUi7isNA
         2Q0OKynkgPAmdmZUHRIg6H7MQlDRZGDcVHRwJ4EDp/KAFVj5RyPkR1JotArO5YLb+cfc
         ft6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777324016; x=1777928816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQTJwACJn02W/7niIQjpCu5qTgIczf4ObEbsGMcqBNc=;
        b=Nqxofi7xw2HkSVjsj7So8bhztN+VB5BuWmK4yPNw6D/SI1kkUvauudPE3rKFJu8JGI
         h2HHHd/QCGNLm5JEBWWbOjIYuwjEoRrQERED92lCGa7PsAywm6qBObOzrT8zeVTwTslT
         N4lNRCqdZyCxtAtRcj4jA5dwEVUjNzEQe+c9VzXGh74oh8+ChQs8YpiOTDl2Ndagzk2q
         E6VPRgUs2nkpUSUgasI3Ttth3veqZ8qOmNUv+cPK+CtecAOp1OzAAFCdcOz088xsyMWn
         q9Ed5X3cM6aMY6WviqnxPqi29f33MK2T8IQmMAAWvHoBgD07OTPZgcLM66+Nka3KPPSn
         1/hQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lDeQYazCw/ENE9aXCk5sPR9XlWLIb8Sg7QRDaWx8/9Ak400b1ODGdjCqvpGA9FiHrsfdG23s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmTSiVf1ZHF7RT0abtriItS3vhmhfysVp1Ln9EDN3tG96GII1I
	R8J/E+ouLNvdm15A/jA3QYUWSt8Dvxb7X2lxX90Ij+9N/Y871ElQAdSuu1/pRZ3jflb7DO5jkUN
	A198Rd3680ZGiuaXc6Pa3XJarUho2qPXkUoRZw8Gt
X-Gm-Gg: AeBDievn7RxX1qGn8UA9lPnAHL6A4KVHNGQqsp7lDI4tdXdlDxrk7MD1mJ5z7puOgjh
	NiTFkP1Rz2LjppBtL29xbDBShqvZNAQFauSp7DkEFXUxQ4dpRJpmYL6BAXuPJRIx5Pl3ffkES9b
	GJsYsBlp7j0z/AiAqrAZacH81HPbs15jwz4c4ZUf0OHCt4ZgFbnVNxEAbKQGuPyN5kdxTBXBb6V
	aE33OIGaT/qfsOvsJDCjNN+KCevjUlIE64MjyUpwNhqlhcRb52ZwiDpbKSHKg+JmH4HJuFMmGxi
	HAhCoKdxRDUF1EFIm05wrUicdEk=
X-Received: by 2002:a05:6512:1087:b0:5a3:e5e9:3c24 with SMTP id
 2adb3069b0e04-5a74661bc90mr120455e87.43.1777324015512; Mon, 27 Apr 2026
 14:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPpSM+SbRsFUd9jcP81K1VmhANhT7uzPqOPmy8i0gZ28ctjQKw@mail.gmail.com>
 <20260427184208.161981-1-kpberry@google.com> <20260427184208.161981-2-kpberry@google.com>
 <CAPpSM+QVaLKspnh+fdLC8wtxqqMHbu+E81A-NzpbqVvN=vp1Xg@mail.gmail.com>
In-Reply-To: <CAPpSM+QVaLKspnh+fdLC8wtxqqMHbu+E81A-NzpbqVvN=vp1Xg@mail.gmail.com>
From: Kevin Berry <kpberry@google.com>
Date: Mon, 27 Apr 2026 17:06:44 -0400
X-Gm-Features: AVHnY4KugOwGxbp-zjUtzyosN6C3qRxrlagqs1jUDEIcUrFp5exemfHxZ8Lr9d0
Message-ID: <CAMAJAJF=T75mRvhsp1eY-asJV-6t=4jGPg2CS-H_VxUZQxvFNQ@mail.gmail.com>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
To: Xiang Mei <xmei5@asu.edu>
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9A60547A84E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Xiang,

Thanks for the explanation! I was worried that bond->all_slaves might
have been uninitialized, thanks for confirming that.

Your patch looks good to me, minus the formatting.


Thanks,

Kevin

