Return-Path: <stable+bounces-28428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E49880190
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 17:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A52BC1C232D5
	for <lists+stable@lfdr.de>; Tue, 19 Mar 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17151823DA;
	Tue, 19 Mar 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lF4Ir/Fw"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451F823C9
	for <stable@vger.kernel.org>; Tue, 19 Mar 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864677; cv=none; b=VCh/P+90l0uTH69L6FNgLSmOhwrvguRHJL9LJYEVIFtcygcCa25ClyB0qt4Wci45A5/1wpaItf6M94c8y+VFI1VI0LkYK2ddlgP6mN2hcnnVspS/TKR1H7cNduL2YXIo4FGhYNtN8YJNBd53v4UfltPO9372vXnvNz0tDPtpar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864677; c=relaxed/simple;
	bh=rYjMj7ePgUflQEILg5XkDq3SlXHXtDYoYHvIrr8ecTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6GY0jrBqoPf5Z1dONOxP6vz5Pdwmdkacxwq2DJW3jmY+rzdPPKb7kPB2LzQ5RCt0dFsKoGmHSZtLc8t2JghnAe6X1QdQb8K5kXLQjpsFqQMm7GxtD9KysLiD+o6PbnO+l1mMkcoixkjDf6zdvx+ldoVZ0m1Tor0i3/Cbv/SfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lF4Ir/Fw; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c39177fea4so987467b6e.2
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710864673; x=1711469473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=lF4Ir/FwKWl4PUdieCSv+Zv7EdBjdE+sm/bOgiFIEBq5uCwDsryMcKLQ5m0lf7Hk9x
         l66LD2jd8mIMh6/xNRfvq9dlEe0VU9q8jwypVLz5u+G8y9ewoyWFuqhCBT50atSE6ij5
         uPGRX0ra4yj+53w58X70+UgmxIDJwAzLiHaRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864673; x=1711469473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=riAPw+X1m6DmK1tPVpYKEJDjgOP8E/jPhgqRZJ5EE70=;
        b=HxzXTUMK+ofnVxBeQteQ4Q0WBgCmB5qsf+eYn/59CqqBv336NlI121VZjrtTB3V4KG
         5iz2xZxClkCd7iiIGyjh5omWiWPZ2UOK2lM/vD9L8OSoeEER3vhKQuAEJTI8J2INMRkq
         ILlB+QKjlIp0qhqTXnXiXlmCW+Z0UQTmCPgI7RQjUzEUw50v2HM/8LD4Z3Lw7sQ69+Qs
         yHf9PbT31cleNJlxLi+RovsFm80gG0oUZsdoLkqGKJqMcWHm+W72ycl4sj+VBIZY16zc
         aYRClN1ehtYlcvZ5FXeLxa6zZPCvpBr/CQRu9RRB7HPLWVB/eume3dx0UHxRmtZP8/aE
         C/xg==
X-Forwarded-Encrypted: i=1; AJvYcCXcgahKQBSQowmSjXluDlVE9BaJKFV8X+iDNUpyQt726oWCkCVmhomqci2G2+fGAexOttrGaavKPUfe3mv+w9gTaRupROML
X-Gm-Message-State: AOJu0YxAByV4QyIJo6/QsC9LhF7WtJpX0bwZXG7l8eUb+9q2G/yDNWzZ
	bgyfFXv1dk7bXTvWXb9DiuIzI4rEmWiJVO5U9r9p5plmcf0sllFq/vwqz4Qfb2fiAcc/x8Yn0uY
	=
X-Google-Smtp-Source: AGHT+IGPWRJOWug3q+HZTJFl/mNrnnj/jNflceIReJQQQs5nQRx/UTA6RZhl80FsHm0MwWXMjV8KmQ==
X-Received: by 2002:a05:6808:1814:b0:3c2:4efe:465d with SMTP id bh20-20020a056808181400b003c24efe465dmr4065970oib.8.1710864672783;
        Tue, 19 Mar 2024 09:11:12 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id jx1-20020a05622a810100b00430a6fe5867sm5709412qtb.88.2024.03.19.09.11.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-428405a0205so374291cf.1
        for <stable@vger.kernel.org>; Tue, 19 Mar 2024 09:11:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWt9IOqPNx2w3r0+3g5hXGuk2mHYdLPTIXRjGgQcw4rukYGxhzDJ4pCfKlAX2/yZ1R6a3EVx5Me2cBEkhYI2WPlw10qiPq
X-Received: by 2002:ac8:7c44:0:b0:430:bcaa:187 with SMTP id
 o4-20020ac87c44000000b00430bcaa0187mr392494qtv.18.1710864671219; Tue, 19 Mar
 2024 09:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319152926.1288-1-johan+linaro@kernel.org> <20240319152926.1288-6-johan+linaro@kernel.org>
In-Reply-To: <20240319152926.1288-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Mar 2024 09:10:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Message-ID: <CAD=FV=Ut0pOAFxD5KELqK+_bkaKOBaYWTth0aVgO5LmMKraPyg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sc7180-trogdor: mark bluetooth
 address as broken
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Matthias Kaehlcke <mka@chromium.org>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 8:29=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> Several Qualcomm Bluetooth controllers lack persistent storage for the
> device address and instead one can be provided by the boot firmware
> using the 'local-bd-address' devicetree property.
>
> The Bluetooth bindings clearly states that the address should be
> specified in little-endian order, but due to a long-standing bug in the
> Qualcomm driver which reversed the address some boot firmware has been
> providing the address in big-endian order instead.
>
> The boot firmware in SC7180 Trogdor Chromebooks is known to be affected
> so mark the 'local-bd-address' property as broken to maintain backwards
> compatibility with older firmware when fixing the underlying driver bug.
>
> Note that ChromeOS always updates the kernel and devicetree in lockstep
> so that there is no need to handle backwards compatibility with older
> devicetrees.
>
> Fixes: 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial trogd=
or and lazor dt")
> Cc: stable@vger.kernel.org      # 5.10
> Cc: Rob Clark <robdclark@chromium.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Assuming DT bindings folks Ack the binding, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

