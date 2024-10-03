Return-Path: <stable+bounces-80652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEB98F1DE
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 16:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9FE282EAD
	for <lists+stable@lfdr.de>; Thu,  3 Oct 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442401A3AB1;
	Thu,  3 Oct 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyfzvENG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2561A3BCB
	for <stable@vger.kernel.org>; Thu,  3 Oct 2024 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967083; cv=none; b=KX6OO1QIE+l+hXjNr08ekbIiIkzuKLQELyzyIw3Lxdg1n2Gyrd3Yj/a9jFi34fenRRRRFOmI9ZRYmC3rlacxyFfPIJDDbufRLsyiab2rhnumarGdLpuTuPsErUCQf0fcsqsnXeD54rBzdyCSVqUjVvQcBeIZma8WcBAtiKDc4nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967083; c=relaxed/simple;
	bh=NeXhRRZE7DT3g8kJ48kuyLUXxM6zfLePzejvee7tD2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5ZVMfQYaSY+7R1afL3p1Ww4ClHhs0THmckMszWIMZKOp8aWtqX/BABL7Z20RGJxSgKrWTX8Fu8/gIxBY7IhegImF9YtKCWFuwIBPVmcbCGarPi9LhEcJKDA6A5w/lC4dezRzLJNR2jqyydm1d/06OJ1/stEq3LgbGLqqAxkypY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyfzvENG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c46c2bf490so639289a12.3
        for <stable@vger.kernel.org>; Thu, 03 Oct 2024 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727967078; x=1728571878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TeU1LyZudadV3KNmAo2vsrTm1POifx06+ONtSSucOhs=;
        b=VyfzvENGOAqJOg6vmbGWoM+jJP1RfZDiHf0LmAqoLR64HDsTIBbUNpkODdLCmHgbxr
         I+rs+Nhbxaevl7hT3+4ohEibOBwTvbKupZw6SZo6s94vqTk04e59x5KnZolcdZYdvRHI
         eet7rzE9wZ6MCsSXk/p5s9dkSxdLeQXXDZ2mhrUjcDOUq0FA9pPU4P/64pYvox3qJJPl
         f/BXU611YUW3INHwtjNMUAhd2IyPsOIg4Slo9eFul5IaRhwDSY4VdaP8iWt3oxDHhOBs
         WB5B/rI6xnZQ2wCtGOZUqtZ5n/GaN5taUtxU+NM3xNCIEm5umnyaogvwz8HTSBJrgYhc
         aVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727967078; x=1728571878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeU1LyZudadV3KNmAo2vsrTm1POifx06+ONtSSucOhs=;
        b=NYioVvPO/APXzJVEN7kKe7r3f0LOpc/M37xIReR8E6but/1/pWBl6RpNF1yqWRQYuL
         4gd+3PySTM+EwC5gbCDH/1Kh1+2YEe22S8TCP2K0e3WUzmie2ROJrcxdP3h84c7/02z3
         dAVyAjDt82yXSxmhJcVxF5xj0IefpoZYnYvVAIzqK4V74yOf5wNrGYbqRk3EZ+zOULCu
         jSeBf83i9JgNFAc+lrNF1Oz3ZYyfxxZ4Nyb2soGctXkEyywZKfvA0rkf4YHtCmtecz2X
         KZPOg99PWSthvJQTxXzvvffGPxAeT5jSdYxg5HFdJ6zRhnaHEcB1h5QepGpVZszdx/Nx
         0hZw==
X-Forwarded-Encrypted: i=1; AJvYcCUsUJxjZ8v5xJ8XGJJ25O2EuZuprw4+E7AaV1UkQeKqEn2COMds8MPDXWMDYNRdqEOi19ctXT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXrXZ8O3lzw+ODIMMkRGs3HRmTqZbtxehmBid1pUb77yB0Wjg
	laDzC3hbt2k23KQGlS/1IJofyfCcRxIJ9EzfNX1w5BGoiA5ZplKrv1/nxycK5U7EyLm4v8PnjH1
	x6aEY/S/q8IIW0bXSRBWdrTkGtQSigFTlVqYVXQ==
X-Google-Smtp-Source: AGHT+IFEqCnDPH06RQJ/I2XQsbGBvms4zMBZy4jpAuETf/Gswg5YWu1pgYUlj1PNIxAz+BBi1CXryf/d/1si9ybMXmw=
X-Received: by 2002:a05:6402:280f:b0:5c8:9434:7e94 with SMTP id
 4fb4d7f45d1cf-5c8b190d765mr7338035a12.11.1727967078214; Thu, 03 Oct 2024
 07:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730151615.753688326@linuxfoundation.org> <20240730151617.057892121@linuxfoundation.org>
 <CAO_48GGH0J9z3NCq=jH5PKQewPdrhUiNk-Bu9yKvX8yhsTWDtQ@mail.gmail.com>
 <F1136AC5-0860-4070-B4FA-86BAEFC070FB@linaro.org> <2024100238-margarine-strongbox-d096@gregkh>
In-Reply-To: <2024100238-margarine-strongbox-d096@gregkh>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 3 Oct 2024 20:21:07 +0530
Message-ID: <CAO_48GE-bQ2ZcdXNKsRS6U+4+opkXi0osSEodMUdW+fo0jNACw@mail.gmail.com>
Subject: Re: [PATCH 6.1 033/440] arm64: dts: qcom: sm8250: switch UFS QMP PHY
 to new style of bindings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Oct 2024 at 15:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 01, 2024 at 09:01:09PM +0300, Dmitry Baryshkov wrote:
> > On October 1, 2024 8:27:55 PM GMT+03:00, Sumit Semwal <sumit.semwal@linaro.org> wrote:
> > >Hello Greg,
> > >
> > >On Tue, 30 Jul 2024 at 21:25, Greg Kroah-Hartman
> > ><gregkh@linuxfoundation.org> wrote:
> > >>
> > >> 6.1-stable review patch.  If anyone has any objections, please let me know.
> > >>
> > >> ------------------
> > >>
> > >> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > >>
> > >> [ Upstream commit ba865bdcc688932980b8e5ec2154eaa33cd4a981 ]
> > >>
> > >> Change the UFS QMP PHY to use newer style of QMP PHY bindings (single
> > >> resource region, no per-PHY subnodes).
> > >
> > >This patch breaks UFS on RB5 - it got caught on the merge with
> > >android14-6.1-lts.
> > >
> > >Could we please revert it? [Also on 5.15.165+ kernels].
> >
> > Not just this one. All "UFS newer style is bindings" must be reverted from these kernels.
>
> How many got backported?
So far, only this one. I've sent a revert patch - if you could please
apply it to both 6.1 and 5.15 LTS branches!
>
> thanks,
>
> greg k-h

Best,
Sumit.

