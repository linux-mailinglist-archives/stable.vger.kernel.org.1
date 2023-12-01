Return-Path: <stable+bounces-3595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA42800305
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 06:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2478B20B3C
	for <lists+stable@lfdr.de>; Fri,  1 Dec 2023 05:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1655079EC;
	Fri,  1 Dec 2023 05:30:09 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E4210FD
	for <stable@vger.kernel.org>; Thu, 30 Nov 2023 21:30:05 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2865742e256so311766a91.0
        for <stable@vger.kernel.org>; Thu, 30 Nov 2023 21:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701408605; x=1702013405;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RQe6d2mCUPulMVUITPnzEMGLHtagoGQTfC04bjLvHSA=;
        b=bfvELtfV2ZaO6TCLQJlVx5OZ7UxWGMWKH19lRSLFeu41aBomyNm7TInRu9rht7fkiQ
         NMxgyQgQ2SZ7dJr69EOnUPHU8cMaQr12Psuhw/E9LOm4CkC+v7J3zrAZ5iQt0l9P4GwF
         Kt5NhnShk5tWT8N6MX9RbDe8stvDFRLbJGQfGzyiQxlIPSHHiG+TktBNz2OdSBZZ9R8k
         6v5bRKRvL7QiP9H8KZOkOTensgWpqVNOUAramOIz+sYtLBwNe6JNbEVbe89becwHHkio
         PWVJryEXraZv+2dfaZyOLPglP7J2UDfhSJZGCJKLxOgJ6efH1FOgxLiLLKS62lTm7Dy+
         knDA==
X-Gm-Message-State: AOJu0YwJyavx2/+5lGLrOYUnGyoIMHdGoXt05yd6XXoItZj6yJDRJSKS
	fsLctYEJP+H/nrFFMTp/zwVhMqU0gZ8milEfzlQgv9+/Og5zFw==
X-Google-Smtp-Source: AGHT+IF45VaQkQh+Qb+PGGfjTtPwchq5ZjseiLMMo4bOpYwJMdx97BiiVyx0dAeFXwy/vqFqrFVkEeWAXevsinFMSaY=
X-Received: by 2002:a17:90b:3850:b0:285:c1e1:66e with SMTP id
 nl16-20020a17090b385000b00285c1e1066emr15306836pjb.48.1701408604697; Thu, 30
 Nov 2023 21:30:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 30 Nov 2023 21:29:53 -0800
Message-ID: <CAM9d7chJ8kP5VP+SbQzFfhvRD49X5qccnzysY6hJHgWG2KSLbw@mail.gmail.com>
Subject: 5.x-stable backport request
To: stable@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Pablo Galindo Salgado <pablogsal@gmail.com>, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hello,

Please queue up this commit for the v5.x long-term stable
series (and v4.19 too).

 * commit: 89b15d00527b7825ff19130ed83478e80e3fae99
   ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
 * Author: Adrian Hunter <adrian.hunter@intel.com>

The 5.x stable series has the commit babd04386b1df8c3
("perf jit: Include program header in ELF files") to include an
ELF program header for the JIT binaries but it misses this fix
to update the offset of the text section and the symbol.

This resulted in failures of symbolizing jit code properly.
The above commit should be applied to fix it.

Thanks,
Namhyung

