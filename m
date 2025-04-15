Return-Path: <stable+bounces-132747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBAAA8A007
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D523BE252
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00119F47E;
	Tue, 15 Apr 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lqqz+gYm"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FA1A01B9
	for <stable@vger.kernel.org>; Tue, 15 Apr 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724906; cv=none; b=mXqbWOkxf/q2MZZ5t52yti7+37452bFFa+3SrJ0N/V48snZMTEjCn6Yqx0fNT/k83BAkWH+G3iWWOD/ZP/IrQ8CwE7m7L9zlDwT/52YlwYLdZzqfrGeb8IZhKuWoxE+nDSbeq/U4MqNSawUKSQ7+Ybxt0tn4gLp6++4X2BEEkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724906; c=relaxed/simple;
	bh=Q+sDbI3861ztbo49i0sAnnGzYlZkCzWiWh9KZGjrKpw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eLi6u5jwbcappz1sDSiHSPA3psJtFBD9oVSK5bZJRznw++oIenfq9ubWhCQdDaG8maizUZtbgB0lrkyM8cvPqJTVBgsFnLeOOzuc8RuCnK2VWR9bwh/GT+eyg/QpmsUQ1W/EJPi5nXho8QAAvDLEOSuqE9euL5RK0gVOtWa9CmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lqqz+gYm; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86117e5adb3so181681139f.2
        for <stable@vger.kernel.org>; Tue, 15 Apr 2025 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744724903; x=1745329703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEbQBiFiZFwJTl0Yl+XvYCk4r5u+r4E4QzEsUOtsGLs=;
        b=lqqz+gYmBLQjpE3UMAPt42C2s6qkkCbzRooU3NR5QnNjByUUFk4PNQP68W/4P5mXGm
         qIlKy5na+Sgf0gCaVRNbBgbZ++ChI0yxnXj2FZpqAPTBjGqqz/cjtzw4capEn9lipjE9
         pMm7EV49LnYdJI/EVZdZ4tJpRoTXA8yKi04mJ09GpZE31zkg0zrwCwo8tZ7pPrqe0q6E
         3x/a3IA1tCfr75XVIEgpQsBSWR6Lqs8nymGtlv31xEf88QAV1di/ABWnbk/IgA3PGhMa
         nHE9NM3A4EnsxSMohllc7qTovOkhphaDzhayLco6fL90c9RO/Dwkj8j/zDgVXXdQthQf
         RfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724903; x=1745329703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEbQBiFiZFwJTl0Yl+XvYCk4r5u+r4E4QzEsUOtsGLs=;
        b=egcPfduRNy1tRBds7f9LKiFW1S61WJryMX2p6csoRuc9jG1Bro6h9SH7JnfWZNDWyk
         xm/xx8tNc9jJB+D2riIr2yxoqz95yAcq0NmxDFiN8bsNSImVgFDJHCle2ePh6lnuLAUL
         FPibTs6B0aek9PBaxh0nhUc45G6uuorEtQlY8PshONTFjF+uX0s+xir9u3dWLqPw4UAv
         UoUXkPtj7Y4BNF+nf5s5oaW/eZqx6xx9781tBKcXDpDO0vYmlX31GcFYHASdusF5JKUJ
         DDH1jadbgCxkFwjudTu8EJvjbcWmhdlmHv1RkyGcnwD8NqGVYNwccHBYxNo97iqoyiJ9
         CeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCViiEOivXJORWyhM3vMdOsy+pJokwl8r/B/Sm3dXEj/JluMOR4z5e5lSo3N72q3+FGyzLSrfQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywsCx6TGKjwvnzH/y6Ry4T9qZpjCAQFyHPFxbnDbPQ5mVNM7OC
	8XPdr4Jj5xX+8Xbpxmn3R/3nL59XPMHzJy0vxF3DgOm4BqtL6B7S/4z/dP+Tb6E74uoV2a2bmVS
	c
X-Gm-Gg: ASbGncvFw9hz6fhDfw4TQOcPi8fDYxERPqlkGhwFdoMm0YX+FG3/hCwMO5lx4bcyNeu
	X1AhHnQKFcA3AVQurQ3y5FNQBmK8SrT7CfAchRqtA/BRxTJvMXZ8o5TsafmHmi6HvcRyhXN1Zl3
	pQvmOv8F8i6vcBt70e5sNcj2+reUYlA1Vw66PgB1DVGQN/gt+GnNIzWqOa4oLXxxXnKYZ7LjeXf
	cySefm1/5Ss0nCyyS1J2LHjSF2NwJaV5TFpFldfAZ70SNEYULesPPHkiGRzAA4hilcYpPQcr4/j
	FtyMdwq+WcTnBTp/3NZ0CK1MEx02ZUj6Mt7DC+3Wa7E=
X-Google-Smtp-Source: AGHT+IEus8WSuQJc6+4zLbZc/MnR/075iVtowh7y7vuln/ACpKCLskT8RvCvla7P/9LF76osem/z8w==
X-Received: by 2002:a05:6602:3890:b0:85b:6118:db67 with SMTP id ca18e2360f4ac-8617cb59f52mr1693574139f.2.1744724903703;
        Tue, 15 Apr 2025 06:48:23 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d3c323sm3123456173.74.2025.04.15.06.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:48:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Martijn Coenen <maco@android.com>, Alyssa Ross <hi@alyssa.is>, 
 Christoph Hellwig <hch@lst.de>, Greg KH <greg@kroah.com>, 
 Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
References: <20250415-loop-uevent-changed-v2-1-0c4e6a923b2a@linutronix.de>
Subject: Re: [PATCH v2] loop: properly send KOBJ_CHANGED uevent for disk
 device
Message-Id: <174472490268.143017.12721024881216566078.b4-ty@kernel.dk>
Date: Tue, 15 Apr 2025 07:48:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Tue, 15 Apr 2025 10:51:47 +0200, Thomas Weißschuh wrote:
> The original commit message and the wording "uncork" in the code comment
> indicate that it is expected that the suppressed event instances are
> automatically sent after unsuppressing.
> This is not the case, instead they are discarded.
> In effect this means that no "changed" events are emitted on the device
> itself by default.
> While each discovered partition does trigger a changed event on the
> device, devices without partitions don't have any event emitted.
> 
> [...]

Applied, thanks!

[1/1] loop: properly send KOBJ_CHANGED uevent for disk device
      commit: 7ed2a771b5fb3edee9c4608181235c30b40bb042

Best regards,
-- 
Jens Axboe




