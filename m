Return-Path: <stable+bounces-119823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CD2A479AD
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 10:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387C13B2F1C
	for <lists+stable@lfdr.de>; Thu, 27 Feb 2025 09:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00126228CBA;
	Thu, 27 Feb 2025 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiB89m7q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F5F610D
	for <stable@vger.kernel.org>; Thu, 27 Feb 2025 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650368; cv=none; b=t3lMUEmUI6rAXLGfVrJ5MycL5iZv659Qn2CnFTiyviHcNQrcrXG9Mkxyyy3COIZqtD3ZZpiL4ApB6NC8oeCayxg6Vw/ymdQRTWQ624rOXvkmkahgD75movPlZycNFSXGiHsb1QcjRfA69rPIb7qkpEmwCOTIWLyXUy+SrckPvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650368; c=relaxed/simple;
	bh=FZg92gkXljfLWp5xIWy5OIT7hy0mXlnkpRrty4FskTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPJmmBiIW3+unDLGiCo2CFe89jVFsQLj+mIgLYweQMnSLkjlz4nHledvdLnIX8I73LcP6bIpGlQuY5oJjlgX3cUQ30TgoH0cD3a/w4g8cTQITZIwj2MVAHLLJUOrdsmw/RRFh8dMhmvHtPdKWdvz0OGFhJsjVPHQB/wZvtHGuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZiB89m7q; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab771575040so330151766b.1
        for <stable@vger.kernel.org>; Thu, 27 Feb 2025 01:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740650365; x=1741255165; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEPF+BF1tDABXHmu1u7MFMwie0IHNzPzsRHwCtOuq2A=;
        b=ZiB89m7qyKVzoFyNAMnbdmCwClCceSk6lKG4WQ/gO7Lv1veISu/nlplRDUULD06JLY
         dH8bCfPCitlQZbTupauADmDAzKWy5ayrXi4ozNYQGO6sFquzqqMeP1Bx9OHiyPaR98Ds
         WYcYkxN9np1rbAqgFW1bQKYskeMTlFGgwLdhJtZ7xqbCRb9GUzwlerZxLgJneB0RgrPd
         vfg+N4vkgiz5PKmUt0PUPgBjiC5znlaV8Aar5czhuBAl7DQmoj8MUvHeDeU1IwLg8KpF
         fre7sW+zDJowf5/0n6xdcgfK294PdQ2YxrJ1vrVxcOE06fiZtNIa+almAHJamnciQUcZ
         auVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740650365; x=1741255165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEPF+BF1tDABXHmu1u7MFMwie0IHNzPzsRHwCtOuq2A=;
        b=vtdX67xd7i0sA+Yz/jvhDcDCLfs8x52mEujmcSIIVmtM1FHaWi5bYtW9V8WoJ04ufm
         J51eOILqRzNxy43zUz4c4Tg6pfbgN55Y3sMorK806Dq0FMuyhbxCiqNbDYfvQFR72Iu+
         Z+quPKogaq/fQHSw1beKsNeXuLfJvv13GYs2Aqp4GkybQQeQk/nTiRlWDk+3qhnUr2xe
         NL4Er5lbqkLeNFS3nnsP+v2/VjLNrae5mqatF5QGYx+7CtkfW5cIVuk3XxFTUL8da1Zs
         +dt1S767JfsjWpgG5zIDYSg8QPTDK2zfHirkXTnduQat5Dda/YBIWv2IW6f1U0AOq4TE
         aXXg==
X-Forwarded-Encrypted: i=1; AJvYcCX5Kb0zdx2gozzDCUn7oOGkHdRjOreoOY/rGw/ez47V0wf/YmngKxScjy4J2ztJc6vYxtDlw50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Ox8kTPQdLCNrzOg1/WybqK2wI5Na5mgbehLEsWWtL5VgsolM
	x0YlYU9CMeyBn6EOXayFmVwoGWLAOITTsKguLlVxzJko51s1K5EA4uMCfy++S+w=
X-Gm-Gg: ASbGncv21j9GcEC+WJ/fouoiJcuDqCYlnx10oO32Flamk0H0jS9jmeeopEJeuq2zllo
	ggRpmtSJectSbGI1PKoWzrq08hZrSeZiApv6KnuyzoEprvDdCHKE9dMsFDZWDxbTg3xfIA6vcvo
	qHrBcEIiz67J7kWKpXI4s9HRSYV4NyY2koQFZo0FL5b9nVjT78CjVumrpEdmWPUKz92+HCtv4dQ
	8zt0Jv3ikmzE6TbxjB0oJF3P9jmUN6m6YicdKA34eLkit6Y30zwE6TVLrCZsuLXqxHNcaxZPoHB
	CZNu8ZB9w1X7sFEBSG3XYzSS/BXZ/k4=
X-Google-Smtp-Source: AGHT+IG9mCmnscH54kVfFF28h+Qv0TbfaejQ9tOnUBiZc5WmqAgsuv6yRgR8ejlnTJsblysvqegACA==
X-Received: by 2002:a17:907:c48b:b0:ab6:ed8a:3c14 with SMTP id a640c23a62f3a-abf0625d622mr372435366b.27.1740650364736;
        Thu, 27 Feb 2025 01:59:24 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c7bc588sm94441766b.168.2025.02.27.01.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 01:59:24 -0800 (PST)
Date: Thu, 27 Feb 2025 12:59:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com,
	akpm@linux-foundation.org, error27@gmail.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rapidio: fix an API misues when rio_add_net() fails
Message-ID: <910d7ee5-87e4-40fd-b1f9-c1d99e4df304@stanley.mountain>
References: <20250227073409.3696854-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227073409.3696854-1-haoxiang_li2024@163.com>

On Thu, Feb 27, 2025 at 03:34:09PM +0800, Haoxiang Li wrote:
> rio_add_net() calls device_register() and fails when device_register()
> fails. Thus, put_device() should be used rather than kfree().
> Add "mport->net = NULL;" to avoid a use after free issue.
> 
> Fixes: e8de370188d0 ("rapidio: add mport char device driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> ---
> Changes in v2:
> - Add "mport->net = NULL;" to avoid a use after free issue. Thanks, Dan!

Thank you!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


