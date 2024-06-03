Return-Path: <stable+bounces-47887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB59D8D8A26
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 21:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A4F1C20F85
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD813B2B6;
	Mon,  3 Jun 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbfW81O5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC913A876;
	Mon,  3 Jun 2024 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717442852; cv=none; b=oNkb6oIhmoLqIRQ/vZ7vgcJI+4E2JF/EmdrGdrL1XFdJ1wlcl8ZSbnqErZL/bYYxCe8fMNONNXtjOp2ryyi0zW1xdLbRxhkJLnxopVCvKILt/A/0DLr2LrGqo3lQe4BKXsBCg8z24gwznFuzl7j/8odi17vkh2KQN3vol/pb0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717442852; c=relaxed/simple;
	bh=zHBew3/4XvlX7DPUyObelgFA3gKLgwQx1HhE9NyOhss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3rlDbm1zHZ2uO0aobFxr52lXNMImQqO/XZw8aBqI/xnEFs2tDza9dv1OvVnfadMyR4r5Z0bezzRs3A09Xc0HeTdMfOOMbckxinWGDisDZ3N5q4GkmQRN0SQgEpjBGBjrNgpIBrK3XZhkbThpEy81M/tRjjXYVwxZhfLEYuUYlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbfW81O5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e72224c395so42546741fa.3;
        Mon, 03 Jun 2024 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717442849; x=1718047649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHBew3/4XvlX7DPUyObelgFA3gKLgwQx1HhE9NyOhss=;
        b=YbfW81O5p5hpOVq3bivtiOtv492t9smWzuueNdWzsCvNZhCH3ThpfylryhMqeOFvFQ
         KviQtAKgA8vLi916ZVv7kqI91wvsqePpzuu6Xj5m4FTNqw5VkeRtrbb02IG97ntQKGRl
         glUkSYL6RuV0IOl9nI0BzpVGsqcj/yOdH5/8k9S/ELiPF1HXMqZ1Kk5TtVTZAU1VsTVB
         AQjUB1AeGFITPO6rfabFvcqBk2l0JtIERPVFI8LG7LnmVscAUGSzkHNXAPvLq0xDi/z9
         kIFfSy4zeCmYJZG6WIeXJWjI1G6KcbgKIxv9VTLwEShfM1P4DWXpEgTIdKVroOo1esPY
         4VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717442849; x=1718047649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zHBew3/4XvlX7DPUyObelgFA3gKLgwQx1HhE9NyOhss=;
        b=u12jBIQS5V4C0bROZAUurUVpvKnz0oLIOXvzgVr4OznTMvG++9wH0YNHf8Sr12m4IP
         Bgv+oXM7K4bzHeXtzMfaqZ2nC/Ys22vO/Vt3c6bmxVB/nrFv6NY6mRpFShEUZOR5KcOp
         f75Tg0PynTf9hY7XWiQJkfzr2cgmTI9i9SS0O9++ij7ptgY9SxOfkkfo4u2RzuTszwDM
         lySJLP1nQuUZb6K0VkSvKKMWOxDlpAYoOfVlntiYicalwuAIAeEI0bEBtE6fpbOLozlD
         c7SLw6/p+ghi2fmQj1LUJiu/YzbZpxzUMSdOcx6Qtm4YZ8Qc2qQoOUpV2KtAxmuYtXj5
         Zs3g==
X-Forwarded-Encrypted: i=1; AJvYcCUFfK4oSIxVDdwwV0mieZYlGuIVgh9BntTOXucow7OXBMt7MFOv3Q1NnWm7UqQexZ+SwNCnUXGf22ilKL31iCmyct/W1NzoHx5kbzmbVGM9StESA+BV+b8uA4oZ+fMm+rpod896cxnl
X-Gm-Message-State: AOJu0YzuwdcZh/M2TIQEDdMB1pMQenMaT0NUwV5XrKCXfiaBc5GnGtiu
	Mox7ryfNU4qOnz3n3ILvvscBVbUVHw9XGeKnJ4DmKZ3IC2PvqD6L1bvbiuAUo24KnNQLVHFK45+
	Gfce9b8e6QT/j/oh8WBEunaL6a5k=
X-Google-Smtp-Source: AGHT+IEMCIWO8m3KqWtZP8FrbUCeQ0EQAQC7aiQdiNSAJLCQDfTPbR8AIlXxxwTHlztCf2EwhJLKaH/iS5/dnsPYIsQ=
X-Received: by 2002:a2e:9018:0:b0:2ea:3216:7af8 with SMTP id
 38308e7fff4ca-2ea951220f3mr60163221fa.28.1717442849212; Mon, 03 Jun 2024
 12:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com>
 <f343ecae-efee-4bdc-ac38-89b614e081b5@163.com> <CABBYNZ+nLgozYxL=znsXrg0qoz-ENgSBwcPzY-KrBnVJJut8Kw@mail.gmail.com>
 <34a8e7c3-8843-4f07-9eef-72fb1f8e9378@163.com> <CABBYNZLzTcnXP3bKdQB3wdBCMgCJrqu=jXQ91ws6+c1mioYt9A@mail.gmail.com>
 <f7a408b4-ccef-4a4c-a919-df501cf3e878@163.com> <ca7adc9d-9df3-4050-8943-3c489097b995@163.com>
In-Reply-To: <ca7adc9d-9df3-4050-8943-3c489097b995@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 3 Jun 2024 15:27:16 -0400
Message-ID: <CABBYNZJwPr_1u+NYnAVaPOd+Wkrb9Jz40hjWF_8v6p6tTaZjtg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
To: Lk Sii <lk_sii@163.com>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, wt@penguintechs.org, 
	regressions@lists.linux.dev, pmenzel@molgen.mpg.de, 
	krzysztof.kozlowski@linaro.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 30, 2024 at 9:34=E2=80=AFAM Lk Sii <lk_sii@163.com> wrote:
> @Luiz:
> do you have any other concerns?
> how to move forward ?

Well I was expecting some answer to Krzysztof comments:

No, test it on the mainline and answer finally, after *five* tries, which
kernel and which hardware did you use for testing this.

--=20
Luiz Augusto von Dentz

