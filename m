Return-Path: <stable+bounces-124079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F867A5CE45
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 19:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23043A4751
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75124263C75;
	Tue, 11 Mar 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RlaKXFMI"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA71926158C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741719310; cv=none; b=Cyy9lloYBMshHq7tYbA3NqjIOIyKkZ7PtDXGKFBdXfT+ueqRqY/uEVXYESCCr7Y1p8RWdPpRBnO4sJuuy/HJz1QP+PTzlrLJkmCyU+zov7c5PrgEbjD7EgFbIsA+BOedFc2mdxWOrA6RBQcScIsd5TmIHR7g1SojgJiqn6ZZCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741719310; c=relaxed/simple;
	bh=6AEQLbvhk1gDF1gstokQrse+Z3G9kX3k16wGREN4U5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ew5HWzQ7aCGR48M/ZMKP1e4EQ27SOiVZk+H7HYVuU9DIo+aDEcYUWpV9MSjvfK9RGnv3uY5du2dM9OZUCVzN+I/b7A16kXUVd4iersF1MLtqkAB0paZiU6uAh9V+4defC4yFPixVgmZmH6dT8F5eutCvFonH146QX4Yfkj44HAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=RlaKXFMI; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 898EB3F1F3
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741719299;
	bh=ouhpjDRTjgwWqVMJ5bBAfO17+dSjGw3KAwVR+ofeOyU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=RlaKXFMI61XoCsRjscWejgzCN+Geg0ckXGVLfirQwkIlG2OcRwOfehwEq5jALtTta
	 nU67Evm+Bcsvjxpe3fL6atEXvgTCfl+FAFtbTcO0lkzr0cs59vgFaUF52+YL0KehqX
	 b2yRIlkF0Bn6lQCKyLyvox2GCA/2efuMQ++Ykop8KrKs2+jSQ9/p3jhr789kKHNDxc
	 nxk4pGlod3D9VR6aJI+Q/BZM0fiqGhGy4pfvaG1DJgzDOrAjKWiwQv8z6WpxiltYXL
	 WX/5NR9K91je/lZ0pO0gFIDNdVSnvLBYFwhtcCYmMNKwsX7vzsWPlhS9NHbZ1sK8M0
	 cS98U1oe+h9uQ==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2242f408320so65399325ad.2
        for <stable@vger.kernel.org>; Tue, 11 Mar 2025 11:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741719298; x=1742324098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouhpjDRTjgwWqVMJ5bBAfO17+dSjGw3KAwVR+ofeOyU=;
        b=VfSCR8wDiTkSAokY/jRygHfqSlCw73GbRtOeSlfyi0aVuFTSbCLlRV8y3OpqJ8MExN
         bt+CtHSFQ2u7BCNxfPe7XI+qrg2MbkEKEDVgmYLcMLh2QA9xyQ5QwflO+l2eYpAn57LM
         bNu6436IdLXaHLCaYHHMQ1LQZhm+ow1BU6EWKOeC9cVEdCKNI5N1/oL4i58nFu8O8pxe
         srpP8YzPCLj14m/q0kJvu89hykuLbShrQEliNBcMiF/57QBqrB+WV/TtgEtAngeLc+vV
         bHgcOkMUF7qQplfcKIZZPp0V9OOBMuOKsFecC/zENEWX1AH6twRJeqrNFwHxcA6bAJOO
         kUDQ==
X-Forwarded-Encrypted: i=1; AJvYcCViDJmyDL7jxsPzLqGvho6NxUqdeua/G4VRoAjfQzkZJQdctyl7azraYxZDSoXiKVpNz0f5mAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF3bvVgOFxJtn9tZqOERjzmnOJZ4s084dby0sM5RGJmrn4b9G
	bitzWxevVMF3jVEgammvLrWr3SiZkf8Cgs0bIPi9olOVy6/85ylfHPPWXn5w7vXXqV9y8T//VJP
	+qbogCkQAU7EdqjDsDbilPkEDFllnDO6Q6zlPjfTpBYy+WHoF2K0ZdQjgu4jVtj1rSX8m0A==
X-Gm-Gg: ASbGncsPXjmKq9utPhTRwV3QU1DRtOsdIt9hfOuIbcRM7iBhsEY1DYa1wYj7sHqyZ3W
	jzUKIqbNeWgQXF9gknuP5EVd90pLYRbGtsVziwfVxCCELrn4oRfTrB8C+SVH6aju7mxruuax/J5
	jqshr3llgsSr7u5JVvW8BkXe2UVfECqkhw83oaxbOZ6Mc/qvj9UgTTwun2lD/Fzt2bDBDSx8nfv
	DzNik/S3Kg/vi3ULcsLt7W2sfUqV/3i/2AF9EiRX04RcPw0LPsxZJdt9MWqXmZp1s/qOxzXAj4H
	/gZHZfaNF0UfMyQs5A77HK0ik7zdm5iQprkS+Oc=
X-Received: by 2002:a17:902:cccd:b0:224:256e:5e4e with SMTP id d9443c01a7336-2242889d3a7mr295920575ad.16.1741719298080;
        Tue, 11 Mar 2025 11:54:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLisilpgPhzBC7HsgeRTwSwJJrpr13NwdPh49yWX79i+mAW3dBfCNkedfNiTKyWgZ9t4L2Aw==
X-Received: by 2002:a17:902:cccd:b0:224:256e:5e4e with SMTP id d9443c01a7336-2242889d3a7mr295920365ad.16.1741719297755;
        Tue, 11 Mar 2025 11:54:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:14a:818e:75a2:81f6:e60e:e8f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a7f77esm101765875ad.139.2025.03.11.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 11:54:57 -0700 (PDT)
From: Magali Lemes <magali.lemes@canonical.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 5.4 0/4] sctp: sysctl: fix argument passed to container_of
Date: Tue, 11 Mar 2025 15:54:23 -0300
Message-Id: <20250311185427.1070104-1-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patches "sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy" and
"sctp: sysctl: auth_enable: avoid using current->nsproxy" have been
mixed up when backported to 5.4. The `member` argument passed to
`container_of` has been swapped in both proc_sctp_do_auth() and
proc_sctp_do_hmac_alg(). For instance, accessing
/proc/sys/net/sctp/cookie_hmac_alg can now cause a kernel oops.
Fix this by reverting the wrong backports and re-applying them correctly.

Magali Lemes (2):
  Revert "sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy"
  Revert "sctp: sysctl: auth_enable: avoid using current->nsproxy"

Matthieu Baerts (NGI0) (2):
  sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
  sctp: sysctl: auth_enable: avoid using current->nsproxy

 net/sctp/sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


