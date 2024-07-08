Return-Path: <stable+bounces-58244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5166692A8F3
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFC5B21217
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8429149C64;
	Mon,  8 Jul 2024 18:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrZFgaGu"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442EF139579
	for <stable@vger.kernel.org>; Mon,  8 Jul 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720463304; cv=none; b=EZ+d54J1OpJ3DfY1xgy4QXaDc/aZAFWavJDnztkO7GNRHBVRT8nh81cQaTwOD8GJuWzoFEHj5B9A035huaSHEoxoo0dGZjkq/HyjNSzxAXCZsV5JmoU1X5aWVdFAN72udc3SExMXRyY/tJ+/so+ZbJn1mFlPxy2m0xUzFnBACUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720463304; c=relaxed/simple;
	bh=pK5FJxAZ0Zgox38ccFvEmzoA9QPHSl0aN2ZmpnthdJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i1oe1K58azHmRhCz+dMrKlz+w4RAVco767ykF6YIXdNrU5+bDW2rO5jtwbff7HgO1S6etMAC+/63QSXfbyobKcP3e4E3Y+caH0Bj/IrRSc1Xg8AKjdMT4YoHE8ynLyb/vQ5/RSIu7McqMFGshJpB6lsZBgxUSXJLzJj+OLRJO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrZFgaGu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-654cf0a069eso26022587b3.1
        for <stable@vger.kernel.org>; Mon, 08 Jul 2024 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720463302; x=1721068102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pK5FJxAZ0Zgox38ccFvEmzoA9QPHSl0aN2ZmpnthdJg=;
        b=PrZFgaGuPOAjVIj/xaLqL+Nr81hez5DLZ4mzYHLblrmJ1Ewo+mcGmKUNif3Hn96JHI
         hC0f6RNkXXyIRIAtsnODRHmodHw+7B7NzecOAQrpVuWraEEk7sgOzS70UNmDW8m63Uss
         MFPYdczH5ZiDsqG81oeOmebKNJaufIji4WQG4uYPheOl5P4p4fbzJeWHAor7aWRlXvpb
         AkudjRJTgQVuQja9wG2G0CoKUCk/o7c6ILUxvYA/+jo3ZG2ZKjukJ2Q44Yv8DHT/KUwe
         4X/kY1XX5rbh9hTj0cuTz2VANrzIYmGYbZo/uFB2YXFOPA6MlRnxygFiTFnmWKPIa3gK
         gnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720463302; x=1721068102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pK5FJxAZ0Zgox38ccFvEmzoA9QPHSl0aN2ZmpnthdJg=;
        b=dZHe5SWsnOCzMU46f3wlIJOTi7lP0uF/08OfT92FITyxJ/rKqZ0dwjDBBNYd0xt3fi
         A+PxQeQ4G6auonku2NMGeFSH61MO5eFbfGJhIaNudG5A80YtLmErlYbq+sSDNWKyew8l
         nUC1EdoC4gOrm0A7i35GfVNQ2r6iEL95azHt+XJLMM55JFxwgfbwaaAFnrpLm21IWoE1
         2oGA5pt60K5Uljz4CgTQp4jUR2yRHaWd5v+irwMIyRPcUifEXtLilDd1PIwOfRClU0PQ
         /k8/38cLjSickBTGUos85sLKjJoUMT9jKIOvb5K5Xu4GzQjJ/ZiD6QC95+Pz6k9FZ+E2
         63GQ==
X-Gm-Message-State: AOJu0YxP0LlWz6EFhT3lzJhBuRRqkEEIO3OyXRXgkh7VkjENNY6d4EO5
	YvSc4dJ/NLF4SQwnMNPzehpWStf7Mu1iP5NOelITX5Jdg4WmIL35iGiLwKnRd2lOh/uK8n1AFFM
	D5AoLBvQS7JMbZQUQ9wegs4YEeY8=
X-Google-Smtp-Source: AGHT+IFwr0agoAnSbhIMSbWlzzNsdTjLYoINYjy2llPL36p+UBMuHqZWQR+OvWjHzHGmOttD3AszBOqXnqGxbQxL320=
X-Received: by 2002:a81:8407:0:b0:64b:a57:8441 with SMTP id
 00721157ae682-658eed5fb56mr4950717b3.19.1720463302217; Mon, 08 Jul 2024
 11:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702042948.2629267-1-leah.rumancik@gmail.com> <ZoPyReRlZ6ViNH-6@sashalap>
In-Reply-To: <ZoPyReRlZ6ViNH-6@sashalap>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Mon, 8 Jul 2024 11:28:11 -0700
Message-ID: <CACzhbgRoMEAzkEVZPMEHR2JsNn5ZNw1SwKqP1FVzej4g_87snQ@mail.gmail.com>
Subject: Re: [PATCH 6.6] fork: defer linking file vma until vma is fully initialized
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>, 
	Thorvald Natvig <thorvald@google.com>, Jane Chu <jane.chu@oracle.com>, 
	Christian Brauner <brauner@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Muchun Song <muchun.song@linux.dev>, Oleg Nesterov <oleg@redhat.com>, 
	Peng Zhang <zhangpeng.00@bytedance.com>, Tycho Andersen <tandersen@netflix.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"

I'd say aac6db75a9 ("vfio/pci: Use unmap_mapping_range()") is a pretty
significant change for stable. Then again, mucking around in dup_mmap
doesn't seem very clear cut either..

cc'ing Alex from this patch

- leah

