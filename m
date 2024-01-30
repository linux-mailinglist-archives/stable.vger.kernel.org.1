Return-Path: <stable+bounces-17379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DD0841CD3
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 08:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF0BE1F278CD
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 07:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8052F93;
	Tue, 30 Jan 2024 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXboiIFv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AFB53803
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 07:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600622; cv=none; b=OFn//mfovNwTCoGNaXD33gIlNz6AuwpgDLWfTUPc45k+Vdlx8u5lLcZcow0vzNq4qjVIl2C60VDxLQpUkmXQ7Ur7yMExHjkF3jLYic3fAwpALOZVbK7o4JvkQXTENftsJl75GovE0nNUUaIprWcyzfJhLO3z0posq6S2wqejH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600622; c=relaxed/simple;
	bh=ZLa+x/C/jbF5KqcCYB/NltnY/Nj95ayTcJMnxL71bQE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JBLpldXqx4HeWQJONmDmWN1RL8yxnlSfzFtPiZ938+MSKLGYpBiNH8yJhVPybWYT0SQeVjgHg/UoeQZMQ+TjR1UCJzwQePqIssqAYYiLS5r6hdgxZ/P2CvRXbVSGPEkShPRiuzPYbYbl4CfdU8o/bQohpamhzAVCNmPukHxShP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXboiIFv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-295bbf1a691so84143a91.3
        for <stable@vger.kernel.org>; Mon, 29 Jan 2024 23:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706600620; x=1707205420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0O1yTs3TmU9k3ouKGGsmCX+3h/BoRRvKAJm9lXiTrXM=;
        b=nXboiIFvY9NL/fNSYbfHQhzaORRUEHCxyh/UTodToQPhlM5AeHo3PipFx7X50R+ulL
         aulZRzLTisU1lRptGGoe9vF5LZp8fpb+mjakv1i7u9Ndg8OakBlZqFRg7ps8JPux/m1L
         Ekj0+yGRRry7eiDhqEGr9b5XGR0Pc1v4i8G5OF5xhq5cuB+ar16Driirkwcrsu0pG0pv
         +GBfaq89CttZZ0ouDwaTiuFCRV0iuPtkb749AFvaQfi3byyM2zfsl7zjtAtX/Y42yPj7
         E2KX5R8lhNYty0bzQ1evPK0GXmHMNh/evBWyKkNPdmcqzZLuQKGDxGrHh8di9b9qcYZd
         rprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706600620; x=1707205420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0O1yTs3TmU9k3ouKGGsmCX+3h/BoRRvKAJm9lXiTrXM=;
        b=Ij5h+jr9/dkl7AOP6BQFLAMDhmRucMm/WnRwXFCAJwoWhMg4fFmQ7BoQrlaxoakGIS
         gLxW5wxBIozQaHUuOhNHN6QgFtcA8psgpzlpxYH4X7dZ3KUxPn15WiNvwUL+/d68NXPt
         kAb4/LyPRnOq9Xbc8YGXZk9qu6OwcDvXWk7MbZeib1YOi3fad4fuO+5HXg2sTx/Vb28e
         xM73cK9oGcCgrKxwTGg3r3TV4a5hu5Ef0fC0rNhiwG1FmCj1F5zVFJtPDR6nd2JehYIU
         uqGvPST8Put+T7D8ne+xhqWvHtGwSRHLoaohnRyIXW8m1N3ZqAx0S0gGlyStzT0vEOLB
         mmIg==
X-Gm-Message-State: AOJu0YzDumkPxcJnOsmDoRVDQ+XlJ2f81ZYf9xBOI346xHYAWLSRzTDC
	JS53CMYhXy/fCoYaGnQ0daSShiMOccsCsc6kBhpakvoUteRXBllZISJQcVEeclhd9DoYhYIggrU
	S9zjWtm35xcwlvpgvZHwGkCJGYqM3fQHuS+k=
X-Google-Smtp-Source: AGHT+IFr077kdCco+jOHBwe3XgnDOOxO66ST7XRSnlI8XygjiKs4Z+6Fjv8mLBBP+zc9reHIWBe7w2SpNnhnwNyndAM=
X-Received: by 2002:a17:90a:72cc:b0:294:80de:dd3c with SMTP id
 l12-20020a17090a72cc00b0029480dedd3cmr5256797pjk.34.1706600620183; Mon, 29
 Jan 2024 23:43:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sri Sakthi <srisakthi.s@gmail.com>
Date: Tue, 30 Jan 2024 13:13:29 +0530
Message-ID: <CA+t5pPnX+Rk2eOHO_hWeQmSP5yV6CRhBURuVEnfkqvtR9Rvopw@mail.gmail.com>
Subject: xfrm: Remove inner/outer modes from input/output path
To: stable@vger.kernel.org
Cc: srisakthi.subramaniam@sophos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Below 2 xfrm ipsec related commits have already been merged to
mainline. From Herbert Xu.



Description: Remove inner/outer modes from input/output path. These
are not needed anymore.



  xfrm: Remove inner/outer modes from output path (commit:
f4796398f21b9844017a2dac883b1dd6ad6edd60)

  xfrm: Remove inner/outer modes from input path (commit:
5f24f41e8ea62a6a9095f9bbafb8b3aebe265c68)



Reason for backporting =E2=80=93 We have transport mode interleaved with
tunnel mode support as part of ipsec with compression offering. These
commits in v6.1 LTS would help.

Requesting to apply these commits to Kernel LTS version 6.1.



Thanks,

Srisakthi S

