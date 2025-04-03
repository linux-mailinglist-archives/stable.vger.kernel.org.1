Return-Path: <stable+bounces-127498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CFA7A0A1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63A37189161E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793A5224891;
	Thu,  3 Apr 2025 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="Gco/Q5Af"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F43C0B
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674780; cv=none; b=HtymvC24bNkHhfXYYRR/vrzAdCjkfkJlS83w4t+WV8gJVzZN99byfSlivMM15xPeZJdKOH9vx6lsyVOJ0jPMLms18x8RXD0u+hMTjcgsmqIUoEwZu1+wtgkrXH3DDAPmlzTfrGQ1tixHnqQc7mb4N1gM4Ehd4RA+QFikBlvx6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674780; c=relaxed/simple;
	bh=5prlmyoajPG2ixj1DUhrDPm5FErOJGDMDYnCt5RFvJY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=kxFzUl0lVfwOtkLJLUIirY1ID2kfLwkTsNflpsFHVzsZq3COdSjWkSQul5bmjrSqFPS68C0hGQmv77+cM7trg5XRoQbpIT0/vFPGzoL6A2MGOJGTdQK8oSMYRU+WBS708qbNMxp7FdDwmEFyvf8IjuDpr5bDBOAoN+Ki4G144Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=Gco/Q5Af; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c68fd223bcso223917fac.1
        for <stable@vger.kernel.org>; Thu, 03 Apr 2025 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1743674777; x=1744279577; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5prlmyoajPG2ixj1DUhrDPm5FErOJGDMDYnCt5RFvJY=;
        b=Gco/Q5AfUMcjAQ6D34juPaBQgaZqRiTlSwI0QNtIOWdlba4aJ0So/iml5YPzbN8EuY
         Gwf27uy9SRgDiO+4ggg5VH+CYgyqkeKS77OvhIDG/HftgIQ53UM6xTervs69QwmN3ogs
         gDcw1IsiUZi0bUn5z86sGZps0VdneZeL/T7Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743674777; x=1744279577;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5prlmyoajPG2ixj1DUhrDPm5FErOJGDMDYnCt5RFvJY=;
        b=Neer/AGZfUWH+oQmavFryD9h101+kmzx5OENkhBPO6tnLnKX2Ta9YB90evHHt7Rtgd
         SAvvozV/YsK0s7HL021GSBFcyMEGmSVZ/v6fFHD8yCWNfdICKtpzOXc4m2y3LGle3cxl
         vgmSleEMuu3oUHT+apj9UQpZFttHS7kbb3dRHRyiTRWm7oy7Gro9jFHejNoE/EAxajaU
         wqNJdpxFqnV22fSNKI+zttRmx8CdfcsFlSFd0tYVmtzGnnM56csvX7wH4axqbYD+VWYb
         SIJilurRzRKETyuzKuXjI4ywaT+y5J9c8ZKnaplTr5SS9l09F7qAxVcdhjtZteD7FKxy
         jkSg==
X-Gm-Message-State: AOJu0YyvPeKB5uvcs1hls2aT6ReK6AI6j+qpU9pLWqpXl9Pc0yEutvW1
	wIGNf3DDWXVeXotfkqAytQQqqyqgXL9oYIc+OI3/XO7onQQQuoC2I2gsBJgiB8JJgCEYi4GL8ii
	kJfHPRPiak3yQue35bnQCRjMSHPPZWFS+OdBeYr+kg6VVSE0eDJw=
X-Gm-Gg: ASbGncvfvp6ltm5L8MVntPmIOWD4JB6Ubqvr4W4ddtFGW3adzL4sXY2w/RGS0EI+L8D
	CX9SpvImzhLyG8x11BHx1/UjgZRdmGnTdIAqW7Y0Nm34FPUyY2zIXC781UxzPuZwM/d2ZnVy6Vs
	W01WvlQnGu23ciwqnWUmyTc14p0KFNdLZZg7TH
X-Google-Smtp-Source: AGHT+IFGbgJ1CSoxOpLavnWAK0w0m5SAQBfO4BNkF2nqvfmCBi/vJJpLfUOMeJ7J9FhIUvyVNg3yfeHflItj/qBWsHQ=
X-Received: by 2002:a05:6870:7247:b0:2c8:5db8:f23a with SMTP id
 586e51a60fabf-2cbcf5ace64mr11177300fac.20.1743674777501; Thu, 03 Apr 2025
 03:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hardik Gohil <hgohil@mvista.com>
Date: Thu, 3 Apr 2025 15:36:05 +0530
X-Gm-Features: AQ5f1JpnzHtyP2DoSsJWOT3LyOsBvdWKDwiCf5Jv-BW18MmgUDDWPkPO0jpi3Bk
Message-ID: <CAH+zgeGNArHoJw4rfd+Q-WQhv_rk+5wke7kYz_LaXNjXNocQew@mail.gmail.com>
Subject: Request to back-port this patch to v5.4 stable tree
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Greg,

This patch applies cleanly to the v5.4 kernel.

dmaengine: ti: edma: Add some null pointer checks to the edma_probe

[upstream commit 6e2276203ac9ff10fc76917ec9813c660f627369]

