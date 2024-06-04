Return-Path: <stable+bounces-47932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DE18FB56E
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972F81F2269D
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5076F147C90;
	Tue,  4 Jun 2024 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q78JyIsh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2F13D27F
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511529; cv=none; b=NJTy4VlE48C+oUd7QJmuNmTwIkVlYcJBkTz0ae+glFBqNsGI0cE+Cmp971DhMu7J6ux7qIFrLNjXMIlu000sTyjqdTYkPNArMQB/j1892EXg+9esJI44E3loNgs7PCXsADrgEeuzjD11GuyDg8vRYqhkErpgw1VthJlPNodOk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511529; c=relaxed/simple;
	bh=vGp3ovyzZdpRyR1W94NZG7tQypJhWhNwsTCZl5Q5Tek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYcd3+zA7WSvCNRO8cjHQjZ4A5Lsre6/ML9FmsPVKiTgfpe8zobexVQWeIui8wYALqnGMbTC+VP01NhKGQ83Tw+KG9iGvKPbLKjpe6FxQ7otHAaIpM+T6W6dA3KGPzuMMBA7EouMg3bwxHdb6JLpkoyy3ZDoltzmQOLuWGgKocI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q78JyIsh; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so355981cf.0
        for <stable@vger.kernel.org>; Tue, 04 Jun 2024 07:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717511526; x=1718116326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQpV5dfzXhIlBBaFJofdAT+Rq9XDrHNaF91R1+IyrHc=;
        b=q78JyIsh300QLsOzWB0cIrO5QteKg38itV0Zky9xhQNsMKqT/bJqXtn93le7vXbA2a
         kcBFFRhPsHYoYSlkDwdDNtG9wycigglwu18jp3iUPoQ5uEjYZMV85Jzx1ZhEpRYYWiR9
         7CpT3aDElHqpDOnmIEGdIo7GpuAVHvHqS/CgYVY5Cz4CWU2NfunGG7W+lESaduWARcED
         vqmsIyt+it93mQ9j5/5bj6zaEYha7ZA/EA5oyAvsnJJ9N8A9nAvYXS095DU/IDgfYHcv
         y/U/B7gzeO0fme01F1gn7R+/QwGIl2uHzFkUlbVsJJTDcJyhiyiUPcJBuVulULClM+6E
         h4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717511526; x=1718116326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQpV5dfzXhIlBBaFJofdAT+Rq9XDrHNaF91R1+IyrHc=;
        b=mwC9mJsuBiqDjhU3aAfKWERZ4YsFQo3VPp9J34GCZwBu4XUOl9gyFQFhoHfGecxJiB
         YfnA0puFFO/hnMFONZEHyoFrMTQSI7+Hnw4fZqBULzQ9PmruzU6kE+KsPH6Erejt/3la
         JvK7CXRRIatjw5Aq8ZJBBd9zLaA54qU99+2ygCn5WUsDCAP5/Hram6xQmEy8HgIHr2zW
         a7tGb/7Tl9USZGL2XCEBUSqBjlWSkJk/1MfE2PTR8Q6BkNYQckWu3LBdbANDkAMT3oOP
         ppcM0WfHMM+6KXvnE4YJioPjGrKs+0HUf0DtgVg6ZKkHdDLcmwMxU1phlV90ZJkokWs/
         +bVg==
X-Forwarded-Encrypted: i=1; AJvYcCUzAci1AKtjCtoKdrIN0d94cr2RLbptfWZqldj2cZSMc1QF5BlZUlEmMKSGh1z6LCi4dWexpZ1TXLtSD+61Lw8iGD5pv3MO
X-Gm-Message-State: AOJu0Yydj+059a1qd0Bv3cGInazW1ft4hORfaTUrSm9/9uGtpKdFpSJ4
	eL3E3ZVt2WV4jENfRhPdJU3a2NKYFz1rLnKKv2hK4AEYa3w1qlk89HyZzHyjDDAwpHERpD7XHHE
	XZTd4v3IuQoH3CMSV+bPfZ8dF+xY6TWk1wBQ+
X-Google-Smtp-Source: AGHT+IGEpedUSaa44exiq+so0jKgv5XcNH+0+P8IoQJ2kUlE8+YPjvD8hE8Ie7JCngfSpIvxHm8sJNewp7aY8fLH1PQ=
X-Received: by 2002:a05:622a:7392:b0:440:1fb0:1726 with SMTP id
 d75a77b69052e-4401fb017d1mr1630971cf.19.1717511526273; Tue, 04 Jun 2024
 07:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604060659.1449278-1-quic_kriskura@quicinc.com> <20240604060659.1449278-3-quic_kriskura@quicinc.com>
In-Reply-To: <20240604060659.1449278-3-quic_kriskura@quicinc.com>
From: Doug Anderson <dianders@google.com>
Date: Tue, 4 Jun 2024 07:31:54 -0700
Message-ID: <CAD=FV=VpYVE6hksZiyVTG+9qOZnpdyt45Av5JizeUiOHaVzvjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Disable SuperSpeed
 instances in park mode
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <swboyd@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthias Kaehlcke <mka@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_ppratap@quicinc.com, quic_jackp@quicinc.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 11:07=E2=80=AFPM Krishna Kurapati
<quic_kriskura@quicinc.com> wrote:
>
> On SC7280, in host mode, it is observed that stressing out controller
> results in HC died error:
>
>  xhci-hcd.12.auto: xHCI host not responding to stop endpoint command
>  xhci-hcd.12.auto: xHCI host controller not responding, assume dead
>  xhci-hcd.12.auto: HC died; cleaning up
>
> And at this instant only restarting the host mode fixes it. Disable
> SuperSpeed instances in park mode for SC7280 to mitigate this issue.
>
> Reported-by: Doug Anderson <dianders@google.com>
> Cc: <stable@vger.kernel.org>
> Fixes: bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
> Removed RB/TB tag from Doug as commit text was updated.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

