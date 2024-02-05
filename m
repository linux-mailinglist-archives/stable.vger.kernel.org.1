Return-Path: <stable+bounces-18810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080E849345
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 06:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8BC1F217B6
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 05:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C679B65C;
	Mon,  5 Feb 2024 05:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QKgyu4Kn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16E8BE47
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110403; cv=none; b=aMpAdYhCiLhaClABel0IFz3QMQRFXbWt/IyuVr0Jjcrb/arGIGrku+18mS+U/Fam4IPd+aXMQdJfejfSnc5/zIFXyBZxCUQGf1cIVyjTo00tywHEMGPYVVs5GXfeqkm51o+ZlFjQmouJz07OCmmAzKXIjPMc672f5aTLxkoNIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110403; c=relaxed/simple;
	bh=b/F/IvZJvxSYV6yT8GonNahencq0VCJX3syNSsaFNgM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=glqQ7G7C2Itx85eTWOR2KkWwy9kyW+eLiEx5bDHvSRSlQ/PVIs7beDNghzk5qox+MRxLkI9/H1fSsEr1IJYziVg41gfr7WYZLcdvpWn1coQzrwszDTvFcFoOjvvpRpXZnoM5G6oW5FmJ2Ggw8o9hIdBa71G6uSNGgP3E2W3fg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QKgyu4Kn; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so3559321a12.1
        for <stable@vger.kernel.org>; Sun, 04 Feb 2024 21:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707110401; x=1707715201; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dW5zoXaotbxS+SYq2Yu+7hcfyLit5t9UvVc+9SbtbuU=;
        b=QKgyu4KnQu38n2VMRkHNS5SggccUPhHeAB5NHXAIHQQDUrPtX1wBLFaCTwLDrX2HX+
         OHyTcm7lD7ikBOun9Bx1P64lNpiEdLWY8gwj4WojiQ6vEyZI8Vj7MptLH6mNBp19rtpE
         vmBvlOGuHDFRkvk/4GLvGMC3TsY55tuFCTqnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707110401; x=1707715201;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dW5zoXaotbxS+SYq2Yu+7hcfyLit5t9UvVc+9SbtbuU=;
        b=Rvmt66S78ZhOsC0KoIA1rTugUo4I1RORTMhe7gUyjiwFubadznTSNZVWgSNQuCBdVs
         YzYzCFysRC7a7444AnvfscjTj/xuQTZMgz3mOer08kI//uDbwNxaB9xf93kCxGG9rrs4
         7n7k8HHSNM+VAEJ754G5JlS0ExSX/VRT/v00Y98gQjS8nnRBmqfZhsYE1YWgHEcGn8n8
         ndsDSY8tfSKh6UlIepZUr/F+W0gskqT4IgTb4j/MY2VY5NnvSyytY5ffUUDZsatGimml
         Tm+x5D9yskIgqckVZTPXFCaR+SaAu0RoI7Ienl85I7wXL/czB2XVWXzofb09IL2CFRIC
         iEKA==
X-Gm-Message-State: AOJu0YyYuOgacQ9n3mAprMLoaRBtjrjfQQBjdtUQtXjqhGobSN2KYM44
	fhHTHOYkYw7e4aPdvkeQFiN2XC2XztVQioD3j0apShWfByJ0UtuBdCQURt3nsHtUZtshnSJZj+N
	X4aezrUOhqcjZfsy2TcQXZIk3oqUQxqPaYk/o4NUrF1XQUgLD2cc/3gOstmEZ6Lxu9EXNl9SNeI
	BHJk4XZgAbWD0fhY6HwbcDdXU4zmflR+rg7nxBvu71Kto=
X-Google-Smtp-Source: AGHT+IF9ggkIkGzgeO3uo/eh4fyZDfJpqokYxDxSkwePH8H9UgegtHqrBxC2F2NZ8p3jAZTfYMVDNA==
X-Received: by 2002:a05:6a20:d909:b0:19e:5e0c:3bb8 with SMTP id jd9-20020a056a20d90900b0019e5e0c3bb8mr7970208pzb.7.1707110400605;
        Sun, 04 Feb 2024 21:20:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW49LbvIWU+foFA9+KIxmqctHvrKIaSi1hkNesPGFRM7R9cegKJcmHbSFXi3GzjE/YdnB5Fl/OpeO3vZzMH5DaqL6KSgHIyyvlhIQUpyRQReWw22hTiBxoqktD8Cs1h7bN/Cd/Brw9tVOsaoCiNwdisW/3kqqmoiX+5XZTjDIqgn/YKopHvMH6THCVhQxwRn9vXhafxdhJ7MbNsEh9Z/9YUHTbcQNqFSa+eN44LDAwcUHy+/tAEd4rqQbdLVf1pwFbD1iIlD/rVOCG5lAw/zFeMPiZY9dZ2IBAaMoBOvFsYb/QRCnW7ICYfQ42h28TqV1bbU+64mlT2XlHJn9yY0theGA3HEUVu3iIEwKYlsyLO/v8F+HDPf11iYfXrGwhw7dYZ7Am1PDIbpWcadF12ojDSrkZSe+UAP7aKohAyjC+TQld5Zn/uBnxO8g==
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78110000000b006dd84763ce3sm5612953pfi.169.2024.02.04.21.19.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Feb 2024 21:20:00 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Prathu Baronia <prathubaronia2011@gmail.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>
Subject: [PATCH v6.1.y-v4.19.y] vhost: use kzalloc() instead of kmalloc() followed by memset()
Date: Mon,  5 Feb 2024 10:49:37 +0530
Message-Id: <1707110377-1483-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Prathu Baronia <prathubaronia2011@gmail.com>

From: Prathu Baronia <prathubaronia2011@gmail.com>

commit 4d8df0f5f79f747d75a7d356d9b9ea40a4e4c8a9 upstream

Use kzalloc() to allocate new zeroed out msg node instead of
memsetting a node allocated with kmalloc().

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
Message-Id: <20230522085019.42914-1-prathubaronia2011@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
[Ajay: This is a security fix as per CVE-2024-0340]
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 07427302084955..ecb3b397bb3888 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2563,12 +2563,11 @@ EXPORT_SYMBOL_GPL(vhost_disable_notify);
 /* Create a new message. */
 struct vhost_msg_node *vhost_new_msg(struct vhost_virtqueue *vq, int type)
 {
-	struct vhost_msg_node *node = kmalloc(sizeof *node, GFP_KERNEL);
+	/* Make sure all padding within the structure is initialized. */
+	struct vhost_msg_node *node = kzalloc(sizeof(*node), GFP_KERNEL);
 	if (!node)
 		return NULL;
 
-	/* Make sure all padding within the structure is initialized. */
-	memset(&node->msg, 0, sizeof node->msg);
 	node->vq = vq;
 	node->msg.type = type;
 	return node;

