Return-Path: <stable+bounces-238725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOTfMzzt5WnxpAEAu9opvQ
	(envelope-from <stable+bounces-238725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:09:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B966428A80
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D08943049729
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A436A38A738;
	Mon, 20 Apr 2026 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEQkMYQW"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA62388373
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 09:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675941; cv=pass; b=RZIrt2ZZHnf/IFOcDJEX2Y9UITViUmUrauHYlDzUPAdYMz4NEvVumAdh6s2ypdap0Dv99GuWsQvDmKZmFIvkCLmFPE0N5M6Ml/WA7xW6LesPOOIpYQxAWGDvEVXX+KLX7eZVr9IAmMbmJGK48dZhJhfOcEpzaqboEJqcRKg04Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675941; c=relaxed/simple;
	bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JoiQdxBTHEZ/opNLCrjh0DMFtEWLNvP4HmPhQTuUPJj5Lqkdp6StABlBDZWFZyeONfu/23kcrO8IEwGvT8yv6iKR1tuxL+h0xS0TLc1xtOpbOq2aHozBWFVbh/6/oAOxLTnq+i3Cop7fWuOvkTR1wide+1Jrh0E43E2EN9Mb6R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEQkMYQW; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65005a8840dso2412359d50.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 02:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776675939; cv=none;
        d=google.com; s=arc-20240605;
        b=Xck7iz2LagdwwvSwJVlg5FpODqndhAl+EQnM23QpyBT6Nlp3ZHfCIqfjwSAvoWDyU2
         yvtBINwX/Bkrtc1C1+YSj9L4n4yEPVqRfomdKtDt1fOAnSQ3PQ6s6Pn6RZLYDHMTuGHD
         s/x+RRbPr0ATjf82kLT00HRD3Ldane7wWLZAYKjUO9EGOObUuljaAmAALpxEk0vlbueU
         2C4c6gCV/nsyJeOSZi+0Sgkc+6yqjAOTXmuGFGixNPY60ihI0G2H7lhmIrnrcUB//bVm
         x/Uu7lPGbGGsf/gKvfKr09LAj8ACC9aJwaQaZEVPpuMHBMwBPYLyczJEWrlhwBuk8lfX
         dYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
        fh=/iyA2p4ysrBZSty/753qmKrKKDUQDz/Pc3zBG4TxSss=;
        b=IsjoJ/2OHMjAwrPU5Gi0bhJY/6wsBbztgGzzd+/6v2ImRc+3Xik+O/ZC6g/viGBpHX
         HyJFXrHgp3q7YpJTT1YDngtygQVjRWJ0jGm2WqCLsqcAVnpTHkRtSDg2Vqb4HPKADD8Y
         oTDH4hv0BUDV36ds1DiyXivDIiopa8AUszKA/vJ0hxe8oSBPDMdvllLkBWo1MvpZOtk9
         hqEVvVoRya1L+hB8jCH3ax+qv92e2IWP5je1/Z1O4aFE/0wy9j2n/11cWF9nSztGUaQc
         N+Jpm4kV63ddfb2AafpOhE9kdWJrHxnZxJcoTeRfGn1y/v/GYGFuTdFCLO+lUkDSHLk2
         f6pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776675939; x=1777280739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
        b=FEQkMYQW5BYd29unTrxxNz/A47+4x5XcJGrTO7SYI64ToOKLClrnmu7ujGqXxH84Wq
         SRLpRsZyRyEfWWgFVMQqcB1VIPNgpAcZ37pIeG2LVe8GlInb8XLpeY4gNs0BViv4E0Yi
         7iVxchv/yvYCBn7pFknVkrKvfkxItPDR6IfJ+SKk4a3QW66CuExXcNPO7JZRCYx+hZLr
         6Lyou/YMLPOzOfD9hGgIJ3jzsMTVK2q2V2Qh7wqT/k/hbh/LglLu/V/hGYpCXTD0dE2B
         15ti88cLGF5VhJDlRK8V6KerBVOFVoKhKLPrpy6+i8da7vcnGs8xRwvj5yvuHl1NpLGX
         UtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776675939; x=1777280739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5egZAP/oNduQWeGQjV2YZI+IrIA6g6E/EegiGcc0lT0=;
        b=mYWZqeUJV6mLunxIRfXiduh5wwwzTT69N6jC0TfS9DPLk+2XnZ8gTk96gx7MCX2Izy
         rQ3eXmBYxxIOXjKTPOI/sSSGSSHCwZCi7kbvCOYWEoL1pkg652AB2yA+vJJbXqU/2il4
         3l2OVp2eVjWCa9qiitva8hLrYtrGTmf3KML+A/hoUmm04MbwHVVd8yYnfCaQj5SYDsHJ
         ILGweO/lXx9U8GiudcMRk9k8BiifIY0IITiV3zH36oUdQasIUxzicUb8nvAYXSCJAviA
         1dB5rldb/twgpZ44GoKUqTY+Ndkfx8jTvw8baszt8yXdEMZLf8/XzSojrFMugZE1H9+G
         zO6w==
X-Forwarded-Encrypted: i=1; AFNElJ/Sg/ho6d0xuEkplfyoFj4WWZkf+xtIeiOwE1zEZl3bg+++mwNFKxqX3l0Aa8kHUtlcD5EQ9zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEM9kMDiIi/K0lxh4iOmdOnXaXzTxAEezRpWVtEd9Yc/e9/ar
	nmIRSJ5yjPiENrJPom3+SYPZfSIRMnsItVLPS4YDeL+vTznLRSsJrWk8QanUCWat7XPjzucnUWU
	DrbGSs+2WFpvkppZGAXNBAw8zfsWdSQo=
X-Gm-Gg: AeBDievjHfTba2EMWjB9M7ldZhXnV8iFYKJRRYXZxGsuc9JDjbyJIzCFWmhwasikm1s
	oucRdyzXVi35rMXPf8ER9n4dIf5WtHK5xJjriWK2+HS9sfgA8sS8LSrlTMe/a9mXnE+WB6ZgnTs
	d9bfUPgF408ylIAVSa28YZnOAEO0skoiT9MaSXY0vJcHanMXliYlOsKc6/aBgKu257eneW7UD0n
	qs730nm1eMhmMO6RaZ9sV4YuQhBmQS3VWbL6TPz9qiBj/mKSkkOF+8dTK4aMWBC9SnsAqQI/AXr
	U9bcS9Od/8+FIjQCGPo5kCPBLg3ACso=
X-Received: by 2002:a05:690e:e8b:b0:654:1261:8b57 with SMTP id
 956f58d0204a3-654126195a1mr7903049d50.6.1776675939331; Mon, 20 Apr 2026
 02:05:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413141328.2954939-1-lgs201920130244@gmail.com> <q6Ni253ETr-zY8OZRWnm4g@nvidia.com>
In-Reply-To: <q6Ni253ETr-zY8OZRWnm4g@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 20 Apr 2026 17:05:28 +0800
X-Gm-Features: AQROBzCv0ouH9dGitvJnxiCUbB4xuHu4ZEpCCDhZWL301SP8_3uH_VxP4dq4Cy8
Message-ID: <CANUHTR9khFiwfyAWFKBuzM5opBRLtuOPTWNZyuaoP_Rxmxk+1g@mail.gmail.com>
Subject: Re: [PATCH v2] gpu: host1x: Fix device reference leak in device_add()
 error path
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Vamsee Vardhan Thummala <vthummala@nvidia.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238725-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ffwll.ch,nvidia.com,vger.kernel.org,lists.freedesktop.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B966428A80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mikko,

Thanks for reviewing.

On Mon, 20 Apr 2026 at 15:19, Mikko Perttunen <mperttunen@nvidia.com> wrote:
>
> Unrelated ..
>
Sorry about the unrelated change in drivers/firmware/edd.c. It was
included by mistake due to my carelessness when doing git add.

> This isn't a leak -- if device_add fails, the device is still on the
> device list, though in a "stuck" state, and will get cleaned up through
> host1x_device_del.
>
You're right. I misunderstood this path: if device_add() fails here,
the device remains on host1x->devices and can still be cleaned up
later via host1x_device_del(), so this is not a real leak.

I'll drop this host1x change.

Best regards,
Guangshuo

