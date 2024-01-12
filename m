Return-Path: <stable+bounces-10592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48882C526
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 19:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41700B215D1
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 18:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFA617C9B;
	Fri, 12 Jan 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqgIM4zD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE6017C93
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso374a12.0
        for <stable@vger.kernel.org>; Fri, 12 Jan 2024 10:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705082486; x=1705687286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XxcXCQP3+9Bv+ZGDo4IurQCR5mkoBqs8qSMmpsQJKCY=;
        b=FqgIM4zDMYO2a5OxXFUwlwDbjJ2QIrwd/nKCxMQ/JjKIySI6pz3BQN2P3ZCF7/iKst
         l0utFJQ/Wp25K4aKvEDRlUXCp4IokUSKmWsf4VAeLBrI2smQmJya1RhgiNd5k77jNlQY
         lrPMreaQWvhe7aeSoHoV7/YSOMGS2kc56WYwMRD9iw6QSNYvbg9DGbEI0quD1tc0hMfI
         u0RwVZrY7WHmwVcn3e8r3XBxFpeD7N78dQm3v4hzdvwUZl7VoULJaTCNIYlMBSVkRACP
         i/Kt/w0wpXem5PeuI15AU0Fwq1ZkPt8JLHJGbzBCUlA6DND1b/0V6Ul2SJm9p5pxQVUv
         Grew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705082486; x=1705687286;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XxcXCQP3+9Bv+ZGDo4IurQCR5mkoBqs8qSMmpsQJKCY=;
        b=Rns2r2ChG5baeON+YFBSXOwTvvR78XEKmCh41QrwJdQCJRIwuPGAlgGgLtGw9GvWHA
         bbKFinsICp2Cdxa1irm4KT3yS7gzQeejP5OOr770nCvvWpStfYobZFqMcTyChOObjdS3
         fj97JLkUcpkKI/IEbeIufMwjCXga9n0ft0zJYK/5wvM9qiGWvHbBHuq+KNpk39+khdF6
         A516Vh5Z+uXFOd+Q1TpTQ8vJl8XstnBdQWGQx1REMtbKcV6b1LPCPoyAHso9NN3a+taF
         87AXwHD/dCrstiNWcUEiYa0zu0otEZEWABudC4zclQG2KlgA0mLV1OFlqYDKO+BW6zYx
         Xzdg==
X-Gm-Message-State: AOJu0Yzku45wlXJ6rW5vH799Zpfy4szoLQS9krGXfH9UW2SFosqXiJjS
	rKmIftExzSYl6nXOuWE7NwFAGFzQNxSjyUIaSkT7iQZNx+UuP7SmLNFVrepjwTk5
X-Google-Smtp-Source: AGHT+IF37WrheBgs7vZkD4LAZbqDI+dAMM/O+eQ2FkKngINtsaFMvdv46HN03Hdih6jdNpEuUF5/JOa1qC5ybtJoa2w=
X-Received: by 2002:a05:6402:40d1:b0:558:7f0f:aa70 with SMTP id
 z17-20020a05640240d100b005587f0faa70mr384479edb.5.1705082485852; Fri, 12 Jan
 2024 10:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jeffery Miller <jefferymiller@google.com>
Date: Fri, 12 Jan 2024 12:01:14 -0600
Message-ID: <CAAzPG9MU2PfTk2Yn+spJqH6mLVsG1p6L6vhJ4LFG+aiojnN6HQ@mail.gmail.com>
Subject: [REGRESSION] In v5.15.146 an ax88179_178a USB ethernet adapter causes crashes
To: stable@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>, justinpopo6@gmail.com, kuba@kernel.org, 
	linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For 5.15 attempting to use an ax88179_178a adapter "0b95:1790 ASIX
Electronics Corp. AX88179 Gigabit Ethernet"
started causing crashes.
This did not reproduce in the 6.6 kernel.

The crashes were narrowed down to the following two commits brought
into v5.15.146:

commit d63fafd6cc28 ("net: usb: ax88179_178a: avoid failed operations
when device is disconnected")
commit f860413aa00c ("net: usb: ax88179_178a: wol optimizations")

Those two use an uninitialized pointer `dev->driver_priv`.

In later kernels this pointer is initialized in commit 2bcbd3d8a7b4
("net: usb: ax88179_178a: move priv to driver_priv").

Picking in the two following commits fixed the issue for me on 5.15:
commit 9718f9ce5b86 ("net: usb: ax88179_178a: remove redundant init code")
commit 2bcbd3d8a7b4 ("net: usb: ax88179_178a: move priv to driver_priv")

The commit 9718f9ce5b86 ("net: usb: ax88179_178a: remove redundant
init code") was required for
the fix to apply cleanly.

