Return-Path: <stable+bounces-219933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBjVNs1WoWk+sQQAu9opvQ
	(envelope-from <stable+bounces-219933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:33:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1291B4962
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C362030254C2
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4211836D500;
	Fri, 27 Feb 2026 08:33:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E195A28CF6F
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772181185; cv=none; b=V2xDSC2MBhZqXLbFUHwnYc+grjWe7+U7S+vrDt6554QetPh8fPP+ZKz+4kHyntKO5hEdsnNMlMnmsOPLWzebx/gKX0iOmYEI5LxgcC4fGn9476bxWIkUvGmfeb5pLXeqv7oCvzR+I2QU9+CwaJp2iiFyIe7dsAWRmCp/5za0xZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772181185; c=relaxed/simple;
	bh=3RupPG3bVf8o1iXp3/mZ55D1C9CIdFksOYT0HhrFzOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ea+mTWu07b7G8jpvRNPJ9/qzqykN4CYg4MwByil2kk25EImlNSqqs0piF0oxi167IiUMY0Gmwi49178x0xqZUa0i4SUUp3UPPF30862feV3kJCO7SqTMhzVM9jcNouG0McngTo2QWvNkJJrpbMvIrJlzvPc21MfuVEcUV5Zs/nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-94a231b285dso1065550241.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 00:33:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772181183; x=1772785983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dEzLMMeMCHGMsmtD9q5xZQbfso5OBJS8UWwuF8jf68=;
        b=P8tM7pfckQS/t/PPC2cqqGDTJ1ysyo8/gD+9uMvIgeXdZOwwnmct3rTnuXwyaB3AMG
         Nt5cH61k/hvqTX+/X/FiJxvnI4PIC1/yFZLDYwHjewlvthC5US8lZmzcY5I+Ye4ZY2xo
         gphgpwKpLElSXMzjrCqB5/DZZRfcRWCxJC/yCqVD5OKVTdAnIGj6ibTSRyWCPrSframA
         wg2Ft60oWOOWoSsqyEmoQpFNlZpJK0kECYmI222sbi1LPUCn8cOmGf9xqW2xVlXTBiC6
         1dm1zu9MJ+WVvxOLJSANX//lN8x6lAYZjBOOG7rfJ7hQbwAr7YSL3+kXsSrgKTc+/gXV
         vD6w==
X-Forwarded-Encrypted: i=1; AJvYcCWYSN7hgkkoNd4NkGPS/R9qNXxnNp2VNdIuG0Id0B2IaE0xUEHIdul567HPh1xX+TnHj9N/ris=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeW3w9CF9BG9vHUqoIWgB/teoxh/wgVDjHlZNgBAzn9pUgr+C
	4e4hZzKTfIU88iB83GLyH0irw/ubFyUJ69+6yd7Ee39srJcWKOD03iVwmJX9osVQLgo=
X-Gm-Gg: ATEYQzx2QPn71Qj8h+WbA0R4M/rb4KYeVmNeaNGSCSKeQW/lT1JtBUCu5AdEFBg8xiS
	gYvYqddn543KdQTJPLKnt/G153grN214+FTyJu9ey00PBF1BYNbdvYWRQaXPsGAzlEckJmeBodt
	mzaDxT9zRpi5ZHPgNdTjFGCQ0oz8GM4dbE/hlqwHtpUU6JA8dJu7CL+c3oXuzSsUGO0BSfxqszc
	S72ox0AW5BBA7x6R/3/DVQ5uTVaQ34JcokDXM/ec6h/SZZst5k7dBCc9WJ2cf0oYh1z2YpOwdkV
	bQdZ8W5ySp2wu5gvUrJZsaKQ9qETmfqjfuRHNPBoRt0+74KM/8zCpI1VEzlz2F0rTE546fTQNnT
	Y+3+79oHHzzX3uamn1vKqCr7GNB3RnsgLSCqpijjAflRkEdSLvTfKgeY9UGy/zmRHOIjkujACvl
	k3KsGhx0UrQyNrWdmDir3Dya5BLLahwfwp1ARWHSotP+fT7FnZuLYjQOF982CR
X-Received: by 2002:a05:6102:2910:b0:5df:b7f3:5875 with SMTP id ada2fe7eead31-5ff322caa8fmr1305145137.3.1772181182748;
        Fri, 27 Feb 2026 00:33:02 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94df63d6f03sm3946197241.3.2026.02.27.00.33.01
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 00:33:02 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5ff19e74779so1234403137.0
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 00:33:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUPqYYX6HlAUNv++Iy6il8d/sgQ8KI2i1/WBgGo7myvwmVGTUQqqHTmu99yVnbLtWUu16/8I4=@vger.kernel.org
X-Received: by 2002:a05:6102:c47:b0:5f5:487c:83d2 with SMTP id
 ada2fe7eead31-5ff325d53c9mr1297367137.38.1772181181577; Fri, 27 Feb 2026
 00:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226191749.39397-1-ebiggers@kernel.org>
In-Reply-To: <20260226191749.39397-1-ebiggers@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2026 09:32:50 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXH94DvcDKN1zTzTBOrcn_zAfZZZJCyGbxjfs8DBya5_Q@mail.gmail.com>
X-Gm-Features: AaiRm52H2NMgOqKerYwyHCRsXF_5j9O_JAbJk1Fw4Sl8AnR8WmXboXf1vEA3uZA
Message-ID: <CAMuHMdXH94DvcDKN1zTzTBOrcn_zAfZZZJCyGbxjfs8DBya5_Q@mail.gmail.com>
Subject: Re: [PATCH] lib/crypto: tests: Depend on library options rather than
 selecting them
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,googlegroups.com,linux.dev,google.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219933-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4D1291B4962
X-Rspamd-Action: no action

Hi Eric,

Thanks for your patch!

On Thu, 26 Feb 2026 at 20:20, Eric Biggers <ebiggers@kernel.org> wrote:
> The convention for KUnit tests is to have the test kconfig options
> visible only when the code they depend on is already enabled.  This way
> only the tests that are relevant to the particular kernel build can be
> enabled, either manually or via KUNIT_ALL_TESTS.
>
> Update lib/crypto/tests/Kconfig to follow that convention, i.e. depend
> on the corresponding library options rather than selecting them.  This
> fixes an issue where enabling KUNIT_ALL_TESTS enabled non-test code.
>
> This does mean that it becomes more difficult to enable *all* the crypto
> library tests (which is what I do as a maintainer of the code), since
> doing so will now require enabling other options that select the
> libraries.  Regardless, we should follow the standard KUnit convention.
>
> Note: currently most of the crypto library options are selected by
> visible options in crypto/Kconfig, which can be used to enable them
> without too much trouble.  If in the future we end up with more cases
> like CRYPTO_LIB_CURVE25519 which is selected only by WIREGUARD (thus
> making CRYPTO_LIB_CURVE25519_KUNIT_TEST effectively depend on WIREGUARD
> after this commit), we could consider adding a new kconfig option that
> enables all the library code specifically for testing.

You can make those library symbols visible if KUNIT_ALL_TESTS, like
I suggested (after I sent my earlier reports to you) in [1], and like
Vladimir already did in [2].

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/r/CAMuHMdVFRQZXCKJBOBDJtpENvpVO39AxGMUFWVQdM6xKTpnYYw@mail.gmail.com

[1] "Re: [PATCH v3 net-next 05/10] phy: add phy_get_rx_polarity()
    and phy_get_tx_polarity()"
    https://lore.kernel.org/CAMuHMdUBaoYKNj52gn8DQeZFZ42Cvm6xT6fvo0-_twNv1k3Jhg@mail.gmail.com/
[2] "[PATCH phy-fixes] phy: make PHY_COMMON_PROPS Kconfig symbol
    conditionally user-selectable"
    https://lore.kernel.org/20260226153315.3530378-1-vladimir.oltean@nxp.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

