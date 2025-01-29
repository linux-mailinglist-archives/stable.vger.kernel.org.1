Return-Path: <stable+bounces-111195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A84DA221F1
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 17:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1A7C160A94
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E11DE4ED;
	Wed, 29 Jan 2025 16:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3N/bdDg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3ED143722
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 16:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738169012; cv=none; b=ClfGEW+FGrOUsLVW2WO+tta4aM1VMFtPYVGLzxRzTfYvhzfuT+mi1yo2gWN3k3Ed40AyOkYVB8jLx7lzjJAZgZhAebUGVNPyCf2cQnsweu3GF9DOXFXHvaBODW6Va6gTb82al7deP50aTB6c4EhNhKLau5hX61jOzO3TaTmV+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738169012; c=relaxed/simple;
	bh=DXfiYCnZEbt67wJ/3cQw2BUg7CuK2Bic1hn0Jv53lJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JhJhY4HTvjm3kMKMy4GuT1Ha8lUOxM2WFn+AsijezMggDoUao8YaE6OIaNuWLE7/sdRZ8l6x9nI+WEgko848R+pta9ngncVF00Js6mLwkkhWAUsRrmcwsM2vSwFDZ56u1kQBk3YT06pjmZpcy4d9ArC11NVhTXY7Xvfd1fru/BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3N/bdDg; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d3c284eba0so9150142a12.1
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 08:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738169009; x=1738773809; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zo/+FHW/bbCK2ziOInsWkp1Gete8cVfoZW7cGmsUMEU=;
        b=t3N/bdDgWVTUqwgexdGS68gbng5r0P7Kf9S4ROCOJlj/KL5PCZLya+imLE7kBPEsGd
         1BwzuojNHkxcfjCeaQjUTKX2EBNvoBzce+WiftchGgM/mJzERSXGc5JKmNznSPFbxNTr
         RX10V4k3cAoUD1YxTP51MPN51BTH9eE1zIWWjVtDmDQ8uUXGlpl6yi9MiQ/1cCU6bju+
         cV9LivH5OA10ZyBEBtMyGAqVnOwpuvzWhK468muIVzJSMJNyo5V7iAX53XDBI3BNURTy
         emerdkopGOUvJ1HjpaIl+q3a7ntOTwq0kGQ7WfgIWSm4JDxy1lsGNJqWpoVn9pRiTPM7
         zgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738169009; x=1738773809;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo/+FHW/bbCK2ziOInsWkp1Gete8cVfoZW7cGmsUMEU=;
        b=pJWPzkA3V981Qr2v26rO4l9l0/F/GefgyskyBthnNgaVbuC8HaB6gOQVhmVda+n4+0
         s0Bt7Zr9TzeMlS2C0lk5favSo6g98PT/N5M+Py/g0SvLzHNThnPjI2X462ncPhIdVaHs
         WALCPuvRn7BYbhOQfzXIU70HhOYB7wJu1vClthdVAhoWxyD32O4O2uM1J6tNBCeNnOH6
         jg0tNFH77hkK1TSsWdjqU4zGlfg0lI8uXGOWEqxOSCelDVEOCFI7aX98Pc3SqeknmiiZ
         U+2BEbWeWrjcfPB8uQH6GqhXwfF7ajCe1Z1jbNeFgUnTN3ED1kuWnnfHQr5eoA8DO3HF
         27Fw==
X-Gm-Message-State: AOJu0YxgVO36f8zX16F1NNnctM/7UQM3j3wqVG6ZYeWLP/W/zAWcXAIS
	5LNqEY1lMR6vr9d8dbPOprnWl7x1vQU4ocqBIfrElUklJs0tQCSSnGJACSTGy/cvMBbFReWLik2
	qLbgcWxp7Nw67TNCItXKbM801fiBviW+uMWxZLnp/8MKcGDZpV0LlmgFrNXUoBoP4CYH69Ci3qS
	1L+FFrbR2siTuiGjZPMHpoJPc5g5qzrM7uWXRTnQ4bYPKl223T
X-Google-Smtp-Source: AGHT+IGJVSiiA3kt+a1SMH4HfX4QTNIN3ASe2v4rWT8DUkkJ4sdQqlb6OCwcYkHT0pJ33KGmNG5IRkzzEQPYVSs=
X-Received: from edbfg11.prod.google.com ([2002:a05:6402:548b:b0:5d9:a53:f322])
 (user=ciprietti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2348:b0:5d0:214b:96b0 with SMTP id 4fb4d7f45d1cf-5dc5efa878fmr3355618a12.1.1738169009454;
 Wed, 29 Jan 2025 08:43:29 -0800 (PST)
Date: Wed, 29 Jan 2025 16:43:25 +0000
In-Reply-To: <20250129163637.3420954-2-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250129163637.3420954-2-ciprietti@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250129164325.3424666-1-ciprietti@google.com>
Subject: Re: [PATCH 1/1] blk-cgroup: Fix UAF in blkcg_unpin_online()
From: Andrea Ciprietti <ciprietti@google.com>
To: stable@vger.kernel.org
Cc: ciprietti@google.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, this is a version of commit 86e6ca55b83c ("blk-cgroup: Fix UAF in
blkcg_unpin_online()") adapted for porting to the 5.10 LTS tree.

The patch fixes CVE-2024-56672.

Changes with respect to the original commit:
  - blkcg_unpin_online() is implemented in linux/blk-cgroup.h.

Thanks,
Andrea

