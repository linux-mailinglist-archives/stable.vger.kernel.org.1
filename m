Return-Path: <stable+bounces-108450-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0BA0BA4B
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 15:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37574161B01
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 14:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC2C1FBBD9;
	Mon, 13 Jan 2025 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pgjGkx4G"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCB23A0F3
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 14:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779598; cv=none; b=fiwYy3n79VYMHDyf+X44/7Y0dMemrYGzBY+zuvgGOUfbHsHi2y5jPOlQcC4Di6b/4Sl0t0c2uhsk2bzpGgnQRexXb66NK2WggEtK6ZZEDQzcnGFa4Rzr9jsQ1JM6FAiFwNJELrfKpHamRjk6eqa71OiSE4AE0YaQ9hK5G9T6ICs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779598; c=relaxed/simple;
	bh=XXGUeMNtduH3jfxFczrGU1LWJGWgOXZPjvIRPPr0lYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N0ar6Fdv0z03eeLheDMUCy2zVUdifXN4FGf/yGVwMVM00pMeqpjL3p5m/h3+Wx66KPqJ8gt0IwZJ5U2tjO1Vpzd1p0igPmhUjMODjM6WQnme0PlOn+X36/ChKApbsuSlFQ6vjRag40G9P9fwBV38ETjMq276NjTRfCmaaX8IO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pgjGkx4G; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844ef6275c5so146250139f.0
        for <stable@vger.kernel.org>; Mon, 13 Jan 2025 06:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779595; x=1737384395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtiliJx5j1ndYsGGG1phZCTgLfHL0dKhOHKuSNMEi48=;
        b=pgjGkx4GNkW/XiewWGEc57VNPKfuId0k27A0UWkT/FcCS9f5sYilL2PaRvGm3smbfB
         hwo7bgC4W73NYUxYRQNQR3XTYemFSx1DRcp8Adhvn+07bQNk9AgTs57sRwMPbn27CljT
         x+eIDeRKaezqEBM4WnAoWdS0T/rjjSRAQv9YQhrZUAqgrioBl6yL7bNSDJUG+IOKPaTf
         0EtTf52VNkrsXbiYhwG0GqYEWSMKNeZ/ntmLUs2gXJJpT2G0Y5lL8P3jjfFZZYACjVMx
         nbws4sQOG0+L+d3HxoKulkeCr5n0vRNAoqE12b+kZmyCf6rNJ1Xktb+vMR0g6BKVuYGS
         2fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779595; x=1737384395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jtiliJx5j1ndYsGGG1phZCTgLfHL0dKhOHKuSNMEi48=;
        b=Nqx8FsW4x+JGtjUVwIyzf/L5a8jf49Z8jr6labhDm5HyfBteNlQwC09uZ2inumezHr
         SK/a55gRtMEw7dOckoMYUn6kC00H7BYflYSuYmVMSaF3vtG2XO08gtTtiZot8Ppz3L1d
         +UYfR3vg6e6rZEp2ovYr1Gi7ph5lttVHiRU+C96p10N3VHxvzTBzDUZcPf2WQd/WLOfN
         dlaq94QuoCdy7abxTbpGorIetxSdmxbHto1UUgn2+F9Mml5mShm6dW8TnuwFzLgJ9OQS
         CDsNRvqh/Y4kFQsi4LD2bvrhCFNoc5eKnA6PLbD+3tssA4Q2Bw91vioMPGERXjTvvN7O
         oZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaSPYur4ts3s4Vqooj/TU85s/xcTL6if932W63FmjWNPb5QlCfOc4WS81PIW+OSwI3ZXM1cUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuKMJD7bHdpZtnCIGX8X0vNYoQ16yPF3bZgqWsbaw9CoPBEiyI
	1sIzoJMCpi2aA/1vtSzOlOuB1yUB0jx6l414w3NltkyeMz+cxukjAhWIe5iaC9E=
X-Gm-Gg: ASbGncs65a3v8vumbRerp+H8Lw/Y0eRxWQX37Y3FI3N4+c3Xy0YsnTB6lVoIV0dfQ0d
	zQxBbr7D6QweJ2iVB0CouA1nPNrmPAT3ZKbcoI44YKz/YztXl3fPh4dcJ8hjHruS8coaeIER51W
	9zAMrXT+SrqH2u2e3OQVPSJOo4MqzZfDv8co1HRl8JJPEikqMODd33islVRxEnlBnPXAT2XskNJ
	zS+TMQtqrPClL0yXAoizSLGXswPqxOQQxU/rb4Rzjw/Zak=
X-Google-Smtp-Source: AGHT+IG0orvDT8cdI9Iol5E8H6Fk+RBM9aLfOujcJ2s3aU1fEULaeNBcgCbArYSL0EMHC0H2PTp4Rg==
X-Received: by 2002:a05:6e02:1c2a:b0:3a7:86ab:bebe with SMTP id e9e14a558f8ab-3ce3aa5adc0mr141968405ab.16.1736779595612;
        Mon, 13 Jan 2025 06:46:35 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7178d1sm2790840173.95.2025.01.13.06.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:46:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <tom.leiming@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 stable@vger.kernel.org
In-Reply-To: <20250113015833.698458-1-ming.lei@redhat.com>
References: <20250113015833.698458-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: mark GFP_NOIO around sysfs ->store()
Message-Id: <173677959482.1124551.14407464395957705701.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:46:34 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 13 Jan 2025 09:58:33 +0800, Ming Lei wrote:
> sysfs ->store is called with queue freezed, meantime we have several
> ->store() callbacks(update_nr_requests, wbt, scheduler) to allocate
> memory with GFP_KERNEL which may run into direct reclaim code path,
> then potential deadlock can be caused.
> 
> Fix the issue by marking NOIO around sysfs ->store()
> 
> [...]

Applied, thanks!

[1/1] block: mark GFP_NOIO around sysfs ->store()
      commit: 7c0be4ead1f8f5f8be0803f347de0de81e3b8e1c

Best regards,
-- 
Jens Axboe




