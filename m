Return-Path: <stable+bounces-177778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C8B44C69
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 05:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3215873A1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 03:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9D32594B7;
	Fri,  5 Sep 2025 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="N14LEQRH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D8221F20
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 03:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757043713; cv=none; b=dL8G+uwjPv8hn7BHp0Ea4NrXvfHgB9A4Ay21PRL8OtRn+JhK+XFpsM4/u9XMBx34zKbKcL76ijmjXPredEEXalLaZhlbALw9CAF+2oNX1sTOoIUANNTu3E4RwCAjwqli4sjXFRid+zJxLpa/AVvlQckym6uX92ZWx/C7R9JgHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757043713; c=relaxed/simple;
	bh=lBiDmWrhi4c+oWflBgV0uV8GvwJWrnyIQZJXI/wC1yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k1g/j2N61ESckNBIng/J1X7L1Ho3fHlYmDR+9uiNjk/8xyp8PJ9CJbiiGHtyE0RdECevXlMza6/OcmN9tuNUfMsy6WAou76ddoZ+jFDFrO1F8eKWJaJFcypfj+fYyyqZm8mNanVxEPP4YmEQg8YG3wH0ZPUOGXs+L7DCVWNA6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=N14LEQRH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc39551so300576766b.0
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 20:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757043710; x=1757648510; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBiDmWrhi4c+oWflBgV0uV8GvwJWrnyIQZJXI/wC1yg=;
        b=N14LEQRHhqmtODriSkhCJ9GNNsq7QDmuWirt+Jj2YpibWqNSdosfmX5WTenqVnRBm8
         ae+06cevl1ROQCmbYivja9C7dPvA+BT7CMFbfKm0rc9s7lzwfnGjWAN6Z7uJLdSmLMfo
         9pKl7QKcPi4maJNkxBBuj92vsq5yIQpO05BOKT333W6w535VuKr8d/xnWCQbp302IDrh
         OTNbYJ8fKgn0eca6U+IC65hGyOqogrNdKsn70jZ9pcMHTa6r3EQ5tiSjB+AmZ0vrxjx0
         pYgVd0i6hnvqKsjcImbP1EOoLt9ugtAkrGoMx8HdOYTZ4Hi7jWLihMnJcbxlFdb51ekd
         6r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757043710; x=1757648510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBiDmWrhi4c+oWflBgV0uV8GvwJWrnyIQZJXI/wC1yg=;
        b=N92dLQ92OxJnnRrf6MY2y94Gnys9S3r2ET0u8BwwkJctEkmc0Er/S5+ihf164l7hhO
         htjuPMtecCh+uy4Czpz8enpEVwnS/rHi8imfJdfH5vEt5tw1F++fM6snz7/NTB3qQHDi
         nvyGJSdAcDho2ExuQCz7HBMJP29omWomgdC9BZocDXBVFZsNjQqEI647ibyhs3dpb2VU
         qPnLipD6c0vNiNWaSJfPGfsWrVSeWoH0kUlwXNWC6G08MqsniDwWrlU2VvqJqasbuVRx
         eOrh2KEChey+zztxk1MDlW/0QDZXh03cYDNBQ221wupID8Y+qSpT4vl+bAX4zY5n4wla
         5hrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdTPmPpLeFwUqpxWuc4IGlYQXX6lSHJ+YFKmII4qTKptkjrBHS4c+x+96Vg54JNmW3Eu//geE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9sZjcv+RefuW7qCS9O4rkCgaAUvGpisTADzpdklkLwvTwST83
	PAXx5Dgl1ouvY84/FqjanVtWBGSrnWfxRz7vSgAbE3eilGOh/MnLh+8KF6iLMxWnbhdIiRVD5DO
	TCJ46H5SBaD0q1TffTuLryhDEJ6aPipM7yEp8+UZqyg==
X-Gm-Gg: ASbGncvmFSk+N9ZJivU3cTChu91BsrJZ0ZmxpD5v7HZgvL7XpcBEO8+YHg37RuHQ61T
	iqbhr2U7fcUiaSWg7qsLSKzoCLFkKBWazPqAfHJUMZXo6Db6zTCyceD/mqVkxDwmRD75vJyZ36E
	P6DTOX07NZkLGFZFDj3QdzJV6degHNXfNon41Bf3oG/IUdhKgFIgc3JkJvWMxPupswJ1qGMtwkf
	8q3nFZMrsw2i6Uddekhoe7/GQYvR+D03sRAYLHlFY9juw==
X-Google-Smtp-Source: AGHT+IHov3qNZs7G3VUo2wWHrIzOMamlj6Sw7x9E1E/umEdIxDjNRb8LL8tMtoVXrxFeEbOX//exQM1lQ8IYRyF2xg0=
X-Received: by 2002:a17:907:3c8d:b0:b04:6338:c94d with SMTP id
 a640c23a62f3a-b04633912b1mr929171166b.12.1757043709612; Thu, 04 Sep 2025
 20:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827181708.314248-1-max.kellermann@ionos.com>
 <791306ab6884aa732c58ccabd9b89e3fd92d2cb0.camel@ibm.com> <CAOi1vP_pCbVJFG4DqLWGmc6tfzcHvOADt75rryEyaMjtuggcUA@mail.gmail.com>
 <9af154da6bc21654135631d1b5040dcdb97d9e3f.camel@ibm.com> <CAKPOu+8Eae6nXWPxV+BGLBVNwSu5dFEtbmo3geZi+uprkisMbg@mail.gmail.com>
 <25a072e4691ec1ec56149c7266825cee4f82dee3.camel@ibm.com>
In-Reply-To: <25a072e4691ec1ec56149c7266825cee4f82dee3.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 5 Sep 2025 05:41:38 +0200
X-Gm-Features: Ac12FXyjYfRCbJFUsaW3YVtT6St7moB3w1CuRj_GKqrFlnMvkWd3J77m_afuHp0
Message-ID: <CAKPOu+9MLQ5rH-eQ6SuiXTzFCEhmaZ9s-nKKQ4vpUCyvc9ho8g@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/addr: always call ceph_shift_unused_folios_left()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:43=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> By applying the patch [1], enabling CONFIG_DEBUG_VM, and returning -E2BIG=
 from
> ceph_check_page_before_write(), I was able to reproduce this warning:

Thanks, I'm glad you could verify the bug and my fix. In case this
wasn't clear: you saw just a warning, but this is usually a kernel
crash due to NULL pointer dereference. If you only got a warning but
no crash, it means your test VM does not use transparent huge pages
(no huge_zero_folio allocated yet). In a real workload, the kernel
would have crashed.

