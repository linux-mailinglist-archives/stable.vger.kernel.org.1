Return-Path: <stable+bounces-230194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4D+PAOe1wmlolAQAu9opvQ
	(envelope-from <stable+bounces-230194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:03:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2303189E9
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCBB0310BA2C
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA638AC73;
	Tue, 24 Mar 2026 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BAg+KLwb"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBC7389445
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367839; cv=pass; b=crj+iTv6Yr6//pLtFavpAMUzORPDmm/mHZznOJVN0gYCZhlqevVfddzJdsmINnZ1MQcLSKREK9MzFeQYxT3QerXMcfCXSU3kQenkCPZ728K92BXeTYH1MBfBdXyN0ubVBNHwPxszxohCwhbZnlR3CCkCHLAV27+lDDBLIOzlWFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367839; c=relaxed/simple;
	bh=9DWC/vfXqs338085CPXMd7zgnZlJCsKQugvNz+oO+5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpS1d5zU+AkKuVKU2V8KImJwhE7Hfd8EiaQUNWMezYxCxcX6z5HkJgnO0vHENjkKGXQfcn6AOtFmC43kj8nc33FwcB9Z8Yo4m1v1aSGIsTLp4X9HHoYJiOOgIfADO2XbF128Az7AyLZ2aYlieHvLH7OrPcW27MS0eO+Var+podY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BAg+KLwb; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50b713d6baeso8927561cf.2
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 08:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367836; cv=none;
        d=google.com; s=arc-20240605;
        b=f/AxGtzqh5K1uPlpDpIrozBekbDsYaXh/dTNAZC8YJNZswD0kk5XC3hBa8Br3VUhUP
         6RUFB3pqBrWjQVRnMM0d1x6JwvYXsJ0P6yEZ1h5L0RW6hChvROImxfh4K/Fp+/k39Ak0
         6SiWRldgdZ/znoCOXKzfM8E8McWJ89TJrWqAz2FlJWfyk8r5NPbVPMTZMi3VmaQSMJ1Q
         e4myUWrRjuW+fzEzkGPEyJgCm8qunGdcsmYwy6iuKEtfImuUp7QeGJZqSk8F4EllhpSL
         tXnKXhRuNCAfcOO9iI+aH8eD9O+74Lo3KCTtKMf8EsxgOc3pKlXnlckKz713QqKAEWpt
         tYjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3zCAzoW2GC6nZkAoqIbb9lMGmfhoc5bqKvLxG5ho4hQ=;
        fh=BmeVIBN0z5iouUEdnT6RYEiVnAz+8GlC6GOOstq6q2Y=;
        b=FpyzJLAAMDm9j11BXVGIUWYereUE2wTbDbrt59XQC0ngKtORLkqEBkxfoAB+1iBvip
         yTvWtUVg5KUGdvM7wpyZeYJNVdmJwAXH50FdJgz+oM6MsuZa25pCitDk9w5WmrUozOT6
         SNPnYfHaRV/7RskoKWIkgPbjAjsu39TCK3195+pPANMpA2QMsZ3JnQdsZAi5IsfnmS/w
         MHtnlDj6/uqlAToa9dHqG8skXKUx13bFMsMvqDWuTHMUDgZedvlmBINOuEsvbE1+G9WQ
         gZFhvcS7Qe+1xmW4IHce4XY0MataYWkGcI94MPyTwtbroQOu10gi116oioMVs7G1Ylu/
         w2MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1774367836; x=1774972636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3zCAzoW2GC6nZkAoqIbb9lMGmfhoc5bqKvLxG5ho4hQ=;
        b=BAg+KLwb5k/X5M6uv39u60APSUNLrQ60paxh53y0DYfI3ZbPxHVTJqRGZ6WEnMDNad
         AvjHjB+TRWcokz+7/HxqTI+jj96230lS1v285zzCubYdwPSyruF3BYfxD8WgbyZ+N33C
         3F1T0YM6etCYC4Nt7Sklmx/BeG/UgtW77GMI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367836; x=1774972636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zCAzoW2GC6nZkAoqIbb9lMGmfhoc5bqKvLxG5ho4hQ=;
        b=E0HfKhzZ97F1tuWBq1t1P9N0S/Sv9HyJniekWC0xQzzBjF/eedQc9v+S8QKvgjNy0/
         SDk4RhGYPft7Nk0UWtwFCyciUnUEt6LAb1pQD31cfiL3PmVD/j5s7iiMU9fmNbtZmJeE
         MuBE0RIszBIB9KBmGdMEb2kgwScxydiOxHlO6VWkuSnvSLYMA6gQmUyNakZYXpFLeewy
         aeo9qmTFmZQydx5QVXDi3juob1pjCaMH74pfeG8CGzq3y8/YFSL9EgKbWboXXDsd4j9W
         jh8kzSXQb896nxDsbZelKNgwihGND91zke9ZJyvAABP5+iYyZgJ0YMqieYCBYNM7Uz85
         y4vg==
X-Forwarded-Encrypted: i=1; AJvYcCURTzglEy8LpEEyBw/Vc7xBLDXzLH/7GXWipIrnIsNPnrPMGHLCoc0eADw/ZqYKlgqz/wejvog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOZMqU4S/4DPbhPqC452pvZtrhbPICDRSkaRm9oo+XJfHWFx0
	fQm7kRWBOySQ9nCfVjoaFXXanG5rNp8PeeyY2LgOk2ZFhZgUJ6ayzDzHGSFIDulb+P5zmteyVHp
	ZhIUapXjUgsyfafXn4DWGiVa+9NycDRbuZ4Cjwk0LAQ==
X-Gm-Gg: ATEYQzxYQE2QoCPZoV3PQb1TePqr5hV4z7OYcrkpXkv4rLfRUPhIpdPvl5LMqW1B7P3
	U/ueim09T1g+qXm2qBEkLMC49Xq8iQhvqbRoUJZvngqPEC6nIDSDo9lFdvnh0tR2tHtwFsZTLWU
	Q1U/kw/0rC1K9oak103YeP5er/2UeL5pMNWKdx8pfth7+ZB+jHAY6WpdxHZ/TSaWanYChyzMHHl
	x9Yj6mfI3OEJgwvt0e062Qju05ULpOZylNM87aJFZSb5bBwJsGlWrpvKnZvlg1GTTne6ZrW3HYm
	d5qT4mPU8w==
X-Received: by 2002:ac8:5783:0:b0:50b:382e:f09a with SMTP id
 d75a77b69052e-50b80e2ea85mr2025751cf.33.1774367835984; Tue, 24 Mar 2026
 08:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324152221.96677-1-amir73il@gmail.com>
In-Reply-To: <20260324152221.96677-1-amir73il@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 Mar 2026 16:57:05 +0100
X-Gm-Features: AaiRm52oL9hSK_cZrHM-DIg8dnovrChYo_u5d4j1I3-1UApTjM2HEzwX2tu5iYY
Message-ID: <CAJfpegtkvxkMcdoG_tCxMP4FF3FUq-PhXMByWFx01gTWXZ+_QQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix wrong detection of 32bit inode numbers
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230194-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 4C2303189E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 at 16:22, Amir Goldstein <amir73il@gmail.com> wrote:
>
> The implicit FILEID_INO32_GEN encoder was changed to be explicit,
> so we need to fix the detection.
>
> When mounting overlayfs with upperdir and lowerdir on different ext4
> filesystems, the expected kmsg log is:
>
>   overlayfs: "xino" feature enabled using 32 upper inode bits.
>
> But instead, since the regressing commit, the kmsg log was:
>
>   overlayfs: "xino" feature enabled using 2 upper inode bits.
>
> Fixes: e21fc2038c1b9 ("exportfs: make ->encode_fh() a mandatory method for NFS export")
> Cc: stable@vger.kernel.org # v6.7+
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> I have queued up this fix.
> The regression has no serious impact on most users, because xino
> works pretty well either way.
>
> A nested overlayfs, where the lower overlayfs is nonsamefs ext4
> would have less xino overflows, but this is a very corner case.

LGTM, thanks.

Miklos

