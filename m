Return-Path: <stable+bounces-23198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AF285E1F9
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62D551C244CA
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582F781AA2;
	Wed, 21 Feb 2024 15:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KPVNGf/J"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EC78174B
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530785; cv=none; b=FTRi7UAI7GGcH7d7QWxm98UjSE3t6oJJCri+esadTQaCUqEjhRtwggwcSW7VSSQHxBEwNbfJUk6TA6Bu1q+519QiTaOVfz6/cDEjcDgwe1q1GXNEkEFjnQ33kbH/9iXB9j5i5qRq0b4Pn8kf6x/2PVToMSOAbU52hJ4C2kp5DjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530785; c=relaxed/simple;
	bh=9VgNrg7E3WxzPLbpdW7b+fQZzMzEpRyOCT/6WT2Sf4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HzdUUKzcSU/QtOUqAazee86C6TQ6J2xi+hrzYz3UU3QQkfHewbrH7yGklB0P/S6rADK0nEDYsamF2+lM7TZH4+mCUlBTFyJReSojt12XlMp+tZuJoMaDGiXUhf5yJniAAB5BdLFdi1AgHvzTusHITrWAv26SWrh9XyKtWF37YG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KPVNGf/J; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59fd6684316so1643264eaf.0
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708530783; x=1709135583; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VgNrg7E3WxzPLbpdW7b+fQZzMzEpRyOCT/6WT2Sf4Y=;
        b=KPVNGf/JFzGtwRewRMQg5bShOJa0Dgvza0OeCoUI1GWDo3nuIs/PNoWjuu8dwSGmAf
         SZPCubx3OIjthO+2MmVHtovqUtncme4JxvyCFCCOmhxRsa6LoP9T/D5mw9loiBQBUzeo
         HdjFsS431y7wY1GXtpOUY9cN0BW3QNQF26OSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530783; x=1709135583;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VgNrg7E3WxzPLbpdW7b+fQZzMzEpRyOCT/6WT2Sf4Y=;
        b=of/G7c/XXm9Jvbkq7WXPxHFqFPmUQz2TtAdYjQVqbzpsoB3yEs7VD9Qk0u6mX7tAQR
         sq54rz36BsdXIhXYCAOzVqCf14p5o9kPWwAK0nZTsgEm8+PZYMztFJP43RCKHuXiJTes
         GkV9a1vC3hRg7F43L813Hc4heWrIkzKxD39eSiPYMD7Jv1N9f907uw8yf05yx40HM1tf
         H2erpM9dhM2vw+B14tkuc2KJpKv74kEFwe/Y7fe0pT1aTEpSw5RYPH1L1g7Cco69CihG
         Ea5yALhZNZ2tpzEwt1Hxzu1Nop2k5+arlcSNZisZqElug/pnHEWpS5i/winT6pgMGg5k
         I3xA==
X-Forwarded-Encrypted: i=1; AJvYcCV3VoEnuuTrth8FGCB/epXlzGw9v7vTqIB3etO75WLBE17wwRZwli9JLV8Dl3N7djvH5MXNsY35Swb0TAfD3j0THG2TBOFA
X-Gm-Message-State: AOJu0Yz0Utp3Am14vzGLwmpKRt/QbkPEix+nLt7iwxMIRHxljAj/oU3p
	ceocJwHWp/5TDTi/lCxzEanPMFBq3hFbGHdqKD5SSNQszzYh2YpjKOb3KEwqz93iYruLWiT87og
	l+k0o4pyaGwJyJa2P0k0vaQaz2GCdC3tz4ArC
X-Google-Smtp-Source: AGHT+IHQpFoZXWJNF9xVniu1c31fdFShm2fJtfOtAD0LYOdmrGGoF9j9d5Fv7SW7EM5r/4boF5/8ahxD5g+W+hfI9X4=
X-Received: by 2002:a4a:355a:0:b0:59f:fc30:d3aa with SMTP id
 w26-20020a4a355a000000b0059ffc30d3aamr5366824oog.3.1708530782898; Wed, 21 Feb
 2024 07:53:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz>
In-Reply-To: <20240221114357.13655-2-vbabka@suse.cz>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Wed, 21 Feb 2024 10:52:52 -0500
Message-ID: <CAG-rBihOr+aAZhO4D2VBwSx-EGg_gbgBYKN3fSBTPKCXdz9AqA@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, 
	cujomalainey@chromium.org, kramasub@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-sound@vger.kernel.org, 
	perex@perex.cz, stable@vger.kernel.org, tiwai@suse.com, tiwai@suse.de, 
	Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"

Thanks so much ! We will stress test this on our side.

We do this by exhausting memory and triggering many suspend/resume
cycles. This reliably reproduces the problem (before this patch).

Of course, as we all know, absence of evidence (no more stalls in stress tests)
does not equal evidence of absence (stalls are gone in all code paths).

