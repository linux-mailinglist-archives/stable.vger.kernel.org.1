Return-Path: <stable+bounces-187711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461BDBEBE2F
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 00:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667AD3A47E1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA432BD02A;
	Fri, 17 Oct 2025 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JmBmgE1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F9925F984
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 22:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760739039; cv=none; b=hUagU6IJx0i4/VpJWmpoy/HVD+6RhjYFCzAA2yzBOxIM/C4Xcx2lV9Ujs2ERiiXC4HClQfJuhorWfGazkCH/XY7/CsWZCooSebCEvTblhr3wqdL5WMI7iM1bm6U6FHYYpNbSR25SM6wKORAftiengxxJj7xTmiYLLN+/+z2gvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760739039; c=relaxed/simple;
	bh=GbPbyxxyLbLbdep7JZtiJzuWrmbM3e9Bt5Q+I2E4tdY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0DIEvn1HnWsZeW8BbCDHkQSws4FaKfWH2EzXaN8y98qGAX/OnP3vv9N5QZtcXlbrIphk6IaJVlQQW7lW1r2FJb1TwFVIuVd1f3NjDQzRF2Lyk1v5gUFVw/uVDVGbgmnG+LEVebiZ+zwnTh697hWEMDIh7QLPNFYDIqBxeXG5KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JmBmgE1D; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-332560b7171so3163145a91.0
        for <stable@vger.kernel.org>; Fri, 17 Oct 2025 15:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760739037; x=1761343837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7wmwesGlu+O0fmIaIks3V1EkOzuHf4RfXae0tfu7YF8=;
        b=JmBmgE1D34veYG+FR0Z/GohWqpecjZRJpobrGsvz0h3SRc5Rv6vXrKmwySVyTFaAEE
         PYQi4hbcOtTBMRVloRlmRmsjO1RK8b+Cl/RQpDz7sWLGdh4+Mj+ZUW9d33yFZBxFkVgn
         l8pRR+0bICygMZADd3W0WFlwm2sDjT/fNbuFRqkm3hLdteb2LXQujGcVNpAnoejE1gZa
         trBRuemumxYxlStccNma54q4fiEvRLyVdajY6BmffnaB1U+ryyNsPZupV7KbQUwXR1ET
         +aJCzxp/3MwZJo0UyUUhHoMZjv23wyqfCA3m+xXFb2fPG5jwiu7atx9P8wDcp8XzNQxC
         C0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760739037; x=1761343837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7wmwesGlu+O0fmIaIks3V1EkOzuHf4RfXae0tfu7YF8=;
        b=ecl0JrGoO1z+suGAQewd4shx32A3IIQ5TkyZ7LnsqI1lN9wI795QDYPQZME6OGmYuZ
         uhaLtOCWZqsvDSst4qb3lEWkpvVbGTqto1GGdziLHcisk0V/3xCw1NwtxAZp03FTVOl4
         4heTCGjYL9o4Xm/rVXgr4VJYNFP9uU0Qr4h4osRKKa967CXIOV4ocOa20DGrwd6UnU+0
         +ArNTkwqxY0CoCvkxgtJclUKPudhEMEddOkuDX9IIjyOHauxLfrHUyfUtYuPiWPGJqhM
         nbnRFaojpo0Huv5H85Ge48dCYNKvwZTs6nXITULlTwJHPa8ByfXsDGebeX8Ax1F2pTsi
         ZoVg==
X-Gm-Message-State: AOJu0YyzaLzlyBGdplOFdc/8Bz0yi/dV//koqsPr/2ugSSqZjaWOzmrl
	d2DLTVhsReqOPG+u8fUBimrjwJomTP55SEFtfQlN12qJF6okcHUY9o7SVUt8JXH/XHSvLIJKspT
	bE0pGSw==
X-Google-Smtp-Source: AGHT+IEh0Aj3JrL7E4NaMWfcxzE/gnD1u3MoX/ldGXUj+FzAk1WWXePITcPCvnrht/Q0UsbnopqzcxIwfdM=
X-Received: from pjbst4.prod.google.com ([2002:a17:90b:1fc4:b0:339:dc19:ae60])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d004:b0:32b:94a2:b0c4
 with SMTP id 98e67ed59e1d1-33b9e2925e2mr11841251a91.16.1760739037526; Fri, 17
 Oct 2025 15:10:37 -0700 (PDT)
Date: Fri, 17 Oct 2025 15:10:35 -0700
In-Reply-To: <20251016130021.3283271-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025101537-entangled-rhyme-6714@gregkh> <20251016130021.3283271-1-sashal@kernel.org>
Message-ID: <aPK-28gyLZU1GRxG@google.com>
Subject: Re: [PATCH 6.6.y] KVM: SVM: Emulate PERF_CNTR_GLOBAL_STATUS_SET for PerfMonV2
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 16, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 68e61f6fd65610e73b17882f86fedfd784d99229 ]
> 
> Emulate PERF_CNTR_GLOBAL_STATUS_SET when PerfMonV2 is enumerated to the
> guest, as the MSR is supposed to exist in all AMD v2 PMUs.
> 
> Fixes: 4a2771895ca6 ("KVM: x86/svm/pmu: Add AMD PerfMonV2 support")
> Cc: stable@vger.kernel.org
> Cc: Sandipan Das <sandipan.das@amd.com>
> Link: https://lore.kernel.org/r/20250711172746.1579423-1-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ changed global_status_rsvd field to global_status_mask ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

