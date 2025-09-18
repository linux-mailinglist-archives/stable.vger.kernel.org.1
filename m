Return-Path: <stable+bounces-180545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AFAB854CF
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045667B2780
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8DD2F2609;
	Thu, 18 Sep 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I92hhvne"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB2214204
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206513; cv=none; b=NaSM5H77ye2bjHUgjMFMNtCAHEdVM0pMNhOsP8YZi1zxg7z/bty0k3vUXVwexaIs9iYEa0UlhwJUv0L6sWpFPkWn1DUybR2VyRdtxLI76THSKQbBUMJYZLP3QqmxijH0ohoEkoaBCm1Z2q5SRQhmlCuppTZ89nxahUn7K/irMjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206513; c=relaxed/simple;
	bh=52mzwF50ZysPik2mfGb84bky8NEzJW1dDbmZc78Gl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mWIwKpxX2JaQuJCXbwK5XL2VvVT2uXF9OEBmbgsm5+dgrCGMORoROcsDlDLrrDq/U+HMudRndLEgrOoKcwXe71sgkRbYa8YbpUXCgi65xhpltFLggxYfB+J/gjsuliSk7pyQa8wZEyua8+bUi2Lox5dl3DjLjyF4ZQo4At5WU04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I92hhvne; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758206509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
	b=I92hhvnejmVFbYB1S4O6uxwKDCpPHQ9DOb2YpM26hWG4p4nbx8ei6HCKEK8VNBvAK3S9H4
	NpY8HJqsuRAtYlVJf36K/NA+GW8z6wbWEoCzcUwnpnRMCCKEXDvXwq9WJVinbN4g3rnxvF
	DuGWUMobI4l3nH1P8swRrFc76XznV98=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-wj7EoWu-OeyG76nyLZTenw-1; Thu, 18 Sep 2025 10:41:48 -0400
X-MC-Unique: wj7EoWu-OeyG76nyLZTenw-1
X-Mimecast-MFC-AGG-ID: wj7EoWu-OeyG76nyLZTenw_1758206507
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2f1a650dso7432105e9.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:41:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206507; x=1758811307;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XGS8iYxGjjgCtPNfLtzzgPnXWY2Ig3ulBcoQ+vUpdX4=;
        b=DX3igQZBDXJTTdMuG0CbOxPyy2J6TnBLeb9NatZa3MnwwtADlBtgpFc/u9gaTdzAEn
         cmRNLbsBnOm92DJb4b2OgOCrby8kfeyI5QHscU5JxHDRNuAhbYx7+Z09BmQ1amyye1fa
         sEScihWoImtASZEDfY0ZaGvsZ3XYUfdiCiOKRDS9DJ0wEk0Whp6wNv+uNSqxO5fRv3mm
         wffjwwoQMTdaR7kuP0b1x/GN/rn1m+fMO2KK985D2hX0T04c9FoItIu26+eZUt+N4ORN
         rB/UTSG6U+XRfKhTkZDSiUUyG5qq8m6Cq2tpgjxj9SlM2c9Cu64jAUGDZNi8sj/RxhYH
         W+/g==
X-Forwarded-Encrypted: i=1; AJvYcCWfnlPuEQmU3G058vL2pB5G+p1swn3FILc0I9cq50ChGBbRmy/ji0k6vlgRLMm4WxWL5Crq67A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uhJUMsmlyp5uK3IptGniSMAfr3fkZDL7Nd+EfE3CUiQcRDBn
	EVaB/fmmCeaQHTrdHQrIFgd0d88fjgfj9GxQyzlu2tSPQyg7jjSMbA7TGuWmEpD2pODNgJtg8o7
	t4RdaxKM7/+04iVhrigMcY3/4l3nNdJz5dGQBbnxF7jJbD5+LC6QVeatYHw==
X-Gm-Gg: ASbGnctpleHPArEikuVxFJXnmXE4Ek2dLsTYaP3Y1Q4Z8cs96qdneuGW2au3OjL3KSg
	E0DO6wIpDtviMiXm9r/q0NWdSn37cdFihf+H2fM1320SX7r+hZzhIgPw1XaGooKwfMbfU01SpgM
	AJ4w9L9xlEvMnumnEOXwAUxSsrPl6TKixxgfPe0rcOEfG2WMSW+0HHoqCjVAbhOHzZvbqFlqf7b
	MfwBvJ8XWs5O3ql94ua1qNx93Iyf4n3W6MwetxM5rW59YvECH3A5wjvdDN5BxXLsscY1HJHLeHM
	lb3cbltURETObntL9phzfSZWEUwNiN0RqSc=
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947705e9.7.1758206507325;
        Thu, 18 Sep 2025 07:41:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6KtyNG51lUBBb+796Ksha+xJ3k91Ah4nN79uv8tPH32cwmgf4CIFGIqg2jBve/wowaCq5Rg==
X-Received: by 2002:a05:600c:3b05:b0:461:8b9d:db1d with SMTP id 5b1f17b1804b1-46201f8aa61mr51947335e9.7.1758206506772;
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm42562565e9.1.2025.09.18.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:41:46 -0700 (PDT)
Date: Thu, 18 Sep 2025 10:41:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, ashwini@wisig.com, filip.hejsek@gmail.com,
	hi@alyssa.is, leiyang@redhat.com, maxbr@linux.ibm.com,
	mst@redhat.com, seanjc@google.com, stable@vger.kernel.org,
	zhangjiao2@cmss.chinamobile.com
Subject: [GIT PULL] virtio,vhost: last minute fixes
Message-ID: <20250918104144-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 549db78d951726646ae9468e86c92cbd1fe73595:

  virtio_config: clarify output parameters (2025-09-16 05:37:03 -0400)

----------------------------------------------------------------
virtio,vhost: last minute fixes

More small fixes. Most notably this reverts a virtio console
change since we made it without considering compatibility
sufficiently.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alok Tiwari (1):
      vhost-scsi: fix argument order in tport allocation error message

Alyssa Ross (1):
      virtio_config: clarify output parameters

Ashwini Sahu (1):
      uapi: vduse: fix typo in comment

Michael S. Tsirkin (1):
      Revert "virtio_console: fix order of fields cols and rows"

Sean Christopherson (3):
      vhost_task: Don't wake KVM x86's recovery thread if vhost task was killed
      vhost_task: Allow caller to omit handle_sigkill() callback
      KVM: x86/mmu: Don't register a sigkill callback for NX hugepage recovery tasks

zhang jiao (1):
      vhost: vringh: Modify the return value check

 arch/x86/kvm/mmu/mmu.c           |  7 +-----
 drivers/char/virtio_console.c    |  2 +-
 drivers/vhost/scsi.c             |  2 +-
 drivers/vhost/vhost.c            |  2 +-
 drivers/vhost/vringh.c           |  7 +++---
 include/linux/sched/vhost_task.h |  1 +
 include/linux/virtio_config.h    | 11 ++++----
 include/uapi/linux/vduse.h       |  2 +-
 kernel/vhost_task.c              | 54 ++++++++++++++++++++++++++++++++++++----
 9 files changed, 65 insertions(+), 23 deletions(-)


