Return-Path: <stable+bounces-247604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WG3sB5LgBmrLogIAu9opvQ
	(envelope-from <stable+bounces-247604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:00:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFBF54BDEE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CF530E98E4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0360D413237;
	Fri, 15 May 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIK0e7mw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847FE410D21
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834515; cv=pass; b=jnDm7/tiG/EcxdFXxU5y49OTp4lMVsQc+6u3qyDeBXuyrJWQ1CrCmeJ/iQFws0O4K6h1wCQjRSnMWqGcAgTUrUS+Zl11+R4UUqHvP8fJlnkQFELLJHiq+LOkZOLHtPsqgiFov5b2tdB4+Yx084wzarg12JnjlaRwzdZ50TJzeDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834515; c=relaxed/simple;
	bh=I877MRSe9H5vPYZq5yiCD/TiLGWBm9ufbCGIjpcsS6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZoJI7NyLkYA1iZujxdyZkpMRqVelIlvr96Ov1qaqLYHKfzSh434K9Fng57grCnrsusgTThY2d//5hxLwnsLoGRuBCkjsmd68PN5M9tvh8IgwH3HB6uBeIOD6RofWqJF6fWHayvfLW7S2WCtuBvGhi8cyY45OXaq+Luj1WjeqbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIK0e7mw; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65d071aac6eso10214746d50.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 01:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778834513; cv=none;
        d=google.com; s=arc-20240605;
        b=FMpFj068OoBolKGsYJ0PQMnsxso+26DSOjR4x389Nm+P+F7zywu/u46iBId8sBVZXj
         U/Q/vbsTMGxaf+jtzj0ivQQI30WyoX3Zf/vZedmfVQkthFWJz/aLukJSgxTQZKTS9cdH
         VR0vZNV/DXFR0bQbuaM5qhhOCZfWfrPRQK+POMFuX0qUBdwo1RD5kMxlALkGApPexDIc
         DVb/6ZrP1SM75tw6CurBp8CO5u0q6L9DMOMB51QU6rGtFklMtprQb0pTJrCNwc4CA9U/
         kAJPnPdn9mQgARL6OXgE0sdaApa6WDmuX3SNPHfdxoAdqMYhZ/rpZGgzsu0RYhtYIWCy
         3Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
        fh=/wrGxbh0P4nR611SMC7cDhKk7AM09Gxzo79dZ08mups=;
        b=gGBc5gnZY5VgeqozWCWMzISzJPzBxUKJesPsGMlb3mwJ/6wPW9QDN0SRGYi2Pm3ns+
         RUT6Gh+kd140KTzQ3f1bLl/gJFkUp1zBYhqXzkN+LjUuE1+FtVMAfZP/faYRn5rbJDKL
         nwOwI3oJev9dQOCN2GNlXu9WQw++7mliD2NagNQne/5UKLcxmZ3SRJIlaFUJaTLyBny4
         M3ccWaJNNrlFztxO7H+b9ip1TUoC/25Ijws11ocrOGu8vf+ROsBQ0DOxgov0XdhvxcJ0
         gtHBXv3/qZqR9dD+x/0shq+dK8a5lNPSuveBQsAhRoZYcxUPvF+rnpbSPjHumSbkYjKD
         xyug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778834513; x=1779439313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
        b=YIK0e7mwJtCTnrAFcWtAoDTrRQ//NLi6l8iDd6Xi2GhYiI+05s+JsC6h230/Wxi9iO
         QFSzQ+Kbw7H5MnmmEKJL+LbCb7Sx4QWsSVZT3k1kvbiXY6W+dHvcM1ZgMCtiW40Eb5vi
         pjbJ7iGZxRr492oBAIyf55xLi9gEFWW2KvHaKsmxeVwMX0jqN8DvNJYzdPK4HPl3C2oM
         yzVUuLltn92f/FxfEH5ZWwRWxXttckgZq8h/8u62UKuqaClChjRoDvPiFlunjoBw35tf
         TlQBqKKB89U/Wcc6idYnfvKBxxn7RSH+eYHcFWDSXgSqM/65RJyC+Hoz5JAF9UIDwutC
         FQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778834513; x=1779439313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PBSjZR3vBTrgdu+SMltlDgYPuNOIji8ITlL8pViUrIo=;
        b=r357iEDfQQNxjBGO89nJeCzKQxnE7hIHiAd83BedD1Hu+uLx9RdIZglSgjK/kkamLt
         KuCGWOLYCMnIZMpEW9aeP5vo2rbCXgn5P1BFsrLHtNRpPolU/RJ84lcM6h+5WunfvoPt
         rAqBLxLmh2UE6RPRE6J4sihAu+H7LSKeb0DhQ0cvX+3FmQpbAMm7QLaWGEtJ6aa59eyE
         JOiIVLkpkKuEyXJOvOUzhyAkKUuRhZSGE+hq6UscRb8fLahqT30Tv891PSwvAlz4vOh2
         YUFcFJupQiHTTUI7UqZC20zKNVLKFZ8CV8oCeXd+TMF7miCWzBL4nXoCRAi2bXA4gRTV
         wOHg==
X-Forwarded-Encrypted: i=1; AFNElJ+2lLE6NzCeLkFmWKAnrjU7lDxyjExhSSaOSsCvq6jnZKyzAfqwKxP8eoWqmtOxCfjQFZUhvrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOORXx2XR4rxtkSupmgnpB/ME6zH46HulSBWd6IesqodPd+x/m
	0ZPMxgcFtGwqCSgkjbWSGFi3tgW+MNAQktF9RzmS5p2hmm5eruO/4kpWsI6mdrq4PcSBGM6ahf9
	UB2Mb0fhJk9Km+JprcKML63TQV6Gn31w=
X-Gm-Gg: Acq92OEToBKbcpYKUHhFKT0XrKE3nH1GXxxaroZrbhapLA59OgaqZle1ngkjHQJodQV
	FFM4HwovEdp5FOfeK2U6lcgBkY3bVoIOpp0X3mk9YNl/AlHaIcj6qcTW6ZmxRcSdNLkTIWSk7af
	X0EpI2ieIwITRlXk6YXyGn6JSxuKdmDwDjyoA208OZJWe9Ca6QP8VP9zIUlDrTYBvAxmNQgsLFw
	UYNElDbuVM1eXKyMfJwcBBjPaeYUNXghz9BSmyWlSGwE+DyOZNOL4Z4o4tvYyofWO5NVhuuoKUV
	nYi4rAr490KlSADWMleO6pFemKk3j+7eDHsQGf2cZoJ4XqGL9PVqFdAAnJcBfdz5XHRa0AGP
X-Received: by 2002:a05:690c:4:b0:79f:d961:47bf with SMTP id
 00721157ae682-7c9594b0105mr32678827b3.8.1778834513472; Fri, 15 May 2026
 01:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512020718.108044-1-kartikey406@gmail.com>
 <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com> <CADhLXY7N0eLpA30eV4Rb=F4vzCf9XYtDjMpxBSJtGeMWNi6Cwg@mail.gmail.com>
 <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
In-Reply-To: <65da2ce9-a2ab-4800-a73e-1a26082d0605@collabora.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 15 May 2026 14:11:42 +0530
X-Gm-Features: AVHnY4IGHTZnfpb9msWE08vJttVqhQ6G8dsaF1hRX2r-HcKGXn0VdlxicBL5ZuQ
Message-ID: <CADhLXY6L1RJvgfMGuogmw7bx5Sj-_6G2C7zR5q+xLQXu_M-Tjw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to prepare_fb
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, simona@ffwll.ch, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7FFBF54BDEE
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
	TAGGED_FROM(0.00)[bounces-247604-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com,lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 2:40=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> > Does that match what you had in mind?
>
> Sounds good. The virtio_gpu_resource_flush() also should be updated to
> use uninterruptible() variant.
>
> --
> Best regards,
> Dmitry

I  have sent patch v3.

Thanks

Deepanshu

