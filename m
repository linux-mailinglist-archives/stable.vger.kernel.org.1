Return-Path: <stable+bounces-67519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A28950AB6
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 18:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40AD1C21A07
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9C1A0AEA;
	Tue, 13 Aug 2024 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k2FR/ycr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4A1CA9F
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567637; cv=none; b=rA74nly2ow01YRppKgTAH8+7HiYu/YV2j6td7g2nDbnHUehi/Hygi81n7NjG0TiEYg8z6d7xDki24UPTWTuzCT0icmfdhDvYfRgbFwv0AlL49u3+30UtKfk2H1rkBvpHZ/IBIdYHCu/auwslDbvg5WiBg4TKCDrjP6TGpUaVO7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567637; c=relaxed/simple;
	bh=/IlpP4Qsf+0X8H5/rIYlw5E1qReGDj4YSxMfZTHsJSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BR9i/aFu/XwWXxfFPhQqfJqPQlbCyLDxakbuahwex5h9bMFa8YQxOJ8qBsgudrW7EQMuMTV+4OOf2oEjWJA1lKkwcHJ60lbnBTsQj03Cq76gD5iKKi4SupulFbGfhsaaxSKFOT6pzBMv1AB07/PT381mt3P6QKaDwWKKhZMXqV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k2FR/ycr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7126498ad4cso391082b3a.1
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723567636; x=1724172436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cvC+MlViFr2QLEkz+G8a9FJXYljq8MctWXeGbvhtnMw=;
        b=k2FR/ycr0JGf4hpISPmdeFJv+JIliuLPH4VEj35F1VcO+VBcuDp54RXXqbEKW/3xj5
         nLPJCzsI0WXaGJM7IZ1W+xfTygsbZwKEpC4bV+r5s5pBnIwMehwkS2OukjLTxuzUXK96
         vLPYpSx/+pd/X2LXSuq9HBl78sjGSKux4dj4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567636; x=1724172436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvC+MlViFr2QLEkz+G8a9FJXYljq8MctWXeGbvhtnMw=;
        b=On3vfg5peVBDPEnn4Zb26gRyN4ccJnry9tI/8HI6uFueukMRHSw+GQgMocR1BqkDkb
         LhXJgOKFEuj9NpKYuCAYD/96sR+ITzANcttQDBbta6WlKbMOTBcvHgYovg/dAOxq6kVn
         0SR+Oet94/qU8pg49WSLK8xGe1zO3ZjIiFtv2CVxKhFumndyFjzxeYsupSExXAs0MEy2
         xM4RlvIC2jhf8FN78RaahrKADjy+oJWtdl/fjsa2xe4yRoC+aDvXILmP0ycp/6whVP4a
         fZj5Mq4NYSFuDbwnsxBoIe5uWmRy970FsEZDG9BXzCZ3FyZUvKTo2u02Dx6KU7ySobYd
         1jeg==
X-Forwarded-Encrypted: i=1; AJvYcCW7vTAxPfPYARa/wLrjk32chA5qkmJpS+CUaisc5wWw89FVnYlV6LCCyFz5aZl+bUx6UVDTUSL+kc++whgYmA06ZmlAxfdA
X-Gm-Message-State: AOJu0YwHMEhsPcSfh3bY9ybOKwXzm655jo1JQRMF5L5oUUrS8ZcOuUtq
	/cu8v/3NkMK9dCXfcHzwg3TR6oauRx0EH+D8QP9ZYeSFKcwJrIyANHwWWINF4Q==
X-Google-Smtp-Source: AGHT+IEzj9oFteYRB1wBRDBdk9axsnQIDwhuKTpjESDC1PAhH2791kVkrch5zHpbudiwlKniI2eNRQ==
X-Received: by 2002:a05:6a00:982:b0:70d:2796:bce8 with SMTP id d2e1a72fcca58-712673aa50cmr186956b3a.20.1723567635731;
        Tue, 13 Aug 2024 09:47:15 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:45ad:979d:1377:77f0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-710e58b69e4sm5933627b3a.88.2024.08.13.09.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 09:47:15 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:47:13 -0700
From: Brian Norris <briannorris@chromium.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>,
	Yogesh Ashok Powar <yogeshp@marvell.com>,
	Bing Zhao <bzhao@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Kiran Divekar <dkiran@marvell.com>, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	stable@vger.kernel.org
Subject: Re: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Message-ID: <ZruOERPfLACNlw7P@google.com>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>

On Fri, Aug 09, 2024 at 10:11:33AM +0200, Sascha Hauer wrote:
> mwifiex_band_2ghz and mwifiex_band_5ghz are statically allocated, but
> used and modified in driver instances. Duplicate them before using
> them in driver instances so that different driver instances do not
> influence each other.

Ugh, I caught a few problems like this on the first several passes of
review, but I missed a few more. Thanks for the catches.

> This was observed on a board which has one PCIe and one SDIO mwifiex
> adapter. It blew up in mwifiex_setup_ht_caps(). This was called with
> the statically allocated struct which is modified in this function.
> 
> Cc: stable@vger.kernel.org
> Fixes: d6bffe8bb520 ("mwifiex: support for creation of AP interface")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Brian Norris <briannorris@chromium.org>

