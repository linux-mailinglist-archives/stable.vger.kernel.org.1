Return-Path: <stable+bounces-238717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKwqJ+jd5Wk1owEAu9opvQ
	(envelope-from <stable+bounces-238717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:03:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3231427F7E
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A71C300AB23
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F603815E2;
	Mon, 20 Apr 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/QwEFZ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA3D3859E1
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672225; cv=pass; b=d8T1nM62xszoEZMYlcQdxJs+uHEYWczp1IPGl33OwZiFPkkAiEaeeHabo09zMgCKKxj6RnD89/Rc0kWDYKFQOodjsGKXVa31JAb3jWx9SKochheeMXbl9eH4WXjKN6XBF/j4q9qCR0Qo0o5DE4PL0dvhDDYbs5j0Z+vEBgxQ9Gc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672225; c=relaxed/simple;
	bh=AD/zIredsgfsCEP34x/bsMTFCh61zgjzg7Qg546Klu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNaVBOn1v8Byv3Hr1IXeS0zon6MFvbAnAdRLVvHAXXiUWKNV1IhKbxs9VYG7RoqA/yzQOlw3t785ug4tXwjylIuXzXVMH4XoCBmekB7YUfe4raHc+Jnn8rjtCmggoh0V7pzGXTc7MCpfhulMCT/chNOgd98Tvj/kNgPr2T4la88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r/QwEFZ+; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651bc8f864fso1425118d50.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 01:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776672223; cv=none;
        d=google.com; s=arc-20240605;
        b=g9NlDuT7rJuDL/OIue2TTAGiA4ysskV1LOpFfLYx2ZIFqGa1JlNtXrWL8Pus8Mc4e2
         tL/QFyH1BBcgV5NtidQ2XY+bdS/QRBNWfxUXiA7o+qMGE/B7qjFEjdPKERI5HMUEiRh+
         i9x23dpHxzN1YcBQrSW6UdHSiQzb0ukdSanxFI8ZG2q6uH5G+H6ON1tz51VaE9D4rUgz
         QlLfxSLSJrBUSRXXjPIkzXnZXwexnGBntzWzMh/+OO/erXchJ+iDkLej9iaJ6G/8GMaP
         4w52KlWLhkeD4PsXwvAsi+o0oxCnQqwW6zQUtGg3hustZs52txEDTe6l8nASjqwm5La2
         GxAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7Jz2ERRg05YqEeoJdExY/vcuAIzubKoobp39X/QVPjg=;
        fh=wUVmKfi6hq5TdCrLTHzJvMRGTSDi9/zTMRzaYq+JyYg=;
        b=CQifce3t/Ek6YLC/VUGphW1cZ6XIV61hrAcHG3FISJRpiB19mHHEuwl0YMlCgKOrn1
         jFuHsYJtmrLPh0GWqDyJywmiXC/DBRwf2k/ynm/4lTIc1mlUUFQfGxwZYQxlE+zvIcsH
         DNseahXSGkN/vou/SUIA1whONsDf9mURXAFOv8g2YOcx6xmpCqJPGHNTQekxgC1asKRU
         gIQjCzqye1wIlrkARJz4st3zVjpVHdu6ybHN5NxKBE6BYxQF4R2NcIqI2dScM/ubyv/j
         3qxlN5p3e/NiVkNRPZDMe0zeGMsZBE3ok++0DjvM+tNmct/YLZWq5sAq0e13Tv0nCH9f
         P24g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776672223; x=1777277023; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7Jz2ERRg05YqEeoJdExY/vcuAIzubKoobp39X/QVPjg=;
        b=r/QwEFZ+BwVFPPFgHbrIZDGWD7d0bVY2+5Dv7S7dsYkUAdbhjBPYNnEWGZuxgYiHd5
         nmliqRfrLqb7KiUdt4jaF9dPGPy57Zxu+/Muc2y/dDMWVnRoEVHYpNcOPFi5rIw1oe/U
         NnZtW30I8F9sHJF3awT2vzlckc76+wl67wXcMJ83IVLvdEEbEbr5R8Z4/QQi4kL3j1Yp
         1hvkVgv1VZ2Bmr1DxLofyZ7fq0DVRDHfPO1Q9LPnmWufwux39FSP2TeGMxf8nTBtvOTb
         CgPWPb0ujfn0ftnQgFtdcE4FFuO1gOsHUDsAJvq/VuEaa/iIXLmAsdMRfhlb6J0o1Bz3
         p0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776672223; x=1777277023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Jz2ERRg05YqEeoJdExY/vcuAIzubKoobp39X/QVPjg=;
        b=goEYFtDKRIqcqtSaplhMZ6tvUQtVLfInjNbLqMQrEfdjy/ZgIJPNDmw+o9PBzhe8I6
         JorOmF48zFZAl/8vDn4ys5xvfYtcqSMrchDmANDAtNdiQgwbvTuyZcVY42VXVCSaVWJe
         5Autkl2p4Lcu5CCijeOn3n441qoHnZ9QBfv0ciJ7rgqZ6StgrjcX3O0jOEkj/vcGDVPj
         UATF6ij5hkMXiOfPG0dZNc06py5LWvzMyc1XfHEpZUQkDyVWHfulujnsDr6/4kUEpa6k
         iPWugTBL0Cayi8I46UKexxa+MKkBKxTLv06sYjh3ncVJ6OOlLb8LAKYd1fP4ZhxfXNjO
         fUiw==
X-Forwarded-Encrypted: i=1; AFNElJ/AcYyQHd4L4PlY90g8HpMvFZwnTlD21+WcDDC/TY4N/kPOI31JptpqPUWC4a/dCGLM3u+aQh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJCTkuQAf68AR5QmryEKMXYp3s44Ekl8SNJBKDTpvcyJSbvVex
	ajGyYaNW+8GtQvU+q4j+J8c+QoUpxpszwS81WiIdEHoSE3rIBRftKkX8z5P0/h0dftYkZZLB8k3
	fwG1LlDV5WapA1gJ7FdwyZU9ec0FBjLc=
X-Gm-Gg: AeBDievAE+PbkzyOOs9jSakCLsNgbw5wSJ0nA8YdT7nVg8fA6r77n/kvugomHHnp6Sy
	H1dw5cxCBO/t+g2BnYs6zv2LWnQXbZwfiAyLtsYJIpA/PRhgJrMZBBvf2mgCPPghi0M2niz3RZx
	nmh6WDvS7B3xs3nNUmXdvK/rBr1RwAdWYy7HOettji6jTfIG3w1H6LfVSSuxYtPjAsPEBO/Z3+M
	ULv4cqj4FA9NZBy//wBdJDb2CbOsMdm/Z8z6bUj0zx/8EoFgj2pOjs/LNxVUrKxl7EFQ5oueCwO
	n013Yz7UsAEjEqRo1XrD
X-Received: by 2002:a53:acd1:0:20b0:651:ba8b:a950 with SMTP id
 956f58d0204a3-65310b57b32mr9454238d50.60.1776672223017; Mon, 20 Apr 2026
 01:03:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413135857.2898676-1-lgs201920130244@gmail.com> <aeXGZIrLhqj5hWG8@lizhi-Precision-Tower-5810>
In-Reply-To: <aeXGZIrLhqj5hWG8@lizhi-Precision-Tower-5810>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 20 Apr 2026 16:03:31 +0800
X-Gm-Features: AQROBzBFBiIisj-4pxiJZjLbnFn4lEYzxGSarNfLzYx2Gna7inl4HfN8ws7HQ1c
Message-ID: <CANUHTR_ceCh7n0eQxrZ8a5s25w=Bi6qyhDX1m=ZGLouKCNoJuA@mail.gmail.com>
Subject: Re: [PATCH v2] dmaengine: Fix refcount leak in channel register error path
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238717-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3231427F7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Frank,
Thanks for reviewing.

On Mon, 20 Apr 2026 at 14:23, Frank Li <Frank.li@nxp.com> wrote:
>
>
> I think it is meanless, no one reproduce this. Provide tools link if open
> source. Or you descript how problem happen.
>
The issue was initially reported by a static analysis tool I am developing.
It is still under development and is not open source at this moment.

I also manually reviewed the code path. The problem happens because
device_register() is implemented as:

int device_register(struct device *dev)
{
device_initialize(dev);
return device_add(dev);
}

That means even if device_register() fails, it has already called
device_initialize() and initialized the device reference count to 1.

Also, the comment for device_register() explicitly says:

NOTE: _Never_ directly free @dev after calling this function, even
if it returned an error! Always use put_device() to give up the
reference initialized in this function instead.

In the current code, if device_register(&chan->dev->device) fails, the
error path falls through to:

kfree(chan->dev);

This bypasses the reference-count-based device release path and can lead to
a refcount leak.


> >   err_out_ida:
> >       ida_free(&device->chan_ida, chan->chan_id);
> > +     put_device(&chan->dev->device);
> > +     chan->dev = NULL;
> > +     goto err_free_local;
>
> avoid err path goto again
>
> >
Thanks for pointing this out. How about this:

err_out_ida:
  ida_free(&device->chan_ida, chan->chan_id);
+ put_device(&chan->dev->device);
+ chan->dev = NULL;
+ free_percpu(chan->local);
+ chan->local = NULL;
+ return rc;
+
 err_free_dev:
  kfree(chan->dev);
 err_free_local:
  free_percpu(chan->local);
  chan->local = NULL;
  return rc;

This way, put_device() is only used for the post-device_register()
failure path, while kfree(chan->dev) remains for the earlier failure
path, and the extra goto can be avoided as well.

Thanks,
Guangshuo

