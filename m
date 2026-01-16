Return-Path: <stable+bounces-210118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4BCD3880C
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 21:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E59530242B3
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E6F2FDC5D;
	Fri, 16 Jan 2026 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6/akdSM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F62D595B
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768597009; cv=none; b=UksDFRvZ4m8nQXFtL1Xc5mQZ7Znqq3XTdciQliwgh4U7t9lOIsCh/0lPifVxxLQCk8ASoQZ6TzQfSoGTOHu5XuuPPg07+bpV1Var14kZPmowHt+UP2PjutVhy37Vmup0EskoX6QmU+2/ZE2VPFNAa+P1rFyx2rouCxJ2o/77fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768597009; c=relaxed/simple;
	bh=KW+YCk3jL0wohXBu5HKQJ96I7hqVok5gvj63pqpLlVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zbn9yMVCdkX6QzoyXiTf/OszUWye/zQbedt4Uak+rtPPS7ounrst6ZDeszv3tPAN6loNRHBD19RfbFPZMrau4dXQf/wrsbQq65z1rnCYZGNbvw6rQY0SeOjdx0De5OJLyCgK8eaIfEkR045DB3tTpxG+X0GE9raTsDgmOjXxbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6/akdSM; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso14812765e9.2
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768597006; x=1769201806; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0wPmsoU/VWwpse+1kjZEJCcgwRAW25UoomdQPrwRwsY=;
        b=V6/akdSMrv3LtNSJ7P/XS1ooNMsn02YYkQFWMXmtVasJirS5qObWN9zb0ZfSrO4hDg
         bPTLQo0Uq0XuaaP5nxnXnT7DiidCPc6Jd42Z8QkN+W6ZPqAVFBcI7SFn4jkH5vHN7+lO
         p1YpHZQBu/D+8WRaIWroQWt3Fr+QF97jWuYEs6Ekg6VC/n4hd2y0qannOCleVuqB8Ngg
         QhKoK3yb5lbjfCWQwbA9CJXDD4PuMzHMUOdb3B1vfVdQ9MQ0g1RH921/88DIPByP+KfN
         VtMfxm21hgwS01CCzhLNA4a3RTl1JS1Uut/ka4CVzGCEsWt20DuIHPQjL4MKNNUWi5Ty
         j96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768597006; x=1769201806;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wPmsoU/VWwpse+1kjZEJCcgwRAW25UoomdQPrwRwsY=;
        b=ASOpVPdjYXVaqqr0EwFW4dRyjMbBcaY3GvhPu+eooa3mfCkrJsuaJFgdd/GgVuRrSO
         OwL1AoTxWO0QqE4Pzdxh/hJntX7ZxlXg4uamnNIBffAIU4Vn2PChhIObSL/iMBHPShuX
         MGbIhBRYbfR+Gbf3lZwDxpfqgT/NJ+RNfYCblnC0kVC2slJTGxM4OhPytpGJk7JO+C1F
         aIALRw53HxTLRwu4lonZwmHNo7dgdXlN1aGvtIWBGy+GlqSvhCRVcuYOxyznfdn4HFz8
         rcjsxMWObsaZZzPXkzZ6sLlhBkWO5lPUrTjD9PFKKA3TkjoexXPvwpnKh7cOmeMKf+87
         hxSg==
X-Gm-Message-State: AOJu0YzcrucJ532FWLjvhBG0NJP7iGx2nD0PyYmh8ic/XVc+L54uqFsg
	RCsWstnUYAAZ9sLY43WU5Ld8z0UdoMYfw6s/EYU4yHEIN4h/nPWHZLTo
X-Gm-Gg: AY/fxX6zxd9LqID9FZOnNB5rhS+JNbHaB0y4OFFB0XjM91yAaeG4oa1eH9u2Jlky3/i
	2MZg0lWyh5aKwh/TtCZg9QIqPcjLiVs6zLBxYmzZ0kHQGKl/qB1T5zzApDkMviFkx6yK3qdo3xk
	3ppeO64u+h3LD3JK7h5GoG3s1v3D7PfRiFkEcbfDi7N7x4kpnA+LWITibGlShVAOeRn97dj0eTy
	9e4dUsIBTB3AgvgMy46fK4ec8HKhtLQbaC7wonloIR1RGFSwimdKNnA2purljX53Dgka3Zgokg/
	MuM8SkwNSQGffuWpyMhGgQq0CeajM3/f20bxnG8rJpXPvMODoWJ3sHrj4C8WsPS7FXFtCwihOY3
	/5MO81NHAPlvW6sihaxNvuFJNnfofYxh43v/dK7Nc47kw8b3EXgbvQ6V9z3DZxKm+yovnTsejyE
	CxJjl2dzNItqfsneXykhA8jdBJjHs/CrFE2mOYjnMFfT1C
X-Received: by 2002:a05:600c:8b08:b0:47d:5d27:2a7f with SMTP id 5b1f17b1804b1-4801e347d3amr55463295e9.26.1768597006226;
        Fri, 16 Jan 2026 12:56:46 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801ea19f94sm26535935e9.3.2026.01.16.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:56:45 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 53213BE2EE7; Fri, 16 Jan 2026 21:56:44 +0100 (CET)
Date: Fri, 16 Jan 2026 21:56:44 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, ritesh.list@gmail.com,
	hbathini@linux.ibm.com, mpe@ellerman.id.au,
	regressions@lists.linux.dev, benh@debian.org
Subject: [regression 6.1.y] Backport of 353d7a84c214f18
 ("powerpc/64s/radix/kfence: map __kfence_pool at page granularity") to
 stable versions 6.1 causes build failure
Message-ID: <aWqmDHdHVLs5M3HQ@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

In v6.1.160 353d7a84c214f18 ("powerpc/64s/radix/kfence: map
__kfence_pool at page granularity") was backported. But this now
causes a build failure:

make KERNELRELEASE=6.1.159+ ARCH=powerpc        KBUILD_BUILD_VERSION=3 -f ./Makefile
  CALL    scripts/checksyscalls.sh
  UPD     init/utsversion-tmp.h
  CC      init/version.o
  AR      init/built-in.a
  CC      arch/powerpc/mm/book3s64/radix_pgtable.o
In file included from arch/powerpc/mm/book3s64/radix_pgtable.c:35:
./arch/powerpc/include/asm/kfence.h: In function 'kfence_protect_page':
./arch/powerpc/include/asm/kfence.h:37:9: error: implicit declaration of function '__kernel_map_pages'; did you mean 'hash__kernel_map_pages'? [-Werror=implicit-function-declaration]
   37 |         __kernel_map_pages(page, 1, !protect);
      |         ^~~~~~~~~~~~~~~~~~
      |         hash__kernel_map_pages
cc1: some warnings being treated as errors
make[7]: *** [scripts/Makefile.build:250: arch/powerpc/mm/book3s64/radix_pgtable.o] Error 1
make[6]: *** [scripts/Makefile.build:503: arch/powerpc/mm/book3s64] Error 2

This is because 8f14a96386b2 ("mm: page_poison: always declare
__kernel_map_pages() function") is missing from 6.1.y (it was only
included in 6.5-rc1).

Cherry-picking 8f14a96386b2 fixes the build failure on powerpc.

#regzbot introduced 36c1dc122eb3b917cd2c343029ff60a366a00539

Marking as regression for 36c1dc122eb3 ("powerpc/64s/radix/kfence: map
__kfence_pool at page granularity"), for the 6.1.y specific commit
causing the regression.

Regards,
Salvatore

