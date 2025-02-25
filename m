Return-Path: <stable+bounces-119511-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7CDA441A6
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 15:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD3A3BE2BB
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63CF26A1C5;
	Tue, 25 Feb 2025 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O0kwHXnR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5926A1DE
	for <stable@vger.kernel.org>; Tue, 25 Feb 2025 13:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491783; cv=none; b=IsiIjnjzq6JqjDR8dHndz4Ne+s2DA594slIIfLnDEhaWyouJE5HySMW0uUwJZRbfmZFS9+TqdyvqmufGaANBKAVe526KhxmICX324cNAoIhRvm9XH7G7mPzlFLbbqeoqwOUOKqeECnDjMf195FneCygp6ZSudIhUBlHxV5yDecA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491783; c=relaxed/simple;
	bh=AbwkYdz2X7gayltRxgUQ66W1QXU2GA6mTmWIt+7XKns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tQw/PgMSHivF3lcgy7bUl84slfAKP5FdBZmXhn96ogH7VTEW/N5v0HSkg5iS8ZpfK9U19w6/8pvvJ3FXhQRxX2ywg3BDpaiIxIVNJzAchdChJ3cYDroNCjMY1qmanV1n41EErSZ5Zgl5U1uuK4lmtbQ/NjcgBC3F/VGeIXNNIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O0kwHXnR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740491780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=38T73+mw3hWmhwkWUmsh4vTnFUuQ6Qx/FSDvLlMEPrc=;
	b=O0kwHXnR1D4iHk0hqUBJo9Funq/PzRfMxre6jVKv+yi2+x0faQL1+7RMhgk3C+AdocjHmG
	aEL9n/LCBMZO3Wx/oelc/ZwGm9TEiGLk1titAil1CQqE+EdH2qfXJBsWNpQEcPsNX4HmwK
	uBnNpkSkxhznppvTSYHsVWreo7w8XRE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-Ua1msB0LMYu50hnk2gP2ew-1; Tue, 25 Feb 2025 08:56:19 -0500
X-MC-Unique: Ua1msB0LMYu50hnk2gP2ew-1
X-Mimecast-MFC-AGG-ID: Ua1msB0LMYu50hnk2gP2ew_1740491778
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4394b8bd4e1so29040865e9.0
        for <stable@vger.kernel.org>; Tue, 25 Feb 2025 05:56:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491778; x=1741096578;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38T73+mw3hWmhwkWUmsh4vTnFUuQ6Qx/FSDvLlMEPrc=;
        b=U2RSWMif2pCTaZKohG6dwbrnuLIw1lQqezkwaVL3UYwDx4HHwEj/UcWcaV4nS7YlCO
         tlvXtg68M2X0paiAQ+/LZQNYrJhqxiKsVxjwPrXCxNzAvgdBEaOzCpg/eiLPaBh5TV2j
         hrdLUKVtAp8ofSYiW90cUiDJRgio0bBt1EfoV/5BmNweP7tR5DOri6/pY17jpEfG1BlY
         9++6MjqCPxj1jo+gUY4JpBTzzrB4vIbCpvV5RckM9xl9Q+2zX2AXudEHmfq+YW70gz3d
         FSZYt2G20Pm1cGNOJvgwMQCzLtQbjFNCZqZhC8SyS4c0OuYHhXQWCYd6CYN1IQSatfH+
         CoUw==
X-Forwarded-Encrypted: i=1; AJvYcCW7swA06lvNZcK+jTIcbRM4c+OzbJicCj4s8holO3Rj0PYpC+5iWE2TXfwUZr1qGbg86IKOM58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWuG02TbBTj78qirIXQ+rq24IRphUq/vAy6pyfkNpgYt/aSOFh
	n1VAN5KVm8KU/XG8TFj2Mx5mA6EhAhvGNTs7tpJuU+ELes00PdtzMprPvvWZ69wanQjYNMmPlg1
	9sFzeeiwYbCuGkbx2a3MIiTiRwqp0Nt2/1OM7SMGBcpwcdToBEjAheg==
X-Gm-Gg: ASbGncsfqrnSFakRq9MsEdaWEQ6Ja6tXJ/bfLXd95Mr49yO8w6Xjcf9CKEcwuE6DcVu
	PIdonsEZhffz/CAvp8XKCcSwLwYXX8FgKLn689uw/4SVKGHUhSRnV142pDKeGKqYuO0bCPpxQW4
	blqKMKlQ5Vzq9AwqkCs4z4l2IEa1nlBelSvGaoPJX0dKtUPUL/yiiJR6vzR1z7JOco28mGoQwqT
	Nc+lyMlxddRpUEOGgcdk4Y+Ijjtxq9BoGLrucAzTiWffEGTa+GVaHbkvdXC8FETK6W1sqA08jdm
	dPASvb4QGRU1CsoZwnmeaXipcjGuMRiksjSsCOtxJIA47myvSVaEeyfKnEnGL30+wpLFpzM=
X-Received: by 2002:a05:6000:2ac:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38f70827ef6mr14649332f8f.42.1740491778082;
        Tue, 25 Feb 2025 05:56:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbt5tEOSqRrZXZZ595kYCv/9EY86RJywnWnAn3BSrUU3qB3dDCE/eX/24vKV5YndzXPdGOKg==
X-Received: by 2002:a05:6000:2ac:b0:38d:d9bd:18a6 with SMTP id ffacd0b85a97d-38f70827ef6mr14649317f8f.42.1740491777709;
        Tue, 25 Feb 2025 05:56:17 -0800 (PST)
Received: from lleonard-thinkpadp16vgen1.rmtit.csb (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cd10sm2424181f8f.37.2025.02.25.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 05:56:17 -0800 (PST)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH 6.1.y 0/3] vsock: fix use-after free and null-ptr-deref
Date: Tue, 25 Feb 2025 14:56:12 +0100
Message-Id: <20250225-backport_fix-v1-0-71243c63da05@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPzLvWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMD3aTE5OyC/KKS+LTMCl3LRMtEU4s0M5M0QxMloJaColSgMNi4aKU
 AxxBnDwUzPUO9SqXY2loAK1wOamsAAAA=
X-Change-ID: 20250220-backport_fix-9a9a58f64f14
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
base-commit: 0cbb5f65e52f3e66410a7fe0edf75e1b2bf41e80
change-id: 20250220-backport_fix-9a9a58f64f14

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


