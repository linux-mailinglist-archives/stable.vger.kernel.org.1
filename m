Return-Path: <stable+bounces-172715-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E7B32F25
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 12:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985BC1B22F72
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B8526AAAB;
	Sun, 24 Aug 2025 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="yhj5GnMH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B8184E
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756033148; cv=none; b=QAzG7WXrctIm4KFl64V7Ev2CCg6WmJxUZIT6qzVTE1oL9YUptuy8waKDiznlPqIqY2+eB4/tU1aoM10jmU0Inj2gGh4+gtNLFE2B2WeU/4zDj2/rxnEwliOVGKX715sk8QEl1olVQyIeRSfRvktcgdC+D23CQtJ/GtfHBDzbyuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756033148; c=relaxed/simple;
	bh=UnZkDCLCCTrKrIDtuTBRV1LNxHw8WqXlnODKtArlAlg=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=Mov0/jivr9gTA/H1K83ODo+TRdCB+eoiKpSSJkDXrRXJJBGIOvO2UuCXR5Z89FKpat0WYrsFsmsh5DFdVVcRNEMIf4/1jWYh9gljMf2C4sMTSSc/icZpd5wns0aZtPcQweUzu8aAH9mSqfMo5vyi7CeV/SBxhsdM4s6+LhYq2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=yhj5GnMH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3254abaf13dso814060a91.2
        for <stable@vger.kernel.org>; Sun, 24 Aug 2025 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1756033145; x=1756637945; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0kKZF2XJNWNbQpUm5qM7v71TqezcAqH4qupPrP5ass=;
        b=yhj5GnMHKT4f5zHK+Bex83nlpO6ZT7+XbBc853KL0byPuqodvvADCdOeUrJTHsrYMs
         /dHtAReLvb4t9wLtJS4GSWSTc0geYnMVAcMFbsGWPpPQiNg3lqqrnQfv09gJS8OFgGUQ
         WEz66tOvvzCNn7Bp2qno5EOY9QoP0nTS9+7boN5yoOX4fnJLVr/waTvYKGMZ/ka6qyhs
         CzNX9e/UucVneklQlj57YpbjLFTdxE6n4rly2w1ycVw/iAtS4Xj9BEkWxBYc65aPLs1w
         8CNHoVSDp2WIGcNCc2a2kgLtsK7KoxMNCZ0CPvev9HXkozCo9gwhKmKWvnoRV5tAPpjp
         p3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756033145; x=1756637945;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S0kKZF2XJNWNbQpUm5qM7v71TqezcAqH4qupPrP5ass=;
        b=Dhr3wWEzJ4V6Y09iL7548GtlbGfa9jtQGDqYemhLaUKnWjOpjALxj04syRyyJVPuR2
         sss0jrPAc5+dAOhmdFCYPHihan1QmG4w9n+rQes7TjGdFXxqx+cr2dCw2uGllizxw2fK
         IGVEPbnVhvIxWggPff4Ay9E5bxxV+P5R8aDGJq4iYHafLp4uL01vX9afLmVs2KSYxcZk
         gpfQHEVTv1PIdL3fWLshwlIMAkNghC/f7r3yA6p4ZNmmazT8mk7+cblsRRNs9rsFN73x
         USaFo0IKW5r1OZN9w099xQMQQsSQblDJDzXdtL3eE/LgKwVtiTXyPZMIPSDQlOpiGHYd
         K1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6GZA7J3Suo5XYdRytFedG3+ZZNKfdja3fsg7jTSQLGeLn0gzCYFU/MZizADpzJ+oA5aeOFRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaxZxVryJqgjbSn54XBH2YC4vRbBqj5JhNg4Lf2ID/66qngWxN
	Ik2su4L84MxYAYKKZDibEJaAe31yjO5eR52/W19FBMNjHPfaeboEBSCzt7QZRNALmn2kFHvKFNX
	Tr7nw
X-Gm-Gg: ASbGncuzgvkJFDfrdaZPPR4TzMuqYidsWIEVvv97pJb2CQpsXzSI4WuqIYrrd/sylqG
	tJEriVYkaafL//KUdrSeqZhEPNwnmeAhD3Jdxk41rLMSsHGCLksi3B1Zr4B4GBCe+XcoPg6F5HC
	315nOr+f4a5XOyAltLLIswcronaq6SROABnDgMgpOS20kMDeRITiYcdBG7GWH4gpIGUUBCvnbuE
	7WhBo/z1A7IFCQ/utCNTKcSKcuFaYHvviN1e6ArJuy8yrcQRzb2dXz9ZfK5V+DXvnDrDLS8XG/+
	1Ak4ZFkZMUF6ABvf8UVifsPr+t/X+yDLdQ7bOVQnfucba5fke1VNCkB9lYvv7ZDiqC4L+1wsawp
	ZMvb6ych4mJhECieZ
X-Google-Smtp-Source: AGHT+IG3haLLbDgS70ChkZIB1bzoAE3APySYno0zfhlEeJNxO5cET+vuRaFvIALRfsHpfS70bDu9QA==
X-Received: by 2002:a17:90b:3b4a:b0:312:1c83:58e7 with SMTP id 98e67ed59e1d1-32515e1308fmr9698445a91.1.1756033145464;
        Sun, 24 Aug 2025 03:59:05 -0700 (PDT)
Received: from 16ad3c994827 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325a5c3e544sm337926a91.27.2025.08.24.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 03:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-5.10.y: (build) field designator
 'remove_new'
 does not refer to any field in type ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 Aug 2025 10:59:04 -0000
Message-ID: <175603314413.574.8183763136099477921@16ad3c994827>





Hello,

New build issue found on stable-rc/linux-5.10.y:

---
 field designator 'remove_new' does not refer to any field in type 'struct platform_driver' in drivers/usb/musb/omap2430.o (drivers/usb/musb/omap2430.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:44aed553dd8d8a3dca40a9719599b1909ecdc56c
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  10b6e479487675365bd106d20fb7dbeec6fb4f60



Log excerpt:
=====================================================
drivers/usb/musb/omap2430.c:514:3: error: field designator 'remove_new' does not refer to any field in type 'struct platform_driver'
  514 |         .remove_new     = omap2430_remove,
      |         ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

=====================================================


# Builds where the incident occurred:

## defconfig+allmodconfig+CONFIG_FRAME_WARN=2048 on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68aadfd8233e484a3fad5987

## multi_v7_defconfig on (arm):
- compiler: clang-17
- dashboard: https://d.kernelci.org/build/maestro:68aadfd5233e484a3fad5984


#kernelci issue maestro:44aed553dd8d8a3dca40a9719599b1909ecdc56c

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

