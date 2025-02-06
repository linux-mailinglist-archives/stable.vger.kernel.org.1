Return-Path: <stable+bounces-114011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B485A29DCF
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 01:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5641B1888C4F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 00:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AD0A59;
	Thu,  6 Feb 2025 00:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GTyBNeKM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C50F4E2
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 00:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738800650; cv=none; b=rsrTE8X0MXSX/njRa2t5cU8NBcYDl0RGCheIPGmi96u5+ae9YV+VaR1w40j0ZRnu6QbcFUyQGIjaL1iF0/+tOzKb6dC2LrA4I4GnaiGqH5emDnm7I1kWIW24zebp/iut7dy28l/gXJxMwOtmPDtyYX92uD8SmWHtzKDS91Jq3sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738800650; c=relaxed/simple;
	bh=ktOszSOXGVZJS4P8v38BQEoc2+xoAVaZB3Acu7OJZhE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j7TI09XqhBdT8/uW3+LF9lFyvcHZLcn078YJqEuvUawvpxPb9FFCXZtAsg5jdsQXWq6d+7DgbagGFow3b0qEy2LmNkoTrNKPltIDy2I80ZaxA9W/0qS/cS1jQHY/QS+3ITAg9eoLJL+1P+40g8J46KdNUHxmJ8zYalgRKW6it7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GTyBNeKM; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9cd8ecbceso557787a91.0
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 16:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738800648; x=1739405448; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLnDTfmq04prdDzdN9V778SCB30+VGrFKgUvVhDTq8o=;
        b=GTyBNeKMFGRL22kxavUb7kIj+gL4MUamLd2e+sZdNYfGyIWPMrJyUdyN7h7so532d0
         k5SV3eZLtZH5kDSRRMPvSEjRQaabckwE4c1KjKGnG5xuQozDiEg3jwVctgEbzrWL1Som
         affAzzSvE97QtEoXfiwuuo/6iFJC7PNInipsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738800648; x=1739405448;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLnDTfmq04prdDzdN9V778SCB30+VGrFKgUvVhDTq8o=;
        b=neLEE1hfBmHKwPRBafAF+OpjAhONDYhad6njDsQFHcpNj3E59FkfwitJHQEuT1f3Fl
         04HixGDouR1U/Aabpv/I0uNfdKHOqczo7jQLe7I5q9OrrCt8THTyIYAKJFkO8AFF+IFq
         cCWl/PYLmSwa8lGHzTPLFM+/g4gkTHuzNj2HgNLUd9ePpi2LKzfh3Ilq2TR4dTNXhhGl
         81Fdhulsqc/YhlDeHDexMlxSKWramhhT0Nky1VQnu6RiFUQvoDADN6znmSljv5Zzk/4R
         YsA6jTiVT/xGKYeyfDwXuCTLPllfz/0eKdlQ7SxQNDMdlubCbfTYGtgNkOdObwjxn7Dv
         UUYw==
X-Gm-Message-State: AOJu0YxHxFXH7YwRPY5cRjAH1eScKKiY9TxB0t52Xk7w2e7ewkSn3n5+
	KMH2yKahTuZeP9SuwxAnXgPzJG10ea2FGOvKqi8H3R6fchYj6cURwy/5BFij+BJzvon5yGLlDoE
	=
X-Gm-Gg: ASbGncuA7oGulmP9OKhrTX8Z0TNcjws328wKvHuOPTJRCWRGOSeNy+5lCoKQM1RG6Gs
	h6bQ2IKv/Bxi3w/HxSYW/0EtV/KM2Im/j2B7NZQ9epbxrVpEvAl8c9e9Zq0/HLNa9qB/Zsc41E4
	n4npsJk9eFws50OAYzdlNspFKecQw5wimDGQrPAP3dYYm4GOlrOKDAIu2oAblb7ck52pJtU2zrK
	iBAVosnWg33FJl97qln0uHFYGMrXzIvEQ0ELmiL4JNqIH1OOl5omCkvb+WYbbYbk/2AODYFFt5p
	vn78LqzaAiF06zPYSvnoc6V8rb7JYyCxzSlWqb69y24AqatL2req3Q==
X-Google-Smtp-Source: AGHT+IFnX9tzQc99sO/QlkEnpDSvJlb0Dn6IZDh7jYTimsBgmtj+0db8gxKOb56/nN8wrX+SFqk2uA==
X-Received: by 2002:a17:90b:44:b0:2ee:7411:ca99 with SMTP id 98e67ed59e1d1-2f9e075382dmr6771033a91.1.1738800648040;
        Wed, 05 Feb 2025 16:10:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:2382:2804:f923:2c2f])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fa09a46bbfsm16044a91.22.2025.02.05.16.10.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 16:10:47 -0800 (PST)
Date: Wed, 5 Feb 2025 16:10:46 -0800
From: Brian Norris <briannorris@chromium.org>
To: stable@vger.kernel.org
Subject: Request to apply 6d3e0d8cc632 to stable kernels
Message-ID: <Z6P-BnP_nZRz_H00@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

May I request this be ported to stable kernels?

  6d3e0d8cc632 ("kdb: Do not assume write() callback available")

It landed in v6.6, and I've tested the trivial cherry-pick to v6.1.y.
AFAICT, it makes sense and applies cleanly to at least v5.15.y and
v5.10.y (and possibly more), although I didn't test those.

It's a bit of an older (but trivial) fix, and I assume not many folks
actually test out KDB/KGDB that often, but I wasted my time
re-discovering it.

Thanks,
Brian

