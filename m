Return-Path: <stable+bounces-120300-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48E6A4E785
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 18:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DBDF4259A2
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 16:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A1220409D;
	Tue,  4 Mar 2025 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWcfLBpg"
X-Original-To: stable@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AF2853ED
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106180; cv=pass; b=EbnwJ8Sx+PbBSDZQ4vJKBViz2gwxrZLHMwLCBqD///qSQzh0KCt+AI1CAoj941JC2zINwOPDJaJoat2ACNk6+K3P0uELJQOOWyf+enz8teq4vSk4Jj3tt27l4sB7SwwtxOVgwNKoT3vLA+Op7lbHfq6ZKZYWHXcjphQumIT1DSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106180; c=relaxed/simple;
	bh=vexmjRShWRkr7S+O8wIzsYn1ODE9j/1sozVgI1TDUjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GugavDkq2bcO9374lSR9O0uiLwiWZOMIeX4/VqXqb/M0YZHeG+dbz5AT8fIOo3Inrruh6vC0Qeb4d5hmhpYjF1igV63EDDk3H8O9aEjvNGPVKtVkr0//X6uM8dr7GN9BdNHl+EINMYmY9iYIMS2exTArQYAjJb/eX/+tz97i/Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWcfLBpg; arc=none smtp.client-ip=209.85.167.53; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id ECD1140CEC94
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:36:16 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h8z3vZKzG2tr
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 19:34:27 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 8360442736; Tue,  4 Mar 2025 19:34:15 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWcfLBpg
X-Envelope-From: <linux-kernel+bounces-541606-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWcfLBpg
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id DDE4D41D32
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:46:05 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 681C83063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:46:05 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3193B91D9
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF58202986;
	Mon,  3 Mar 2025 11:40:20 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CC3200BBC;
	Mon,  3 Mar 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002017; cv=none; b=NK2DnzDkaOZeOf/mT5QmIJoLoKEj6HnGqV6+2Gbk+vktV9JHiQDZHowleyLwoKPkynJEM/7D4qjox5265EomH4IzCPv2b9YuCvM6gJbgwbAe3jDEGYMHySM59lbfYSUX5EV2MsDDLYyJ8ft6HfDlxC0VrUQWKokrGw8FZNP3Exk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002017; c=relaxed/simple;
	bh=vexmjRShWRkr7S+O8wIzsYn1ODE9j/1sozVgI1TDUjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bp3aqvUx8Fb9JqUvHtvCbKIBubOo+WQSm/owfF7NrC6+PbJqsrkPi3/X/xiCHL1fi6fO2P52FIO+zNIFKspKjQmOqXcmU/hyrOUGpyIKof95L+wVEXtzIlU0+bdQkS/TFvcsslSuiw3JiM8yB+1sIKQPhCIBSbkNsavIMiiQWEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWcfLBpg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5494bc8a526so3717827e87.0;
        Mon, 03 Mar 2025 03:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741002013; x=1741606813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a3KshhKLPc3asFmOXQnuU+ysx6yVcCHiVd9RsF7krHs=;
        b=PWcfLBpgbyy01yn5+C0iJvUKDGS3hDiO+8ezodFzKDM1PrDwyXd9c3YpAfyRvgkVKH
         NfJSQQmxBGLNAlvSTtpvDJgaP4lgAuSu19p66EoCpllYBqeU8uyEOLhHF5fmrajxvWdx
         rsZTAuy/YSa46607ao7hsEPAzMlfohqa5KmicpPOViW9yhMxRCDEE6W/eQYRp7Juk/P8
         MxXElLKztOFprUWanUNzCQ9JImc+KGSnqdDu1V5/ujSMxJpk0tzLttGcPERFqt25RT7E
         MK74uQlOpp2Xa4BJ/yQBG99bJ3wfpLUZBIomiPfzmo6Kj+7l3UHfWhAnl1+OHnaKjKTO
         xi1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002013; x=1741606813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3KshhKLPc3asFmOXQnuU+ysx6yVcCHiVd9RsF7krHs=;
        b=U6j6SeiWo/CnWoQm188JMboR12+9RsAqwFLOM/C0mqlvvxckmNz0W8hhjcrk23Zj30
         CijLWU+s/WuagumHVkGAS1IMny4EWCXI6hq2S8YJTbaIM1lvPI9LlRz/hcslvQ6l4nYY
         pMq+LHruy+BejjAKzuYLsVg0qOQAHfkKIHAq2zYp5py0uHDX1rzAF3KgrWFkSTlj7LZ4
         cIrL2s4+y4akda27LroKk9j4oN8KuYLTuHMfhpADRyfd9YvoSgzlRuVoFnOjzoPyOHhG
         Zj8X7g+pzMV8AV+3wZygOXgD2UGGT1mjl7ILLlMqPsrZR1tFRFSxJ9rtEfpxRs3+M6l1
         Hk2g==
X-Forwarded-Encrypted: i=1; AJvYcCU5hBwdkhnMhEVjJXBUD687PCj/xZ1eagIU1AUNA4Z4UQnjRTcyedAgr4kIwBQQYYsi7BLE75Q1zwNYeok=@vger.kernel.org, AJvYcCUO3DqrszZUvOFfpOAJHD1JBYzOwnY2C2RWYaWhzOb4w1UmdeNxcamPWzY6YiErSZ/j4iUOHhAA@vger.kernel.org
X-Gm-Message-State: AOJu0YxGM+zXt87Cgt/hNxuGiWP2qv/7se0t6yx5hUNFP4lGs/VgHY3v
	8j7P2IS+Bu7205aO2ssZuuA3VXpsh/rnip/QqtcdnUWJff03S0nmp4JE/50H
X-Gm-Gg: ASbGncsyx/8rQ9Q6HUvyifVWGO0xZRQ9k0ocBwAytbpmX1B7It1WN3v+vHlmPsIH/T5
	jlHs2DucZC7KdMbiWRdxvtZoruILHiQ6fn1BEBo35CAnv4NJwvjm1aJlHj/B9iKp9V45IEYL4l1
	JPemHCm4q0sh6QZwC7BZisseNWexQq8GT8ITIe6HGqYkhRGuXdf0lxDniHjyix4t5Uni4fYpeE/
	keHQGuu0e+GDWSCUeYYuXVYVHHzVFVIOPLvBKtahhhr+UYRn0z+ckIMI3VWKwYAfLThyb4eWfBb
	WsWXpX3OksF7J9tdrULTpP6k6R2Rb/KyrniNbXZ2/XZ3UsIsCedngbwVnONTImgluTjnJEM63Jp
	bB5j1IDUwjR3Shj4BCR6Iy7PYQZYR44nkPQY6HZRM
X-Google-Smtp-Source: AGHT+IEbZSAS8VlrLgb63qXjtHIvC4htXmc8dPx7Hmc+Hwrr8Xjf0XYoxC/WEWCfUuOyOIo58FGCyA==
X-Received: by 2002:ac2:4a74:0:b0:549:4e80:6dc0 with SMTP id 2adb3069b0e04-5494e806dc6mr4270805e87.0.1741002012981;
        Mon, 03 Mar 2025 03:40:12 -0800 (PST)
Received: from razdolb.local (static.248.157.217.95.clients.your-server.de. [95.217.157.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54949de706fsm1125399e87.23.2025.03.03.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:40:12 -0800 (PST)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
Date: Mon, 03 Mar 2025 14:40:09 +0300
Subject: [PATCH v4 1/2] media: videobuf2: Fix dmabuf cache sync/flush in
 dma-contig
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-rkisp-noncoherent-v4-1-e32e843fb6ef@gmail.com>
References: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
In-Reply-To: <20250303-b4-rkisp-noncoherent-v4-0-e32e843fb6ef@gmail.com>
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Tomasz Figa <tfiga@chromium.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Mikhail Rudenko <mike.rudenko@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h8z3vZKzG2tr
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710869.73006@R5z1pxErlOhlvbXP/CB65w
X-ITU-MailScanner-SpamCheck: not spam

When support for V4L2_FLAG_MEMORY_NON_CONSISTENT was removed in
commit 129134e5415d ("media: media/v4l2: remove
V4L2_FLAG_MEMORY_NON_CONSISTENT flag"),
vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions were made
no-ops. Later, when support for V4L2_MEMORY_FLAG_NON_COHERENT was
introduced in commit c0acf9cfeee0 ("media: videobuf2: handle
V4L2_MEMORY_FLAG_NON_COHERENT flag"), the above functions remained
no-ops, making cache maintenance for non-coherent dmabufs allocated by
dma-contig impossible.

Fix this by reintroducing dma_sync_sgtable_for_{cpu,device} and
{flush,invalidate}_kernel_vmap_range calls to
vb2_dc_dmabuf_ops_{begin,end}_cpu_access() functions for non-coherent
buffers.

Fixes: c0acf9cfeee0 ("media: videobuf2: handle V4L2_MEMORY_FLAG_NON_COHERENT flag")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 .../media/common/videobuf2/videobuf2-dma-contig.c  | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
index a13ec569c82f6da2d977222b94af32e74c6c6c82..d41095fe5bd21faf815d6b035d7bc888a84a95d5 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
@@ -427,6 +427,17 @@ static int
 vb2_dc_dmabuf_ops_begin_cpu_access(struct dma_buf *dbuf,
 				   enum dma_data_direction direction)
 {
+	struct vb2_dc_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	if (!buf->non_coherent_mem)
+		return 0;
+
+	if (buf->vaddr)
+		invalidate_kernel_vmap_range(buf->vaddr, buf->size);
+
+	dma_sync_sgtable_for_cpu(buf->dev, sgt, direction);
+
 	return 0;
 }
 
@@ -434,6 +445,17 @@ static int
 vb2_dc_dmabuf_ops_end_cpu_access(struct dma_buf *dbuf,
 				 enum dma_data_direction direction)
 {
+	struct vb2_dc_buf *buf = dbuf->priv;
+	struct sg_table *sgt = buf->dma_sgt;
+
+	if (!buf->non_coherent_mem)
+		return 0;
+
+	if (buf->vaddr)
+		flush_kernel_vmap_range(buf->vaddr, buf->size);
+
+	dma_sync_sgtable_for_device(buf->dev, sgt, direction);
+
 	return 0;
 }
 

-- 
2.48.1



