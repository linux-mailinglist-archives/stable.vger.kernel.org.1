Return-Path: <stable+bounces-112003-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6145BA25775
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 11:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9FC8166D87
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6308D201266;
	Mon,  3 Feb 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IVNl1CU5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871DA201258
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580157; cv=none; b=DmQasZUl6Ngv66IdVcIHr2x7IkAD0RqhB4YQfxhQSzMRtzEQNzp/AeUYK6swHlKnbiN5AL8r94NvG2/wolqscSr4ygqEC9U6NsN0qUoPx6PA86nJqVtV0k+ZQh5nY7K+Rh1yR55ERJIm8M1apfaoJu55GHnu56304kpiBjr+1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580157; c=relaxed/simple;
	bh=/xMdp+OR8wwy6+XfSSMPDQAmvkZdV111tF4rmkARnCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfHOXMo8+RnzKm2t3IPov1M2PkOHHYic6suxMgFzPRYPH6GpkPvRCGevVC7wbDsKkJ8wpng982amz60jmWEX0M6J0ahqwrRuRakr1fHidDd4qp695z6QC9x6JO0ER6gNI3lx6WEpAFqq6k7HcZ7E5VwGkpPZS7ssUAI37rmtCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IVNl1CU5; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-85c4c9349b3so963535241.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738580154; x=1739184954; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+rUm5KJHkxiBfXtuHfaxFq0/vaTdZZ4HaHQLNH5uKBU=;
        b=IVNl1CU55JIEkFisX5t66xbnt9ajW3J9TQlLvAooBXE4yIubA0P10aj9ybVbsAMnt7
         JxNETEGwbhngV5ifsvXgUhf12L2lLghZ/rvw6rTNLG8HmCzqXvycKbBLQhMqlLgOx+24
         uKNwe9y7VTH3VLNhtRa40JJUMFhlMRRUWtCRFAhuRqm4nwpUEx0S+i+CaHjChZrZHyFb
         4jNIFY07xUDRp4EAintBZbxjsjGFtXXbboGG7rtJVmWP/rIcH0EZAZuivvOlTUUjyrMx
         3kzDllI51iqlhSXUYYHeXAyqUVAi380UR5HuNZnNMT+F7MRca714WiT0FPcma3f9KJlx
         dIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738580154; x=1739184954;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rUm5KJHkxiBfXtuHfaxFq0/vaTdZZ4HaHQLNH5uKBU=;
        b=LdTSTnRi8AMi4ko65lF/vjIKKcJjOl/IqRYSUGuBBMnzvah/JZTqRAEGO1HVzD3dFR
         ae2eehQ/ShZfwG3pK2XB+txO2URk88SNxfc/mqavkW4bMXJgVKYAtW91rmdDGIVnC9Aa
         wZCJ/IbTGzku701HxSuMdAhGKvc7+3mJMp39t+PJiThBpy8XcNhtjEjt/ihmE6XXxod+
         lBPAv9Jig1CKD9aUWsuqq8pZiGWW1HhmgcmQPl4SnwWabJ2fyh8AHUYSuenIhmLfElBU
         NJMBKElLqT1tx/SSCJ3eF7a4Uzygdc4v4cjbRhc1TI7aRnOT7Cu/luClMFq5R7JkjhPO
         2Gqw==
X-Forwarded-Encrypted: i=1; AJvYcCUTb0c9eG1K7ly21TCX2aCxhQSSfbp3eGDQsKcvoXAJbQFi2pcBlwdAI+vNTFkEKaRR3X6gWWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMcmriaFhbSFN7sK+yPv4Bt9nmlGvwg5wZ48hUdbBZ5Yimz0Z
	Evq1OESwLxfZC2vioCsBfH6i6EuPHZigt6W6hw/HQahy9wExwffRP2Rt4iPNWUSFq8sbsfkaU8i
	9LhKwP+8JqWgOgtTKgfexo21C9p1yBjP/jrBARQ==
X-Gm-Gg: ASbGnctjNpjwlYHUJi1WAv6n4XSdRsjJy5jae7YVt/8l1OODCLhxjq3YwPzx9+NAbJ3
	acfyz1BFV01ain0IaiRiuCXsl8sI4WWHnMG0wPpYOCIY5gMQMqO6PSpHDM9xbGIn4aw+XD8O0dA
	==
X-Google-Smtp-Source: AGHT+IFnW6Bcf5yEVNRCxppgIk0GIS+NVegSyfhXLF4jlT47dmkxc5NDclwM4Eh+voGMzwf6nGRfT3mSuUEktH+lUjE=
X-Received: by 2002:a05:6102:6c4:b0:4b2:5c0a:98c0 with SMTP id
 ada2fe7eead31-4b9a4d25380mr14983804137.0.1738580154344; Mon, 03 Feb 2025
 02:55:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203080030.384929-1-sumit.garg@linaro.org> <15a801d6-2274-4772-bbe3-5d2083b91b64@app.fastmail.com>
In-Reply-To: <15a801d6-2274-4772-bbe3-5d2083b91b64@app.fastmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 3 Feb 2025 16:25:43 +0530
X-Gm-Features: AWEUYZlHY3gLHyf9Kk9Dd9yJHRbDU4x0ELJaNO83enlNss8d1-v3c6HXdESb-lA
Message-ID: <CAFA6WYNJf2axMuxHmMP2OOdvTJc=YEMEAcSDHZDmiinkMAdcfw@mail.gmail.com>
Subject: Re: [PATCH v2] tee: optee: Fix supplicant wait loop
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, op-tee@lists.trustedfirmware.org, 
	Jerome Forissier <jerome.forissier@linaro.org>, dannenberg@ti.com, javier@javigon.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Arnd,

On Mon, 3 Feb 2025 at 13:46, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Feb 3, 2025, at 09:00, Sumit Garg wrote:
> > OP-TEE supplicant is a user-space daemon and it's possible for it
> > being hung or crashed or killed in the middle of processing an OP-TEE
> > RPC call. It becomes more complicated when there is incorrect shutdown
> > ordering of the supplicant process vs the OP-TEE client application which
> > can eventually lead to system hang-up waiting for the closure of the
> > client application.
> >
> > Allow the client process waiting in kernel for supplicant response to
> > be killed rather than indefinitetly waiting in an unkillable state.
>
> It would be good to mention that the existing version ends up in
> a busy-loop here because of the broken wait_for_completion_interruptible()
> loop.
>
> A normal uninterruptible wait should not have resulted in the hung-task
> watchdog getting triggered, but the endless loop would.

Sure, I will add that.

>
> > +     if (wait_for_completion_killable(&req->c)) {
> > +             if (!mutex_lock_killable(&supp->mutex)) {
> >                       if (req->in_queue) {
>
> Using mutex_trylock() here is probably clearer than
> mutex_lock_killable(), since a task that is already in the
> process of getting killed won't ever wait for the mutex.
> mutex_lock_killable() does try to get the lock first though
> if nobody else holds it already, which is the same as trylock.

Let's follow-up on this in the other thread.

-Sumit

>
>      Arnd

