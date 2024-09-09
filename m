Return-Path: <stable+bounces-74057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 029E3971F5B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93AD8B21245
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11AD165F17;
	Mon,  9 Sep 2024 16:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9v+Jvmq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539541487E2
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899774; cv=none; b=RrqS5QErZVR0ImE5EM2pAuaZfmvWBbqRW5GBoqJcZ0ub0zLFHjEf9Avghefi/If2dZFI29YUpfqxZXyOedFuo6BM1iZIGc7FfKODkIMqmNs9jxfv8ajXBh3v9NlE0HAl1DNq2CRJyH10xCCycohAEU12dK3CcIGwqsLqIMmxAmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899774; c=relaxed/simple;
	bh=33cazwN30Yiov+9LORxIDEGL/1eJRw4eNqKauKt9neQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d9Ieqg9CLKOXsVdIipoXrC2chXZ9ncxw5zn2prjpiobQBSZbsqPor3b/hOY0ccGkcM0gfH1Bxu7pkEyT+PY2XZiQw82gMmRqQw4jONnZaJjYJn1N1a0tZ1+A7e3ZSCTDF5UrfN0foXUlWYobvtWtD1DzTqJoY5WZ+m8qd6J2Q88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9v+Jvmq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2d8859d6e9dso4772206a91.1
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 09:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725899772; x=1726504572; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPorGTNYErNbol15iOxscjB/66VKQ2zh/DvzC2fMNYI=;
        b=v9v+JvmqocE9ZvvquqFxbP/yxfr3SVd6MV8l6+k/LZ479XNKIqMSQu/O65MKdL2z7i
         6Sivmq06tEQz3bzyNNdphn+HwyV55HRbniHhJ5rw0Z67eK1+MrUPEElpvbnuWYA+fz9f
         raipLQ6hAogq4s0CbM7mIRAiCEtmyCyWCsngBHyG2DhNg+/DqDX4RfLCDGrGbsbSVQNy
         OwIwKNgq2+tpV3B/fYLZdPOd5xW4O/Pf0JeHI4n1gNm5gbrNiV4OVgR+MAKzUvmLEDBm
         7hZzVrI5GmjL7/foYhbTLLycXlr27TDOK9onVQzLHed7EpG68eSpTVScFrArmhF+dbrq
         bmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725899772; x=1726504572;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPorGTNYErNbol15iOxscjB/66VKQ2zh/DvzC2fMNYI=;
        b=ixE2Qm4zZG8342dkKz2EFR1Pp6KX7Bg0yrXEl/a9UPsnOZskLo2WBzwT3/fZ3nDSEY
         m4nDoHQpOJfqSHTgxY0kCkQoreh2K21BBeLRqI5DAD/K++bBE1s4Tz+9AT09ScDnlkxO
         yXoOe0+9jCaOywvlzwscKV24Aen+m2LNhN49pPkWnIej+6lUrgQ7xozSJ1kSboUb7a+p
         WBx+LaHm0uVbRlen8MbeVxLHcNIQskIXo8N8Bg/D1iYfvxYjtLBDjV28reivL4iCwyGA
         nPdrEYvCI3jFfNdUXH2qMWPVxf8Xl21rEiACI0yzp7oxM2IerR9WQwziJA3DJ5CntVcx
         lqKw==
X-Forwarded-Encrypted: i=1; AJvYcCXnV9Q3I2apfXZ7/WbO1StHBiyffXc86YGcMiGkrFbfD786WsAtSJtRZV9SfE0Xc8s1fk86NrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSClqQw/dR9S8edNAlUh8EZHX89lxnaOps84G2fAMbDz3Orjd
	4DT1WB+GZeprpXvW9i2oPhPtzQHrWHOiGP1NJNhLgmOEOwnt9QcOCfrnizsZKzeV4w==
X-Google-Smtp-Source: AGHT+IFmuNtX925WryPi1G6qyYRiFaxKnHHSmfHgSM3gFnnRykz3bujjigujUbo43Go3eHSC7MJAD6o=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a17:90b:1481:b0:2d8:bd72:c5e5 with SMTP id
 98e67ed59e1d1-2dad4b82644mr27240a91.0.1725899772201; Mon, 09 Sep 2024
 09:36:12 -0700 (PDT)
Date: Mon,  9 Sep 2024 16:36:10 +0000
In-Reply-To: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8f2e20f2fc894398da371517c6c8111aba072fb1.camel@kernel.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240909163610.2148932-1-ovt@google.com>
Subject: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
From: Oleksandr Tymoshenko <ovt@google.com>
To: trondmy@kernel.org
Cc: anna@kernel.org, jbongio@google.com, linux-nfs@vger.kernel.org, 
	ovt@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> nfs41_init_clientid does not signal a failure condition from
>> nfs4_proc_exchange_id and nfs4_proc_create_session to a client which
>> may
>> lead to mount syscall indefinitely blocked in the following stack

> NACK. This will break all sorts of recovery scenarios, because it
> doesn't distinguish between an initial 'mount' and a server reboot
> recovery situation.
> Even in the case where we are in the initial mount, it also doesn't
> distinguish between transient errors such as NFS4ERR_DELAY or reboot
> errors such as NFS4ERR_STALE_CLIENTID, etc.

> Exactly what is the scenario that is causing your hang? Let's try to
> address that with a more targeted fix.

The scenario is as follows: there are several NFS servers and several
production machines with multiple NFS mounts. This is a containerized
multi-tennant workflow so every tennant gets its own NFS mount to access their
data. At some point nfs41_init_clientid fails in the initial mount.nfs call
and all subsequent mount.nfs calls just hang in nfs_wait_client_init_complete
until the original one, where nfs4_proc_exchange_id has failed, is killed.

The cause of the nfs41_init_clientid failure in the production case is a timeout.
The following error message is observed in logs:
  NFS: state manager: lease expired failed on NFSv4 server <ip> with error 110


