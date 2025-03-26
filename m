Return-Path: <stable+bounces-126676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B12A710BE
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 07:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299013B3448
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 06:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246F16C684;
	Wed, 26 Mar 2025 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDcDOavR"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D62E3370;
	Wed, 26 Mar 2025 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742971665; cv=none; b=dFFN7NMxb3OfVQ6F6EBEwYMzC2IyvNxTi8w2FV3/YDuh/tvQ3Uom1sqtQQRb4Vtt4+AemcOkWxQPTBQiuEZ8Vhj6iaXYWoqqshQud2D6w7vEKeN9vSwD2CitEFbB2ALYeVoFn9xNNADRHJs62dGs70wcoAqo51xyF+7POtEcLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742971665; c=relaxed/simple;
	bh=hInxrTw2p9YD0ruU7r9TnLPL8BFZrnOItF+gEKhRCF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=ZZ+vgEjArctcK2yvbFN0CsM7V3+7Xw0jUsnL/E3vTDrA9L2dzpMlXWn6i+OBiBfzkghLIzAj4txad+dFfiO3T0MwLwVQ7tpWp3pAQphDxdD8xyQHQ6oj8oEItVwt1ULbcJjuj7cP1YXWldg7z0IF61w0MwW0Pn8zUqy0E2qf9WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDcDOavR; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54993c68ba0so6892851e87.2;
        Tue, 25 Mar 2025 23:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742971662; x=1743576462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3ZUwlq81Dl9Tw3Z0k8iVPb1wMk8RLrd84BZ0RhOluI=;
        b=fDcDOavRFwKL/bREH+M4oz/WO87cv+GXEGGT1nJbGaaL7HRRcW8dBew7BqWeR6TlKI
         ZFfAYm0MqLggXfOz4eW3DDN8twWE6SD9WmGNvHB8l3y4QlCOLOxKcbHiWBL2tJ8u4a1M
         YSvSwUVXlSh8rIotsjxyM8RMxgTlrqJJDH8PO5QIPCR9kQq3VP0MyAxUmmP3qOqn6rOl
         JUd2uZm4WfPy45e2MYnnHGzUhj/bLSMJjs9O2ND5LNYYQHP2U8XhB42M+3jjBwOuxhml
         F8oys1pdYvMnkVXsxBwtq5szok7uzNW58Y2KPhjYYMGAMGbtVidq3jj7ffNtaivDEHCl
         yj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742971662; x=1743576462;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3ZUwlq81Dl9Tw3Z0k8iVPb1wMk8RLrd84BZ0RhOluI=;
        b=aETAJv6trsiqOOFcYw6vF1jWUYsuNg5MOf/4flxPmzEiZyRp3Wg652/w33jsFV4YU9
         9elb+sKU/wSuJFcyLknFLurGwPNo3D3Lh7Pq6eN9heP8eqI5Spie1fJjSEEY9lhv3NmB
         sEEfWc8w+pc3PKgjxhsoJhkvZQLcfDtvKdpd9PDqq+oIyt/RO9pe3ORvHVJPtSkalfnv
         oZV3OT6+SEhqBJ74HtwVE24mD3fF28Uw62+9aGgWJlAnZhmcsZjRY96QFP8qy0TD0Hfy
         1sSjZ4h1m42ItI20hWvvfL5cCy1tEEl+PgmSfnQd1M7BTCg462Bow76xeQ4vt2AKuBbc
         b5uA==
X-Forwarded-Encrypted: i=1; AJvYcCV2fZnytQhKcZn5eoDaz5G1PZ9i/BJWCGDmYnyD0mQ4oHjp9GxM5euErB5MaXVwGPFHxd+Km7SeBSR3@vger.kernel.org, AJvYcCWaYbBFgW7gcEfY+hrzVVcvaGtSBa2oFGCodMBqCVjYAug1CpvsfG+WWwzSLwl7oCzzllMxZ3x2@vger.kernel.org, AJvYcCXKBrVdpJeQUvKfLNdGAfy1ZKd5pGewCHlub015NhgRgJ1hV5R+wEHe4nqVMbJAXbp+EtbaHvpPpIiuk0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjfto5zmweky/lsGbGf0qA7PxvUEFsMwxPB0lpphDzJimHdJq2
	9SiheBYur6Ntr2iWSH5llJA76NhCYlrs2Uy+7d+Dwwd82DhLdpjF
X-Gm-Gg: ASbGncs0UDpoN5YunoDHhZBhrc8gFeQF8Op1yvZlNQGbrBFCaVXVilovqG+svwhDrLq
	wseVtm7nT5o2+1UxcQiBL3GuewyvVV2mDAIIY4NFlQZkJ97u/wWmw5ZtU2M+o5t4wBsDAy+ThmT
	UhaJHqcB6/0sHmPcTKzs95Q4PXW+ZFkApHf5LtYgik/JQVkNiTVSDniuOh2+zMlf6+nO82UI+O/
	kNJ2A9HWDpjwY3HMTduV2ohbpTZuQUK2oOjL+yYwRVa6KYU6nZt0816ZHDZFg31Mk36jVJLyweP
	q3D7R9xsBcjI8qDKd3kzh6JOy7xIMDQpv01ezlqpZKilEQlQ9GGiT5TLr7U=
X-Google-Smtp-Source: AGHT+IEydJCRHupdB/cKYq7WepoCyOs09ATLFIeqJraguP+X4PcOqh1fYBqXJO1n1JIuhWwAtkAspg==
X-Received: by 2002:a05:6512:1590:b0:545:cd5:84d9 with SMTP id 2adb3069b0e04-54ad6491654mr6736601e87.12.1742971661849;
        Tue, 25 Mar 2025 23:47:41 -0700 (PDT)
Received: from foxbook (adqm95.neoplus.adsl.tpnet.pl. [79.185.146.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6512143sm1688712e87.228.2025.03.25.23.47.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Mar 2025 23:47:40 -0700 (PDT)
Date: Wed, 26 Mar 2025 07:47:36 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: raju.rangoju@amd.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com,
 mathias.nyman@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: xhci: quirk for data loss in ISOC transfers
Message-ID: <20250326074736.1a852cbc@foxbook>
In-Reply-To: <81c922e6-8848-47a2-bd54-1a9f8b1dbdc0@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> >> The root cause of the MSE is attributed to the ISOC OUT endpoint
> >> being omitted from scheduling. This can happen either when an IN
> >> endpoint with a 64ms service interval is pre-scheduled prior to
> >> the ISOC OUT endpoint or when the interval of the ISOC OUT
> >> endpoint is shorter than that of the IN endpoint.

To me this reads like the condition is

(IN ESIT >= 64ms && IN pre-scheduled before OUT) ||
(OUT ESIT < IN ESIT)

but I suspect it really is

(IN ESIT >= 64ms) &&
(IN pre-scheduled before OUT || OUT ESIT < IN ESIT)

because otherwise this workaround wouldn't really help:
ISOC OUT ESIT < INT IN ESIT is almost always true in practice.


Moving "either" later maybe makes it more clear:

This can happen when an IN endpoint with a 64ms service interval either
is pre-scheduled prior to the ISOC OUT endpoint or the interval of the
ISOC OUT endpoint is shorter than that of the IN endpoint.

> > This code limits interval to 32ms for Interrupt endpoints (any
> > speed), should it be isoc instead?
>
> The affected transfer is ISOC. However, due to INT EP service
> interval of 64ms causing the ISO EP to be skipped, the WA is to
> reduce the INT EP service to be less than 64ms (32ms).

What if there is an ISOC IN endpoint with 64ms ESIT? I haven't yet seen
such a slow isoc endpoint, but I think they are allowed by the spec.
Your changelog suggests any periodic IN endpoint can trigger this bug.

> > Are Full-/Low-speed devices really also affected?
> > 
> No, Full-/Low-speed devices are not affected.

The interesting question here is whether LS/FS devices with long
interval IN endpoints can disrupt a HS OUT endpoint or not, because
the patch solves the problem from the IN endpoint's side.

(I assume that SS probably has no effect on HS schedule.)

Regards,
Michal

