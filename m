Return-Path: <stable+bounces-78171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B7D988F2F
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 14:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73431C20923
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731ADC139;
	Sat, 28 Sep 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir0uqB1N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F0B13C90A
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727526570; cv=none; b=DiMhqWnaacQ0rd2KYRP99OR/Nak3UNwYdZl4jAq+91d6g06wX7Obppmn25ubiDaD540QvwhXlPWZ8OpEBQC3v43TZp/2sIUAAkaqyXQG10fvQa70VZiTYz2b1HSc13++pnZI0JkMcbBxU7QudXpoX92CRQ06OZuoeBLKYKVXcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727526570; c=relaxed/simple;
	bh=PIPOQV5MlwU2RVHtw0BN/7aQnZ/vufiz0PMYcF8RlJk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OL7b1bGgqPtk+tHvRh7mMJVzBiSp+JoJQZ52ZCIwwqy5dQra/FtH3DcGy9PEaOaypXJpGjsiUfZn1G7uauIwm61swVNLcQZNxu4hXSBqXe1DT9TtpN17AX+LbpzY49HJ3vZG52waVKYeHUBzYgjUbcQ2GtGbgBDr+mPmEOeP4lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir0uqB1N; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b067fcd87so3330415ad.1
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727526568; x=1728131368; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aJ8WWUuKvf9GTwro0OMwJuCEfHPckI7kPW/dWv3QOLk=;
        b=Ir0uqB1NcgWHenSEBVy/F6afDhecil1I5avk6XctNqEyzlBlILyag1k2tgPHeUB2ai
         ru+QDWZ1E6mafV27fsQHxPaY84bTyahfa/1OanLl7SbBBjwdIzNZn/3ZfFmfCr7fxaOX
         qlbicI+pcuj8D1CgcxW7yAMNfbfXtNvGYFZ55yMPjNYCECfE9YLcmGBvXgAncHzWRW+R
         0izypszZyiLAG+30ftWMaDza/ZwerR+Y1Rbum115jyT35zdfreozbXnPEUui0QB4TeZ/
         TEX/Sd6oaoQaxrPnarFcgsU0QdvbiT/EF0uFGhSecNvqPLst0+MNMtWCsILImn4KyYNN
         a3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727526568; x=1728131368;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aJ8WWUuKvf9GTwro0OMwJuCEfHPckI7kPW/dWv3QOLk=;
        b=LoSErdxx4P/NI2Ye+pqBPDUPLZABcIQ+obHoOQ23f54mIyYiYp7QcY5O1e6nF7LTYV
         F/yS/bEUtWX1PlfAuWgDKVn/EAXmHsgE5wkFQ3wFhLuFgL/aXyhyHaXpu6PZH9g+0p/P
         CB7yZ12XfV/nxHxq50cIjfopM7kShRjBj7SO3FQ9na08NHf2s4frTREk/mLpUM6LPssc
         toGDBYdg5demk/0ChZUYLUCQmOOzHhav6BdFYRLv3X9idGp+s4qfRyrfhyKT5XE5h7qO
         FslpWOIZ1Lxo/C4YQQKpLXksGEXCv+oG/y7PvyLfgxdQz83lZNrDrM2MZz1UT7tfNV4u
         q+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkHAWBGQEpKuDHA3gS24XEvxAfDQrxIFM0Desljbxbs2l1Kk3vPllfM4LS+7oMT5mtolOgjKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3CIZHE0L7MfmnwVFQd142xcRZhvCnmBYGoGw+p8ZkbK3S0Z6
	XoJqD4aFkf3KfC/lzTi9AMG0SQUnDVTso9dvEfa2n8wWgTETePYa8njuVTBHNL4EX8p3OYGbfP9
	S0QUtKRgjRn5C0zkr4vIpSj/cI/8275iWQXU=
X-Google-Smtp-Source: AGHT+IGrsUANfVoELlzbzZj9rBQitM411Hn/UBFZLk+pIRQJmK6O2cia7wFzai2ecugfJm8Cq7orrx/FJvs+zVCFuQI=
X-Received: by 2002:a17:90a:db56:b0:2da:74ed:b35 with SMTP id
 98e67ed59e1d1-2e0b89a68e2mr3049595a91.1.1727526568175; Sat, 28 Sep 2024
 05:29:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Sep 2024 14:29:16 +0200
Message-ID: <CANiq72mHQ0eKJoZeRxB5h1eHza8nERA_DtWUMKecyQuivH7SXw@mail.gmail.com>
Subject: stable-rc/linux-6.10.y: error: no member named 'st' in 'struct kvm_vcpu_arch'
To: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>
Cc: Greg KH <gregkh@linuxfoundation.org>, loongarch@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sasha, LoongArch,

In a stable-rc/linux-6.10.y build-test today, I got:

    arch/loongarch/kvm/vcpu.c:575:15: error: no member named 'st' in
'struct kvm_vcpu_arch'
      575 |                         vcpu->arch.st.guest_addr = 0;

which I guess is triggered by missing prerequisites for commit
56f7eeae40de ("LoongArch: KVM: Invalidate guest steal time address on
vCPU reset").

HTH!

Cheers,
Miguel

