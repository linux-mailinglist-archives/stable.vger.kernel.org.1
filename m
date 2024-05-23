Return-Path: <stable+bounces-45984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E58CDA1C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DCA1F2239D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7190763E6;
	Thu, 23 May 2024 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVc84db7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52586187F
	for <stable@vger.kernel.org>; Thu, 23 May 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716489845; cv=none; b=VQEad4cWjApckRPi/3PfwgVEKuruxJToBDWJ2TCN05ShO+Pv3e1gUo1AiNGv6FBUT/67JXM3uAJsDlxl+yT9sXXMTK4fRapGZCPkUlegxOEiDiDHXgKyU1HA4OXpGv5PZx8kbmQ3rQkUXM5N4P1xD6jQ6xMa4JE+qEGm5ZZ8/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716489845; c=relaxed/simple;
	bh=Iq0e9vMRPjrgBBUGWR5a+1x2pGIRgPq6aHNB3OhZfzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qsX28DednLWqRvg1ajPHGQlAilpEiWc0nsqLeMf2BrnxIvLg6Nee31+JXoaEykf4R8rTq1U16h4xTpKt78zAaXgFrJhvl6vg/KZ3tvQp3efLzo6gjGQEDAZkYjlKLXJsNsTHqy9oO6KPr86bBOMBx8LRbA6cZiTvX9P+Vuk8Tls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sVc84db7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f8edbb8eb2so72545b3a.3
        for <stable@vger.kernel.org>; Thu, 23 May 2024 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716489843; x=1717094643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJhYo6Bm4ilNPJnxKHarAOV2HozYAcvQZlVRjigniR0=;
        b=sVc84db7UM7or8qNAa6IRZ3Rtc8hBAQFWnNFGCFCXdBHVYMe5oNl8yCkDruhdUzXbR
         Q/5IH8s8wqEFXtDmcd7BPPHhrW8hcIbUtwqZv5BvOwlnSh0w55fvb90Rb38IeShghXWU
         YblfprEyOZ7Bjt9Hx6jCkym/x3YdSWXyqs0WTxzRPAwWYFEdxGb/oodNe2PYIqsg7TOz
         PagYbXmdIFp8XgUCzh0ZVTgm4EJLxh/joY37wZQ21BmR9mJ3OrnzaiiE8DYm9pGXzOGk
         P+WWGXPZeEx2kRrDkN+nLOwr84nPx5SmzJ/E+9J1pXrTPYdIEVXPuH/TFhxNz4wyxlnl
         rquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716489843; x=1717094643;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OJhYo6Bm4ilNPJnxKHarAOV2HozYAcvQZlVRjigniR0=;
        b=RmiNHiYk1qiiDelYVHLFTZsuRzf/y3SOlqVjryZmteUx0DJo/ovppRYIah+S6vsLdw
         oeZAMzJG3gs16RYbSoAH16tEgffLAXigkDzzOj3MSgHjkLpsKwekH/pbC/aFFfYoXQDp
         uLOgOk7kwl83v21VyZc4uQ1F4fChJfB6xghsaodRfi+wAhDUFTeKyar/I7t6/V9l25qr
         wK16QHhVLjTyvwXgQSefkjoSyb1P1gKfq2p/WmY/9Mpr/Q65mqtA31JUy7/4orLi4ILM
         Q9CsHNrx9rqcPtv7bnZtM+SNEb+1LG7KsBWWjNE1iKAKw3YepXM+5k+vUE0ui5nyaukY
         qc2A==
X-Gm-Message-State: AOJu0YwCI69phazSJ8EUMezw1MtSRUE1owzPiR3gCmeuYS0TsapGSox3
	W/Yj9LpsQod0XxTQs9I0JiyEoButz68E8/bta79ucBrEeq7ukpLQPXOmwDnv3SSo1X9Nz4Fdqyk
	SU9EYsX+NTw62adv2ESpTmdpV9pnS3rj1C3RH1l8IgzkxCHVYzR/3S6z0w75S7gX9lSZl1oEkII
	MsWb4FHQ+jk7rdH84nfb0lkj7eoeHp18wqoA3USTkH9Nk=
X-Google-Smtp-Source: AGHT+IHKUfDeimC0/rDT0mcqu1Am2UJtvorQLLyc8/s4mUg6/IXXzhx4+WLcJE50DvDe/rr4WDysyWUAW7EH1w==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:3927:b0:6ea:8a0d:185f with SMTP
 id d2e1a72fcca58-6f8f2e67626mr896b3a.2.1716489843188; Thu, 23 May 2024
 11:44:03 -0700 (PDT)
Date: Thu, 23 May 2024 18:43:52 +0000
In-Reply-To: <2024052313-runner-spree-04c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024052313-runner-spree-04c1@gregkh>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240523184352.1541595-1-cmllamas@google.com>
Subject: [PATCH 5.10.y] binder: fix max_thread type inconsistency
From: Carlos Llamas <cmllamas@google.com>
To: stable@vger.kernel.org
Cc: Carlos Llamas <cmllamas@google.com>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

commit 42316941335644a98335f209daafa4c122f28983 upstream.

The type defined for the BINDER_SET_MAX_THREADS ioctl was changed from
size_t to __u32 in order to avoid incompatibility issues between 32 and
64-bit kernels. However, the internal types used to copy from user and
store the value were never updated. Use u32 to fix the inconsistency.

Fixes: a9350fc859ae ("staging: android: binder: fix BINDER_SET_MAX_THREADS =
declaration")
Reported-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/r/20240421173750.3117808-1-cmllamas@google.co=
m
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: resolve minor conflicts due to missing commit 421518a2740f]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index bcbaa4d6a0ff..6631a65f632b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -476,7 +476,7 @@ struct binder_proc {
 	struct list_head todo;
 	struct binder_stats stats;
 	struct list_head delivered_death;
-	int max_threads;
+	u32 max_threads;
 	int requested_threads;
 	int requested_threads_started;
 	int tmp_ref;
@@ -5408,7 +5408,7 @@ static long binder_ioctl(struct file *filp, unsigned =
int cmd, unsigned long arg)
 			goto err;
 		break;
 	case BINDER_SET_MAX_THREADS: {
-		int max_threads;
+		u32 max_threads;
=20
 		if (copy_from_user(&max_threads, ubuf,
 				   sizeof(max_threads))) {
--=20
2.45.1.288.g0e0cd299f1-goog


