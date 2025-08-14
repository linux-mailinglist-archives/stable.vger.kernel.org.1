Return-Path: <stable+bounces-169621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A557EB27027
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23C467BFB0E
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BD0259CBD;
	Thu, 14 Aug 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAbUgB1C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F35259C9A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203135; cv=none; b=scN6atEt6t2E+30Lhp/ddJeiCvPegwti58HWJP0n7xZ+xKVYVfCgrL52MwThtiTMxnsnH1YLHNAXZU9tgAT/ZCzq5YVeRZ/5TfYRX3oqimQFgj1PQMBcfYlVTVfRYWuN2wydXVuybKAgrEKpFpXDVq2yODyNC+1yhVcGopYc9w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203135; c=relaxed/simple;
	bh=btRuK0OjDfr6KPijoeCQ8c4lGZWLBPYmMCkWGMtR+oQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IDnPrnMtV1wLYran1WBQxHxgGXei0+dhJleIkKaYrQsK8UwDDvQAOu93Acq8ExatSWTFZRH5v9oJBwYdkU3dJVakXaehAAdPqeCzMha6c8h7lmaikB3gsxfH0Jzgu4VALZSkuK4/eGSNz3tixQSBfH2A2D+z+0zqUj5M+clgyBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mAbUgB1C; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24458274406so26954425ad.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203134; x=1755807934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTrMhBuO9TgAl6EGBA33RiEPTzWN9EC7uvJKmJoNuUM=;
        b=mAbUgB1CRLYOGzhmrW3QXsGRKQ1zmXHKvDQYUmKGkq6kiQIxmAFKGQPeaB2KQWbfnl
         kUbKEuFec9HDR0T16+YgvUscgINr21emoMQJNE9Y7t1nZ2yBC5Ww3+HHuZ3T+Fk93AB5
         P0fcMvVOsi08XfcHXF4zbAWK/vaKw8TixhjVidYhk3dw16u6RdRvZpNkKnvFqI6lc8nq
         wUFsenXw33GOPm8V0aUE3HD/t5K2ErE9+mb6NT0jO507jwbdoV8zsE5TaspCLNVWRC/3
         7+ctKSz+bUL6vuNr9Uvxj2eT422fv1XfLspnqHI0NT3pDwhpzDJTm5j7RctmOjK07nmr
         addg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203134; x=1755807934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MTrMhBuO9TgAl6EGBA33RiEPTzWN9EC7uvJKmJoNuUM=;
        b=B6eraluhJBuFOaOBlslEO4wW+WLqRg8eu9fK5hjxqUW76juLvX7YO/u16OxnR99XLb
         LQIrnptCnENDjvgS5+2T1NBB4Q6N4RAMp9ERPPGbOcdTR2hAe6D1nyuPTlw/rMQzGIML
         8ydtCbU9KGGchfZNNuns1fnZ+VzU36KkC+ejzSR/6/oVsDEXT7686sPSQkp1A6lgjBjx
         b+KxVaeX2d3knmQtS9TrSH3i3PO/wibI+gpY8DBUbOkuFA+7Qni6+8+iOMyVTIRqIYXj
         NyKhiJOSv9f4JRHLCa0fWicij7Z4au9CaDMXGvtH7oghh1azhc0tasaJuTBlfFgnewdU
         xmOA==
X-Gm-Message-State: AOJu0Ywh/MZyWMG+zyPM7HZtTnDwdDe2i5tkkqNDL1J5ukUvy4VoRxwp
	45gSN1zkF5zYEZjlPutRWBS/IljV2sQ2lvFFZNdgoPCp3SLFBOOVxVeqSGWvH8p16FIcELpQbhb
	JbYcmlg==
X-Google-Smtp-Source: AGHT+IGzkmhgWa28hmQQxe+zC3SycYO0BgiWcXfU5LMhFn3fiktK+ARtK8Ekw7y92A0BPliF8mX2PehrAqs=
X-Received: from pjbqx15.prod.google.com ([2002:a17:90b:3e4f:b0:31f:d4f:b20d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b4c:b0:242:e38c:89db
 with SMTP id d9443c01a7336-244586c46cfmr70931125ad.35.1755203133769; Thu, 14
 Aug 2025 13:25:33 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:25:32 -0700
In-Reply-To: <20250724170725.1404455-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062034-chastise-wrecking-9a12@gregkh> <20250724170725.1404455-1-sashal@kernel.org>
 <20250724170725.1404455-2-sashal@kernel.org>
Message-ID: <aJ5GPOjf24EW1RPB@google.com>
Subject: Re: [PATCH 6.1.y 2/3] x86/reboot: KVM: Handle VMXOFF in KVM's reboot callback
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 24, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 119b5cb4ffd0166f3e98e9ee042f5046f7744f28 ]
> 
> Use KVM VMX's reboot/crash callback to do VMXOFF in an emergency instead
> of manually and blindly doing VMXOFF.  There's no need to attempt VMXOFF
> if a hypervisor, i.e. KVM, isn't loaded/active, i.e. if the CPU can't
> possibly be post-VMXON.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Link: https://lore.kernel.org/r/20230721201859.2307736-4-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: a0ee1d5faff1 ("KVM: VMX: Flush shadow VMCS on emergency reboot")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

