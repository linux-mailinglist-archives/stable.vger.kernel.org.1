Return-Path: <stable+bounces-180595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18969B87C6B
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 05:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D240A580D74
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 03:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8222F755;
	Fri, 19 Sep 2025 03:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQVxOCEb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101AF23770D
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 03:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758251767; cv=none; b=T5QZScC5LL+DzgY8bVjp8XDiBeoJdwHTtWudWEs8HFjEJJXvwTFKw06eYHFt7+0bsTxdxnpqzbtEnrwvwaEBDgO6gxJSqHIZQcOvpRdhJ4uhblRv7EFMDdVLHbuo6i16H+GtQEyuzPVciRXCXnPVT10t9t/YOhI3QjvltugsXQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758251767; c=relaxed/simple;
	bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8Cf04SvUGES2oWn3hF9AwXD6CFsXbKGAwJyOZmb9M7gzkovGsjHCfTuSmRk/onvI0cj6bSGcUAhXksYXLjfJZpLzr+ZBwCc7U3Xe9p1IqvvGY3HfilnCmk1tISlCfyvy2LcWk9jwqXgX7sGgJ8zDKXsGEcbbeW3oWCcECwrp18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQVxOCEb; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fbfeb097eso745196a12.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 20:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758251764; x=1758856564; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
        b=fQVxOCEbPGqx+dyhkUUZdDEk4b63Zk/s12muZ+R6pMhxdVG86lkIAXMQFVv7314MMj
         bAMQglMPKlwdjtszbOvFLJU+EiK6GjIAxrrZawu2rzJ1cuX2gHE2rNY3YwiRne38pIuj
         90oi2TzIvuU6krD29TnDAuE60mGfJGZ9iFM1hyjFPQ5Csp+CHPa3/mONCLa7xDtxpuXW
         zmz+/da8FrjWBr9LeDtMWNBm84ArE8t8uWF4s5aVq0o1tOpRbwH1wMiXOZaucC6TSZ7L
         A+GhSnfVU98fPnDScZPPyZby28hX/i0gHspmQLSjy7p84RG7Oh7gV1Enhd3JFKKib6TV
         JgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758251764; x=1758856564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKwgfiNki99HQfE+BDZ76jqOzfurZlN2ZbRA0KdOE1M=;
        b=gGxSZlhZuctJ/eWrmJT1HUmtjZA+sNOuk4czWMWNIRtM/CONtYyKCLscoASaqnfE8n
         anjpyRK7L3S5iE/xE3od5AmbKyr+S7FlGcCIF4zL72CB5VE8ILFkjptkBUqkJVa4xg3a
         M9PZzU1P9J1YsUhOXNLt0ZNJ36wLeLOHt8+k3LghutEJ3SopkNEhGyJ6qmwcpyGpLhc5
         rFBWCp4s2mY+37SPZTHp0pqOAmXwWxCBmkSNSX249+Y4HqeKIh8ihNdkV1KKLPuWt9dO
         Qa8JX1xk6iNQtuq+LllpXRuCwIif9F/t8ui0YClCKZZ3b3o3z5W6JmLL83gd7Jzdzbfa
         Zu8w==
X-Forwarded-Encrypted: i=1; AJvYcCVdICsbDGRUmAOnAgkzZDRMJriE4vGtnWqGnVBugXci1HDPP9Y56MCrDx5qne6kkCrIpgQxJUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgas1Nf02ktpFYOWeMIV5/GfyqpQrY3UWneenQYp9vQ1OJflS
	IOy6TQLz+91GeNRIcRoqx/0o2mWwZ21JT8QbKlvUk0wRCjbn60bkS8Dg3DLvZ9tzGlKULUK0KgL
	+eM4l51lWqXFdNXYBCiKFKwW5qXwDmPA=
X-Gm-Gg: ASbGnctGJQwPk8Ux9Cr2TescnFd6HMxOsiLS8zPUL5epAeEpxuh94r2XJ3xLUBr+VjM
	8hAt7Cw/hHTJxohisZK80pgtBYs9bRIUPlLGGcvhTyDpiW8JIcndj/4I9XDPfOlkbd9SwvRm4yi
	/H3z2TR3g0oWvItop5Wh+X40ObU1N35CF103kC4ne3QPd611vHdvnv0kffpfIN1ckj7uLniGDvc
	z+F41d8
X-Google-Smtp-Source: AGHT+IHpuZQvB5VjDIkqb6EILgkWDUV5pQg8TL4O9i66Ma8EIkoa3WtmJBAeGAlFDqdQk9Kqs1c+lPs2vKiXQxoNaR0=
X-Received: by 2002:a05:6402:51c7:b0:62f:3531:d905 with SMTP id
 4fb4d7f45d1cf-62fbff7b4bbmr1183252a12.0.1758251764087; Thu, 18 Sep 2025
 20:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917100657.1535424-1-hanguidong02@gmail.com>
 <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev> <CALbr=LZFZP3ioRmRx1T4Xm=LpPXRsDhkNMxM9dYrfE5nOuknNg@mail.gmail.com>
 <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
In-Reply-To: <abc0f24a-33dc-4a64-a293-65683f52dd42@linux.dev>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Fri, 19 Sep 2025 11:15:28 +0800
X-Gm-Features: AS18NWBWy3JSGoTuAR7nCC9TldQxYSoxjAO81Iqekfd37aXEUhor2yl6szKD32M
Message-ID: <CAOPYjvb1vEzgRM_m=FsjDTTuyGMWpxgK7UfmS458rbN6orVjtg@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, stable@vger.kernel.org, rpearsonhpe@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Thanks a lot for your detailed explanations. Could you update the commit
> logs to reflect the points you explained above?

Hi Yanjun,

Fixed in the patch v2.
Thanks!

Regards,
Han

