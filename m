Return-Path: <stable+bounces-8219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090F981ACB1
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 03:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4556B23C46
	for <lists+stable@lfdr.de>; Thu, 21 Dec 2023 02:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB32187E;
	Thu, 21 Dec 2023 02:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ian7/FeH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2784419
	for <stable@vger.kernel.org>; Thu, 21 Dec 2023 02:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5cdc7e18152so272097a12.3
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 18:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703126321; x=1703731121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vJGbIHxG2ZsYy3EApEYIrka9GfydAEUv+b6Hz8AzfM=;
        b=ian7/FeHw6NJNiqpPaz4eJcj6EU8bgem2UJ6Uw5zy37pldCXYlh7dA6axpDnAJNZ6v
         QYxNrDbChc0c1RUMOOUAQpNYaOj3mGBkAjj2UlhL8BFgt9g9Abu/lt03COzRvYkY1f76
         gathwJDmWev4kvIPr4U5WYpW+BpJihYY0t0uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703126321; x=1703731121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vJGbIHxG2ZsYy3EApEYIrka9GfydAEUv+b6Hz8AzfM=;
        b=sf1ieDXCyScQHallnw+5Frb+Pm4JD1ht6z4VIghaTdlrs68kSVx+V1xcQNduzP6r0g
         dF4TVoY2OomBNzONkofp7aNAVPU2kN6/pz+h0lKLVGTvefgKk+rxZjuzDyM8R5lK0NgR
         ZLd+M3SuX2oEzmFanobL5V/4oDFBse+IP+YLbjUyyka/56Ulm0M4bd2JnKbkZkXmMawz
         qSMHgRohawFuN1iCeIc5idXcqjWUGKhsYf5E0fim8a8W8/3xfsP00iBlzuzu6bzEAqXi
         3y8utYj4J6XCGGBtwDEd2JZ9gL+cDwJ7RvpFKLBNw7e97QwQGvNZ5fFVDVaQ5ObmsG/O
         C3tA==
X-Gm-Message-State: AOJu0YzUjN6BwirEcK/Se7ShyU75gb+OZEuUhAuxUlm41QVTN70zcx62
	WC7vT0vgMdD5jT2Gu1EZkXpO3g==
X-Google-Smtp-Source: AGHT+IFZTzHJljAEY9dBckgyqNlZpe7i9t37+5ZwyzFVa+SsJmG4tRtrmgdjSlzgL/JHtsz/d7gP0A==
X-Received: by 2002:a05:6a21:6d99:b0:194:d254:301a with SMTP id wl25-20020a056a216d9900b00194d254301amr735237pzb.119.1703126320783;
        Wed, 20 Dec 2023 18:38:40 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:dc4e:6304:4aae:aecc])
        by smtp.gmail.com with UTF8SMTPSA id w128-20020a626286000000b006d8840a5923sm471801pfb.166.2023.12.20.18.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 18:38:40 -0800 (PST)
Date: Wed, 20 Dec 2023 18:38:37 -0800
From: Brian Norris <briannorris@chromium.org>
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v2] wifi: mwifiex: fix uninitialized firmware_stat
Message-ID: <ZYOlLanvv6DTGSw1@google.com>
References: <20231221015511.1032128-1-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221015511.1032128-1-yu-hao.lin@nxp.com>

On Thu, Dec 21, 2023 at 09:55:11AM +0800, David Lin wrote:
> Variable firmware_stat is possible to be used without initialization.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>
> Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/

Repeating:

Acked-by: Brian Norris <briannorris@chromium.org>

