Return-Path: <stable+bounces-3185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1247FE335
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 23:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51F3FB2104F
	for <lists+stable@lfdr.de>; Wed, 29 Nov 2023 22:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B529C2B9D9;
	Wed, 29 Nov 2023 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JueQZ4Rw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA9B2;
	Wed, 29 Nov 2023 14:33:24 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-285699ebabcso296348a91.0;
        Wed, 29 Nov 2023 14:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701297204; x=1701902004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I514WpKhed4nrQIz3BqBn8ospI7mOLbqMpjJBTq6ymk=;
        b=JueQZ4RwW7FulVIowO98Gq4yGgK5415D+vMjvL0vvuuEx79ASrdpWUSpBYU4bTZG8H
         VRVeMjWz3Xmx2QJuI4Z5fRdxEZpNNu4zZmjb0oRrYrgv45kXlg0i77oJCOZqxy5P65I2
         Db/vpSxRZS+0kUd+vfGkDvozmOap4Jvbkbf7C+Y0AXgrrWHXuSKtw60pBrdBbkQilJTs
         T4gM1kPvZE5cFyO/3OakZRmkQYwEcQuULBzq6t9zKwyCVWMXSjhqj2+OsBPBPfed6RWX
         Dh8CfSMc2m3aSH2Thab4udFyVjGmYvtr04FRGm6mNCjxSdju9g6zqhH1v5XBuJy4vQ1h
         +i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701297204; x=1701902004;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I514WpKhed4nrQIz3BqBn8ospI7mOLbqMpjJBTq6ymk=;
        b=oAVO0W0CT0EHI2p0WM3SpTyRWzGwi5uTRCmPW9llLpM8/VzZa8n4z0cdfIM64OL1Xr
         RFLiMAn1u1tMwbawSSh5gqEFZ12m1HKz7l7RK6HYAVNuZ8J/igBV4XRVqW0hNTZcZst8
         fpXOHGsM8bOsiewtDrSO+zE+X6N3r3bL/hUq5IDKCjJWaM4UyrcpiOdAQaw7MW2xcDK3
         3weuxZnXmLpeqk5WAYBP5hLedoPFMljmcmeRyrmSUl0K2S2bPcHatC8EOBMMbxmO3uer
         RgZFU3G8RFus91ACeaDC56DTenoGeGcueUpOtMnznDlva24751n0LTWRv7LqMcWB2Qq1
         cXHg==
X-Gm-Message-State: AOJu0Yx84f6k70WzAja+RkfsBd2xfji57K5H8CVV0T8hd/8jaqLPmFRN
	FCof4KnSMDfol5qtpnbLFq0=
X-Google-Smtp-Source: AGHT+IE3ZS6fBgIZrU2HaJY5dQVHSaIR5sQW0MA6Oe5+Gz0QY2Tn9XeHc+eVzspjQkI0SKLmVHLiFw==
X-Received: by 2002:a17:90a:ca08:b0:283:967c:4e6 with SMTP id x8-20020a17090aca0800b00283967c04e6mr33689697pjt.12.1701297204224;
        Wed, 29 Nov 2023 14:33:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g4-20020a17090ace8400b00277560ecd5dsm1879096pju.46.2023.11.29.14.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 14:33:23 -0800 (PST)
Message-ID: <cf0da74e-4440-4ad9-975a-53b77f3121c5@gmail.com>
Date: Wed, 29 Nov 2023 14:33:21 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] scripts/gdb/tasks: Fix lx-ps command error
Content-Language: en-US
To: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
Cc: casper.li@mediatek.com, chinwen.chang@mediatek.com,
 qun-wei.lin@mediatek.com, linux-mm@kvack.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20231129065142.13375-1-Kuan-Ying.Lee@mediatek.com>
 <20231129065142.13375-2-Kuan-Ying.Lee@mediatek.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231129065142.13375-2-Kuan-Ying.Lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/28/23 22:51, Kuan-Ying Lee wrote:
> Since commit 8e1f385104ac ("kill task_struct->thread_group") remove
> the thread_group, we will encounter below issue.
> 
> (gdb) lx-ps
>        TASK          PID    COMM
> 0xffff800086503340   0   swapper/0
> Python Exception <class 'gdb.error'>: There is no member named thread_group.
> Error occurred in Python: There is no member named thread_group.
> 
> We use signal->thread_head to iterate all threads instead.
> 
> Fixes: 8e1f385104ac ("kill task_struct->thread_group")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


