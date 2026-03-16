Return-Path: <stable+bounces-225696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJEQIXpluGlOdQEAu9opvQ
	(envelope-from <stable+bounces-225696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:18:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F852A01F2
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B71F3046510
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFB43E92B2;
	Mon, 16 Mar 2026 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8ri1ixT"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A35355F2C
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773692279; cv=pass; b=oaWRsI42FIHvclKEJLwLCBdqUGf3vKtgCWQffcKMZyU4op7yfYjBFtyUFMAJ8QwXnMrWbRQlgpleh31Mb737j1AGg2uzmaZ3LF/pjrcCDGPCmyxsJ9W+t6bs4QVPaAdaviTIvsJrxEM/ZXZf9wPurETP7xwhI2mbGpjNOx/jHEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773692279; c=relaxed/simple;
	bh=zflpxtRBylCX5rFH1aSVW9cpbT8IuiGQT38tsF8ylXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiPNg/XHnkc21768jGQ3Hx5IXkWcD4cqGwhtsXQDLEsmhCuVZwr/L8WAd3/W+SdesY0p+4r+gFPklPhnC4Yhl6GQ9BShtQsnw5jXE7AFofgld58GgRXwOE9wpPnLBgdav9n5P9TBonqQj3bspgOCHFuwWuT+5CMVQHTxtl5O5qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8ri1ixT; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-56b679e72d9so1314304e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:17:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773692277; cv=none;
        d=google.com; s=arc-20240605;
        b=Xva8VtGN7YvrSgJMsTJsL5XE3Ev39Q3CxLCitARAZROueImz4ISOknW8tJXCUZ8XVO
         1kE5hsfQCbtEN2hbw/K9dIy44J9TuEejW39vqc7pZbfA8tKr97jbVhzo0EaFxhb2d1Vg
         EeVg+1T8m0nHf6pEoZgU4a+UIP3AjT26N8uPsHKoYVYmGKFB1PE82ZAD0DIH+B0bfIu1
         n36wcNiw7dxAxnK0zw9yAzjcX/FJADi7iic8kasPvJfSM9MOiDe1Z+qYQis7lDJyLEc9
         Skptc1hAbm7IhOXYjywPwSgICx5ydIiAFk2CTt/Isymf6M2Nfcc8nhQsp5NGqbXyYEsV
         2sXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z9Q6fH9c6L1HLnK289rjhbhnEGeVoiRSnOJS5fAspJg=;
        fh=t4T5geW5MVzn8E6A5JjHShyIUZevNImyXD2viTDbcqI=;
        b=YjpPA/8LVdWeZmYqR30zGIJtWv/DAQqijrkoM3cth5SuiDQDE/xx7xJtlzd3vGbYTX
         7jGC1rI6hDiud6FiNleVY6Zot0k49eDvcl4fAEf6O31MQe8Y6ZQu5UzP7mHt4ZrWycVH
         yPOA91vHE6AtDvDcrQI4IXc/JvLnJL2n9ARzzE7ZlsflTrERwn83ETQF7Uareu5GiDNw
         Gz1aJFOEtOOHxy5IBYJvp7dviXNUivNFoegJ5UWPRyZRMB+p97yQgQpm2lh+s56yMQev
         1ppDdngmey40RgmQF6OHgxpBtVWhvkznKgHZEkYLJwHC3UyhsPXphcpzJko2nyGm9Iwb
         RqjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773692277; x=1774297077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9Q6fH9c6L1HLnK289rjhbhnEGeVoiRSnOJS5fAspJg=;
        b=u8ri1ixTDzIQxdC3TGqvVvkrleLPHqqfAiTWEMbkICgOCrTocy+FVEorLtqAypQIic
         5boB45tp0hc6jK/YeBee8DIFKK4YxE1N0ZXalfQgebLxDTMyg8Eczngrtz2N5RXIzF4R
         4T3UxnW6isTBqY/HVwtx7jYJax8o5dROVjGecgTlveQyodatP99tEM36/6B/nTmgyE5X
         u/TsJTNAG/vdazyTnRFyKJZT6pt1AsJz6CWn49k/smcHUze4VxuHLMrvc0vTTQQs4j9W
         rqtqLNe2Ev8ubOK6VuZRtPNHxuOy0wlLlwBi3WFOBrq045FYCjrRT2KXvdv6y3dNI+zb
         gWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773692277; x=1774297077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z9Q6fH9c6L1HLnK289rjhbhnEGeVoiRSnOJS5fAspJg=;
        b=kWtITYISoHBp0RlnG+de5o9vgoYL1NBJXnR0b7dawQ9D7bCJ+hs9y2sRBr8Ho6nJXR
         Ji4RNb4gyv4m8g8mjSXIitObGw+2DW37Jo42ErMj3fwGK6OxJmmUXn8l1XHUlBNI5r4m
         jpJe58er7mPlelNkWcomryDoWkHCSDzAOzczo7DKdXx5xmHDpZDHGUbRD/oT7EHNzVof
         t9cDRF/AAHCzTeZ6pC4lfZt1EYSRkpbfECSYlX09UQTdQ0nfIIOCp9fMsugSgJj2Cu7R
         A7Ncws4iZqut+LEvSGiZTokchI9WIxEuw33cFB+jwjjWd/Px73+DSjRbPMVESZzK6x2p
         7hcg==
X-Forwarded-Encrypted: i=1; AJvYcCWNNhA6h1uzt0vHSBUjosyZUQB9tQsCNeYG/NsmQVgi0oV/Mie7rjrqbkftijhLOJ4JS/tyWUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwi8bK4fThYZLMip51XmAn23YpwP61FOGkVAigaS8ZvfxcqCco
	0Unv0EasxcQj0E5CvFCupMST+Tfe76npKaCde54hLFpU8NdsMeJ6YkHltn2sr7uPtD+9pyi0f9g
	MaoS1xY3CIHFDPYrsmub2LC16/fJraXtUgWvvzlxr
X-Gm-Gg: ATEYQzzYoJrDjKfckKSl7lhec1Tv+gRsibun+V4milPk0zBvD8UeTLTcnD6MQXu72rX
	nasptGmzXRVlmDHJvs2fB4U7je/ou2JDDg+fuQEJ9unk+UU6edu9VCiD/ST3oFhIGhda53/zszI
	KvlC1x4JGgMvGuLkpzZHiAhnCoRQ7IgX3L79q9t/bR3VI19FTG5SiA1xHmyWXjKHIg2J1LSfEVG
	hPJ9Ybx77zyWdT2x21m7/aDuQ+U41gkWS6F1/fcnbrecsybY8BpAkZu1B4vY7lvMTH1KVtDIXtk
	Gfe+TosK
X-Received: by 2002:a05:6102:2914:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-6020e545dd6mr4815388137.29.1773692276401; Mon, 16 Mar 2026
 13:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316182025.3383443-1-mhonap@nvidia.com>
In-Reply-To: <20260316182025.3383443-1-mhonap@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 16 Mar 2026 13:17:27 -0700
X-Gm-Features: AaiRm500IMKzdT9Uk7XlTKlfOo9LWN5p_UCslJHzbBodrkrMtGSMmsrWtG5rUj8
Message-ID: <CALzav=dkiHkA6f9xv3HAozsoOz39ruLVB8yCMLB6nw-+hX1cHA@mail.gmail.com>
Subject: Re: [PATCH] selftests/vfio: Fix VLA initialisation in vfio_pci_irq_set()
To: mhonap@nvidia.com
Cc: alwilliamson@nvidia.com, dave.jiang@intel.com, ankita@nvidia.com, 
	kjaju@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-225696-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 10F852A01F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 11:21=E2=80=AFAM <mhonap@nvidia.com> wrote:
>
> From: Manish Honap <mhonap@nvidia.com>

Please use "vfio: selftests: " instead of "selftests/vfio:" to match
all the other changes to tools/testing/selftests/vfio.

  $ git log --oneline tools/testing/selftests/vfio

> C does not permit an initialiser expression on a variable-length array
> (C99 Section 6.7.9 constraint: "The type of the entity to be initialized
> shall not be a variable length array type").
>
> vfio_pci_irq_set() declared:
>
>       u8 buf[sizeof(struct vfio_irq_set) + sizeof(int) * count] =3D {};
>
> where `count` is a runtime function parameter, making `buf` a VLA.
>
> GCC rejects this with (tried with GCC-9.4.0):
>
>       error: variable-sized object may not be initialized
>
> Fix by removing the `=3D {}` initialiser and inserting an explicit
> memset() immediately after the declaration.  memset() on a VLA is
> perfectly legal and achieves the same zero-initialisation on all
> conforming C implementations.
>
> This fix is self-contained: it touches only the existing vfio selftest
> helper library and carries no dependency on any other patch.  It was
> originally included as PATCH 20/20 in the CXL Type-2 VFIO passthrough
> RFC series [1] but belongs on the vfio list independently, as noted by
> Dave Jiang.

This should go after the "---" below. It does not need to be in the
commit message.

> [1] https://lore.kernel.org/all/20260311203440.752648-1-mhonap@nvidia.com=
/

I see you also included a new selftest in this series. I'm glad to see
more usage of VFIO selftests!

Can you please Cc me on any future changes that touch
tools/testing/selftests/vfio? Or better yet run
scripts/get_maintainer.pl and it should add me automatically. Thanks.

> Fixes: 19faf6fd969c ("vfio: selftests: Add a helper library for VFIO self=
tests")
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>

Aside from the commit message nits above:

  Reviewed-by: David Matlack <dmatlack@google.com>

