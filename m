Return-Path: <stable+bounces-77841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D774987BDA
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C956828547A
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4492B1B14EF;
	Thu, 26 Sep 2024 23:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQ8vUqUZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A91B07D7
	for <stable@vger.kernel.org>; Thu, 26 Sep 2024 23:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393812; cv=none; b=QdzpQKTtC1J/on5X1zQg3xoL6GRsFrViQsSc4LRFWFpv3eCFmEqUyuoY2UnEomDYOYmnquz5v6MzBT3+eQzdtoKjMwPxAtR/uMENOTfrVRb+MOqALGhTBsJ+ZwZpMczWaSqWgw+IdNyBVEh2i2wcW5E5FP24Dq2GqLsow2e2j1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393812; c=relaxed/simple;
	bh=3vyvMvkO3Wyq1P4R+cw5CeJ/ZKfVE2YqNvhB7LdkgvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fnJ8ErRoGnVUsrFNLrQVX7zYI6TYm6e60DuTmYhfmmwteOn9cEntA9/lPCOI8KLjFthUuD5b3wwB+uBHMYRKh6MPMRqOKyXEkIou3kNgA2UFgFAyV0ff1MZwjwzfR4G/nuI/d59rz1+eaD4lgq4eskmUEnxc2O+muHDm/K1pbYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQ8vUqUZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e035949cc4eso2379470276.1
        for <stable@vger.kernel.org>; Thu, 26 Sep 2024 16:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393809; x=1727998609; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/iuxb3h278Dc+JtJQ9VvOQ0vkunN058i5/6AjQ3E3ks=;
        b=VQ8vUqUZrMX6k/MD35HdssE1ItwSF4rmvDPBiJ9NErWiaQctAKZ2SLNhmGDzI7lc0p
         AAfeGpTYw6evxroj7TpjwrfxqIOcxpQdD1MoNKGSy0Xg8aUsyzPJscIzokfiltcnwHyJ
         +PVTdF7TS1rI3Y0ms+ixIKuWqWq1tj5geKxpT8FY6xz9VIdwXAWeZV03sxE6vIq0pJYF
         P0yfpnvvsrcdKY+x0FzeFqkKM/u3NAUlE+QCdtffH/VOPEkIrgEeEk6NzyHRw+dcRdR2
         5SbatdeEtawerISrRTBjqjzOYmfBQYV76hjaagKJ1hvVAOOFMslCDRk6IrTNvifpJ4Hg
         gyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393809; x=1727998609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/iuxb3h278Dc+JtJQ9VvOQ0vkunN058i5/6AjQ3E3ks=;
        b=BhYyuA4+QONUuZW9CQj3RwkDJimP7EMR1e08wC13rMU649t1EFtPY4ZokvP3o+wCmd
         e0b4tk9PZk5tYhB0TV7Xa8HndFuQRz1MyjMhj4s/sOUgrnZscQuI3+KECF+mkKV7a9vl
         bT52AWphUnEcMcn/jdiioj4e8ugo9DH7X2YrGlDN25SBNMBILzxoQZUoFZ0j2Sjo9u5Y
         rSxVA42u665wEyo1KyS6CwZ8evNrJkdzFdgL/nO9h8/PnYpIOU6y6kJfJf+cUVgBA8eL
         UdukGjdnZQXK0PAjLuoTdnd+fA33yw2LEANyQS7RGo3AMfqu14+2ObFLeV08AFia68WQ
         Vt1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXshy+FlaFMfQPdj2DYkbVDd4lgi/gdcoM3VtTU6neVVEhwrnnBbs2QCW1KCBszswWkNP5uKnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz540yZl2xzZidYIzJtkxbmP704LDMnWUZNPjfCoME7+uTeAM13
	z6ucJmPwP5RHeU3FIdGa1j3ymfmk1k0qBsYNfo4RsQUPeH4TRbbkI0OqWnm2UzAdTnzGHTczxeK
	cjl+WDNeQtw==
X-Google-Smtp-Source: AGHT+IHBVAPawG1xZ8PVs7gjULOKJDTEQX7j5JE8yqCAQXtSxFo6puwM71uXOnRfMu8FHut5bqq89unj6w+mvA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:e906:0:b0:e25:e391:5739 with SMTP id
 3f1490d57ef6-e260495ec2amr1466276.0.1727393808817; Thu, 26 Sep 2024 16:36:48
 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:15 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-5-cmllamas@google.com>
Subject: [PATCH v2 4/8] binder: fix BINDER_WORK_FROZEN_BINDER debug logs
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"

The BINDER_WORK_FROZEN_BINDER type is not handled in the binder_logs
entries and it shows up as "unknown work" when logged:

  proc 649
  context binder-test
    thread 649: l 00 need_return 0 tr 0
    ref 13: desc 1 node 8 s 1 w 0 d 0000000053c4c0c3
    unknown work: type 10

This patch add the freeze work type and is now logged as such:

  proc 637
  context binder-test
    thread 637: l 00 need_return 0 tr 0
    ref 8: desc 1 node 3 s 1 w 0 d 00000000dc39e9c6
    has frozen binder

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d955135ee37a..2be9f3559ed7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6408,6 +6408,9 @@ static void print_binder_work_ilocked(struct seq_file *m,
 	case BINDER_WORK_CLEAR_DEATH_NOTIFICATION:
 		seq_printf(m, "%shas cleared death notification\n", prefix);
 		break;
+	case BINDER_WORK_FROZEN_BINDER:
+		seq_printf(m, "%shas frozen binder\n", prefix);
+		break;
 	default:
 		seq_printf(m, "%sunknown work: type %d\n", prefix, w->type);
 		break;
-- 
2.46.1.824.gd892dcdcdd-goog


