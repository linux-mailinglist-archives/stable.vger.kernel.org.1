Return-Path: <stable+bounces-108648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CE1A1118F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 20:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5731E3A1CB8
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 19:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B16420A5FB;
	Tue, 14 Jan 2025 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lwbg7obx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F403220897A
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 19:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884600; cv=none; b=T5vLh+hmbmimWsGFUDocd73v07rPRbK76BaWdULbrMHh7a7R0FSxGPrujLga2TKBhangbfYNkBjqLaq91BLlYQTe0t9OtWMJ72WUadKxw2csbMs6aTEHj1e0IWAmIZZJKY98TvnLruqDGnyhYSWd7kTE0N4kH4dXa/xIoaaJC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884600; c=relaxed/simple;
	bh=y/+EmGDA9oQh65FkQDBWgjTtUb9Q8LO/NWhu/sSSR2s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7k32IcQ9LbMXeQgcK1HDXAvjVbaM3m86aVS3LDv3/yZbo11uIqmpJdizq6f87+ugmzjkDHR/U//zX52gltmhYkaNotvS4FdkVEb/m/o8VouCXNYINEfZ0BJ8WUCEN2gKycWyvejDFjlMWnKuvzm5prs6YJkXbhSBs1+K/TtA58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lwbg7obx; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso42581425e9.2
        for <stable@vger.kernel.org>; Tue, 14 Jan 2025 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736884597; x=1737489397; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OmWlR4cF+mPlvD/SKofAb59V+xFfrfDkiiQN2ULLVu8=;
        b=Lwbg7obx6A9/bESQudinRz6qKVK+DOZJokUjGSNHcw6pSbb1XKY9YxyJH9+y+XOvHB
         JBzEEKp9jHf5xz12via0CbnxZ/3qWmS26D6g7KrZ+xle1sES4bPHKk1znJourdMeHZJg
         5ypWAT6BVB4447KtyueqA1trXRfhWYMFbg+anGv6GyBwhaF1bIq75dbBcx33ROfMzhOW
         OIVOIyJMQtSLt+8aTS0HJ3XWW5ByAkc5dGb6/fqAl4r6ow7ri2JQ1wqGhOzMLoOaAih7
         DQW6cE0y76hJ/3yoy/4thiqSq3bs2PG5OlZiXz8m6LlE5s578LSqKJ/wjAux+5p+YIfz
         vScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736884597; x=1737489397;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OmWlR4cF+mPlvD/SKofAb59V+xFfrfDkiiQN2ULLVu8=;
        b=hQdgDhWVxncf8eQwpCNrRJrfjxTPlXZZ8/Z7zZ9GnCopNFMpcqajeodiFLrDq34Ud0
         gGQosVw6ViXxnwn7uPRdJObFI9phyWQEgQhzgvwZlTaO6ucsQBof32CWLhgyAUtM5rhZ
         hujb4a1cWuZrtzbUVvgrqn5zwTz/aT/W5uahKUVaG2GBEdwfTDXriN+YHqSfOuGzIZM1
         C6QAWvRupSkynmfWGO8T943J/hkEvFUR8KZlz6/nSoAOD3PNpMGkAcn5yXKZTmQeUUbP
         mysOFmilzekmxsRz2yA3CJhkK5fqMJkdgh+cNQDGPvVHxA5s0PP87BXm+J1tiSmuazuJ
         +3qg==
X-Forwarded-Encrypted: i=1; AJvYcCX1llSK+Eo+Kl+/PQb6mxDb78mPIEPkAo5geapKJpZh/+JNMIUst9CVciPl9wb+UaG2B4Y6eqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmPsHXT2/fRRd3GEf5Hc2OPp1QDq2VoPYZtxznzkIyLOpIJTXs
	BES5aANyO5FjZ4YfGYxHoKqSeHIONys1ofeNRZTZUoUS5M6P/VCOe8Uq6r3ueKw=
X-Gm-Gg: ASbGnctMHd7G5jtGQtsGt7kWSzKbEelcCguckWtuCxSrd47tEHPHBXBVNcNBeIqtRly
	AeQS7FjDAV4N/BDSF0BCuK/JxuoBZ0T9myW98SZ/2jFak9ESvgDPlXX8D4F8UBGxkxlaGCjnsnK
	qtydZtNdk4BxyPIODtV1shWDLmlpwhvRjlL4IcwA3g2D865wa7kDYpxWNqMIBo7rCpcBvbjGIQF
	WrVG8OC7wIj2WIKSMrVnFspcZORPR4/3lTE0uyv/qrsZBVzhPUYuD6pBk+e
X-Google-Smtp-Source: AGHT+IGQouXUOO+qEb5G2vSRcAAdIKYNRk9bOvvSttjkX7QyY7z4FXFdlG3d/Ksq2SBLmY2mxOAH8w==
X-Received: by 2002:a05:6000:1f88:b0:38a:615c:8223 with SMTP id ffacd0b85a97d-38a872f69c7mr22826797f8f.10.1736884597362;
        Tue, 14 Jan 2025 11:56:37 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bddbf50a2sm5275313f8f.43.2025.01.14.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:56:36 -0800 (PST)
Message-ID: <13a3fdb675baa36fcda1bb254b05032b1175a2a8.camel@linaro.org>
Subject: Re: [PATCH v2] scsi: ufs: fix use-after free in init error and
 remove paths
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Bart Van Assche <bvanassche@acm.org>, Alim Akhtar
 <alim.akhtar@samsung.com>,  Avri Altman <avri.altman@wdc.com>, "James E.J.
 Bottomley" <James.Bottomley@HansenPartnership.com>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>, Peter Griffin <peter.griffin@linaro.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Eric Biggers <ebiggers@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker
 <willmcvicker@google.com>, kernel-team@android.com,
 linux-scsi@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org,  stable@vger.kernel.org
Date: Tue, 14 Jan 2025 19:56:35 +0000
In-Reply-To: <58f1b701-68da-49c0-b2b1-e079bad4cd08@acm.org>
References: <20250114-ufshcd-fix-v2-1-2dc627590a4a@linaro.org>
	 <58f1b701-68da-49c0-b2b1-e079bad4cd08@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Bart,

On Tue, 2025-01-14 at 09:55 -0800, Bart Van Assche wrote:
> On 1/14/25 8:16 AM, Andr=C3=A9 Draszik wrote:
> > +/**
> > + * ufshcd_scsi_host_put_callback - deallocate underlying Scsi_Host and
> > + *				=C2=A0=C2=A0 thereby the Host Bus Adapter (HBA)
> > + * @host: pointer to SCSI host
> > + */
> > +static void ufshcd_scsi_host_put_callback(void *host)
> > +{
> > +	scsi_host_put(host);
> > +}
>=20
> Please rename ufshcd_scsi_host_put_callback() such that the function=20
> name makes clear when this function is called instead of what the=20
> function does.

Would you have a suggestion for such a name? Something like
ufshcd_driver_release_action()?

Unless I'm misunderstanding you, I believe most drivers use
a function name that says what the function does, e.g.
dell_wmi_ddv_debugfs_remove (just as a completely random
example out of many).

If going by when it is called and if applying this principle
throughout ufshcd, then there can only ever be one such
function in ufshcd, as all devm_add_action() callback actions
happen at driver release, which surely isn't what you mean.

You probably meant something different?

Cheers,
Andre'


