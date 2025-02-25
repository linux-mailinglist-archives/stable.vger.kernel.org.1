Return-Path: <stable+bounces-119521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558B1A442C3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F071417B1D3
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB326A0A9;
	Tue, 25 Feb 2025 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtQoT+J7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E30269803
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493607; cv=none; b=aPRJaLR9Nvcwjc6ESYFT6nKo4odAJDVVzs3nHTMs0zq0XyXkulpOVYLvyu+I7w8w7Iy6q0g3i9zqJlMGCxs9fEl4qi5VkpROfH+2TDFB4jRt5l5CW7C4xy8LqSW+aMWnCafLkLtlXOL4d85DI8nxXJpq72cLQycsWRfOsG8migQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493607; c=relaxed/simple;
	bh=ws73LzdVsospmUQsBLIeuEHPV8IfNXtt9Hvu2wKtG2M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QkTSVCMtuITbEwr/H5RCvwRcrOyNa3RPJP/OYCoDV5EYxs9KEzmnDsggjSYUNU6CZIAKrOUvhUmmEz+q8ZxvxZSN9C60UgsXkd0iOeiIoYhVTvACuEJzj9bM5dA+KRLHlDDzq317nxfdd1Pv8q/m07wq/xZVueCIL0RfimWE73g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtQoT+J7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740493604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pBGhrYWkFeITUmL5WYiMfvc7l/ZEvi+A9fqUKd4jHSg=;
	b=AtQoT+J7jeGod4xsmYiqfKZ493bu/+r10jdb8K9H+GUNf9DlUSdrQ8Noe8vlnDYSCVbOPr
	/W1Pc3VHkKSmMMBHLHe1KnNJt10YP/M5I+wvDigbAKp0NptUhF6fYerbRgzD13tdao6ZMn
	eNlMziC3hl8eE1KlV1ByAZr+LGNOP1o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-u_sY8weVNoyJld231Hs7Ug-1; Tue, 25 Feb 2025 09:26:42 -0500
X-MC-Unique: u_sY8weVNoyJld231Hs7Ug-1
X-Mimecast-MFC-AGG-ID: u_sY8weVNoyJld231Hs7Ug_1740493602
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso27247035e9.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 06:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740493602; x=1741098402;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBGhrYWkFeITUmL5WYiMfvc7l/ZEvi+A9fqUKd4jHSg=;
        b=xNaqfef3+OIwKttIAspSDWdNVEXTcyFhs3b807rPvFnXI1tUWfO3hNZrcj9OzKrwCX
         tWstqsnWrRQuq7wllapa6eikPSvy9VJokFSg/jsZ5HTv97HYdst7aI/8AvYLmmcpfjj+
         ut16VWUL//SdN/u5RxAzrEXNy/PrMfcjthOwuHpUi9006B4EEsgM4sqvrfHfqxsfvtVl
         CgUXRmmct1dboSIpck5pRNt9jre/NqCDP0fRna/dKsMzXc6PU4EdsI3yffrEm21FoKlK
         YrHOD93dcK8LnPAGTqzomJErWqHmURSeZ5BCSYpZ1gbN36olJITmhpXj1gkps39aYiMm
         XG7w==
X-Forwarded-Encrypted: i=1; AJvYcCVGmEU3noB5na8clJah4Tlxz1ms7efuXedCdqlh5QW0UYrMHBlL5EVg8qy5ZSSPdDvERJ9p/8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoPf2eCoueXQs8yEOG4eTIYUHjETdM264wtldV2A1drrroK6e
	tIKjVEFLLa+keFZtE7SkgPZGTYks8Hw9PC1nHhM+MiIIh0y4utYufPpqCylB3LvduGFGHivztn7
	3cvFDdmHQfScDIc9mZIMNkoxAW5SAPbdtyQgSHieMpKt2gUd10ccCaw==
X-Gm-Gg: ASbGnctJPulRgoHnD47fDBEqpSqHniHHH0S9lrZqNmzmsLrcHLdEhq2TBPdgkXI1drr
	otNxfBRCi9h447oiSLVKswcAc2XtsARX+bNiPFdLm8JZkWxr+16sxJ4FZ5bs0H404AzfgP24SER
	78McYorvecsnAYihCbZm+rbkMvaTfq0WYoKUY8YXYfr2m2BWDMruZZQzAGBki3SmW7XDmxeTmo6
	WftCHKiEw0ukPGy2uOofmC6X5LlMXYAE+vtnI/SGqCwJ2TNg0S/+O6o+yhdY0JWQMUMS5PTVmSG
	hymffa8QZtAe0dwJTzZ7Rb1Io2R5tOYlbYLu2NGYW0J3yXPVvO24eb0BBq9x1MtdHg+ChrU=
X-Received: by 2002:a05:6000:4009:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-38f6e97a0b1mr11479405f8f.32.1740493601726;
        Tue, 25 Feb 2025 06:26:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjaDfgW2LADqlJLYOFtRq9ZRwJAy9nvbKohHaJpmlGfR6SrchEJHJ6cEa21q1LfSEB7TyhCA==
X-Received: by 2002:a05:6000:4009:b0:38f:286c:9acc with SMTP id ffacd0b85a97d-38f6e97a0b1mr11479374f8f.32.1740493601420;
        Tue, 25 Feb 2025 06:26:41 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e7108sm2494009f8f.69.2025.02.25.06.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:26:41 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 5.10.y 0/3] vsock: fix use-after free and null-ptr-deref
Date: Tue, 25 Feb 2025 15:26:27 +0100
Message-Id: <20250225-backport_fix_5_10-v1-0-055dfd7be521@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABPTvWcC/x2MQQqAIBAAvxJ7zlhNIfpKhJittQQVGlFEf086D
 sPMA4kiU4K2eCDSyYm3NYMsC/CzWycSPGYGhcqgUigG55d9i4cNfFljJQp01JjQ1HrwGnK3R8r
 uf3ZgKonVDf37fqKoudlrAAAA
X-Change-ID: 20250220-backport_fix_5_10-0ae85f834bc4
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
base-commit: f0a53361993a94f602df6f35e78149ad2ac12c89
change-id: 20250220-backport_fix_5_10-0ae85f834bc4

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


