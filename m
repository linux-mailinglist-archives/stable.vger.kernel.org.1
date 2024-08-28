Return-Path: <stable+bounces-71387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECAE961FF9
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 08:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 681CFB23118
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 06:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9DF158520;
	Wed, 28 Aug 2024 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqCliIIj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A17156C76;
	Wed, 28 Aug 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827576; cv=none; b=Y2kGsskS95+P8zQ49KMJ3HiQNVl24AchoiPdbRSQ4+O/+KieL5mtn1KIyNyHJ7+GvHxcaoC6tRuSHiGHu/4a9GPExEDD7MrHfxgFGwNVhCooe8b8z7xajFcB8rQ+Sy2mHpWKZuLb0PBBrT24tIKauJkkRNzBvv2nl984g3M9ZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827576; c=relaxed/simple;
	bh=ceQ9ve7FkIE5RldllOc4Y92N4eSThFv9EbJwRov8QJg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=OLffbdlLtx+YDNv0d08cjTdpmTJUkj+/O+DFSR7WuuD/2g0CH1axD1cNLA0PbH5WGcdOkVNJujgYLQcNk5MT/feHvUMtOmShEtO3ueVbJqevNkTrIiJh4W/5FVTHmdxtqT2vawbsTgIiXA69wrmgDJcIKk6pAz8phcFCG0bIU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqCliIIj; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so4724678a12.3;
        Tue, 27 Aug 2024 23:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724827573; x=1725432373; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=24MQir3mu9HfGly2MDnOstXsOhraZUtPd53vlZyA9h4=;
        b=HqCliIIj1LTWvRrW5SXKmI9s1tAYD+N42IU34qisDyiQ3OUc+IYwdnpscU8GPQp9Ua
         o4F3GQ35NSkmrPtZ0+X2QmURJgCBcIBq+NmWnbiNOw5Hxm70zwzz9BK+pRs/7BqfJZlM
         oBs58gKUBmIy/JNxQnKw2XU9bcDTIdy1fr+EA+oLlquzTq3R8wXhUjVPD9W7vOFHRjml
         S8+/XQSncynStEofDfvBErlEzVe0dCdFwL4WFs+uaZHg3IOuiaWo3K+7GsBL26tQgedh
         uNr+txAVHJzfDt8YZLOYCO8LlyeAkjexJxXDbZ1r0JviO0Nd/DvVtrsG/UJpevjIrsO1
         BsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724827573; x=1725432373;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24MQir3mu9HfGly2MDnOstXsOhraZUtPd53vlZyA9h4=;
        b=M4FQ//uy7m0T8myOOOIlJGVG7cMBWaXcboeEQpwa9hgal0CxUwQaskvLRChpfcxXbv
         A7TQGl4VNAQ+2UA2acXz5KRv49kCHSjLks1nx71rQYRoQFR1Mr/PU6+kM1yMB+mVVFu/
         a2+u+tLWfcB94wnkBrmIjTU4481fmWOvDPtXEcNDK0CEksmYM1PQFIVnc8EWsw24jFS0
         /EcIuB+cP4B2Aze3QSfMXR3wLu4a+QJB4XRIf/kJRL1t43N2tU/cCaLJqdwiFxeYKmNO
         +SjxgX18PDbYMyWvpePrXD+YCldMWIwgexGyB2vW1+L3dxx7gty4Gp4JlyatDOp0Y7RL
         CRoA==
X-Forwarded-Encrypted: i=1; AJvYcCUJB4cWbStdjts+m/9+eE+58vxYJDaIWJqCKdKHTvnQzqFsPvK3uxLdXUYKfdq57gUH4MLw7qng2Hr76T4=@vger.kernel.org, AJvYcCVRWjmJ/WBm0O7djom6mBh1nrCXMCJn8u2XkjpZS/jbj3dXb51Z8Ef4n9Tbd5dl8N/Sm/2g63az@vger.kernel.org, AJvYcCX5KHog75aG1WlzyiPl6Wt994CoO2puWgDCB/oImP1ogEjXsfTRTKg5Hb4ia0iJVKBac2LJboezraX0@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGziCDl+DvoogWJvA9oSRoE+jWpJv9wZTHkpKbLLMMnc6komu
	82xDTH86edxnqsqgjSguwoYFixdUGH/DxQ3csW/zfqnq8rFpVW4IDnTP8Q==
X-Google-Smtp-Source: AGHT+IHHhhy8aDMecJm2IBluMWQ+P9b7AX4oGfQIN9F080PhQA8xqt65f3JLuOeTjbzLb4JSmY+N0w==
X-Received: by 2002:a05:6a21:6802:b0:1cc:da14:316a with SMTP id adf61e73a8af0-1ccda143292mr24309637.20.1724827573161;
        Tue, 27 Aug 2024 23:46:13 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad56c9fsm8819712a12.64.2024.08.27.23.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:46:12 -0700 (PDT)
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, quic_asutoshd@quicinc.com, adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com, stable@vger.kernel.org
Subject: Re: [PATCH] mmc : fix for check cqe halt.
In-Reply-To: <874j75s0rg.fsf@gmail.com>
Date: Wed, 28 Aug 2024 12:11:51 +0530
Message-ID: <87y14hqhcg.fsf@gmail.com>
References: <CGME20240828042653epcas1p1952b6cee9484b53d86727dd0e041a0b5@epcas1p1.samsung.com> <20240828042647.18983-1-sh8267.baek@samsung.com> <874j75s0rg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Ritesh Harjani <ritesh.list@gmail.com> writes:

> Seunghwan Baek <sh8267.baek@samsung.com> writes:
>
>> To check if mmc cqe is in halt state, need to check set/clear of CQHCI_HALT
>> bit. At this time, we need to check with &, not &&.
>>
>> Fixes: 0653300224a6 ("mmc: cqhci: rename cqhci.c to cqhci-core.c")

Correction. This should be: 
Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")

Subject can be:
mmc: cqhci: Fix checking of CQHCI_HALT state


>> Cc: stable@vger.kernel.org
>> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
>> ---
>>  drivers/mmc/host/cqhci-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks for fixing it!
> Small suggestion below. But this still looks good to me, so either ways- 
>
> Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>

With above changes please feel free to add RVB.

-ritesh

