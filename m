Return-Path: <stable+bounces-166672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E38B1BE7E
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 03:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7BD67AF8CA
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53241C8633;
	Wed,  6 Aug 2025 01:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="baOotImi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71D1A314D
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 01:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754445298; cv=none; b=A8qXtI6uuV61e0tSMWEiKSibOggRz/xOAnGgb0RPqwcVjhTKhuJ1T8/9PVC8qThamCAVTHHvM0QF18ElNQYgcm9/h6GIvIwOTA7symit2Ovb9Yk1mqO98Ln/bi9aSk0XHbkBTYRZ7pqzWm8IHUBTL64SYMUzkUlhX5sJatHsrr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754445298; c=relaxed/simple;
	bh=kQQnVC0izYvjXyrwC7oXu9KciKX+b5K//bAiSMoT01Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqjQT5I3VDIJF2PkFE8Jo9F36QS18XF00CXH4gxk9+Nvzhcv51dYFAanoeZxATsoLq4jxJA9TLUYm1ZMNijqkRbzohkoimbTYZzSCAGg62MuK4Yrl/nfkC2WzEXJNyApkxI/VSEI+oQmoVc7smqtHimCJr4W1E2Zt7YgPOU51ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=baOotImi; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so11096389a12.2
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754445295; x=1755050095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1PkDCTaXOlCgVfN+O/OMDhLH2gXEH5igacRG1rqZxQ=;
        b=baOotImi8VFWztjrqkLdLyC+32RiEnulVJwGP3XdMJMxJX6mUsAb/cATXokamb9YHl
         BgvoIiBo36MkmxswSO1R7bfw5Wtbs65InFL7C3gtzcGMLRYt6fLb6UfUTd7yjT89XEFO
         olRJpseZ9mRA142BOSe46BdKNVULondlTyp8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754445295; x=1755050095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1PkDCTaXOlCgVfN+O/OMDhLH2gXEH5igacRG1rqZxQ=;
        b=VbEcQWo0tKLTlqZBWOnCOR2ytQy/IgYFrE2bsSpWTcy5k/0076+GRWBFwcwr71E+hk
         mQmj9PfdU8pt3VsR0Ho5j3+KY+zMisEsle+wQMvn5U7/qR5pdzs3BsQf90cCjcSUlU6r
         aSTSSQSXI0f3wbUX7YIHVgt6aHpCVHrwgDvnU5UGKD1fP/st9pDN4E/g7qAd/PCfEgvB
         cP67FoJvidMowACnI1pvlqkkArgQLZDG89ogY/9thr9OZVy+keNq6ovdDn+KzWn62XrD
         kW8GXUUc1bVnTpHkX/zbIMqeK65+DAtJgOEnP27/OlqU1yvS0qAivc2qXPrmho2hUAXv
         +usg==
X-Forwarded-Encrypted: i=1; AJvYcCVbMd8MKyCBMABDZfFtuIgsQnTKdXRHJE10Eu+IkjyG/QLwizHx6TN6xIr8Dsi0JAsVXt2sno0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykp/ckrT5PeVTe8S5PJ2/4r0zsQaQFeFS86AWyqty2KXNUkavH
	NA9KAbVF1AwIxh5EB23qkRs5gCwwnzKkeuntZjgesFd24bemg6eKMOeds8U48Mo2lDHnziJQ9sZ
	R1djpefIdUg==
X-Gm-Gg: ASbGncuwqiMAtynYBav9c8+tPO5coYvbvGrS7DAL4HPRjUnC6hUrGmQz9pyiCBgLzNr
	pQcHyISj5Onb8QHwXLixSWdWASx6kDw791Fg/KqtwdbRAzQARUtGnwHt3+ietvPJ/AP+3iobCA9
	eVZfh10PDENW4AU74ZlLByDr+a151ijNOVodBvCwYP0YtipuHgQdC8jewG0iu9MS7tVeD6rwHbc
	v/ihDjVCI3G16VCAhEfBTsZMt4VBMzq3WJZ2efA8AMrpl2ks5NoI5COiJ2wy2EoB6id+jeBHveC
	hv11O6oUEduymL+sfNAu7AGBSmE256mqwaaxV/0tQmfmZMVhxyKfGSA2fqO0NTayklx+PGpW6cg
	gkCxXkkipQfFpdK8fhzhXdEW/MLUrnrYIzggDYIRho/EyxzW8KdrOFojOGfZb9jhS58lzFUnU
X-Google-Smtp-Source: AGHT+IGU5KwrDtbOVevW2bIEQ20iN0Yl4QQWhLD6Fv4ID/C7zXO+RWam1vgkiBP3PNlh1GZhi4JLNA==
X-Received: by 2002:a05:6402:278a:b0:615:4d3a:9330 with SMTP id 4fb4d7f45d1cf-617960eab45mr885753a12.14.1754445294849;
        Tue, 05 Aug 2025 18:54:54 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7a20sm9328651a12.34.2025.08.05.18.54.52
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:54:52 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61592ff5df8so7987447a12.1
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 18:54:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW/KvWHviPhNRiYnuIcRhY21jVwm0tcEUxA7C3U3yUcT+oic84o+d+PVGgBwqpDJeVQefV95Zw=@vger.kernel.org
X-Received: by 2002:aa7:d64b:0:b0:608:6501:6a1f with SMTP id
 4fb4d7f45d1cf-617960b2169mr747725a12.1.1754445292221; Tue, 05 Aug 2025
 18:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com> <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
In-Reply-To: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:54:36 +0300
X-Gmail-Original-Message-ID: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
X-Gm-Features: Ac12FXyVcowt5QK4YaVtsfApiqsjcc5RnE4u3G8HT-dXMHsAGYoNHxft3oIBLvY
Message-ID: <CAHk-=wjedw0vsfByNOrxd-QMF9svfNjbSo1szokEZuKtktG7Lw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 04:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And yeah, the attached patch also fixes the problem for me and makes
> more sense to me.

Ok, crossed emails because I was reading things in odd orders and
going back to bed trying to get over jetlag.

Anyway, I've applied Ammar's v3 that ended up the same patch that I also tested,

              Linus

