Return-Path: <stable+bounces-28590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8809A88656F
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 04:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D221F247CD
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 03:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D84688;
	Fri, 22 Mar 2024 03:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PbCDnJUJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CA94436
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711077942; cv=none; b=WD2rIJNg7bD3vb7vJaZ6Pp8oJYP2E6XU6zMbAnX0/NQi+ay3Ee2tKjfDKU03q7CSvwpVGtixWj6IES/DNYyR9XOPftDXoHQx5Et7AQmYL+8I86Expmfg8lOO/H7r2uU0A0f44Z+hoMHE4XNV736KPTHnXjtBXGYjIgWN5pFvknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711077942; c=relaxed/simple;
	bh=rA9OLiQVBndIxCqI/RnL35hJtQlSZt3ZhLZoSTUWMn8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfTsS4tlgYi+JmAsaoO3NCR0PTf1o7lm7aC+BOtW9Qt0lRR7TAi+a96Ijmq27RqeKuHkJv+D0/s5sXmRUQzqPV6afiwFf9q+Ns3v4IQaBqN5uV2uAOmxvjp/kS5G9iTEIcFytz++fCrg8OkMlWgA7glrvHQn+VhdM9OxDjRmLTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PbCDnJUJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1de0f92e649so11241215ad.0
        for <stable@vger.kernel.org>; Thu, 21 Mar 2024 20:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711077940; x=1711682740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UcsMqmY7811GML8PC3DqwKOCOYs9+H/dHHUmPBVs1BQ=;
        b=PbCDnJUJS3zAisOyQ5DDkQvi8p5CkTHVnu9Gh/fnWaI2XVAD48T9DUeZUOgaHOsnQ4
         lR7exPfB028KXLuhYdmkHudjn7faI+3PtMxTdSsYPCbtFx7/SCevBmI+/n9aywYXItA6
         X8ZengrEq18IFYYRsyAdmeEXlT9PAmForI40I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711077940; x=1711682740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UcsMqmY7811GML8PC3DqwKOCOYs9+H/dHHUmPBVs1BQ=;
        b=iLT6b/dLOFPYkXLP/C6EL69V5OIfsbzxOkXpMaCHsfCT77Gw2bIOEwXsVSX/NLdoKs
         oEgET9jviut22CvZbMyoDQHKVOrSEsCdioELvX1lKBtKrSijNbwWLZosSVlS1mN5Pi72
         2Q4YemqRE8i6bpwO/ES8x2swSYQdfzhQPLDSx5mDtC5UXBTLblGf6Z9nwqywfhv/X/S8
         a/aFviwsN3/AiRYVRAQCiPLhG+dYU4N53RDac+k7ugW6zrWizcfORjonlmUrzFn+RQed
         HXIm1IE3UginsT9nq283cFZdd2ZNaqTMJ6gKy5T9xFr2JdhMmgL7kgR11Hu2h+ncFMdj
         PjGw==
X-Forwarded-Encrypted: i=1; AJvYcCUcL7nibPNttSZpObRoK+naByOO16l6RwxrnYrSDOwvv+HOKs4ISfXqXigR+8uZVSVeG3IRY7q/xJ9MU1GGo9COC/zSHEsX
X-Gm-Message-State: AOJu0YzWQ60zn2oyOuJOQppoLJpUT1KzcPL9EGMJYwZ2VOyf/R/qhvfu
	sYCHRY6Smty2nhGllxDyUydGp+P8WpR2xy1pv7pHR9HRIj0jZjI1nvx5yjoNwpx+b9ssD9l3e2M
	=
X-Google-Smtp-Source: AGHT+IFMNGILCIbGOORMV5AHfyreOQC+oqrzNbTvmrzQsA8QnVKKZXTt1rS+A5kiGLdhP2gdpVAEXw==
X-Received: by 2002:a05:6a21:31c8:b0:1a3:7327:2323 with SMTP id zb8-20020a056a2131c800b001a373272323mr1123844pzb.45.1711077544553;
        Thu, 21 Mar 2024 20:19:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d0ca00b001dc944299acsm657327pln.217.2024.03.21.20.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 20:19:03 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-kernel@vger.kernel.org,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Date: Thu, 21 Mar 2024 20:18:48 -0700
Message-Id: <171107752638.466752.7224681033755371253.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
References: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 20 Mar 2024 11:26:07 -0700, Max Filippov wrote:
> In NUMMU kernel the value of linux_binprm::p is the offset inside the
> temporary program arguments array maintained in separate pages in the
> linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
> thus must be adjusted when that array is copied to the user stack.
> Without that adjustment the value passed by the NOMMU kernel to the ELF
> program in the AT_EXECFN entry of the aux array doesn't make any sense
> and it may break programs that try to access memory pointed to by that
> entry.
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] exec: fix linux_binprm::exec in transfer_args_to_stack()
      https://git.kernel.org/kees/c/2aea94ac14d1

Take care,

-- 
Kees Cook


