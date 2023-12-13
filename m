Return-Path: <stable+bounces-6600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C61DA81149E
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 15:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667E01C20EE3
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143C9468;
	Wed, 13 Dec 2023 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpwBG+r6"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCBF5;
	Wed, 13 Dec 2023 06:30:18 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d718382b7so29060935ab.1;
        Wed, 13 Dec 2023 06:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702477817; x=1703082617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BADNCYI7ARVEMi4bULCsWCLAvCC6uH/j3ttfZo4ZFh4=;
        b=JpwBG+r6ViYuc2zfnM0Y/1KCwmsh5MgzoPBPVX+VG+b56grLaQupZ5OeqQUw4Z+jj7
         FhF3WQQUSOoeQPT3bwrxrfq2pd7HkTHD+fSkUcT3kTB5q6QVCq8vEJsmmHC4v3I/s6To
         rQdy6EUIW5bveQVizs0jC449swDv3KrJbWpgQfdr1dCCr1uwIFVkKXLvlbln/m5wHMmt
         VnbxQU+TPIX5/GLEuwAKAwN4d8lEPgIjANXo65JbLmPdLpRP803x0NrhZpmiPr+EVSKd
         l0LquqNUz/7JIqZZs0YLdBdW1N1eipXJdbQbmOgS83OiVcT6rpwJ0BekxKw3fV8BoR7g
         hYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702477817; x=1703082617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BADNCYI7ARVEMi4bULCsWCLAvCC6uH/j3ttfZo4ZFh4=;
        b=RYkyUwIEo4RFMK9b1vjTv0ZSjVA/BGQi9qd0brTzJ+nJxxNG6fia9vWfgm7XI1aQHE
         yxUszLVGyFSoNX6MIPgBJ4gXBassCdGyQptMZ91Yyucuo4THO+bz4l/VwIpEIWWIW5th
         CYZ1i8ANE+heMOBBDFinQQpdJ9ywcGul95G5Dppt9Wmr7e3RqcUSO7MunZ/eSHOI8GjM
         HB8+5G8Y7QF8raYBDAZSn2WgA5J4LwcQIFM8yVBGYwvfICrx7EqburXdWMjGio2Zpijm
         id6zvAksIz4FsvmLmqjkrH+dQom9NAzGcLyhNNYh0FdqhpsFkin11jFla/oGZ9rgn9I5
         iw/A==
X-Gm-Message-State: AOJu0YzQRVgM8OcUhKMi0t0fGytCADOj6nfKAvKgk4V5BXQwwxe2hYWC
	jJoq1CfvUNGmLGS9DvENnG8=
X-Google-Smtp-Source: AGHT+IFbIak+XCynC6U6G+3v2hHkzbggZqbLN+akC1pLq4lzTugL9jWct41vx33M7rwpEl+oO7U3nw==
X-Received: by 2002:a05:6e02:184b:b0:35d:6d53:5439 with SMTP id b11-20020a056e02184b00b0035d6d535439mr12806246ilv.11.1702477817424;
        Wed, 13 Dec 2023 06:30:17 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q27-20020a63f95b000000b005c6746620cfsm10005338pgk.51.2023.12.13.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:30:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 13 Dec 2023 06:30:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com
Subject: Re: [PATCH 4.14 00/24] 4.14.333-rc2 review
Message-ID: <89626bb7-d3c4-467b-a905-59f4390bd383@roeck-us.net>
References: <20231212120146.831816822@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212120146.831816822@linuxfoundation.org>

On Tue, Dec 12, 2023 at 01:05:03PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.333 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 Dec 2023 12:01:26 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 440 pass: 440 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

