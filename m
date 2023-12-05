Return-Path: <stable+bounces-4713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E030D805A33
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 17:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D5E31C2124B
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 16:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652E03B798;
	Tue,  5 Dec 2023 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsPJBMyf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795A319B;
	Tue,  5 Dec 2023 08:44:18 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6d99c3bcf7cso1726275a34.2;
        Tue, 05 Dec 2023 08:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701794658; x=1702399458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zC0jkdkYRUNrXPSR+3nJSIkrw8CIUlw8B0SSsidNcI=;
        b=CsPJBMyfL2WBCcEWdmsruEltNT5uSA3OV98gjvgbGxMEkJcXZgTdXXrFsHs+Go6uoe
         Jn3oceKCKi95SorzEWczXtUxawyhPrRRSscMDT/L216MxDRxKkw87mepisQ1hEKbvz5V
         o12DH4oO9Ma7Otg1VLGfqPzo3t6EtvapG8aqJ7o3ucGX8llXydMMgTxHLSOyQVZkYuaa
         TBF41z/wuK41lxHV4nVjI+KPAs+IFhzZSZdkjwdMWW9WM8aqBsN09mSLP9AZtF7PRzhq
         P/2bjNVzj3Cd8BwjbTYUX52FgVJUXaKpYjaY7cdloA3+GWk8/WRSE8v13kqDpKAtyXXJ
         Vt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794658; x=1702399458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zC0jkdkYRUNrXPSR+3nJSIkrw8CIUlw8B0SSsidNcI=;
        b=YXKA04pNt+0bupiqihAdZ1THAOnUbUrBHBPBajN9t/E0eB+a9FYNI3VJQH2kNyGO5V
         vXu5V1CscWEQFI/7XdlLq5YwazT5NH/gctZa+FsYlsScHAqvUQTiaqhzKCpkUHlUiBk7
         F4gJTROfDbbGxgRVrDeC7Kuy6J2PcZXM1PHfu0QgHkfKHrP12N7jmFtbxMiav2A7sfZM
         fp76AAkiZ+4WnciqJJExfIKTUwSinD6Bzzq8S28214GhROFEdmvU2b2s+VAJx8NFRtTU
         Z9lc8cMt4155AaWCQEYBvwpAP3aBXjgWXWPiK6XDOkZQyzIVJsSLf5zaikuYbiMvRD2V
         u+DA==
X-Gm-Message-State: AOJu0Yzkx3V1BwSJsVdjLcgM4kfZ/4H8jAzo2EonVLF9wLUxNEmbSZwx
	8978OMLISO+ONqvuE7C+6GWs02L/AQU=
X-Google-Smtp-Source: AGHT+IFXwhJ60+DmuGGe2hCYSg/v4QQ4X6790ptuWg/gW1gI08VvtwzdXK5WZLNvwqFxMJbYsBcRNg==
X-Received: by 2002:a05:6871:4417:b0:1fb:100b:a25d with SMTP id nd23-20020a056871441700b001fb100ba25dmr8042737oab.74.1701794657735;
        Tue, 05 Dec 2023 08:44:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id wc12-20020a056871a50c00b001fa3c734bc5sm3389122oab.46.2023.12.05.08.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 08:44:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 Dec 2023 08:44:15 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 4.14 00/30] 4.14.332-rc1 review
Message-ID: <fc6da6a6-2867-4399-ae6c-e22e7a57648d@roeck-us.net>
References: <20231205031511.476698159@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031511.476698159@linuxfoundation.org>

On Tue, Dec 05, 2023 at 12:16:07PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.332 release.
> There are 30 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 438 pass: 438 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

