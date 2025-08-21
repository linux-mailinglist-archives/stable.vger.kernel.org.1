Return-Path: <stable+bounces-172234-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EFBB308A3
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 23:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017663BB464
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE3D2C0292;
	Thu, 21 Aug 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TpAkFXun"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D7C2E8DFF
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 21:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812798; cv=none; b=M7CM2h+sg+gFORbhr4HzDKfVQ4nxFWOoExCfa7+NncohXkbTQsTn8oSTp7Hv1zgHbbECUrILJfr1nOB/OwGHhJvtQNrfRWUE40PgSfijfKNaMq4Qxk3rQ2JuP78q6aVjdp2+ffcvRNXz6Apbb8ogsXPxTwMe3otl0Ki6dPLM+0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812798; c=relaxed/simple;
	bh=/21qjhkYG5MbGoFBRUjfsOyrm2PMReu12VX6h06fUb4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=l5oaarkS55wILDYdUVZA7dFdIp3Q21jZ9zX4tMvWf4G81CaOHKneWqYJqWWSeXHBmzUtuGvqoI6rYNkYOgdTa7MFvcbNyk6xTvaMW28ifJ+DG+4eaKcscWEHhY1wESQPHo/z0CCtlBqj8bPxySEUOCcBne9OUe1RhWSGvVV5FpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TpAkFXun; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2449978aceaso10478455ad.2
        for <stable@vger.kernel.org>; Thu, 21 Aug 2025 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755812794; x=1756417594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5gSukFnzF9RPh0dN9M/nIBV4M+6pu/ZbkCa4+OFJTSk=;
        b=TpAkFXunrjzSSatxklXiMDoQh/GDgdbnR3c2gwM3U5la6krWKzR+Ke7j/MI1nONL3s
         1MT+coQzqejmVm7tdxa1x46Ei9Qq3+SqK7NWzyGnuOgFvKEKbxkr2MzHI+A25cKE7ABk
         ur1d3Au3pdWeKzHt2atSB9WRGe8yFMrwh9rwrKkIX+lIgFs/0aIF7J5Ox4y582k+wJ0v
         lcbELocNIqXR6uJ9tNGvmVKgxUUL+vA3JEZMhi2rPL1q4cqtjSG9lvkfM82bD/bo0cf3
         jFCVbpEQ7kvI0m6Udo/tO9OOb9S5RXRpJsdog4RZ8X/mAsH7fb6k2s0IVZWgzGAcFALJ
         /uUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755812794; x=1756417594;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gSukFnzF9RPh0dN9M/nIBV4M+6pu/ZbkCa4+OFJTSk=;
        b=udTIz1gwhzj4CC4uR9SxT6VBgfZ9/gfaOCbDKblAoj6KIZ6UyMZLNFbXq3T/lukXnZ
         rI4hfkK33VDf7oFLSZ8sVkrO51YrFg+HOOk/0obIySlAkaVIo+Nz9sKdxYLn51mBmQIM
         BKMIFKOxZglWU4XTBVLe6aM5dkETtrmKPg4a2qRSVR2zHVVJsNZ5BTvSKNsuOGhl/5O2
         SKyjGg0w8BDqtb9XqUUSOyc5Y6IxfvwSq+KZMd2AkpEJnlIPj1rLbgmhGX3T/EpU0QnA
         om/pisWPf1XymixCSU3hgytDRvZJ1FnD40/fRd/sFN9h+weHL8KPbQd669wHfwCKME17
         aokA==
X-Gm-Message-State: AOJu0YyORNfElyzy9ukKnKrDolo2XpJpfjjv6Q4FKm1R0C21WpccVjL3
	t7nm4LVRsxz5I1YaxMSywjL46yzTHy2i0EdifuFtwqN3qP6J+yfof/5z9IsA6Q4om5s=
X-Gm-Gg: ASbGncsBJDk2iemhYudwCx19hO0nIbfGi6V3W/aYWK+2VgF9Z1CaCtJK/JS/Cxrec40
	RKgFZHjDmbDTKbR/gvCL0Ckz7Sn5N/1/AJlTtKrtUmaOnnlPKxtFIHWbyIyah9RMmsewPP4x1nu
	yAfyp2BZ+NcKyB6NEnQ74I8NyOANiiX1DmwmDkq6wz3dg5DQpI/oVnI6XudxWGlIPuWzhCbaUod
	SBFEEsSvaLT5d2bnyY8w9dLOMdbPCSUwRzk3oOCWMp5FxzLpIKKxwFr+oDiPmguep9fz6M/sqSv
	vohdtPNvYbCt+eOwDtdu1X0PIROtxaijel8YMRM5b7WReP7mmHanKqNAAGehCxZVhjRW19mHHil
	GDypHYJIO+8R6ueNitG/q
X-Google-Smtp-Source: AGHT+IH8qJRYEgf2+tKpNrro+xf/ELaO4r6aeYvbZSz/EgwcLZ7yc69DJ5nmzW1zCRKaC0W8sH0vEQ==
X-Received: by 2002:a17:903:24d:b0:243:3fe:4294 with SMTP id d9443c01a7336-2462ee0bf56mr11825925ad.12.1755812794634;
        Thu, 21 Aug 2025 14:46:34 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24629bb5f5csm8021285ad.130.2025.08.21.14.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 14:46:33 -0700 (PDT)
Message-ID: <7a97e700-9ecb-4c17-b393-0f8a31c398e9@kernel.dk>
Date: Thu, 21 Aug 2025 15:46:33 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: FAILED: patch "[PATCH] io_uring/net: commit partial buffers on
 retry" failed to apply to 6.12-stable tree
To: gregkh@linuxfoundation.org, superman.xpt@gmail.com
Cc: stable@vger.kernel.org
References: <2025081548-whoops-aneurism-c7b1@gregkh>
 <75f257ff-21d3-4eae-afa1-a25cff16abe0@kernel.dk>
Content-Language: en-US
In-Reply-To: <75f257ff-21d3-4eae-afa1-a25cff16abe0@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Fri, Aug 15, 2025 at 9:35?AM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/15/25 9:26 AM, gregkh@linuxfoundation.org wrote:
> >
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> >
> > To reproduce the conflict and resubmit, you may use the following commands:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 41b70df5b38bc80967d2e0ed55cc3c3896bba781
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081548-whoops-aneurism-c7b1@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
>
> Trivial reject, here's one for 6.12-stable.

This didn't get included in the release yesterday?

-- 
Jens Axboe


