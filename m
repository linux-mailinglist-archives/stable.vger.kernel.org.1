Return-Path: <stable+bounces-195007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6214C65BA5
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id C706E29070
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92663314B9A;
	Mon, 17 Nov 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l9omBSjr"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5A314A83
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404259; cv=none; b=V25z0S8MdJOCH4LBOrNxcT7caGQKozONsRPIWuhEf8M3yRjbryTjyT7kZ7yngMRl5k1yugXJwp1qXvstdju4Zj2Nw34DTT6e0sM7H4FuE3mLFh9/Byq3O00AGEaFegbJxzWdTbC+6gFEMXae+yu7kFXskFuXxbkGkC8T0IH1mcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404259; c=relaxed/simple;
	bh=20lwm6JOtChvlMh74FxsClts7z/ThQcFc5kTgOvXEPc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XrccPXU+N1AjYk/ggzk5W5K4OBFluzmNFRbUplnOzU7KfxoG55gGBh3XbEBBJ10M5n0D/CTRxqXA47Q40Te6tB0SsSyhI3zoHnWmIDb1G4kxRjW02la7IEfvZDQ4FI0pN4HGGhZWW5DFCRlI86cpG5IHiJ6Il6ULZwhkY7XGVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l9omBSjr; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-949042bca69so59342239f.1
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 10:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763404256; x=1764009056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqKQSsT6c3z9Bj8qCv27kYuWk8B17EEFfT4KJ4q6GHk=;
        b=l9omBSjrVV8D9Wdl6IeI069D6mYxCbmqw7FcTTISJylWsT4UVwVmM1/mtsBjWpAU/Y
         8iLmF7un3LIN981wPHu1BlQdUNjGcLnbLZVlAKsoT6l/PpDbsMzzt0QR31zB1sl7OLEr
         qwrvQqLySRiMOkglTg6ai1sTzJKhyvP0Ui9qgplOE254fYTQLz7HupP7Y6+eVMz/QsXf
         8kS59B/yQZ8K+Uaq77M8L7jfOlvnvpuG++UU6UWymek9hVWAKtjnURF1mgdRtCdFWUfF
         kkOFg/V9t6rx6xA1PUzgvXW22+O7WgoV7804wZoWpMqAjAZV3Xetf8PTCzt/j79dgiON
         /S+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404256; x=1764009056;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqKQSsT6c3z9Bj8qCv27kYuWk8B17EEFfT4KJ4q6GHk=;
        b=I2/5fSS5QyP6b9FGQuxkCQ/TF2BGHHCO8KM224wO4uIVBfcOnlt20/GhcR8STadjpB
         AFIi8iefcFUjVTVpBjQUo1mczj19Cbps3UNW79BK6i+SrJn4sVxzV2E/udKTJvzSWEcm
         TEVnvpMRMnX37s+6gsda04/Fe/VA1d13Yf+bl7NZrBpVycubDIGpYpm8xrfZBMb9yotQ
         bYcwNQQzA5ng+xfD4mxgSgkss/c+VLVMzgNyeUBQo6K0Opi5/5yv1COrmYrAODTIRHRq
         9OwXz4+X+vhyrbJhNi7V6qJbdPTCI9gCjV93TxsRjTiP+sYpKYLc2lSURQNj4p70MUjw
         d4bA==
X-Gm-Message-State: AOJu0YyhdwgOUTSoJ1hiZIciTRsihDEBCud8mJY+YdmDPDeO1xpVCtl7
	I3rENykUhqXfehWPZwAFFDvsdYzhlk2lfl3qJOCqgAN9nSvvoA6jDDxUdNXt2bM8Z2E=
X-Gm-Gg: ASbGncuTYKJX/Zlx08UTgcFdyGkITjfSQGg4L359L0sPs/cz5PxUXOsCypTVJVJna8C
	PKYGvycDhYbvb0GtgPNKpMW57aC4tEGo+lJ+BNngHwCN+qLdIOy/mZT2wtNK6/stc8/LhfD4K3n
	ZaDQZ8+1juFEDOfNeCzzfIe1PtvbNpBMITcUY4x5lsnOHp2nkRe9WJTSYZEG6UpBfiQ7nUjO4Vf
	qhfmvAhP2zZ5KyNsFVArjGRmEeQzxBaZRJI5ULwiiCLyx/9+2OukI+ulliU1CbrJtLBanjSyJkZ
	FkySm6fJbZ96Bf6qLA6Ow1DlCp1y5UppKVKSlskxbADzEoZn5TYCBs3hzAAFFCfi8ehXeuXkbu7
	N3TedE9dm8JTYprGB+aaYnH/jijSIJRlYBELP3DUGx0L9vTltY02/sc1yaHrdD1Wk54E=
X-Google-Smtp-Source: AGHT+IGvuhMY4d03HogBUJSIJbGY9sYO14AFhTEAj3WefpBduHEhD1PThR4VVSVrWu3aCSbDyhdMgA==
X-Received: by 2002:a05:6638:35a7:b0:573:5038:cee6 with SMTP id 8926c6da1cb9f-5b7c9d8b98amr9092982173.12.1763404255881;
        Mon, 17 Nov 2025 10:30:55 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd34cd7fsm5045090173.54.2025.11.17.10.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 10:30:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Chen <me@linux.beauty>
Cc: stable@vger.kernel.org
In-Reply-To: <20251117053407.70618-1-me@linux.beauty>
References: <20251117053407.70618-1-me@linux.beauty>
Subject: Re: [PATCH] block: rate-limit capacity change info log
Message-Id: <176340425521.222021.13576588245917125051.b4-ty@kernel.dk>
Date: Mon, 17 Nov 2025 11:30:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 17 Nov 2025 13:34:07 +0800, Li Chen wrote:
> loop devices under heavy stress-ng loop streessor can trigger many
> capacity change events in a short time. Each event prints an info
> message from set_capacity_and_notify(), flooding the console and
> contributing to soft lockups on slow consoles.
> 
> Switch the printk in set_capacity_and_notify() to
> pr_info_ratelimited() so frequent capacity changes do not spam
> the log while still reporting occasional changes.
> 
> [...]

Applied, thanks!

[1/1] block: rate-limit capacity change info log
      commit: 3179a5f7f86bcc3acd5d6fb2a29f891ef5615852

Best regards,
-- 
Jens Axboe




