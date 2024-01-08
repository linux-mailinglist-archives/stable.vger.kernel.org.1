Return-Path: <stable+bounces-9976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41783826B90
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93501F2228A
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 10:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC34E13AEE;
	Mon,  8 Jan 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3azg4+Vm"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F113ADD
	for <stable@vger.kernel.org>; Mon,  8 Jan 2024 10:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-336755f1688so1624990f8f.0
        for <stable@vger.kernel.org>; Mon, 08 Jan 2024 02:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704709751; x=1705314551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kCXHaEQUi0ZUwYtkv2nkrbIUf7S+GGCSAoSggZuV//I=;
        b=3azg4+VmmIflWBrQN37O7xeoh7wo9XXEcNs2lWpYO547Sr/hn09U1mUtmRs3nLnz/S
         r7bllc/BnBWpmHYM14NNLcym76ZTUSJwi4YWS6d06i4gqimtu5VsD5yRPK5AJN6ngu3/
         +Ef1HNulFsUk2gW4R28Iwwy2qSnUiyN1rLxSXnCOx+8G2WnVomkdcjf5LoeZZ7J1NOT5
         UvaRI4CnIiqaFqahsCBzWCwdaoWv7U5B2CoYQrppCmNHEUmpxKlsMXes6Gxc79ACD1kS
         A4/k7L/ENLIzsKRna1RG/X5WTpIBBx8hkO1ldCM5ckMzvlYJ1DGbnred59yH/Or/Ee3c
         ERhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704709751; x=1705314551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCXHaEQUi0ZUwYtkv2nkrbIUf7S+GGCSAoSggZuV//I=;
        b=ZjbSaevebnh444ze3WhBr9/t7QEuIzoDKo5se+S7OjRqrWg3rv1h5UVYbHn1xNV6GS
         IWgSwIvxiQ4slIfQ3bfBGp04LkBRBTfS/UVSR9xybT02IO5uuJEXO0O9sb2PSL+FAX1v
         +2k98fg/XmsDFq4PprOmq7Ifa6rEPRFG8J+k1BX2dF+y1LRACfD6rmp05/TleQai2yhS
         xoUSpsup32u8rmxyGc8ydr40A2LyEP0jKMCvUfxlzcNlLGKrgmymmMOn0CaBuc/v3YqY
         0XNwR0Z8RZDqGuqI56e57nWtR24TdcvnDDYblnvIMwV+SnazUBma/soRNop3Vrxx1JPS
         jaWg==
X-Gm-Message-State: AOJu0YyuKTTfInH5017EjsPqRs/7OfZrdyDq2ClEis92MFa2XhNjuoOE
	GmLk2iL4yPN3dD9KyL0ovTQH3gh8h2lrPA==
X-Google-Smtp-Source: AGHT+IGnOOQibmQuoA4v9IBTcePsKD9E6oPQOILhrmPo+lqiDBVQaa0TRXA4yibbMA4jKMtY3U/JDQ==
X-Received: by 2002:a7b:cb8d:0:b0:40e:4272:9f32 with SMTP id m13-20020a7bcb8d000000b0040e42729f32mr1280219wmi.49.1704709750789;
        Mon, 08 Jan 2024 02:29:10 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r3-20020a05600c458300b0040d91912f2csm10544908wmo.1.2024.01.08.02.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:29:10 -0800 (PST)
Date: Mon, 8 Jan 2024 11:29:08 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] Revert "net: rtnetlink: Enslave device before
 bringing it up"
Message-ID: <ZZvOdJ1eFodYHzjV@nanopsycho>
References: <20240108094103.2001224-1-nicolas.dichtel@6wind.com>
 <20240108094103.2001224-2-nicolas.dichtel@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108094103.2001224-2-nicolas.dichtel@6wind.com>

Mon, Jan 08, 2024 at 10:41:02AM CET, nicolas.dichtel@6wind.com wrote:
>This reverts commit a4abfa627c3865c37e036bccb681619a50d3d93c.
>
>The patch broke:
>> ip link set dummy0 up
>> ip link set dummy0 master bond0 down
>
>This last command is useful to be able to enslave an interface with only
>one netlink message.
>
>After discussion, there is no good reason to support:
>> ip link set dummy0 down
>> ip link set dummy0 master bond0 up
>because the bond interface already set the slave up when it is up.
>
>Cc: stable@vger.kernel.org
>Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
>Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

