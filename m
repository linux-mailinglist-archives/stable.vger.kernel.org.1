Return-Path: <stable+bounces-10348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC05827D66
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 04:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D76284A91
	for <lists+stable@lfdr.de>; Tue,  9 Jan 2024 03:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2D03FFF;
	Tue,  9 Jan 2024 03:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsoj7S3f"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95168259D;
	Tue,  9 Jan 2024 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dddfdc3244so383145a34.1;
        Mon, 08 Jan 2024 19:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704771523; x=1705376323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3eFkTrLnCWs6jCP3r5JBqrIU5a6chwk8A4GmgjiNGkM=;
        b=Fsoj7S3fXIIYoP7aV5BciboXHSgsx36CvAZAO0dbpbVWEvxriRwg4eGA0gzB+TiFNo
         XdzUBzhRcZVvRlZp8WkbOCBgA/hDQC5Rr9qUK8M/VFu3Uf+CqRtTjouu+PFbR0v5tEh6
         WonztObOsg9Ynw/Cb5KJOFjEw5/732cku576KvjI3GR7Qkb/8fZnP2UxtlfUBO8IM8nr
         JX+91AINrOrHZP+UQ1KpmW636nyhHWkQ+Fn8zFiimyUY45dGH8rfauK2ccIRMaX5doRt
         uO52pBT0tUDD+OIs9/vYpcycqXSEp59aY48/tp+bcw2Zenzneio1d6TSxPJSoWB5uaqS
         DbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704771523; x=1705376323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eFkTrLnCWs6jCP3r5JBqrIU5a6chwk8A4GmgjiNGkM=;
        b=gVHU0bceh0cDf2nT1dyRZAxyH2H9FC95hEVHfG3H/g7MHSRhVKEnSC5ZZ69snf+HiP
         i24IovlRGBajcFmwyS+8RSsg3d/3i7pwbAXSX3/EFqyVNK+MY+Ah993T0RXh6ojeqJO5
         Rfa74m/kN86AWYo1w30omEXka+qAvsSXyyA/ZIlJZcUKqZjsxfhxzoKixP3UeZFnrNSp
         TXacqWGDYwUjDokK7CwlDwfViLx0cd7jECEVwEiNPGfaVcPMklrUSD/J3q1SAebncfvP
         dLMUpCZBerfznsi5GKSf1VG8UeQjI/gL5oZrg8fcGUvUbAR3NMyEQ47OBngBW3fyHf+s
         zkGQ==
X-Gm-Message-State: AOJu0YwZz62qPzgrqZICYShD+6YuMPvxAtHNoieKwxXiWOT02eXgHn69
	xMuMWGPLHLGEiBb+1FMbidQ=
X-Google-Smtp-Source: AGHT+IHXJ35OjLmnPpomOFhZywO5zO0pa2axPOWoL5L+gGdnUSQ5TPfkSCVgNSE5/IVKSceocQESsg==
X-Received: by 2002:a05:6830:1157:b0:6dd:e4d4:bd8f with SMTP id x23-20020a056830115700b006dde4d4bd8fmr162942otq.2.1704771523527;
        Mon, 08 Jan 2024 19:38:43 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gx17-20020a056a001e1100b006d9b2682c91sm589339pfb.113.2024.01.08.19.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 19:38:42 -0800 (PST)
Date: Tue, 9 Jan 2024 11:38:37 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4 1/2] Revert "net: rtnetlink: Enslave device before
 bringing it up"
Message-ID: <ZZy_vX_uJgryR-Ti@Laptop-X1>
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

On Mon, Jan 08, 2024 at 10:41:02AM +0100, Nicolas Dichtel wrote:
> This reverts commit a4abfa627c3865c37e036bccb681619a50d3d93c.
> 
> The patch broke:
> > ip link set dummy0 up
> > ip link set dummy0 master bond0 down
> 
> This last command is useful to be able to enslave an interface with only
> one netlink message.
> 
> After discussion, there is no good reason to support:
> > ip link set dummy0 down
> > ip link set dummy0 master bond0 up
> because the bond interface already set the slave up when it is up.
> 
> Cc: stable@vger.kernel.org
> Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

