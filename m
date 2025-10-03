Return-Path: <stable+bounces-183167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12009BB6427
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 10:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 027414E120C
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 08:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2527703C;
	Fri,  3 Oct 2025 08:45:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528F2741B6
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759481115; cv=none; b=ZeIfFOmd+UDrsfIS7yvaKZqbSBN/atk885HD17h+quSz829/8B8FT5Ekz7jjkY7LNN/dlgnma5Yj8+W+56zv5Pw//8+iQH07eSEl6emG+PdmZrCysLd/YR1fbg7oC3JNhP/NHUNjNwne+mH8lagS75dfggBrkABPwflZTc7FR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759481115; c=relaxed/simple;
	bh=YB1ghMEOeQ5JFYWeY2ps8djFxf5/HuRtlXBeq/CH+jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPQKTkuaPieXBsNII+8iPJtK5ISPKv5CGyCdYD2J5qemNHSQSP9GzVMAn+3w3s4sJHhy3qSv00Rd442obqFIiryP8tiGeFIGo1+qm2MKcTVuoQeAjS29HQVk/syGRylQ+IsIP2gLfzQiTg9ZIeNdm4JmQ7+YjheDNEx7xjB6Ka4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-637ef0137f7so2430989a12.1
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 01:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759481110; x=1760085910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNchDiEzIDmBEztmo8oZmioyYgfq18ckj4ZJE8yTj5I=;
        b=B8CIuCGiOynHy4tGpJ/axtlCAi82YCZLyQmJYsR5gD0N+ZpYOgSqIvYgDkIlpKnTBY
         wGb5inR7PN/CSiOskexmxvDAx7JNhZ3fM/LePM/0UymmngFwWimGi4XnO3nCMowONCnr
         LkG2KBlEcaJrTL+BJTPBgfbRQ4Mm2KWlX9gpIvCREv4b44smxtgCWVXDFiDLZJ7WRyAT
         RAfo67mA/SIjc4qQxcd2e0tY+TrsmHDOJ1fBp/kLQmxxa8enqDgXpcCznYfos9pUF+/L
         OmOIDRB5r7GEdEn89HbJAWEgajNmJVl2u42WgfelbR8alQgaA5pGr+LovfpJflLdIh+E
         41vw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ube3Cs07C4RCitk38AIkS3MgSxRbFepAOZLTE/4Wx4867itqiNaSdXOvgbo7+lXoMU8FPo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCoYOjqMN4AMxTQifdFKLXSFErfLnX+z6Dl5d7quU0I1eBthAM
	nieWJ0hGBhO2S0P6W7h6gFIg2qYZyUvXrP8STXm94oPAwNG67DAt416o
X-Gm-Gg: ASbGncvk3X8xkj96kk9pArso76+znKwsyokV4bxdnO0Z6BBwf1UF91NUPDgCK64FhGn
	8JMv+NazF85S2lHajSP+PFnu55TtjCevivc6j00czUVHL0wEebtY7VSAHag3XViZsCvSp2KiAMt
	WjS4bRgdec6gDROMb5cfNK0dcmo+KyzbP+eD4O8jmvkSMoECK0v2sfqjO4L41UT2YgeX2EpwoPq
	0uvGdypiMIiH0CuHqd8By/mndbk6mNNV82jqpoxBT8cd+80g9PZQQFRa5n4cNrQ4qIXJys46AZP
	k9dIPVHSYejmeFHdshFUlaLC40cHqfiML6AXuVEP/U0Qap1n0SgHlKs7N3pBCJ9oD2Zk7VNRkkD
	GfUsbXYM0b0hAsqQrKReCe8zq17BRIn2Ol+5WCQ==
X-Google-Smtp-Source: AGHT+IGjw0zmq2CU/sdA/VkxJILpqI/TtLALso31v4P2kiwd0BksUPICZg/6K3fI5iB1htfz3dZPgQ==
X-Received: by 2002:a05:6402:5347:10b0:634:5297:e3b3 with SMTP id 4fb4d7f45d1cf-63939c509b6mr1714584a12.38.1759481110436;
        Fri, 03 Oct 2025 01:45:10 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6378811f14bsm3554826a12.45.2025.10.03.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 01:45:09 -0700 (PDT)
Date: Fri, 3 Oct 2025 01:45:06 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, david decotigny <decot@googlers.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, calvin@wbinvd.org, 
	kernel-team@meta.com, jv@jvosburgh.net, stable@vger.kernel.org
Subject: Re: [PATCH net v6 0/4] net: netpoll: fix memory leak and add
 comprehensive selftests
Message-ID: <s4lrro6msmvu3xtxbrwk3njvmh4vrtk6tmpis4c5q5cbmojuuc@pig4xhrvhoxq>
References: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002-netconsole_torture-v6-0-543bf52f6b46@debian.org>

On Thu, Oct 02, 2025 at 08:26:24AM -0700, Breno Leitao wrote:
> Fix a memory leak in netpoll and introduce netconsole selftests that
> expose the issue when running with kmemleak detection enabled.
> 
> This patchset includes a selftest for netpoll with multiple concurrent
> users (netconsole + bonding), which simulates the scenario from test[1]
> that originally demonstrated the issue allegedly fixed by commit
> efa95b01da18 ("netpoll: fix use after free") - a commit that is now
> being reverted.
> 
> Sending this to "net" branch because this is a fix, and the selftest
> might help with the backports validation.

This is conflicting with `net` tree. Rebasing and resending.

