Return-Path: <stable+bounces-6610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66330811608
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 16:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93B781F21768
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EEB315A3;
	Wed, 13 Dec 2023 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BeyLrSX1"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF93E4
	for <stable@vger.kernel.org>; Wed, 13 Dec 2023 07:20:17 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7b05e65e784so59787539f.1
        for <stable@vger.kernel.org>; Wed, 13 Dec 2023 07:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1702480817; x=1703085617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3PNM5zXBLheQcIjEpK8gOH2bim9GcY7Tuic8Z+UFE8=;
        b=BeyLrSX1t2fusOTEW4Z/Jp9D0CCDHU/5SDqnfDRxmdZkzJQ0mn/o1i/wX+HUmqdywG
         VoxYHcN2CatjZG3wIt7ZWexen18me0u46jcoqYURbUX9FKR3FUeSxjbpoO8NP8NzPZlk
         +AMNbEEJcaFg225avSS5SzoJqGeb8ABcZYlZEEeXaQ1Y1sTAPlz+aaq68Qoofvpnloax
         4VfPkN6kUNR0wbH7FaBXrUVQR8kBKzZEEKIEnlrZCBQvhRpRsgWQbvMVmwqaBBaQChBI
         ZPN+m1bTosb1VXON0VGblAcjeXki4uMyTT7xpJN0YtJ96a5YM4N90o236tE8KuU/cRcG
         AM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702480817; x=1703085617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3PNM5zXBLheQcIjEpK8gOH2bim9GcY7Tuic8Z+UFE8=;
        b=EwfQ/6n6i7Y83qBMjMfb/thH7tN7X/GBzJR0/4sR8Jqdj7ZqRRxxK1sBu2f01ExGcu
         JTLhcBXB4K1X9KWpZUy/DwpYlF/aUxNtpsGthwSrH0gJGMi84unGugKWayFb/TV75MaO
         6E6qR7Wm9SsLaEhFEO8uNKSHJIMiw1aONDenIsuKMgkyrbiXRojwxUwDf/s8t41H9dl7
         JAc7zi8o1Y/EKz65eDF6ceORqQWXTDAyvYqsGbG7IQNnOsbl0vhA+MOSTIGlaEfmFS71
         kzBGeK83x0ETLpJuqKUpQj61zTkeKq8BmFT5WrobmRWl/NEslfuuOSNI+PcYKqOO8tev
         NDUQ==
X-Gm-Message-State: AOJu0Yz5E4Hgc3iDyQz615ovSvnG/lk2qCA313JsOS2Fw6qnajG1FTL/
	b90kZ2Qolw7L43kN6xEEsWZIuw==
X-Google-Smtp-Source: AGHT+IGY0kHOkIzt6H+QWTL10izoHuOyMzxLzV+feo8HGgLLYqLqoUMAAYk3po1dYDle3iKyK7WuqQ==
X-Received: by 2002:a05:6602:b90:b0:7b6:fe97:5242 with SMTP id fm16-20020a0566020b9000b007b6fe975242mr14827360iob.0.1702480815144;
        Wed, 13 Dec 2023 07:20:15 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gj1-20020a0566386a0100b00466601630f4sm2990491jab.174.2023.12.13.07.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:20:14 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: willy@infradead.org, hch@lst.de, dlemoal@kernel.org, 
 gregkh@linuxfoundation.org, Min Li <min15.li@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20230629142517.121241-1-min15.li@samsung.com>
References: <CGME20230629062728epcas5p2bb48fea42a380039c0eb06c19a44aad1@epcas5p2.samsung.com>
 <20230629142517.121241-1-min15.li@samsung.com>
Subject: Re: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
Message-Id: <170248081388.44340.415544465517225810.b4-ty@kernel.dk>
Date: Wed, 13 Dec 2023 08:20:13 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1


On Thu, 29 Jun 2023 14:25:17 +0000, Min Li wrote:
> Before calling add partition or resize partition, there is no check
> on whether the length is aligned with the logical block size.
> If the logical block size of the disk is larger than 512 bytes,
> then the partition size maybe not the multiple of the logical block size,
> and when the last sector is read, bio_truncate() will adjust the bio size,
> resulting in an IO error if the size of the read command is smaller than
> the logical block size.If integrity data is supported, this will also
> result in a null pointer dereference when calling bio_integrity_free.
> 
> [...]

Applied, thanks!

[1/1] block: add check that partition length needs to be aligned with block size
      commit: 6f64f866aa1ae6975c95d805ed51d7e9433a0016

Best regards,
-- 
Jens Axboe




