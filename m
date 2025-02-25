Return-Path: <stable+bounces-119507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183FCA4416B
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3411A3BD1C7
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E026AA9E;
	Tue, 25 Feb 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nr21HE8m"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14126A09F
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491611; cv=none; b=ga8zrDWRKYFrUbVp7xJEBAT5xGnadlCczXP8w+WGPDeu9l4y3JnP54acQibhLFp6EDSLSTPB8SQLkIHzuLhTVFO5D5JhWLOhSiqFLp+cY8S8TGRbQ6x/85ZeRU2QU89bAYKrqRqfCO4f7Bi8w1ZxBNWLUV4WJJ6nJe5Zp1oZ5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491611; c=relaxed/simple;
	bh=82Cm7eRnYO1Gs6EyYEYB0DaDMAmIX0Fz6jXVv9kAhP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Bg66eZzKEa+DvX4malCEU8jDRgxbyxhvwTYceo3AthTtt1sM4cRmyCPdJNzWbn2YKjyLeuWnyEPceIIrsMu817r+q8nDA4NVrgxgoFPquiQ0SJhNhWGn/JbMgUq6bb85jciqn+1PZpLNbedaOTEQSRU7TRxjMbKj2OlCQIJNUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nr21HE8m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JhualFRSb4ymDoYF+yJo3RCj5m28bAqfsabjeJ4NBpo=;
	b=Nr21HE8m7rLAg6XpdrALxqzBoQLzEuOSuVihHgjOnh2hpDDVWdlIpc/4RDpbn7R0Wbh+69
	lIP9gv49rufzAgPgscXcSuTCj6vLQMjIfVxNN3kzSx+qjsWJW6jjA7hV9UcC0dW/2/ct+B
	Qgq6xwCnb9+ZwcmCPWa0aas0vsqBAXo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-GdtjdfvVPRGS7rxquoo0sw-1; Tue, 25 Feb 2025 08:53:27 -0500
X-MC-Unique: GdtjdfvVPRGS7rxquoo0sw-1
X-Mimecast-MFC-AGG-ID: GdtjdfvVPRGS7rxquoo0sw_1740491606
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43942e82719so41470825e9.2
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491606; x=1741096406;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhualFRSb4ymDoYF+yJo3RCj5m28bAqfsabjeJ4NBpo=;
        b=bbPpg0Z+EdqXFopIZNq/y2oweYpo3sK9sowwW+KJp+U3uBRNtHxfLkVb9loEvFGDz/
         3TS8JE3+KtPNaP7nCVq/U1zMj/O2Egi8WHwVZyxyyNM2g+ZBa7TiF9JTfDaEul2Q4C8/
         zcdhGHm+HoIrTeJYVy3rZATACOAvM7TALrGUrim0OXVkcoNEaJP/ol3ZPFIxSPXkUTC7
         3icXdFJlk27fhL8ZeO6v7jrYfUPXJ6WFtqszaxMQ8Sf4MDO78T70TNtJHz3QWKjwCKAT
         4wrjkKWfhZOLjzbHsZXTcxaL9i+DUoBy9QWK6tjJVyGUpc4Ff3Zbhssy/pcXLHcRD5v6
         0Hkg==
X-Forwarded-Encrypted: i=1; AJvYcCXfZ8w8XEE4783x51+o1Ms+0lOQwRANH1BpEjOc8mXZfh0EWQ84I40+JTGdx/8yqGqnS55RKdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP/3g3sl3dzxyoYe8DvlyI1qMz4kiFfd+2HuXUqb6pee38KuGo
	fj7dCJZLr87Md4yFOIcXfQohDM8rv2rDcJnnritqL5vj1fsDogXMKLBzCIv0UDfU/S9+t+srGyP
	2/I4nhC3cvgnZSWRPa97Lg3p5ZiHPcUpj70jlvSGhP1r3rG+mF7Rg9w==
X-Gm-Gg: ASbGncuLe62c3lleGje0ZyF5p+s1/qHlqH59edF38A0db+VUH5bPXFvs6OSvAgZyc11
	ITx7ta0ElNXby+ZJpf+zq24Ynqt8fqYdhGvQlPwZCPklBsVzBq+uHgBUdfJnb5Z5WHxK5ER/m71
	7QVc7zKjPFNMsKmtVfkstYCr5IjyIDRiOsZgeHkhE0vRgE+o9uBjTTFpqH0DEiuyMHDSw2y1zuE
	G6VX2MYFjVI8Ys6qXfC90Gd4KO+Dh2VbS7N/ZIKfdBazPryu1DAUu/PDbQUwKEL7/1oBj5xdOzB
	Jiyq+ZhKQGHr8nmG302bka/IvDlocNPfyeSdBs8O+n7gdSPXfIeIf6XbVBY7qGsRxRvFyoI=
X-Received: by 2002:a05:600c:1e13:b0:43a:b0b5:b0 with SMTP id 5b1f17b1804b1-43ab0b500ccmr34395765e9.4.1740491606299;
        Tue, 25 Feb 2025 05:53:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECnlGZvRGqwXZbmKf5uhrza6WIphalSG/NFoZrN1R/iaIGUYCTLHLIfuBtLGYqrpaIbfkH4A==
X-Received: by 2002:a05:600c:1e13:b0:43a:b0b5:b0 with SMTP id 5b1f17b1804b1-43ab0b500ccmr34395575e9.4.1740491605917;
        Tue, 25 Feb 2025 05:53:25 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86ca9csm2362323f8f.22.2025.02.25.05.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:53:25 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 5.15.y 0/3] vsock: fix use-after free and null-ptr-deref
Date: Tue, 25 Feb 2025 14:53:14 +0100
Message-Id: <20250225-backport_fix_5_15-v1-0-479a1cce11a8@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAErLvWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3aTE5OyC/KKS+LTMinjTeENTXSPz1LQUSyNj45RkIyWgvoKiVKA
 c2MxopQDHEGcPBVM9Q1O9SqXY2loACsbFanEAAAA=
X-Change-ID: 20250220-backport_fix_5_15-27efd9233dc2
To: Stefano Garzarella <sgarzare@redhat.com>, Michal Luczaj <mhal@rbox.co>, 
 stable@vger.kernel.org
Cc: Luigi Leonardi <leonardi@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2

Hi all,

This series backports three upstream commits:
- 135ffc7 "bpf, vsock: Invoke proto::close on close()"
- fcdd224 "vsock: Keep the binding until socket destruction"
- 78dafe1 "vsock: Orphan socket after transport release"

Although this version of the kernel does not support sockmap, I think
backporting this patch can be useful to reduce conflicts in future
backports [1]. It does not harm the system. The comment it introduces in
the code can be misleading. I added some words in the commit to explain
the situation.

The other two commits are untouched, fixing a use-after free[2] and a
null-ptr-deref[3] respectively.

[1]https://lore.kernel.org/stable/f7lr3ftzo66sl6phlcygh4xx4spga4b6je37fhawjrsjtexzne@xhhwaqrjznlp/
[2]https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-0-1cf57065b770@rbox.co/
[3]https://lore.kernel.org/all/20250210-vsock-linger-nullderef-v3-0-ef6244d02b54@rbox.co/

Cheers,
Luigi

To: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
To: stable@vger.kernel.org

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Michal Luczaj (3):
      bpf, vsock: Invoke proto::close on close()
      vsock: Keep the binding until socket destruction
      vsock: Orphan socket after transport release

 net/vmw_vsock/af_vsock.c | 77 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 27 deletions(-)
---
base-commit: c16c81c81336c0912eb3542194f16215c0a40037
change-id: 20250220-backport_fix_5_15-27efd9233dc2

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


