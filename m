Return-Path: <stable+bounces-196613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C03C7DBB4
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 06:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37F6B4E1FFA
	for <lists+stable@lfdr.de>; Sun, 23 Nov 2025 05:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB12417C3;
	Sun, 23 Nov 2025 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/9ZwH/7"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3D747F
	for <stable@vger.kernel.org>; Sun, 23 Nov 2025 05:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763875204; cv=none; b=lqjTrQgR/TgGqB5rshHUbN6yD3R4inTmligVLX9htv4QjA7Xf2XXjRVPS3VTi1DgcFTe02nCrCLMc0G3XUAmgXBZjwAoogasiKd3VjfCzFXVRNrzY3i8cuCBYNqJsFn2aOFnrJSTCVIclUVA2nGiNEgtJL2gWj2tfr9NIa0BEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763875204; c=relaxed/simple;
	bh=rZievru8xFoio8W0pGZ0BzqjHLspt23+y+NwVN7V/34=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u+K3khpAU2Mu1t/HY0Qq9owyA30/ln36KTssQO6z6XtWdavfbVM0wVZJLnSSKw1nP0duoTpDoHA76gqS45iOW3XXRnma5JddTCLgJW1RN/QA15Fq7j2nce3BUc/aL9a5fwtsMxGePgOyuaYez22cz1qcViO7qQa0vbfJipumoU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/9ZwH/7; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-640daf41b19so4331720d50.0
        for <stable@vger.kernel.org>; Sat, 22 Nov 2025 21:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763875201; x=1764480001; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jDsSL1Zlb9jxmd/NT8Y1nKlEBZtEEJl+kOBs1aZkkkc=;
        b=Y/9ZwH/7fiTEbZS6Tgbg+OePKC+CukYLW07vITyNsaH8fSSvBI6LUXPR0l80BuNeA1
         Fo/nj1fk4PWruiS8DQT/T6YP4P7aul6UIUi9NeJcDSk9CHPriEvfzRphhae03TcGIUBa
         6Gc2fO6dU0XW8nTWsAOY4coC83u3FAtz6szsYc0JmJa99ECoCcFwzVYMVZlgTpEZt2Ks
         +RBkb+DF2S1WRFA8ddPyg0p1DCVVvW6BaVH+bcjEM9RifmlL8kw1nmhWQzaz1RFMgp88
         vib88SxZazwXSXeAZ9xqu23jK5XCBbgs+BtTkU1fcCnT3s5xK34JzIUEmBylYJPO4u8j
         8xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763875201; x=1764480001;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDsSL1Zlb9jxmd/NT8Y1nKlEBZtEEJl+kOBs1aZkkkc=;
        b=J0hCDz0gHnLZpJ2FlLp9MDxyhMfaqrxukE/o9OkynOvzWUygseg/qE4R8brMRFB4gm
         W+dYakt0SoiuRArPPRIZiK8La+3Zv9iS3gWclv4FU6x3OeN6OQE2+gB19Z3LIMmE7lT5
         a2Jt5oh4xbVjf1FShO9onvrc5++0WuMK7z2wQwHOREEDtE5k4/Fk8MF56F0lhNIEfaqz
         e3KvI3QRJouPLEziXztoUdCSrv4L8otyPLOl7ViNzwaJABgfAJrlUwYJCbNEdWK9J3dm
         WIN0GoaxU2Tb7AU+rnGVihB/rwbQlgh57IFdskLYK1My24dV0HlsGgNCtZrfajEcg555
         ggRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoqkvmuEocezv7nFDH7rtxZPYq1jrwbe/NIXL/VduZKnnb91wN6VycteQESE7nUoOUxZ+32Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnAilh/OBDg6XMEpusAXrOD84j1/jiWTJQtadLJB0VX1h7iTM
	MScvYg4i4PcPqg/8KX+YrKyyxeQCOrBNuVlPKK7hTreAuvyXvAlLtqps/ChyE3QpLw==
X-Gm-Gg: ASbGncsukwypBkgyDxp1DyMw/EU8XZsXsh0qTBUuqQ001A7qRsKfW8pOj+Kfz6lPqGj
	7fPfGHokKQEo4moMhtWErYcbPnVdx1o+3A4XI+EY/FMeJpr9EM3RDCVAYbaNYE25yaCEgxR/1Cf
	eYYBgEldL+l4GRFXrqjAii9X/aA2Y5AFfGDAsy5vNhk2M15Oqn+eMTuF3Xi1bPFohZBGj9QwmXt
	keiKUjT7Br1l/vd0M1H81GgZjtV7TqIIj6W1gdccv1BD+MR9hR4EQyFK8rwAsIV61LHD+NCB7gA
	/9yrwyJxMxrL2iCB4ttsMckSgAt/PL/6OvKNxukPQSH1CQOi8WIcEQBDyCNuxJNOA8ynEhywlzT
	jLvSY3uJ4owN8BxASSU8qjSqBEhcUpBDckcn2ggSvrV/aL6CoV3DSiMqadnSYTGwV5Ug8iT0u4X
	CclJUlJi2C1ubwx/3pFgQodVoG8/gHN8ggRdgMJg8gVrGrbwZLNZZHpp54FCCFB2fHGNmczYrFi
	gt1eMbh2A==
X-Google-Smtp-Source: AGHT+IF0vxc7fueQhP/zzHhG7TPxCfv+GZcM3X/oy0Bl6V7n+93lZi/orIHTptl6ePqE2hjsn/kFZw==
X-Received: by 2002:a05:690e:1404:b0:63f:a2e4:a3e7 with SMTP id 956f58d0204a3-643026316d1mr5289527d50.34.1763875200654;
        Sat, 22 Nov 2025 21:20:00 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7987fb02sm31856247b3.5.2025.11.22.21.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 21:19:59 -0800 (PST)
Date: Sat, 22 Nov 2025 21:19:48 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Deepanshu Kartikey <kartikey406@gmail.com>, baolin.wang@linux.alibaba.com, 
    david@redhat.com, muchun.song@linux.dev, osalvador@suse.de, 
    kraxel@redhat.com, airlied@redhat.com, jgg@ziepe.ca, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, vivek.kasireddy@intel.com, 
    syzbot+f64019ba229e3a5c411b@syzkaller.appspotmail.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/memfd: fix information leak in hugetlb folios
In-Reply-To: <a4319c8a-4e81-00de-f184-844348d85681@google.com>
Message-ID: <250c36cf-6334-4b82-dbd1-5618a24271da@google.com>
References: <20251112145034.2320452-1-kartikey406@gmail.com> <a4319c8a-4e81-00de-f184-844348d85681@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 22 Nov 2025, Hugh Dickins wrote:
> 
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> Sorry if you were all waiting on a Ack from me.  We're agreed that
> the comment above __folio_mark_uptodate() could be deleted, and that
> it would be much better if this code can be moved to a shared home
> in hugetlb later on; but for now it's more urgent to get this patch
> into hotfixes and on to Linus - please Andrew.

Ah, it is already there in mm-hotfixes-unstable, thanks;
sorry, I somehow just never saw the usual mm-commits mail.

Hugh

