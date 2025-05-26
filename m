Return-Path: <stable+bounces-146391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E971AC4452
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 22:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13E9189B07C
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 20:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5282405F8;
	Mon, 26 May 2025 20:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9DNDbVK"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E577123ED75;
	Mon, 26 May 2025 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290525; cv=none; b=jshFt4FrrqHkIj1N9wxkLc5SCsX8THSTV8aVJcCXN3Jek9f+g653uAhExbhndmhhwTe/DEtE8cC4vwH/JmMxulPZdomcrZNVF/pWhLye3YUDiyURGGF2ae1R4aA3YDxW6SGFYH0/9QAtGKbycRC6Zz9juYWgfOslg4YYFFzI+5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290525; c=relaxed/simple;
	bh=ohtRGyK05Q4++k9YprJKtDiINTrJ38VxHWprFUmxbjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQ8zattVoaORx5stu95k3hvG1U2UbF/tOj0RQpIhGVe4Vk6Xu5p/y1Gneiu6fypvWK4MypheO62JUpBF/w37rdXe0zWna6CybbUyJBcsDwvb5zBrw4aTe439tIkutQ8b+T0Vl8Gpgm3rZpc+5M8zYVRe+I8rvHf570SXcH16Agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9DNDbVK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-54b10594812so3501928e87.1;
        Mon, 26 May 2025 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748290522; x=1748895322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iz3Z0SmA3CH68uW+s2njhq2Ak0+uNQJ+8t0g3Yz/k4k=;
        b=a9DNDbVKGQBqdaEjKgtw9YCJBVzTBuU7djkQ4IVB6D3AxIVpmGDFReDJw//cik0/US
         gkeAMRanuNX0cPpR6WYvMZVKrcV3SO+3U0Q/4aYSvJTqYx5kW+AbRPOCJeScvTygRw7j
         NxyO2f/9u2CkH6KAmoxnLzd/kljAm+zyWPdZ7a7U/TfY3TJaCkZI40mMEZOUnuJ7vaKJ
         0eFy7hhAnwje2gxLUDnU4/bQvPMfCd4VHPe3m9rl7rX4p4Fe6NhSbO8FSvx2vmGs/kYG
         g5uDjBjMxKgDVc4uHZUAp0ovxOSDAZTF6ATTCV8rzWh/XoCwhd5ZDkweV63wyhpQyiDB
         K1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748290522; x=1748895322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz3Z0SmA3CH68uW+s2njhq2Ak0+uNQJ+8t0g3Yz/k4k=;
        b=Y4hmwNrAa2/9DiK82PGmP049PBXeZ/PY7G0/l5mf9/ud41EhPPIEm/5rz90qJlE7O5
         MgdpohQaCVIN2TvsDWRz6vU5fS7fmWZNYqn/IYVmcIw+HK9DmeBp+e4yo5LzuqAcbkLr
         WcEWUsFg105fUJjBjIU5oKvsC/oYyUC7NhNr2O9udLAndx0ATZKUdSaSYMiamgOj0+TP
         o4Q2p0lU3Ifh13sPnp9A3dfcgATzkkgJXvgNjbaTgTR/3ssaZxqaK6nMtMx0XqlwJop2
         tcV/3flfw5QuKuebVDkKABPLfdof7n+MsK8eq9DnvmAiQdtpQCmjhQAYrxA2IHZjvR8E
         K6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUisb2iFKypYmQz25ZW01AuDR9EmRC6qvs7IiLiom/S0oPvm+jnqSxNmzpPCTyXiRvD8HKQN7U7@vger.kernel.org, AJvYcCUnRZ2AeQgp3bSNwVshFZt73P8PSuDKXHRRn8YuzxLnvBD2TsAXcwVv9suy44mtLaOg1TjyV30E26zmeYk=@vger.kernel.org, AJvYcCWy5Nq5aiNUZbdWNaiSCJbnHoy3bFIuT2UWASG3OXD+m3+eM+4ka9P1Gclb7Vmtzon4WxSrAtgm@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXT6QbhM6ez3PAjR87Er9IlAIYOpMxUJQMAazqH+pxNyMfF7w
	bYAqBfa0BGrLx6nRTWl+4IW5ipcUj9+ad4NaQSLymRd7MdXU4bXvxi3b
X-Gm-Gg: ASbGncukH/b8XVoYXbafd6/HNRG6zhC8jRANoouqrXvBkP69ogHAgh9lgUj1hNifEn8
	SueFimg3i1PQFV8iNqkuOsfbfr9eIC2FqqjnL1C5gIcLU9nvZA6X5MHiRk3aZI+jU6RxxtdzZ1K
	Lpd2S0s2aR5lGUMgqfw1V8+JARdwRMkU/5+CntNcK+pfh+oSwtty9zkI7+CmPUT/bOeFR+axiSd
	MRTKWsgyGKoX3sHrf/r0ZIHRryLCqHaVKl5XewuEAeiZ/3rxgfN1W9RZ4DAbIuib05BflbkpAOu
	TSwrwGRcPO5ibvLHfj49KJGLvTgM7BLeFLtbpAdDWYnbcICLkRwCWpMpTRNuJnvlhg==
X-Google-Smtp-Source: AGHT+IGycTsl0j5+lha/9zLWk2PFmXfqE+GNYPHs8FfhaZmKI2qkSFlQux6x1txIjajzO9kiHd4gIQ==
X-Received: by 2002:a05:6512:b9a:b0:549:6759:3979 with SMTP id 2adb3069b0e04-5521c7ade8fmr3277731e87.18.1748290521529;
        Mon, 26 May 2025 13:15:21 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5532642ee85sm163125e87.138.2025.05.26.13.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 13:15:21 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 54QKFHOQ030107;
	Mon, 26 May 2025 23:15:18 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 54QKFF40030106;
	Mon, 26 May 2025 23:15:15 +0300
Date: Mon, 26 May 2025 23:15:14 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Jerry C Chen/WYHQ/Wiwynn <Jerry_C_Chen@wiwynn.com>
Cc: "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1] net/ncsi: fix buffer overflow in getting version id
Message-ID: <aDTL0uWIgLRgyu6s@home.paul.comp>
References: <20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com>
 <aCWuCPsm+G5EBOt/@home.paul.comp>
 <SEZPR04MB685354203C242413D1EBE96CB098A@SEZPR04MB6853.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR04MB685354203C242413D1EBE96CB098A@SEZPR04MB6853.apcprd04.prod.outlook.com>

Hi Jerry,

On Fri, May 23, 2025 at 07:32:26AM +0000, Jerry C Chen/WYHQ/Wiwynn wrote:
> Sorry for late replay, it takes some effort to change company policy of the proprietary.

I can imagine! However it's not necessary to send patches from
corporate e-mail address via the corporate mail server, you can just
send from your own personal account with the appropriate From:
specification to attribute it to your corporate address[0].

> For the questions:

Please consider just using standard inline method of replying in the
future, letting your MUA quote the original message for context
properly.

> 1. What upstream tree did you intend it for and why?
>  - Linux mainline
>   We are developing openBMC with kernel-6.6.
>   For submitting patch to kernel-6.6 stable tree, it should exist in mainline first.
>   Reference: https://github.com/openbmc/linux/commits/dev-6.6/

Indeed, and the process of submitting to mainline implies that for
each subsystem there's a tree which subsystem maintainer(s) use for
the integration and which is later offered as a the pull request for
the upcoming version, usually it's called {subsystem}-next (also such
trees get tested together being merged into linux-next regularly). I
guess in this case you should make sure your patch applies to net-next
(and makes sense there). Neither the current submission[1] nor the
previous one[2] were applicable (see "netdev/tree_selection success
Guessing tree name failed - patch did not apply" and indeed I tried to
"git am" it manually to what was "net-next" back then and it failed.

> 2. Have you seen such cards in the wild? It wouldn't harm mentioning
> specific examples in the commit message to probably help people
> searching for problems specific to them later. You can also consider
> adding Fixes: and Cc: stable tags if this bugfix solves a real issue
> and should be backported to stable kernels.
>  - This NIC is developed by META terminus team and the problematic string is:
>  The channel Version Str : 24.12.08-000
>  I will update it to commit message later.

I see, thank you. Sigh, this 12 characters limit doesn't seem to make
much sense, too restrictive to fit a useful part of "git describe
--tags" even, but it is what it is...

[0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#from-line
[1] https://patchwork.kernel.org/project/netdevbpf/patch/20250515083448.3511588-1-Jerry_C_Chen@wiwynn.com/
[2] https://patchwork.kernel.org/project/netdevbpf/patch/20250227055044.3878374-1-Jerry_C_Chen@wiwynn.com/

