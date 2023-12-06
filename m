Return-Path: <stable+bounces-4861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A78077DB
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 19:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F9BB20F74
	for <lists+stable@lfdr.de>; Wed,  6 Dec 2023 18:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC7B4187C;
	Wed,  6 Dec 2023 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgYilJxE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380BBD5A;
	Wed,  6 Dec 2023 10:45:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfabcbda7bso9259745ad.0;
        Wed, 06 Dec 2023 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701888299; x=1702493099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+/98j/xqe2VNXzxExNyuXe8kMEXJoLbPHQEvWYwrPg=;
        b=AgYilJxELz75YOCYWap0cDdOe9HUIV6lXTHSNELY9VKbdq75JsRu0gonNE85KGkpaT
         dx+tYRCEEqd5kFu1bXGiDzPyUNl1yylqTJVcGeFEK/EG+TOg0av4EaYpptQI6jdaH+B8
         gsGTHylTVuOm+rcy2cWkipMfTaCGNr0YFhBz/iqzM1BXI3irVd5Ms4vAkIyawHsHtN5x
         7sBCZTcTHHw4HQ48xc9MrH9+jI7LQdRxLUV/gcZxN4g+d8/UyKSQx40R+Ao6HcuoAF0w
         MYv5UAWcX2nJMoCd8tzQ31AeOjiGYrpJGA9id/kJ78m0hNRnc42apXbTLkwAgpEVyPHT
         OwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701888299; x=1702493099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+/98j/xqe2VNXzxExNyuXe8kMEXJoLbPHQEvWYwrPg=;
        b=fCLjBf/4s2eI53jsfvFcxYBeULz8tsG3PuOmtNGdV1a5bG/goBslZHID8rZ6cF95kj
         lrbfMax3WGku3Rw5sUCogGHqjlxNgOJnVAVvTPnvLzZ44dr34N5B+f5sEGHWXO5EBCyr
         iJ4Rx1k5e01KY05+1fNawVU2Xjnvk860b6xsiUi5VRCkpLm7jQSg53cBjjASMdIIXbuV
         peUCMEtp5Q8Hvlc4nl4uG1mRGrlyCscpMxwSAJPGXwB6PcHM8VD3ZeS4wIYKwzffBolh
         XWhb7ovpZ+fIJQr04va4Q5NeHZ/fsJs/DHPzl8a6znjxaOBuH9z1AkHM5jO8MDOskSZ6
         x9Rw==
X-Gm-Message-State: AOJu0Yz/IgaZNpSrpV2yG5THeohDftAwN4AlMexC4hsNGl/f1DCLsD1x
	2IWCkHgY3wtbAfTX9HfvBVE=
X-Google-Smtp-Source: AGHT+IFbfCrstIdUA4m1TuN4ZqxGaAd1VlYNtUqPm4jg7M0XPKC9yVJuEBtBHvWQ3wVPiv6eHLzAvQ==
X-Received: by 2002:a17:902:d487:b0:1d0:b5aa:2ff6 with SMTP id c7-20020a170902d48700b001d0b5aa2ff6mr4917265plg.39.1701888299532;
        Wed, 06 Dec 2023 10:44:59 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b001a9b29b6759sm145074plh.183.2023.12.06.10.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 10:44:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 6 Dec 2023 10:44:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
Message-ID: <b118cdc1-3cb0-4a27-8b74-6cb27e45b689@roeck-us.net>
References: <20231205183248.388576393@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>

On Wed, Dec 06, 2023 at 04:22:38AM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 537 pass: 537 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

