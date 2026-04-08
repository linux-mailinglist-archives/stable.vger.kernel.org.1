Return-Path: <stable+bounces-233731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ph8Mgmo1Wlf8gcAu9opvQ
	(envelope-from <stable+bounces-233731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 02:57:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4BC3B5CA7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 02:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FF41303A0BD
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 00:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB162EE5FD;
	Wed,  8 Apr 2026 00:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jutTwTox"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBD1A9F86
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 00:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609843; cv=none; b=jGlwaBfkAxUmw33JE6DAF0W5upnzJZszzlmPprdeGIEnqAvsUoGWhb0E9wFGQnkX/d9k3RjAvK+D0xpmPysw8njHMfhuQjp7IqgRrwRRdAFC/iSHTjVI7O8SCBLrkJqULhRQGoxxyiqpwkuc+Q/wbB5U5tWVDNwjkjvUgMSxtVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609843; c=relaxed/simple;
	bh=vltGgRctxcK6xNVXLyadVC+xyndPCUM2rNpMXA70igo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjaa8QcFASa9GwiAzLe1qXeiqhD5g4XSJSpk9Urzqa+sbND0SM8mO91RqlBjZExDzRfttsaxj4SFcbxHFpddiCbxLX+XQRdVf+s8zSkJ71uuCN48nbVC9nsucJYN66qBqjeWqSUQhy3qwV/hQQ17nBk5yD4/R7FRMfsCz1jTYEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jutTwTox; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9c9d03524cso464258066b.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775609839; x=1776214639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vltGgRctxcK6xNVXLyadVC+xyndPCUM2rNpMXA70igo=;
        b=jutTwToxf+ayDNEht0HS2CgDkc8xX1SpZBkl1g/zzjwBmBKwMCZBzVUpGjMaUm8QpV
         INNkSQ38y+QNjeuqGpKnfDIh47tL8jqnUrTKY3eQfOlYHA1RQfv0mx/rjf7WBy+rkhcE
         aSvBFRYqL5BD7eylz6fsSGP/H+Zqit1hg6p9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775609839; x=1776214639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vltGgRctxcK6xNVXLyadVC+xyndPCUM2rNpMXA70igo=;
        b=jYaNjm4uRPK4RlRP79HfKSnaKFEdm/VJ4hZ9Q0ZBJlVeV3RvmF2pqXXyStPtr9vgmo
         8kAWGGM0mGbhFeFizAZrRgbd2fr5lm7Jh5f5dk8h0Og8Bnh0S51pXAIe6wDZ1xa0SyQe
         hGUpdn75fK/86Fhe6R+G03mjGG+3b9HJ6n2qTCj5UWPdjKcZG55srpxeCITFZvIpkeWJ
         xmHJe60GliEf8LCWqJTEUvM83RBlyCAbRtAZmDbFUEnmKWw05Wl28DKBulrgyNwYV7N/
         zVIzlVK5oKNyaFUfRgV3g+COrLik3EYkiaNXzPLaeQphugryL7p9CAi9gn38NqHu9C0u
         beQA==
X-Forwarded-Encrypted: i=1; AJvYcCWF6psrOENlHj6F86XnTqyC/ENLNHpKquzZ80ujUGU/rQr9D8KRNc+CXGET0JYSYwml5o/ssRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClXPDTZdOGIb6+yKLhMeKE36KMKfVmBQOVZO3MQ0nxELes8vq
	SPwJ4otlVHYKUNV1911hA3N2JwWPWovneKWfCCwOvZ48Ld242jKYQS8SF8ndvU2eLQIeqQyL6Xu
	z7nGEig==
X-Gm-Gg: AeBDieutp9sQQ5yJtmpaW57Vc5G/bWRwdtAY0AgUL/jqiqIsQs+2mFqPyv2RnPG1xLJ
	e1VJ+S52FZky6ZTUdKs3b8ufGo4+2oGwMYCZ59AxN1JR4d9CWiRvtNJ6S/sbWSsiApO1jZqgdlb
	GuXl5GJQIWIlV3mdyVBhiAHd6+3vr/KbmhoUnLd3MDMCMTndMLeJP0811V41rs1RaCG+6+4gg4a
	r+GCNdrCE/a9n5LZ4vOYSxx6h5go5P5YyMmbZULVxKcxw0viQlHJkpZQ5Xt2z9wQTFZeCpGMVM+
	nrOWroUv68LHvMb/A2pv3EvBln7HBjn+yamODnUybM1WE+lsH5PdmtF/YcduYQV8/1FFLpNNgWI
	TYo0GoMWevzZ8Hv3Bbfxuh5YsJuQIgQuq/AybMvB706NnhYZ98X07H2x1piADhOSDnWp8SBJryE
	fhgMD6vVKPvG+/GZ5kLW+HakkzzpV71IwtxBGCxL3C7I5kvz6BPpK/MMw87QyRVw==
X-Received: by 2002:a17:907:7fa2:b0:b9c:9b75:70c5 with SMTP id a640c23a62f3a-b9c9b757d1cmr817329566b.35.1775609839261;
        Tue, 07 Apr 2026 17:57:19 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3d026466sm584468666b.55.2026.04.07.17.57.18
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 17:57:18 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43b95e5b3afso3146434f8f.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 17:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbcgoeZc+XMXKphptz4A2cN4a7La+9zI/C5sSbePcaHuGNPQPdquFIes5UM0ZkbgSuEg1AOsI=@vger.kernel.org
X-Received: by 2002:a05:6000:2313:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-43d2927bb89mr29559425f8f.11.1775609837572; Tue, 07 Apr 2026
 17:57:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407094156.2573027-1-johan@kernel.org> <20260407094156.2573027-3-johan@kernel.org>
In-Reply-To: <20260407094156.2573027-3-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 Apr 2026 17:57:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WevFKZs5fgvs-ESNaXsZgGnnREuSQv3eDx+SCz_FibXw@mail.gmail.com>
X-Gm-Features: AQROBzCxXm2pGSS3ZdJUtvXSvhbl2wjjbYO56g_aGiuHGDPMuj51FobaVu2l4nQ
Message-ID: <CAD=FV=WevFKZs5fgvs-ESNaXsZgGnnREuSQv3eDx+SCz_FibXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rk808: fix OF node reference imbalance
To: Johan Hovold <johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233731-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,collabora.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: 6C4BC3B5CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Apr 7, 2026 at 2:42=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> The driver reuses the OF node of the parent multi-function device but
> fails to take another reference to balance the one dropped by the
> platform bus code when unbinding the MFD and deregistering the child
> devices.
>
> Fix this by using the intended helper for reusing OF nodes.
>
> Fixes: 5111c931f36c ("regulator: rk808: cleanup parent device usage")

I don't think this is quite the right "Fixes". Even before that
commit, the driver copied the parent's "of_node" and still set
"of_node_reused".

The first place I see the parent's "of_node" being copied is actually
commit 647e57351f8e ("regulator: rk808: reduce 'struct rk808' usage").
"of_node_reused" is first set in commit 1b9e86d445a0 ("regulator:
rk808: fix asynchronous probing"), but really that should have been
set in the beginning anyway...

Other than that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

