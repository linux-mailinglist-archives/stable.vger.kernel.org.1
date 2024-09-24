Return-Path: <stable+bounces-77043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0894984B35
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 20:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B331F23EF6
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593A1AC884;
	Tue, 24 Sep 2024 18:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="faxkAUmj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8584E1AC45A
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 18:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203445; cv=none; b=fyjSW0ybYMyL5jE9nVoeYHAo6vqUtmktLSzGU11GdKTH/Z44PBxT+YcpgxNDvuaKB5wNHIc3dNGRAeT6zWMcoVuOckHqloHrBjNbsMx+2sVNsYqyQcaz4UJOZaBKriMchgdXb6RZJKr5uYOarKFLSd157WZDFgu2vQWXVac+ocQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203445; c=relaxed/simple;
	bh=kpIYtViOQeWQiFTd/NLgMquBDxjgF1ZQgKK3T4bn+cg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SS+ueBrK5iYHNYq9wxKJRLa8iNR4SLNTN9hKojmgMPPTcQMNuq9RWPMI0C1SZE1X2Xx1so7d3X0T4QojiBAt9quCqok1EPuGEc3A4qqkmJs1FJ+I4xyxsoAGuEdFsbLLgrh1Ku3BHTavY3SIMktyC/j4kixg6Td7jaKA7coyqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=faxkAUmj; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-778702b9f8fso110288a12.1
        for <stable@vger.kernel.org>; Tue, 24 Sep 2024 11:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203444; x=1727808244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1oXC8Fyd+mfraJhY/OY1aVwil/UuSylKa/jz0IG2oVU=;
        b=faxkAUmj6fNd11rsZgceFOmi9uJBfEwIRBBX2Is5cXUdIGdAxRmqHfBgj9+zPbSSzn
         TFBM7gSz4jbWMWADge6Itz0piVrNepDiVFH/ycCVwtLTyM5YhKo7D+IeoOaAT7PiaR6V
         e5bWG/jfI8gLCdUIyCoIpnKPvOVaJeiWLGMSo78WS45TGhlrjb56sG6i4ttRczQGMqA7
         H6rdS9oTfkGu8xF99iZr2dgqgsupjXTmTF6/2j7EZVtt1F8dQwKEJTf0aPE8V3WFr9GN
         c65tWWjGnBdGnbsZcA39r1JYgnT/YqofqitjQkChgtEPUne8pcGEHxr+WUR0kTj3szrO
         V3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203444; x=1727808244;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oXC8Fyd+mfraJhY/OY1aVwil/UuSylKa/jz0IG2oVU=;
        b=WsAacF5CFAWgRU32pUDt94rZ6Ux/apzz4vP4mf0Trbj0H6+OPo4cIvfhmPLwr/rFi1
         ZcQ/pKek1M2G5oMxAqwDaBYsG+Wf62UPoHb6A/bNRotODI8v3cXcBhkc+MiMj1b+sow2
         4NQdLRR78WkPnAG7tHvPdJoYp56Sw4UolmRdYQzhBBJOdxCfIClWs0MkGjxUHqOshH1v
         o1+XlDQofiPDhHXMKk/7gRiX201EF7ST7viJj4iUWzwI3UPaV7OB7j9j0RflmZexmAfg
         XGOhN83d7ghDwEP8v972owhkMn0LTn2aclM/rQQxHEqFKtnbln0N17oRDAKa5QnIxlI3
         p16Q==
X-Forwarded-Encrypted: i=1; AJvYcCVk07o1vc0+UZu2mgPW2teoKmoQhyqsqp758EAZXPBQWoTIc8C2t7bJ0q0xVGHohOPg++lkako=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo+101XPM4WShtP/yNjzKbqfITZ85IXu9qc1M62KesILjhYLOI
	sUYS4nPZ+dag7AmpHWTXwpJyomwnGYUQwVT6Ocke+94EU5iSvwOYKMI2HPj3JS9sSyh9TcjZF28
	sPT3hOoNnXQ==
X-Google-Smtp-Source: AGHT+IFbyC7MQFY9cq99fUMRJyL2CLYOxSU62ATMuruSt9AJVRvuWwWgZ0ZDePt6LkCD6G+9LD8GCQ9u2gPJyQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:1208:0:b0:702:4fb6:8724 with SMTP id
 41be03b00d2f7-7e6c1a24f4fmr180a12.1.1727203443587; Tue, 24 Sep 2024 11:44:03
 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-1-cmllamas@google.com>
Subject: [PATCH 0/4] binder: several fixes for frozen notification
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, Carlos Llamas <cmllamas@google.com>, stable@vger.kernel.org, 
	Yu-Ting Tseng <yutingtseng@google.com>, Todd Kjos <tkjos@google.com>, 
	Martijn Coenen <maco@google.com>, "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, 
	Viktor Martensson <vmartensson@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

These are all fixes for the frozen notification patch [1], which as of
today hasn't landed in mainline yet. As such, this patchset is rebased
on top of the char-misc-next branch.

[1] https://lore.kernel.org/all/20240709070047.4055369-2-yutingtseng@google=
.com/

Cc: stable@vger.kernel.org
Cc: Yu-Ting Tseng <yutingtseng@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Martijn Coenen <maco@google.com>
Cc: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Cc: Viktor Martensson <vmartensson@google.com>

Carlos Llamas (4):
  binder: fix node UAF in binder_add_freeze_work()
  binder: fix OOB in binder_add_freeze_work()
  binder: fix freeze UAF in binder_release_work()
  binder: fix BINDER_WORK_FROZEN_BINDER debug logs

 drivers/android/binder.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--=20
2.46.0.792.g87dc391469-goog


