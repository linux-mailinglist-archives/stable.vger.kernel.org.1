Return-Path: <stable+bounces-108022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDF9A061CC
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12471886C07
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 16:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69201FF5EF;
	Wed,  8 Jan 2025 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDn1HA3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AB1FECB3
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736353568; cv=none; b=Dq0jvxz4mS1n+qWfPHw5SQyPurgQY9Qo5/isumqZr/Dud5m42ptoOHtnd4+ZkVP5ONJmbVju3acCXs9N/BIBSKIw+lif1adyRi4lvCTAfrs+CJDwRb8ndyWwoLnSXfRDRJ6vqtmMpMIGQYwfKF83fRUNjOuTVRbMBXY1jq8/9TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736353568; c=relaxed/simple;
	bh=Vrpja7gLp8wClJr7WGS7vASHEC8+FJW4qOfjHyBB1O0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvTOUcksP1LFPvj6igDRbeiTywl+F7psE/rNnN1uOJ6CpS3Wi6rfNrU3zjp7qdAGhQjfBik1SbdymEt1f7hcQgf787/ORasSkEZ3QoN3jhxiSnVbpf/RoTZnt6uKnu7nosiO/9WTIl058/LGiKlUDYAZL/QFEvgULl2Xr7SSBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDn1HA3z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so29918125a12.0
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 08:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736353565; x=1736958365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vrpja7gLp8wClJr7WGS7vASHEC8+FJW4qOfjHyBB1O0=;
        b=tDn1HA3zNZRjj9WMo8acx1ez8tIfQvTIbLvJjF70xmYxxxwwOOvvl5YYDDDgO5sxLv
         eRTAZFiDVw9Cz4kHPaYIKFE76TaK5iEqPGWXJKRSEwgEdRATaLzdKWsmMt+z+04sgSW0
         2aRfWEni+MTBDtzEJH6uSg2stfecoJMGNsC9ffCYDRKl3/1/GaMyfUHT8z8ACMarzMfA
         B8RMJjlQxkES1CCLGjGO2pFHnHHt7lhO5oDIVzZRIireZ1RbxfzV3pjsITidX5TTx3nV
         WRrDhjlKMbIiuDj6pobx0+w0oB25FTVXzZ1CUhPMv/v+Zz5ieH19kFfnWHaIA86oL/Kg
         04XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736353565; x=1736958365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vrpja7gLp8wClJr7WGS7vASHEC8+FJW4qOfjHyBB1O0=;
        b=t7lqxl+Gx6Z+DBOgzwqEHS+Ja9sYBXE3uLQ2FZuVsgn7FsAgnUu01y1hURRXfpsW3R
         qUioG/irTiznPNV5zq1YBpZmVPTEVutx6Mla421Q/2XvOIVgY5O9XyNWzImkOPBXVUzK
         ShhMNv0t+wM1UjlOkvOqEHov3VqD0YA/fbR6Pft3a0nVwVqWM6xXTWrft+ohl518YcaL
         X8h4JuvutVoNPlgw8Bpi70BOu/LOZ3m33nTi1YoVOEb/5aPSXqnaGoNdIfjb/K+VyHH9
         qdKYG0MG/vqJ+0GibXNLCb6xjs75R3+ytniN6+rd03s9bmpX7Lq/KUE9uQ9AaL8VH6yp
         lsYw==
X-Forwarded-Encrypted: i=1; AJvYcCXfIS99eKIPtKRbl1g8/tbprawg6WLWoGMRnudnyrNUU0aXCuSi5rSGPYeqUw72Vmi6WT+2568=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDXvpQoND7Dyl2OiAAA1WoylkV7DgG5OoH8G6qsSJ6VZ3qtJH8
	y+lYOpYxKSCtaLKNsP2EMHG2eyg+y8OgFWkoNxpY+7dsxZCzmQDblL0X96Gj4UvmiEZZIOox5UA
	d8TB5pbyV+NTzpBDH7dwaX/8lXRh5KjHmAPA7
X-Gm-Gg: ASbGncuV8vp8eX1Lt8FdVTFjB3jjzcIIW95Kq1OYBK5mSvBhe/hZxqdeTRL7/LAgf9/
	cNfxrPQL33dpL1q6+7VnGdtsrPTCCzjYTzAySBao=
X-Google-Smtp-Source: AGHT+IGeGF4vh8DxTEjN7tESfGNU41x6ofqkC+fyq/M8TSO5+w5+umwB8ua4y8BitM97QdgJt25Wf0pnzPSZGjKvuUs=
X-Received: by 2002:a05:6402:280e:b0:5d3:e9fd:9a15 with SMTP id
 4fb4d7f45d1cf-5d972e6f473mr3265028a12.32.1736353565288; Wed, 08 Jan 2025
 08:26:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org> <20250108-net-sysctl-current-nsproxy-v1-1-5df34b2083e8@kernel.org>
In-Reply-To: <20250108-net-sysctl-current-nsproxy-v1-1-5df34b2083e8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Jan 2025 17:25:54 +0100
X-Gm-Features: AbW1kvaWCFc1GR9QJN1q6qk-A8PrW0sTYcPB5wSHtxPxsBwUlmaJfdU5wH_8KII
Message-ID: <CANn89iLPDTRYEGO0C=gtbHnM=OUPhfdK3RoLzzWMOMLEgmT0Tw@mail.gmail.com>
Subject: Re: [PATCH net 1/9] mptcp: sysctl: avail sched: remove write access
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Gregory Detal <gregory.detal@gmail.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, 
	wangweidong <wangweidong1@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Vlad Yasevich <vyasevic@redhat.com>, Allison Henderson <allison.henderson@oracle.com>, 
	Sowmini Varadhan <sowmini.varadhan@oracle.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Joel Granados <joel.granados@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 4:35=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> 'net.mptcp.available_schedulers' sysctl knob is there to list available
> schedulers, not to modify this list.
>
> There are then no reasons to give write access to it.
>
> Nothing would have been written anyway, but no errors would have been
> returned, which is unexpected.
>
> Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

