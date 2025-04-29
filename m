Return-Path: <stable+bounces-138952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94A3AA3BBE
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15145A7E70
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E533C30;
	Tue, 29 Apr 2025 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KZmZA1Hr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2869826988C
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967125; cv=none; b=a83hZG1UrsT8Ov8f/vl3pWWCPY2NNe7BkD+fVUrTaS06BoHxdCIOalLTCEdU4F5jeILW1xiXa49CAniXCkyHqLfFqQnyhBNEhW7jAhwesLR3XTwZuZYQLH+++KSqsCcsves0Iqrhuu8SjODSvgEEZbntllK9fpHlFA++btMowvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967125; c=relaxed/simple;
	bh=2Ojmxvs6675NjSVuqKUpkCNvtSnX8cK2Q8B/hEgAo84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JzNm6g4z5djhWOwdcDNMsCTGeOKz4ZNkU2RKZNGDpagvuOAggqLUqzwd72SI8KnnNbMHaEfQF+lkFd43il12NcqV8USxCGbvnwJOqcXup2D3R1gwB1pERUltWIr72+4LEyjtKu8mzPmsQaPBArp/t/uGtJOazpRu7daEzbSDHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KZmZA1Hr; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736b2a25d9fso4457448b3a.0
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 15:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745967123; x=1746571923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfWWKlG9HXvLLFw0Ifg67i040d4sRpJ/e0Ey2hp+hs=;
        b=KZmZA1HrlZ8FI/EntU097qK6z86Z/xG+dc0IDiRojm0jog0bFU/pksYpCvLvZJqZPk
         NMNn2/rf5Jt64d6hieboYmyiSpIzahEPETe3KaMK6xxs17SgNE6KOntncI2QoFO6Q+Hx
         D7Uqc7G2qbVFntF5v1yGNQqODjwaaN9ZxMuL0qagdlisS/wC8a1RnVIH2ysVuRok1z4d
         rS4I3q7lNPuJVbSmqKzoqG0DqDONMLIuor8shXYfRq8DMAhhs++fx8nqqdiezBqpQpyV
         xaKocsO6Z9dEhN9Fhf7Xsh39Ici9ce2gmG4KTT8TTXwFO3Hz4tRjvtTKHzcXvr4NVQah
         yOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745967123; x=1746571923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfWWKlG9HXvLLFw0Ifg67i040d4sRpJ/e0Ey2hp+hs=;
        b=BlFSsJg7MCfhSQmhZPwYQsmDUzh7RhIrAfrMXESN0Ead7RDBn/9UQRUic3OyvleF1H
         W/cHoY+TfPhLYU6GQU50ziTFmQuaYOhOlirA2t537JpH+TV9Kha27+ejIN4k4sWbMJoR
         dESotrUfAeGavRcc9BuUs47S3DF6I3WSuWan3KPUGEif8hVI3fv2KyWNo3xJB7FATy4x
         bR3pHC9pXfKP1AWWSZf21XuP7oif/LHDVwvBGOqsUbfniarJp9HgZxhmV7smGYccdkJS
         akNA81Jnlreh2oN6gNuBO7MkQTgDoB5lYx3jHC5RGPFOf9nWOjWPtWkfm8YmQuBxpw60
         0JHg==
X-Gm-Message-State: AOJu0Yw+jllsa49K/Xehe/qCUFBFfTOO58FW8tN4bsqXcMHiTx8kjs7B
	FYhoeSri2PTtmolC/Lz0zYY+PeYQQF0ujZHfiRztKKMoJpbpcadvuvqdRiznLMjf3Yj1NF3AQlb
	5DvLNTLAo5Aaq7e9kFJAFbo09Gs/q4q+T6G6x40a5HZqPdN8jy/KPjkY0dyvi6Nd10YlKoPY80m
	jgGwKdTwvNoaDQqwzKHCHuY0Sn+toL7VySSHHvnHZbN2g=
X-Google-Smtp-Source: AGHT+IHJTrKOavHq60DaEmufz0Pxe9awvZIoqEAwzn6wg8tvpb679zUcOpMDVDJLN+fCuGfAVrtwmC6X4Kyp+Q==
X-Received: from pfay38.prod.google.com ([2002:a05:6a00:1826:b0:736:38af:afeb])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d0b:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-740389cda1fmr1190172b3a.13.1745967123232;
 Tue, 29 Apr 2025 15:52:03 -0700 (PDT)
Date: Tue, 29 Apr 2025 22:51:58 +0000
In-Reply-To: <2025042803-deflected-overdue-01a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025042803-deflected-overdue-01a5@gregkh>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429225158.3920681-1-cmllamas@google.com>
Subject: [PATCH 6.12.y] binder: fix offset calculation in debug log
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: cmllamas@google.com, ynaffit@google.com, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

commit 170d1a3738908eef6a0dbf378ea77fb4ae8e294d upstream.

The vma start address should be substracted from the buffer's user data
address and not the other way around.

Cc: Tiffany Y. Yang <ynaffit@google.com>
Cc: stable <stable@kernel.org>
Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Tiffany Y. Yang <ynaffit@google.com>
Link: https://lore.kernel.org/r/20250325184902.587138-1-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: fix conflicts due to alloc->buffer renaming]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index ef353ca13c35..bdf09e8b898d 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6374,7 +6374,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   proc->alloc.buffer - buffer->user_data);
+		   buffer->user_data - proc->alloc.buffer);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
-- 
2.49.0.901.g37484f566f-goog


