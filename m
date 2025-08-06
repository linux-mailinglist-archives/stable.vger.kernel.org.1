Return-Path: <stable+bounces-166670-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C0B1BE34
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 03:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFEA17EC1D
	for <lists+stable@lfdr.de>; Wed,  6 Aug 2025 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0041F18A6AD;
	Wed,  6 Aug 2025 01:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TV6xxwRk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E683113B293
	for <stable@vger.kernel.org>; Wed,  6 Aug 2025 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442695; cv=none; b=Vff8snIiPD72kjVkadlsPwKuiJbG7cPziqjKVm26fqVmou1UcONTpYlHhkLHM+8RYPIc5FuhrHYRNz36bE13y5iFHnrh078xBBaeMdn9qWNFHwdWvxhxNhfSIGV+jg0zdDntDjHUfHw5XkVpXlIghytCRR9G8qr7eNZxMmhWM6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442695; c=relaxed/simple;
	bh=E/w+DRqXb2jFxDHaU6euhPt7TOxgsKSFsApi1bZjEcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WitFFU/sFares2Pc+96FoKC/Ro9omRZY8Kf3HfK51ESgZ9dWcw61JaCGvchofOZ+2e6lfGcv2+GhjibZTPlzDt970GO7ke91ngZKEQ9PfpCKNyr11nPXHsYH3HqkAKMGutPmtl3IVoCkJGZimKm1drE1v/e1+3keCLf8risNhKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TV6xxwRk; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso8484597a12.3
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 18:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754442691; x=1755047491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d2GKUutMb+CTg/SBIA+X4H18S3n8qy8/RVR5pHccndQ=;
        b=TV6xxwRkIg+yv2/GlIo7VjrUjDygDS0OepvQzt4wtDbe7SQM8IInGiUpuWak1Kvql0
         R7hJplKZuY0LSGrsMJi4YMVTLxAh36vJSIlFnKwXaBoVV69UFRFNY+e1g9U2iFfMP6zD
         OUylYtOC/dYY0S4WRyWVp1v9SXfHfNnAZIckI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754442691; x=1755047491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d2GKUutMb+CTg/SBIA+X4H18S3n8qy8/RVR5pHccndQ=;
        b=nMT4PNslsNU575Ng+N4GXooDOGo+Zr4wR1VRWILOQBvnszXhuvAzBYIS+m8UcgBQ6n
         AVrKwaAcMSigvgU3IX/BKhAri5VbiK8JDP7SZzf+cTwXlqIxNVFvw6kXr5lFdx8aaBq8
         YWKxqjnYOP3BOApVOWHqUuLimyfMe4HUxEj9S/ckMSCeYhw6NQ7a5PgnUgGl5XMU0fhh
         iEyDrXnyHBnKSL0UnXIwRIalrpb+M3xHP4bcEkOc/VhMl7651MCIQ1CPsG9mljiDrpTZ
         3gyeW6sld5SETBm0Prx7+RuL5YpXXZpBkupS2teDQL/qZEpGkBaqWsSNlF/QDCb3IpAp
         6cUw==
X-Forwarded-Encrypted: i=1; AJvYcCUhkYFUhFBlGRgAhxOygw4SgvX08FmBlkKLtaKRhG5de9oCcarWM/w/DvabpPFvvpAqRThcH/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuGxCaNTYayo4xkWJP/60mTvITcfG1zrT1QXmf0V8xHh4VcRct
	K7Gi9NPsq2I06c5JW5aksIVakCRGrl0DGJSCtRN2P2opsAjuHEMo5bPy97JWL6RLT1TgGIQj+6h
	f9hPyHHxrvQ==
X-Gm-Gg: ASbGncv6zlv8T/qecvINyT8j46Pc81nGK8FMjJDUJXrU02UpjNs6bbNEZ7oBrb5Tf4b
	9fH7JVjcylQIuX5y6aZ2IPXQGScbrzFdMJKLzpxq8zRUk+Xzodwka/bkTUe8rhm3j8dw5L26GTx
	wlLEKrQpOFLdfM3eZr/gcy1og04QvT3PMN/ZzR32aosChgpWkbwmtjCD4p9YDk1M3QE3fOE9vQj
	zYGQy0Juc1QJlwynGk3LWIV1IULLq4u2xvQewNzBua9vsWvx7DW6ccfOuVuwhUTqWZjpHR+zaCo
	YbJ52D8Cl1qyuWiUGUqVc1zZCIT6HQPzphuGxsPTUqJzaxqgeXkCU7VSJ05RMUQcu3blJcjP5J6
	K6Oa9G0sJAwl5ispuqxppuxAwRlSP0S8Awj9HBYUKv02/USAttFPx2LcfINtBQGa7hdilddJU
X-Google-Smtp-Source: AGHT+IFW+zEVK7/e/U7enZy386hklJK9hN5rZvSXasnn/oM75jL1q6nhmV/hbMCdYP40BxN//7lnZA==
X-Received: by 2002:a05:6402:44dc:b0:615:7b50:91a6 with SMTP id 4fb4d7f45d1cf-617961880e3mr835376a12.30.1754442691492;
        Tue, 05 Aug 2025 18:11:31 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffa17csm9082804a12.49.2025.08.05.18.11.26
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 18:11:26 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-af97c0290dcso356706166b.0
        for <stable@vger.kernel.org>; Tue, 05 Aug 2025 18:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaXsE0gplfR8d/rnszcDAmYsGAHXMTIVKbxbH/aCLeszQNNc7UvNAbgbF1x1M0YcMXehGFPow=@vger.kernel.org
X-Received: by 2002:a17:907:9703:b0:ae3:6651:58ba with SMTP id
 a640c23a62f3a-af9902dffaemr94719466b.35.1754442686168; Tue, 05 Aug 2025
 18:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801190310.58443-1-ammarfaizi2@gnuweeb.org>
 <20250804100050.GQ8494@horms.kernel.org> <20250805202848.GC61519@horms.kernel.org>
 <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjqL4uF0MG_c8+xHX1Vv8==sPYQrtzbdA3kzi96284nuQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Aug 2025 04:11:09 +0300
X-Gmail-Original-Message-ID: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
X-Gm-Features: Ac12FXx151gZKxn5F0B-h1oNAfMmrkA84RTvsrxwBVO-1UWY7oBd7NqVoQGVGt8
Message-ID: <CAHk-=wh+bnqPjL=9oq3uEkyZ7WB8=F_QMOHsGjHLj98oYk-X3Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: usbnet: Fix the wrong netif_carrier_on() call placement
To: Simon Horman <horms@kernel.org>
Cc: Ammar Faizi <ammarfaizi2@gnuweeb.org>, Oliver Neukum <oneukum@suse.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux Netdev Mailing List <netdev@vger.kernel.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Armando Budianto <sprite@gnuweeb.org>, gwml@vger.gnuweeb.org, 
	stable@vger.kernel.org, John Ernberg <john.ernberg@actia.se>
Content-Type: multipart/mixed; boundary="00000000000016f79a063ba80507"

--00000000000016f79a063ba80507
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 01:40, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And no, I didn't actually test that version, because I was hoping that
> somebody who actually knows this code better would pipe up.

Bah. Since I'm obviously horribly jetlagged, I decided to just test to
make sure I understand the code.

And yeah, the attached patch also fixes the problem for me and makes
more sense to me.

But again, it would be good to get comments from people who *actually*
know the code.


              Linus

--00000000000016f79a063ba80507
Content-Type: application/x-patch; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_mdz5fpf80>
X-Attachment-Id: f_mdz5fpf80

IGRyaXZlcnMvbmV0L3VzYi91c2JuZXQuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3Vz
Yi91c2JuZXQuYyBiL2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYwppbmRleCBhMzhmZmJmNGIzZjAu
LjUxMWM0MTU0Y2Y3NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvdXNiL3VzYm5ldC5jCisrKyBi
L2RyaXZlcnMvbmV0L3VzYi91c2JuZXQuYwpAQCAtMTEyMCw2ICsxMTIwLDkgQEAgc3RhdGljIHZv
aWQgX19oYW5kbGVfbGlua19jaGFuZ2Uoc3RydWN0IHVzYm5ldCAqZGV2KQogCWlmICghdGVzdF9i
aXQoRVZFTlRfREVWX09QRU4sICZkZXYtPmZsYWdzKSkKIAkJcmV0dXJuOwogCisJaWYgKHRlc3Rf
YW5kX2NsZWFyX2JpdChFVkVOVF9MSU5LX0NBUlJJRVJfT04sICZkZXYtPmZsYWdzKSkKKwkJbmV0
aWZfY2Fycmllcl9vbihkZXYtPm5ldCk7CisKIAlpZiAoIW5ldGlmX2NhcnJpZXJfb2soZGV2LT5u
ZXQpKSB7CiAJCS8qIGtpbGwgVVJCcyBmb3IgcmVhZGluZyBwYWNrZXRzIHRvIHNhdmUgYnVzIGJh
bmR3aWR0aCAqLwogCQl1bmxpbmtfdXJicyhkZXYsICZkZXYtPnJ4cSk7CkBAIC0xMTI5LDkgKzEx
MzIsNiBAQCBzdGF0aWMgdm9pZCBfX2hhbmRsZV9saW5rX2NoYW5nZShzdHJ1Y3QgdXNibmV0ICpk
ZXYpCiAJCSAqIHR4IHF1ZXVlIGlzIHN0b3BwZWQgYnkgbmV0Y29yZSBhZnRlciBsaW5rIGJlY29t
ZXMgb2ZmCiAJCSAqLwogCX0gZWxzZSB7Ci0JCWlmICh0ZXN0X2FuZF9jbGVhcl9iaXQoRVZFTlRf
TElOS19DQVJSSUVSX09OLCAmZGV2LT5mbGFncykpCi0JCQluZXRpZl9jYXJyaWVyX29uKGRldi0+
bmV0KTsKLQogCQkvKiBzdWJtaXR0aW5nIFVSQnMgZm9yIHJlYWRpbmcgcGFja2V0cyAqLwogCQlx
dWV1ZV93b3JrKHN5c3RlbV9iaF93cSwgJmRldi0+Ymhfd29yayk7CiAJfQo=
--00000000000016f79a063ba80507--

