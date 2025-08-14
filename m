Return-Path: <stable+bounces-169629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E8B27038
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED225E7280
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E28258CF7;
	Thu, 14 Aug 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gE2VdvHv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB033B665
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203609; cv=none; b=DIzXi0bzPgFVfawOLtdzmlwpPzFHwsUHokO/bMGLt/KW4yQxFBxIvPhK+936XwbfwNriR2sCRxqSGAwZkpjqC29eRkcCE9asvoaBFo4rF7SRUrsjhgSsrNRqWamrDh4iCzmQsK06pWnwpmBmnGHuWytwpnRnUDTpjhmoyFr4zn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203609; c=relaxed/simple;
	bh=PGdzB5rJ700rC0ITGcMtJysha0XSeIQKynmSnED3iJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OY+YZuEaWxHoblB1GciMKkEvSb56Tu8SIn5k2yEa4vbfdq5zmNNLwbJLbhWFbjRyaci5Gar+YQLAu2m3B7/3xrO9pUt6jxsaIKH1MXpX6+r1SCehB+3zwo23qJnFyz+t9BPrVU8x2eoOFfSmioDTB3PjuTTbAmlaaDyhekUBTJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gE2VdvHv; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-24457f44a29so14682585ad.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203604; x=1755808404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4Mtlz8IIE/uW1ZYBHp1ebjQe32lzjSLKURSfraUkLQ=;
        b=gE2VdvHvnHjESnTBZcmz6IKHJtNTTz2YtWgEnCSeNRXUDa04DyE/SXQXypjEQKy+Ka
         eUjrxhwb6grlwi0d6RM6WUBRPltPwJRoXZkVQu8jDu0s4eNWCE/MeQJXU4IDc6urG/zK
         P2mvtbVfFd7yzj2q4MG/5YCaJW/9rHcWTkPzFRNculpjYyAGHv2lzKEA9EH/Zk4O4poo
         tBZCHtVjjQbj/vl/ZckMehSN0taJ+Vs5IEjqMOmqfScB2RRVOJIbINq8wBYe5vHsxSVl
         LWWd41QWc3XWtXfvOETmp5lYJJO+aVJsU4DuvK1iwl6diML0vDOxq5Auoa2T+h/44DI3
         OL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203604; x=1755808404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B4Mtlz8IIE/uW1ZYBHp1ebjQe32lzjSLKURSfraUkLQ=;
        b=iG3vgcgFs/SD+5appiI7XXQPdGvW6VZJ7G1GyCOgtLySFHan8PRTgljvWBiNNXJhbn
         Vw/SgUyUlFslrUm/mWHpFYoMCjX6FPT9Y4EPl6pKfiuyjfaa+kDF06RZkGaoCq+jk4oe
         26C9PgUyYL3hIuDmDJ1BAmY0w15GKKP3TKgyBNt5nm4dJI7oifXWs4+Es7ikGnOrWr+N
         t15WdJGTY8Y5XvDjYN2uA9PPfv7hvoM4Qw+DS3uwoVZiCxdtCPSnI+wh8ojgS7iV87pS
         WTM0e/IHZGEPD9sf+fi7ow/YWK5N/WpxD8FBqwsGRGbMW/c7bcYSryh62zys5sdnHPz9
         IcEA==
X-Gm-Message-State: AOJu0Yw3tiWXMN5SAIoPIgxlAuBD27VXwEFn8VBbH5+3zR+pWWGbAMgq
	yoQcBih789U5BZDJTaxsrPTGsfU4cQvePSdhnwX4L9sseRSVHeUDMrYWOjbwIViwOjWSljRqoO9
	bsKEkPg==
X-Google-Smtp-Source: AGHT+IFTcmVMzV5ijoNUqzyfAoyRzV7nHDn7JYLtvC9IGN6hj/o6y1m+DgSv/kXDiMN2+aAkjoCbs39RmSI=
X-Received: from plbmo5.prod.google.com ([2002:a17:903:a85:b0:240:72c0:cc89])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:985:b0:234:f580:a11
 with SMTP id d9443c01a7336-244584e4479mr64191465ad.19.1755203603985; Thu, 14
 Aug 2025 13:33:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:33:22 -0700
In-Reply-To: <20250724181134.1457856-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062039-anger-volumes-9d75@gregkh> <20250724181134.1457856-1-sashal@kernel.org>
Message-ID: <aJ5IEp6DFSLzP5nl@google.com>
Subject: Re: [PATCH 5.15.y] KVM: VMX: Flush shadow VMCS on emergency reboot
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Chao Gao <chao.gao@intel.com>, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 24, 2025, Sasha Levin wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> [ Upstream commit a0ee1d5faff135e28810f29e0f06328c66f89852 ]
> 
> Ensure the shadow VMCS cache is evicted during an emergency reboot to
> prevent potential memory corruption if the cache is evicted after reboot.
> 
> This issue was identified through code inspection, as __loaded_vmcs_clear()
> flushes both the normal VMCS and the shadow VMCS.
> 
> Avoid checking the "launched" state during an emergency reboot, unlike the
> behavior in __loaded_vmcs_clear(). This is important because reboot NMIs
> can interfere with operations like copy_shadow_to_vmcs12(), where shadow
> VMCSes are loaded directly using VMPTRLD. In such cases, if NMIs occur
> right after the VMCS load, the shadow VMCSes will be active but the
> "launched" state may not be set.
> 
> Fixes: 16f5b9034b69 ("KVM: nVMX: Copy processor-specific shadow-vmcs to VMCS12")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Link: https://lore.kernel.org/r/20250324140849.2099723-1-chao.gao@intel.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ adjusted context ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

