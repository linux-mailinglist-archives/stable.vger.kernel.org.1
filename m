Return-Path: <stable+bounces-203404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715ACDDDFC
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 478AF300F314
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 15:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54CF23BD1A;
	Thu, 25 Dec 2025 15:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="y47mcnct"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822FA1EF09B
	for <stable@vger.kernel.org>; Thu, 25 Dec 2025 15:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766675337; cv=none; b=gi+Glw0pyW9Gv7LVDHRC/EEH4ZHScrhBgbQMri4yno6WEA4lk9KU9Fx0iMwShs2EsJRI4xZAfnIsWZV4+AcAMan3duu9InAYoPqMvnqMSJL8cLfeFVOfLN7VA1vHQyF/FmT14NJlDRvU0vpjvh/5tYoxvcgyVF7WJa43elxKyME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766675337; c=relaxed/simple;
	bh=1a8WVK/5R0u2R7uTPPcpwGnVq8+rcROVcLyIqeUBGAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=snmIdD+U869M1BY+OScrSBHSmyP0omRng68GAUqjRF4tAXXIgCxaj4RsbyMAbRqSD0gylnBi9wMxsSAWeeCzI0qj/+qL2vypeuGvr/lG+taq07BL1/+sQ/HvC1p0bU9nNTvib5iBeEExh0OglS0UtutwgFTXFMhQXpfihGfYPRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=y47mcnct; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-44fe903c1d6so1571029b6e.0
        for <stable@vger.kernel.org>; Thu, 25 Dec 2025 07:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766675334; x=1767280134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4enrxTcJXMNYO4nBPNY3Xlx1Fas4M0tOaGVZ1+UN1kM=;
        b=y47mcncthDnI769p6rGhLZVqjvRvc+lOVw1hkhnC42UnzCu7Bb9iCYZLMZxbpdFSO9
         jI/nlAsiPGZDvdY7g+cy+CJDn9g2mxe/ygo3QpYZwEsQAW7fUygMmJ5HFvqRINeEUThU
         mUtOXHqHe/erbTMOdVbuQL+X3NHcMoYzH7uWd32jFWiMhc5PGomsc9wOySFTsqn6jHSr
         M/UQbF6GDyiAPb0lEJ6iqYY/aGaTpGaqrM5BfRclKKgQBlO/ZAV+deKzQUbsoTAVMQbJ
         MqrgW8UBPenQTFJazvsjrEr/6d5ssotX6MOTbSVS9aDVIBS2Nr1/sknzo9/cHOO5QkWj
         9u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766675334; x=1767280134;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4enrxTcJXMNYO4nBPNY3Xlx1Fas4M0tOaGVZ1+UN1kM=;
        b=OgfCBNGr1ILDCTlvqXCL8zk9hF+5Vidol2K1Zg3ZhthIMQ65IL48qUwGqyGrtJ/svb
         xmLxHtVT+ggOll+SQpjwQXbTwc7WeKyismR6M7JM+kfR7vobpiDzdb8DsWQmg1rID3/K
         Wm9p+CtCYVMliKDMM4tj6KL05jkYfjtd4esA8qnrJ/4IRLQJxwpnFpX6sEnwOfBT7J2Y
         ygvyuHCG+qwypO07UlVqPbEHaA3nbTry53HkSK1LofES7mYYDerxk+apSSXPoE8bjf0a
         jfbmZPjmQX0nJsYBiU9efebYj592k+aBThC1dsEkwqgO31fjuxHYh0mjPEUEXyvN1MxH
         N9NA==
X-Forwarded-Encrypted: i=1; AJvYcCURFyMONbV6YKfXQFbzLhaWgkt3oeYVO3gZBuGAsHxv3l1mvuT8FnnorL6B7C5WfpNSX5EwuBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbj4w3BrMRxtTV6PDeD7abdwbDuwUpMrwFkuRssGRqGtOFNQrD
	Ms/HcV0sHG5Kh4xUXrWQ1B+m+Hdjmvan+68QmzJca7d6aNngpqaVC3JeGvMHbfkUHdLGlgLdkbJ
	b9BA/
X-Gm-Gg: AY/fxX7PxKerf95oVZP6DuLuja+e9ORGzcrJ6Xx+2b3Gh/QItvNNjpAH2/JK8uSV6k5
	DDxEu/PnKvVSoPc9enKmem3BUCEUAO9XXTEiFIFt28xHDpMhUNQjhLMDPJLQBK7cWdqND+JigEe
	AiPj0Rp4Or/lCBmAS/C6ryDN5W5FHLpbJuOUPvJ1l5ZX/oDx+vVjuxeDk+CAaqp6VGQ1XMn6kUW
	SxB/31FiUEWROSo6p8XXCxrcg5aX9TSC4l+ouXGqpi0h9V3RUnRM/rP+7f4tWuQjDteiywvAh2p
	6AoAWvdxEy/+cY1dLGVbxxI2U342jF1CjDkKN+3jc2ORVLleP471PJ8AH2FmGlY4yw3TZbcR59C
	+36o7BCuGVZ4ORsd6dFplX0x6MMOhC1LkiCVqX5CkLA9pYfdBjJJ1lFHI77yisiu4DjMfmnPTGW
	RBwYY=
X-Google-Smtp-Source: AGHT+IHvysv98JjOtrG/XeetHHlKyurM7jKSGEnAoF86eGaByvTJgHoycWQr3WJoF84WobCqIy6E9Q==
X-Received: by 2002:a05:6808:1b1e:b0:450:c9c3:a249 with SMTP id 5614622812f47-457b21cfc2amr10228559b6e.45.1766675333911;
        Thu, 25 Dec 2025 07:08:53 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3edb41fsm9481403b6e.18.2025.12.25.07.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 07:08:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Prithvi Tambewagh <activprithvi@gmail.com>
Cc: io-uring@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
 syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20251225072829.44646-1-activprithvi@gmail.com>
References: <20251225072829.44646-1-activprithvi@gmail.com>
Subject: Re: [PATCH v2] io_uring: fix filename leak in __io_openat_prep()
Message-Id: <176667533028.68806.11770987520631890583.b4-ty@kernel.dk>
Date: Thu, 25 Dec 2025 08:08:50 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Dec 2025 12:58:29 +0530, Prithvi Tambewagh wrote:
>  __io_openat_prep() allocates a struct filename using getname(). However,
> for the condition of the file being installed in the fixed file table as
> well as having O_CLOEXEC flag set, the function returns early. At that
> point, the request doesn't have REQ_F_NEED_CLEANUP flag set. Due to this,
> the memory for the newly allocated struct filename is not cleaned up,
> causing a memory leak.
> 
> [...]

Applied, thanks!

[1/1] io_uring: fix filename leak in __io_openat_prep()
      commit: b14fad555302a2104948feaff70503b64c80ac01

Best regards,
-- 
Jens Axboe




