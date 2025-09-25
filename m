Return-Path: <stable+bounces-181721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F29B9F6FC
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37EF24E294A
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B05217704;
	Thu, 25 Sep 2025 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DECKPo1S"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F41C8611
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805821; cv=none; b=bhiN1KRH91wnaSvYlkXOOZrJ6FIMTt9WL4M5gznFF8ceOKRtz4LkSjAyeTA3S1K5oHDq+CbAmMrAYgzqcXeW15HZRlVXl96COsRpQO5ZhLHklMe9eUjHGUrtHfSFdyJ9hdCBT0Da3cIubnkM83DC6XtNkgsaFx89mZSrBnBS/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805821; c=relaxed/simple;
	bh=0B43x3hO60s/q7zuJq3RHOjXfJvIsP5KZNO4MN7Tppc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PZWw4vF0pmoXDhBTC6fDh7SChP/O6kUliD9cR7QxVx7h2cV0+CHykzgkvj2RKukZBHovtjR1UNNVZjtMgH66p61blPcNOz8EEncCiYdXPJ/5rJ3OugYhLqgKAWugotU2HVI/yNU36e2q5u/VQdI5dOJ9/nI+1blF/bpND4VLj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DECKPo1S; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758805819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
	b=DECKPo1SUylXy39P44wVpzMhUT+EypRxLpfO4IcaL/fBeyI+Wu13YdAbJ98dYjb/+o31O6
	/0ZNnafaqFkkWgqVn51c5pBwphpaEDiRvAeY5ZedEHxY3FXWxJ5p53xWiP/6rWYuqBRSxS
	oTiaJa7kcFOxICzJvnV7OjhxoNzjBCs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-tFYCd4NIPu6YwRTpFR2IcQ-1; Thu, 25 Sep 2025 09:10:17 -0400
X-MC-Unique: tFYCd4NIPu6YwRTpFR2IcQ-1
X-Mimecast-MFC-AGG-ID: tFYCd4NIPu6YwRTpFR2IcQ_1758805816
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso706291f8f.1
        for <stable@vger.kernel.org>; Thu, 25 Sep 2025 06:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758805816; x=1759410616;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KW0ZC7vXwF1U7peaSsttqsWo+PHv2YRJfJzgYOs3pfE=;
        b=wkNYjdBWNZUe7RJGS4CYqyfNfQ50Tt3OTDVsCUxAlc8QW5KG6xcr+0X1E3HIkKUD9F
         FY0ex3yL/8sLfX1YtLZ4jFcQnVTM4nu4pLS6+hB7nQYYJ/cBksTl2SIgZp+eUjr//Dwf
         kxSk/Kolf2+YKC2W4SScB4yRfJAtuz3OfQtgBIUUcLLykT0SeSSwrcPcdSQOf4VeG9wa
         8bEyXiGV/gSqobhhb8iemuN605uciMRhcsxEmHKTp/vTI29dcD/AOrKYpuNVu0M/LYiZ
         AhjWIiMYq17Lmw+iNGI1Uh8HQaOvI5OldjmmI3RwdoY/Fi+C5zFy44kIyhWzmRtEKMF3
         VBuA==
X-Forwarded-Encrypted: i=1; AJvYcCXnOCTAdzTEg80Iqpf3cy05vh6pkXewCOt1q+KdwCbRy2psGO4H0wHuM42o6b0AcYN1KpU0YPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNV9byhZ19sUCTR9sZJgvVzFwdh+sevJS8QmiRzWY2Tz7tXtX
	SOz/lLR89yuxRUGHZyUOtpyU/k7E0RZJFdFiLqs43eI1rjOc0P4ClHYLFx3R7sniBFxCGnSPZJj
	F7VvhONHi+lib7rZY6ZQJ8A6TfE+kYtyoRYGwI3hkmXcKlj9Mb6EtsZSsjw==
X-Gm-Gg: ASbGncsm5L+vFqvGnQfL9iVuuDulhCTmVrf+IpQPBfp21LUo/naOw1cyC0oR1GBP+Vj
	Kk88fVnjApfu3AapHFLl7ZPmOYeNi64wgKFLR70mhYYEx/gzDHd4CbCjgVH7eBkLLfAYyaGQcJd
	KgxwPK3Mw6nNaIpC4DZsYIKgugnbUq6/J2nykG7aZL+MM+5qTOMOcSRT+PnBad1CRqVmjbyjl1M
	7H7A14bF8dKk4pKVF3Af1yk7Kpde6AJO+XvjCG2aU+xjfkNZ/qZPlPx2S3YBmrFtZUcvl2r9fqF
	wiewdRmPW0CdHQ3qRXN97ANpcR6AiXoQMA==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216285f8f.49.1758805816386;
        Thu, 25 Sep 2025 06:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzU/fT07/taXxNhpSlgViOVy92VqAS1NyA0bx0hGfqPg/L3VBSKrQfSmeVvB7FScm07URuig==
X-Received: by 2002:a5d:588c:0:b0:3fb:37fd:c983 with SMTP id ffacd0b85a97d-40e48a57465mr3216242f8f.49.1758805815830;
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72facf9sm3112468f8f.13.2025.09.25.06.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 06:10:15 -0700 (PDT)
Date: Thu, 25 Sep 2025 09:10:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, bigeasy@linutronix.de,
	hi@alyssa.is, jasowang@redhat.com, jon@nutanix.com, mst@redhat.com,
	peter.hilber@oss.qualcomm.com, seanjc@google.com,
	stable@vger.kernel.org
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250925091012-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

I have a couple more fixes I'm testing but the issues have
been with us for a long time, and they come from
code review not from the field IIUC so no rush I think.

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to cde7e7c3f8745a61458cea61aa28f37c3f5ae2b4:

  MAINTAINERS, mailmap: Update address for Peter Hilber (2025-09-21 17:44:20 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this fixes crashes and hangs in
vhost-net.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Jason Wang (2):
      vhost-net: unbreak busy polling
      vhost-net: flush batched before enabling notifications

Michael S. Tsirkin (1):
      Revert "vhost/net: Defer TX queue re-enable until after sendmsg"

Peter Hilber (1):
      MAINTAINERS, mailmap: Update address for Peter Hilber

Sebastian Andrzej Siewior (1):
      vhost: Take a reference on the task in struct vhost_task.

 .mailmap                      |  1 +
 MAINTAINERS                   |  2 +-
 drivers/vhost/net.c           | 40 +++++++++++++++++-----------------------
 drivers/vhost/scsi.c          |  2 +-
 include/linux/virtio_config.h | 11 ++++++-----
 include/uapi/linux/vduse.h    |  2 +-
 kernel/vhost_task.c           |  3 ++-
 7 files changed, 29 insertions(+), 32 deletions(-)


