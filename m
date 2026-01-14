Return-Path: <stable+bounces-208374-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E79D20817
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 18:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83C0930054B8
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 17:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A842FDC22;
	Wed, 14 Jan 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="epo8Jnh0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA282FB97D
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 17:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411132; cv=none; b=sgIZhpoHkl5ubwcWg6UvooznNP46uaCqJl5LO+bsF6axG3GljQchUfi/eMUOMQP2sTyTxkqfq0AHjJZHx441dkVxQB2vEMoY3JaKjV3G8YYXCUyV7anSSs9dne7WA2vJfgrQNxELTpY/yb/Nnc0hc/NH5Weuu07HdRMjJYPou6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411132; c=relaxed/simple;
	bh=mxl3Ipzdw/b/hz8fYLTH1gbjiA9vocdLe9R89SiqV5E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HjicHy4itkcLaOrjC4X2BB1J8dFVpMBcG2Vcc0SkjcoLCfi97LwfS7uDk2/s+4ZHLitld7/JDiObDmL1hLHnwPQXe1oOGpqXFeEXYttPuMZb6Q6pg1SROPwog0bQXW8SmWrgZ42aasORUusTU2aqi9sawz2Kcpz4GJQVErXbYzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=epo8Jnh0; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7cfd0f349c4so17306a34.1
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768411125; x=1769015925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YAWlEckmPq2PSM6zAc9AYSjzTMqKbebhNRk5WWnTRg=;
        b=epo8Jnh0ilZG8K8Ere+loMNWPnOyDLVFEojBWC8uKkeyEa2l7tZpVKRXR4KinOmwTb
         5wiemTZFFIVu8gPw1HS2YFmro9ClJKGEh98Ol7o6mqIxT6XdbMnaGh1XlJR4mXnRlEFu
         lJ0Zqq6iD9NL3jAwjCymQTx2qr+sjxTi0NkJbKoELSd217zOFTiEwKP5it5lCapOEJyb
         D3kRIUDoNerp2ahB3RklbITdW3eSWQkJf43vC+TO0PXJQAvYTbwAC3TxXDalQ/NbcQV+
         4MrtQgprDuDkpmxz3q5lLSAoZFQtfrdp1pW10NtD2R6O/TU61u1bw/reF1Wxdq8wqY+q
         eAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411125; x=1769015925;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/YAWlEckmPq2PSM6zAc9AYSjzTMqKbebhNRk5WWnTRg=;
        b=Oa/6paLRykf0vdWb4EIAtpjEV1WCshG3fS7dL8evmCB4ElhB1KIlC1XwJ1uyVdxGrj
         m7WViwnzK40KSnZeP6cxt2Mp2PxMqYrXY2gzEUlMwpej8lnr7cnwKjcqVyq6oQN1CYkM
         w29wqlCZVlgkx00uQwdPBGFEDU3MWcPoUS+N7J4IuXX7FummsEg2NALB6Zc6LEHPoe2h
         HFoUkfF/JF73g+bwVMcWtPpcnrwPOjGBn5lh2TCxpNsB43aVgRJ0x6L9/7n3DDDFoLjW
         wLuLm9xHbMPPNLRj0MhT/DAOnYinpFbsYxELvrZQz5KJKZWd23MiyUOGCdqEXwyswkLj
         tp1g==
X-Forwarded-Encrypted: i=1; AJvYcCW6PnQJuCBk36NfYkMFDcKzrX5ZQz9/N1/8xsbfHmB2XOCQ5KZ5t6eF64EQVViHQ0bnb3/WqzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5UJfSVsf8y1qwWHKztGoiJtImsX3tEmK/xRmmmiKkLYxcX5T
	XxjjLBSCeMBXs4wniMdtk7VYn0+DWp9D9190K3KuFto8QTH43wzdGgTLfsHqhx+RQWRbQWnhDj2
	66tcB
X-Gm-Gg: AY/fxX4pEPpnxMilzdAjz6zIHF2E57X211Lihs2c/Rr9/1p2uUO5uD/xTusPVSe25Q5
	4FFRAVVQ4yS5e7rlnDHpOm0hDNfqWU1lZaX8Ef4c72oY6fvC/fI5icGRzWoKNMOHFrh90iSIUlK
	Se1YrN2Qu+eTeVFiPXQgNO721uxVNWQaB17rNm2WoW2jVgCLjlgQ6mJb9wMiYaU/X0I/s45lrVZ
	uQxwmA9eA1akwM7E0IlwfTvRxBHGwPrsb7Sjz/oV99yOi5sGuzQGcx1ckELn+d/hJT0AW7/wbQF
	kNwrNWBrjvigzbuwU4CFkSPMtBFfcvgcHcOR/0sYe7pYF921l/cJaXr9WX9H8h7TxceFKQcT9b4
	5eUOH0uStsY1NdWrKTdCyZNX6juYH3F/JHnsk6cfwTJGwq311EGh1NWZXFq8zedGbVpyf8iRb7f
	YRgg==
X-Received: by 2002:a05:6830:2691:b0:7cf:d19f:7fc5 with SMTP id 46e09a7af769-7cfd19f807cmr777569a34.37.1768411125217;
        Wed, 14 Jan 2026 09:18:45 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478ee668sm19425130a34.29.2026.01.14.09.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 09:18:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>, 
 stable@vger.kernel.org
In-Reply-To: <20260114085405.346872-1-ming.lei@redhat.com>
References: <20260114085405.346872-1-ming.lei@redhat.com>
Subject: Re: [PATCH] io_uring: move local task_work in exit cancel loop
Message-Id: <176841112450.443561.17209876764056331154.b4-ty@kernel.dk>
Date: Wed, 14 Jan 2026 10:18:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 14 Jan 2026 16:54:05 +0800, Ming Lei wrote:
> With IORING_SETUP_DEFER_TASKRUN, task work is queued to ctx->work_llist
> (local work) rather than the fallback list. During io_ring_exit_work(),
> io_move_task_work_from_local() was called once before the cancel loop,
> moving work from work_llist to fallback_llist.
> 
> However, task work can be added to work_llist during the cancel loop
> itself. There are two cases:
> 
> [...]

Applied, thanks!

[1/1] io_uring: move local task_work in exit cancel loop
      commit: da579f05ef0faada3559e7faddf761c75cdf85e1

Best regards,
-- 
Jens Axboe




