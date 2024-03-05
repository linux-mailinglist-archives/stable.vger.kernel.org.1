Return-Path: <stable+bounces-26759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C08D2871C01
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 11:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9B91F246B1
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A25B5A3;
	Tue,  5 Mar 2024 10:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghX537yG"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3245B5DB
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635186; cv=none; b=qsuAnxDqTRN0Q1SD80gnSka99CjlwR4fRqWOx9TiaqZ1Kvzx2tLWGnPinxA8fo9JBqIEz11POFSSOAEUmSTEs4yUoNSWsJ5lih70xXxFlHGCODZ8KAfWxhjO63MQuwTWkbGX83U/QKxYRLhFyPa5nMmgjLB9BIFbH1qCtb5trJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635186; c=relaxed/simple;
	bh=pFdYAnZdJkey2fB1AXbz9SK46Qgp8Uv9r7+q1l7WKMo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fcC3Px7Pz8IveeN5F569clw0jLD/mM3O2df4PteJahz7/oRx27POcQ64R7yd9RZgvRJdajS6QbSC9EadOMczquePnVvpB/MhtOA8gkE7cRyfLNTKJ3JkwryGA06KNKTGWmXWnK3AKnLMdg2thk+3BoQQLsh/VoPAUQkR2o6kJQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghX537yG; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c78573f294so22291139f.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 02:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709635184; x=1710239984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pFdYAnZdJkey2fB1AXbz9SK46Qgp8Uv9r7+q1l7WKMo=;
        b=ghX537yGBf7ce9YG6x44iyZLhsuJXoNIVo/XLVwiPJTq3C3aACsALoVFhFRCg24d01
         s0ZLhc1p2g4F6dtJqBxQsOceZkRXPFJIs7dgjSbzi51UE8LDJODAQ0ZdyiWkh0S6sPyk
         yu4JJ69GYkeLvxIxYYWcZ7pqQjgfu3VgWUDid04tG2hvrMF8jFtRD5mpEMVxTIdbwQcp
         0zrhH2GQEbYkGKksnXcPKxz6VB9n0Q2mhU6Ac6je+xlodUMbEFN6wdmzPIaZJncAYOYu
         UxMvdr3AMjyWOJhzYj1eolAlT1cAPaFyqDf95SQuUezHOquHsNALvpzMxLw8+h+jb9Us
         4NNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635184; x=1710239984;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFdYAnZdJkey2fB1AXbz9SK46Qgp8Uv9r7+q1l7WKMo=;
        b=Taq23w5BaXARm6Jpu6DKZBLJK1/RlBSqd2HZxV2nhsdrhdgqzpvyqqMauagd1rMO0C
         jNzedjVC73EBnTGOqMrz4Vq4hzc1DNJfVTU5CqW1asfy3mXUsiqVMTuRRa0ljimE6CKv
         rEWddsHSplZXNkfNG+Fy59Wi4ySlgsuXBeAw6FEJQf7rp+RrRithK8X6pgV/PKRQWDYq
         oCB2tyan8STl5pdcbHViJ8+N7RdD9SKW5YPCQWVGRRtHjxYM/OB5ONZ6KuGbRIWV6XXn
         ZKpY5CCp2dH7bYCsWthR1BULLlhHw/jD3IgPirPChiKZKm7Hj5s8ifEmmuU7gvluSYrY
         24rg==
X-Forwarded-Encrypted: i=1; AJvYcCXkRa4W9mO/yn3iQ9wtLBNtU0h1+4g/ep0/yLi20e5p6wNFm4mLnKlTcglL4WxsDb+LDS8u3AuQUi+XhGewXPLAf+I/ejYH
X-Gm-Message-State: AOJu0YyX/cL5i2m7QGag0MJKFV3c6UrUnzhEQ0wSlzQNjfCbNp5KsfKV
	G5zHvnnT5KNYvJSqWb67DprNzAEYlztNPHX6h9tPw5oKobJZcwj+hRoOLo+F4zAo9P6CaKJLzje
	UGeUcXK+yfxP7PXkKK9OCF3Kkftw=
X-Google-Smtp-Source: AGHT+IHXewfnOMLd4nsI0abW4hEBKxDQ5wmxfSkGzuHLsYPW7rSimdeSKDK536GOszGfWSsdAecIXmaCFXlJjF252hY=
X-Received: by 2002:a6b:d912:0:b0:7c8:5946:f45a with SMTP id
 r18-20020a6bd912000000b007c85946f45amr4576400ioc.7.1709635183767; Tue, 05 Mar
 2024 02:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Eric Hagberg <ehagberg@gmail.com>
Date: Tue, 5 Mar 2024 05:39:32 -0500
Message-ID: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
To: me@pavinjoseph.com
Cc: dave.hansen@linux.intel.com, regressions@lists.linux.dev, 
	stable@vger.kernel.org, steve.wahl@hpe.com
Content-Type: text/plain; charset="UTF-8"

To add another datapoint to this - I've seen the same problem on Dell
PowerEdge R6615 servers... but no others.

The problem also crept into the 6.1.79 kernel with the commit
mentioned earlier, and is fixed by reverting that commit. Adding
nogbpages to the kernel command line can cause the failure to
reproduce on that hardware as well.

