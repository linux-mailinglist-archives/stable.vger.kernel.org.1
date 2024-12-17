Return-Path: <stable+bounces-105039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A2A9F5611
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 19:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2C41888968
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D55F1F892B;
	Tue, 17 Dec 2024 18:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YeKhcdq2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111891F8911
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 18:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459904; cv=none; b=AzDp+02h5oy54j/7c7qHQQAPTxWm4J05GOCnFL0lXoL7k7O5/T3I4Crfgh38rGo9IqH9WtShVJ0YWvU0zM1gD3rlvah2ccLOIEzpJ/xpLbMtttsMmEToEMNmk5wFDmvPVfErk8xPmOtuduqDXXl4B36WB0FtcsVvZe6egowgXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459904; c=relaxed/simple;
	bh=N8eTVIG15b8Txm2GjUbLWrnQoyTPsXqcDWfT1rBo99A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0D31VCD8+Dp/vD2NdfClx4Iz7WrDRXuISgXDNyYgFsO4v0JeiKf+kr8bQqHp+imumdy8blN3aSP1G2Nbedi2P60TvJDJUiPBYZHEJxfY/W1g2T97j/Su0Qqimy7l6HzWuHifkhLshR5L5Kf3KvftwXxunc9MK3UA8IKFlhrKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YeKhcdq2; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso9916250a12.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1734459900; x=1735064700; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=chiV2kyNC2VPSeaz4uEiEuPCz6nVVRZHgOxSESSDtEU=;
        b=YeKhcdq2FaSB/oB5ivaoT83mYkCEVG7xqWVxmDsx+fBp8+QK9TMC/D5nRpZ4ZfLe+f
         yAGHKI7bWDL90PqsvpXX5pfl/DdGBFDp9QOC3nYJT8O45UJng9iUnBBpyW2x1eKEYsoH
         PjlNOF3Fb33rbZ5pbQboB+VjoYx51B9oQ7C84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459900; x=1735064700;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chiV2kyNC2VPSeaz4uEiEuPCz6nVVRZHgOxSESSDtEU=;
        b=J0Kv0qludMwuXCQ0vJ1DPW6UYD5EAKX/PpiorLyMxXaNFpuikZlD89NEBn5fz0PitN
         7YH8exSESA8EmigHQV7QsOPogrdFe1mRWXWJUE9Sh73BN0te3uucf3OEJRHx38koRATa
         P5a77qhtDO6spC5VYa+lfSGhEOfXwmve7SUFLsurGzCZjT0AGjR7329OTUwFbTEm9mEg
         sqlFVGAO82eTaMAOXDKYxaYhPyyGN9POOI/epi1Bz64DQkJNoAid5wel9GXxLTro+Xzs
         ZD3qS7dhshw5dbuYbm4P+TYb90wJRtbSf3eAGWkK8W5kNk4dl7Sps0a2/CcwdnL69aNQ
         oD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUcSG+DbgOpTHXzcBJTfRUoVawMkzYYl1wzWGklLk2rzUPiV/r+Q3XzP7vFdUnXsuGZdZFxt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsk1WxlmgGvnRq078BqwA8rh6a06YLylVgePWHxziXQf2EDNa
	Ty5x7t7AqKM8wzcKEV2zrLWMirQvt1JlxU9TX0DlpTjVW7yGx49+Rs+M/wt9HH9bxsUxgbq+Bg6
	Dj1Q=
X-Gm-Gg: ASbGncsghnTXcMg4zLXnFeyvuN3rFi+zyQLu4LHJbD1T+G7UOGL1rO9RP4hA+WoPv21
	UsK2NnAzWySmTVVc+7+8cbDdovjnZ7kzz8s07caRLRjt0uVrX+hElxsE+MQUQRRbk8Dq94vDZfb
	QDaiSstJDtqVfLNYM7AG0wQmmdtsb1O/NVFKfiyQKMjyGUPS80z8fZ2RnXBqwH8IoBi2Xvwt/Hj
	+DUtigByJzozpaNZHd5WeC5G+32TBlIm9OJ+xFnvI0e4IVN7cHW2AIJ2P63LwNgRkxHgb77OEhx
	ZpHzQP6tf8rZeEBvn6t1cH1egwKca8o=
X-Google-Smtp-Source: AGHT+IHGBafOQH75TuyFQfmNasaxl31oISkDTVMSml+5lMQhETkgQ3u8TREA/kRMJSxCfX9pdpxTXA==
X-Received: by 2002:a05:6402:26c5:b0:5d0:96a:aa90 with SMTP id 4fb4d7f45d1cf-5d7d55e7578mr4620116a12.17.1734459900204;
        Tue, 17 Dec 2024 10:25:00 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ad1a7esm4561463a12.32.2024.12.17.10.24.59
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 10:24:59 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa679ad4265so1216177666b.0
        for <stable@vger.kernel.org>; Tue, 17 Dec 2024 10:24:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXl8YVcncOx6Z1AJBe/ropbIP+nVEjlT3FgbEqXUATBOvbyiepXUGBCZ2ytO5o64wsKBocvbBQ=@vger.kernel.org
X-Received: by 2002:a17:906:eec7:b0:aa6:841e:ec40 with SMTP id
 a640c23a62f3a-aabdca5bf6cmr338877266b.26.1734459899304; Tue, 17 Dec 2024
 10:24:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
In-Reply-To: <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Dec 2024 10:24:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Message-ID: <CAHk-=wjThke2-HB_Zi35xHe9ayTPk=zB_kjd0Hr-Yn1oV0ZSsg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 10:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> What *woiuld* have been an acceptable model is to actually modify the
> boot-time buffers in place, using actual real heuristics that look at
> whether a pointer was IN THE CODE SECTION OR THE STATIC DATA section
> of the previous boot.
>
> But you never did that. All this delta code has always been complete
> and utter garbage, and complete hacks.

Actually, I think the proper model isn't even that "modify boot time
buffers in place" thing.

The proper model was probably always to just do the "give the raw
data, and analyze the previous boot data in user mode". Don't do
"delta between old and new kernel", print out the actual KASLR base of
the old kernel, and let user mode figure it out. Because user mode may
actually have the old and different vmlinux image too - something that
kernel mode *never* has.

                   Linus

