Return-Path: <stable+bounces-272665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BIB6H5tkTmphLwIAu9opvQ
	(envelope-from <stable+bounces-272665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 16:54:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF563727A1C
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 16:54:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=s9lVuUmT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272665-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272665-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15E4130739BE
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 14:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116ED3FADF1;
	Wed,  8 Jul 2026 14:46:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92FA3B774A
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 14:45:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521964; cv=none; b=Vi9RNoVeWK+tMSmox0//eEJAyBphffD0niRSeXqDDlbYT+sMGb47O0bWwNmwgtP/2xLMHE3TFy0zhvCWMuZFk74GUjMAD5+xhSpVt+N53ow7Iq9JfKzjVyTCAsN6c3tl3q9qnFzsrzDrm4A4kerRFcnFy7TKVD9N18CGH+yWfb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521964; c=relaxed/simple;
	bh=rhIP3xpggh82GZU7CmoSbbhDhRtAE2Yq1Aqs3Z7Bwm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Il2NbVInZpcAEZwBZ6d6xX4g7SalrPEd2xr6h789FEmGHvXhdDSe9K9Wmfg7u0K01jb3G4fNmay0kZ7GExZFsklYBdtrXc+JPaC4hMiysaVxJRbEYricKW4Kz+QfpLASC4bk4LlL8cTUhqOHFZhf+gJLCisQYbNGEDJ97X+otbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9lVuUmT; arc=none smtp.client-ip=209.85.128.54
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c19bad03so7467265e9.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 07:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783521958; x=1784126758; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pEp1ol1LlGWoTCSbyN12Tvrg/hxt8xJFi5XclnHnmwo=;
        b=s9lVuUmTwciOqWa1I6yt2CrDPzWoEYlgcbrXZ6Q1oFWpdGj18+2ON9CvLyI5bQfW0U
         a42VpgZZzwyHxABEfoiX48uJn7XgQvnytE8/odS1QzdD6XcXr4AtHcJWuuNkyN38AxMR
         QH0xPyktpQPFfgqmQd2JsbEj0444b8eAJ0ncAnNkhlhTJZfTgHWpWKph95T5D0R6cQY3
         nlMShkb6zp6EGnpBrXb1d5Cgjdhdo7gt303S8OWEhQs7QGySkiUmWXQS5bit4h6otZvk
         DcluSMEO2Gr+j//xIdzh+ruG0NZOppP6R2Q6ik/fQ+4STG3VUxxI0XrJW+Izwnl+w73J
         FujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521958; x=1784126758;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pEp1ol1LlGWoTCSbyN12Tvrg/hxt8xJFi5XclnHnmwo=;
        b=FEG3+YW6pw5n3mGqxhW0xJ7sO+mLXG+rnRcyeaWaBDPmIpOBusVH9+Y0ZBIw5+XbYD
         FYjBkABAL8OcKsGUtPlbdMjuccSiXUsuDGWQTYIXTpkZwrBhdgp0Gx8yaFXhPHhlBZRB
         QL77X+gsk1zCCzoPUnsabvnBguEu7aJZRx65FmCbWJKaZb2dWwWYIz1bYn5JsM2AV+VP
         0BVT4zpYldR9nYhEGAo0T5YRArfxAWKlL/eYns4McthMS8VN8jq9j+ruAcs1nJ2BfL8O
         GHhuspxdzKFQVM2oLCGk6xO3fewQj649fjRBvo5/bjs29sCn1YiWzolW3OA46m5PB2Vo
         jNhg==
X-Forwarded-Encrypted: i=1; AHgh+RpnloyECsM329UrXU5pRUitjv/leCwNsmSGERsL96qlePKqXvFv2uTQbPk0bqj3+RxlydLMhsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbX+Dl6sy8er7JHlOHgc9TU99+CGle0F7cZLB1c4PWVmFC6Vw
	5qhoIAOoo3MzGgQdl5mZS7W+Fl6gxJM4TAtGaBnzTQmactpsiXr3jZtocz5Q7g==
X-Gm-Gg: AfdE7ckimQ+YhHWAhiyj6i5TAVR2dzEg48oSpUFwnjf+OuxESToTH+5Gc2rstnB6AYu
	lKFNGu9WUchyUpLVHYaZySdsQRpDN46+cxylY552+Z/8ORMltUgJiKxjE94/hjqTKZ+BLvVEeWF
	BOmkzJUHFldeTkAnZU66ncs2BxkrzaZLI58T5k/82lN0KfPeYL8YBhhtRnJDyieuxMNDvgac+LL
	o5KrnP1fosK4yh223ABsCSML1nHoIm/M79eR8/hJgUS2VmN1ksssw91G2C94qHpzHZeMK2qigpM
	rMkWeUVKsl4TGGeWAIYESJWKVCwraxo7Q33oXWXuTepNNnndttz1YPM0pcsFhG2GT2fWchrshIc
	x46ILi3+e9QrRmTCEo69o3CLzu/783a6S+IKPkASrvFNtJM/04IbggiY4qI/GbCvPzX5F9JNZFI
	8LjyQUvxCcabeb/riBAasc5BBtWUEKOQHQvvnFNOVf88+VQ8S5wmnThVJskxIx4GChhJSfVNAfv
	0hCPUvuokrYuMbjy1SaBizFgsL/jBbupJ6PIky+r+eQ8TgMk/9XaaJ1WlFEHkPSuIuBtGrAjMw1
	4lkSJRTKDqC7Kh88OlecBO94J6Tr/Ec0VDqmGWNS3ltL+cC8+2/Px9/ok3OLFcTEoAM97cEe6XM
	2dNUWz0DybiwLcgjhB7tDD4lOha273pdvsw==
X-Received: by 2002:a05:600c:3e86:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-493e68316ecmr30972775e9.2.1783521957530;
        Wed, 08 Jul 2026 07:45:57 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294b3sm129329345e9.3.2026.07.08.07.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:45:57 -0700 (PDT)
Date: Wed, 8 Jul 2026 16:45:55 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Stefan Popa
 <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Ivan
 Mikhaylov <fr0st61te@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Kim Seer Paller <kimseer.paller@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: ad7380: add missing 'select REGMAP' to
 Kconfig
Message-ID: <20260708164555.0000602e@gmail.com>
In-Reply-To: <6d8c6b4b-89b3-431b-a31a-11de654c2901@baylibre.com>
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
	<20260708-add-missing-regmap-v1-1-6d424322e3d4@gmail.com>
	<6d8c6b4b-89b3-431b-a31a-11de654c2901@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272665-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:dlechner@baylibre.com,m:jic23@kernel.org,m:nuno.sa@analog.com,m:andy@kernel.org,m:stefan.popa@analog.com,m:jstephan@baylibre.com,m:fr0st61te@gmail.com,m:marcelo.schmitt1@gmail.com,m:marilene.agarcia@gmail.com,m:kimseer.paller@analog.com,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:marceloschmitt1@gmail.com,m:marileneagarcia@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,analog.com,baylibre.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF563727A1C

On Wed, 8 Jul 2026 09:32:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/8/26 12:34 AM, Joshua Crofts wrote:
> > The Kconfig entry for the AD7380 is missing a 'select REGMAP'
> > parameter, causing build failures.  
> 
> This one has already been fixed.
> 
> https://lore.kernel.org/linux-iio/20260603134955.2f1d5ede@jic23-huawei/
> 
> Suggest to use linux-next for development so you get both the fixes-togreg
> branch and the regular togreg branch.

Ugh, my bad, I only use the testing branch in the IIO tree.

Thanks

-- 
Kind regards

CJD

