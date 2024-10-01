Return-Path: <stable+bounces-78552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93898C12F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1376A2839B6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 15:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864FA1CB529;
	Tue,  1 Oct 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3lyWkIwU"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D452E1CC8A6
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795153; cv=none; b=FHkpZ4VrQk40/vlcexoclaLRlPDdI8Y9wbtcEC7Gg0Gtx+VHGfvclA+ifEp18VLa80fdI0uVjbyskc/tkMUFD/s6Cq7dimJSPoquMndtBV6QjLzd3Gbf59RuHjWzIA+2OlDp2wQKLjaWNmZW7Hyi1b+CoX0HETvAXcuL18NhLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795153; c=relaxed/simple;
	bh=SWgoSI2AYx9jfAkhOX1WH3TK3W9FMDIEL2mAGp/iDWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EtLccO1b3hhyi5k/DT2BJ8fMU6a658Z8Nnwhlr7jGolohg3jbcp1La503U/iKYQ+konDN3G0I9ZdiEW2rtZ0dIn7hJHlxZ3EVf5i0FMxUlxHCCAXBhpt0VTeImc7ySkcsYV0KdRUQO2iQp+NJuXqRLD5INm7mczQLpnoxmjQU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3lyWkIwU; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a1f1ef7550so28847575ab.1
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 08:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727795151; x=1728399951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWgoSI2AYx9jfAkhOX1WH3TK3W9FMDIEL2mAGp/iDWU=;
        b=3lyWkIwU8pI8dir1U4YkYUDhvBQIY/+epyJllubT6x7c9mr/XBH+fE0fZ/SPV7gkhn
         O0InWa1BV95ZYVGR3qEvwYMi7/VDTwHEtt6qBWj6cu7j+GKFgTa8u4bkjUVGLE0rpUnE
         QTgma/CZ7CtuM6N4AxvunJx5DBi0BFCHqYOk8T4z1HN4MNfLGO6dfbzTl+OjdPY4HVhh
         wPSXdDQSQVSbALDt8h2AANY8iOOx6TDeiIFjVjJQbdzUjMRtz1itf42rZsTrUFU8uB+H
         iFrUvH4ih/HKxQhcJ6u0FlN+xxosX4GCUlUVtzX7s5e/I0yT67D6Cmw1AcHT2AzRrFMA
         WnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727795151; x=1728399951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWgoSI2AYx9jfAkhOX1WH3TK3W9FMDIEL2mAGp/iDWU=;
        b=HNgVvLlgDJEw5ZT3b4th2PPQ1bRfXBEswKGziquLD4oFjh+ll8o2Pkx/+TOhQ1dMHU
         WQnR83IJrB4dyZqK1PcV9bfkp7HvoYBSAq6YQ6zGfyOiQWdlPWrQq4XtL3p72Xcptsuc
         aQUEHMEwQjNnC8UGmlhYI9pZ/lkb5h8F55qV22iyVUIsGDR0VFxDRzkRUEgplXvkdQp+
         uO2k+jCymYyH9EYZQHXIHT4XTczXHTQPFwiraDPEEEU8Gm5HFqIQ7GWfH7AciJ8ky5ob
         5+FOUMbkTGr84CyvDNtHKK5nN0DGEofwLlP3GsmFb9ZCcUiG7+aWR7YEIq8+UWxHh0S4
         etGg==
X-Forwarded-Encrypted: i=1; AJvYcCVVLn0DN72H+mZjMOmNs2TVJyPwT0F54B3lMqYVtS8GsemyrTZcQbIAkRRMNJGveJX4jWv1Wvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlG/vb3+KIsNDKo+giH3gPnRv82S0BrF7PyCk4D/k+lKPeVkKG
	wzCBspHZbcnWuw7GiHb5hfin5vih4SuzK7AW5gw9sZPexPm+NPXlU5sr3Gw/O6+TrSMH4/wqBak
	67q/tgV5+brtY2pL745OtUTmN7jxah49vERvv
X-Google-Smtp-Source: AGHT+IFYhGN1/EqXsAmRGJhOLtUtIkXYKysoJ8g6a4JcGZoVUc96KdHyWTnep2+hbuEvm+kWxOb07P6VtxlhlwWD9lU=
X-Received: by 2002:a05:6e02:164b:b0:3a0:9ea3:8d79 with SMTP id
 e9e14a558f8ab-3a3451bbd54mr155266705ab.16.1727795150688; Tue, 01 Oct 2024
 08:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024100127-uninsured-onyx-f79a@gregkh>
In-Reply-To: <2024100127-uninsured-onyx-f79a@gregkh>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 1 Oct 2024 17:05:36 +0200
Message-ID: <CANn89iKy0uzynO+0K-H1hiaEx301ZCFcXfgQ3UNRDfpWddMVtQ@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] icmp: change the order of rate limits"
 failed to apply to 6.1-stable tree
To: gregkh@linuxfoundation.org
Cc: dsahern@kernel.org, hawk@kernel.org, keyu.man@email.ucr.edu, 
	kuba@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 4:02=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-6.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 8c2bd38b95f75f3d2a08c93e35303e26d480d24e
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100127-=
uninsured-onyx-f79a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
>
> Possible dependencies:
>
> 8c2bd38b95f7 ("icmp: change the order of rate limits")
> d0941130c935 ("icmp: Add counters for rate limits")
> 8032bf1233a7 ("treewide: use get_random_u32_below() instead of deprecated=
 function")
>
> thanks,

Hi Greg, I did the backport of two patches :

d0941130c935 ("icmp: Add counters for rate limits") clean cherry-pick
8c2bd38b95f7 ("icmp: change the order of rate limits") minor conflict.

Thanks !

