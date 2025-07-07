Return-Path: <stable+bounces-160344-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9AAFADDE
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 09:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9968E1750C7
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 07:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74DE28A1D3;
	Mon,  7 Jul 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+q8XgNz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A09D21D3E2
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751875137; cv=none; b=eh0m2ftk7P89NlhuJhHWLxpFmGspwRHc0+ZTDDLFaOisvGW2nbNMdO4YHVDARBAMFV8GbOASIjtd0t+9ynpcwRt9mImQPtD8tuoGD9BVIvUF5LkjbrJrQDU2nblGhQ0+Ds8Zt23wrkCBLPbW2ghRmjVHMuNXMS4QZTkUYRFC4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751875137; c=relaxed/simple;
	bh=A+ZtBfcnyXesaB6ecYzuI8KUuf4sAzTnIz/Mb5HBUPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8DyLc1/8j1v0riA8WoQxpzR5qX2PN4W0IgPaRkZ07I89gWbW6w7q5t1C5EGBBXESejoJFJ8FF/QSWA+VeOmrdGG/LV76JPDoKksio09ZmxQA5qpOCer+EHB9sX/FyDBXZ5he1PoiFnWj/ndawYgiwSr9LEtzt1TPNpwjTyvoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d+q8XgNz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e81d37a7so1626435b3a.1
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 00:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751875135; x=1752479935; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OTPtMw8HQb4L5f8OeutCZQxDgspI5HCxCvqaYmgltWo=;
        b=d+q8XgNzmcQwRXBgyo/OvInip2fFnRZm7M2EzPmipV0SO59vIc7TcwalvRpX4SPoob
         +07iqre2LNFnvTAg5ysapNiBiqpe1Iy8qhRif+p+PS6BcPw+uIi8pGX2+GM4SAD1HI2U
         nRrudOvK8XZF4Z+i7U3DooRVc5xA8ISXq3vIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751875135; x=1752479935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTPtMw8HQb4L5f8OeutCZQxDgspI5HCxCvqaYmgltWo=;
        b=Am2rImiE3NcW5ZYRgBwDXu50q/V4dqkWP5HE3iAkVwjYtMQGIR6G1aStuRKWzwuca1
         SK47c9m8ft+F4ikA6ANhJYD42D5lEY+Vhf54vt3W4yfpaTH7u9/eq9l8J5UHDJRWT/CI
         tUIodMX583XGV/0MklBIlkHWva5hgeRHGoVPT+EsYq62VA/xcb4FdkEUB/nJdhZsuyuN
         nXL0kC5X/lM9sJoJHjmV3wwpRv7FYvVNX4D4CQo66G7m1JabfGd5iZvRXh3PZDD3gWG1
         Hvl5wJCja32YcCBeq8KiNNOChXj5N58ZiGxNycocnJviiww/1x+FjuhwQEnj0MZIb4wm
         IylQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNnAZgXZvMP4njNZyakuTU83tntnlpGEm20r1IyIikxgd5/VfCu+lqeN3gxtGWBBcUvMqJFEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznSYzfOeFqgUFGeVizWD70rKrPn+Gp0GASNNXadAjDot19hJN0
	SzN58jfi4GUB7n6WDHvb7RgnBu0OVOBk7z41IPeyI1i0WA76w6FvDd1jCV3/HQ7Tgw==
X-Gm-Gg: ASbGncuCok8NSxT8wsxjcg2zkfaWDalZ2ej/iwujlKlHSE7vV9AKrRU8XZGrI78b7wP
	8JmndavPIB1lVYwqb6nAoBzSxskHcFEfZevGY8ocWPo2/yPXqCvgwvQtVZwhNgXHifD9m6ARz1U
	E8Nm+mBgnEeFiTk4Z9LQQUtmtPS7fYq2XDRpB7lwMbFN/Qfw32DxKBIl0mjPCw7ektZUPdNq4h+
	2M1RrQJWyKUvXBmHqHRvLgRV5/jLGVnLJlWpND/YSGgaL2rQU8JbldQ8ROY5ukS6SsFV0ko6HjQ
	rfFpeeBuRI1Aj7kmColqw5hDZqDXrU0cfss04tp7JAmlr1r1fTCoGwK4lpAbI6eMEw==
X-Google-Smtp-Source: AGHT+IEK5EtOBzyfZ2irKKdKJ5yA76QHgOFTf0rbbII+tFWb39ZzUOI/RILDQ9dMA3Gky1EGCo+7QA==
X-Received: by 2002:a05:6a00:174c:b0:740:9a4b:fb2a with SMTP id d2e1a72fcca58-74cf6fd0b77mr10437438b3a.20.1751875135471;
        Mon, 07 Jul 2025 00:58:55 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5470:7382:9666:68b0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc32fsm8422139b3a.52.2025.07.07.00.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:58:54 -0700 (PDT)
Date: Mon, 7 Jul 2025 16:58:50 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: akpm@linux-foundation.org, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v1 mm-hotfixes] mm/zsmalloc: do not pass __GFP_MOVABLE if
 CONFIG_COMPACTION=n
Message-ID: <i7tgsnsk4zqmij7h6ujrjkdhupk7mffciqodtbqyfla6zxalro@sjcgdsf4bwrs>
References: <20250704103053.6913-1-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704103053.6913-1-harry.yoo@oracle.com>

On (25/07/04 19:30), Harry Yoo wrote:
> Commit 48b4800a1c6a ("zsmalloc: page migration support") added support
> for migrating zsmalloc pages using the movable_operations migration
> framework. However, the commit did not take into account that zsmalloc
> supports migration only when CONFIG_COMPACTION is enabled.
> Tracing shows that zsmalloc was still passing the __GFP_MOVABLE flag
> even when compaction is not supported.
> 
> This can result in unmovable pages being allocated from movable page
> blocks (even without stealing page blocks), ZONE_MOVABLE and CMA area.
> 
> Clear the __GFP_MOVABLE flag when !IS_ENABLED(CONFIG_COMPACTION).
> 
> Cc: stable@vger.kernel.org
> Fixes: 48b4800a1c6a ("zsmalloc: page migration support")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

