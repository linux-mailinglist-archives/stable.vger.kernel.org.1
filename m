Return-Path: <stable+bounces-112058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2651EA267B6
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 00:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B197A2239
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 23:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A22211A24;
	Mon,  3 Feb 2025 23:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2dHGHRn"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68252211A22
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624046; cv=none; b=UtNm/eWbt9UIAK2sSY/LvloJX1zD/pfKskwTuZ/ILUuNwYOXV3rEzfHXmXohCUw9t3Tue/TJUqpXBSHwhQgxy7rWwdxIVv+DoOi/WaGk2Ta0j267fkKDPomxa6yrjS5OakzLSUsZRuEpxOdT7GefujaTmOsf0ACXn9hu63VOfkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624046; c=relaxed/simple;
	bh=M2w3XqBI1LFOu055TZezIq2s0keVbs0nkiw3h616fv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa2eTaLPYRgvECOviCQHEUKChBOrYsrtKFu3XLspac0OFnBJz7jX3EqvmpnNWKegihLvxuMTL8M2nIlaiAa3yG23q4z7OAnPUefkdXa3rzW6ENQOK3ThSz4+WLxekPI6AQla8SFJuARtNnKWJ/Nr6xkJpaWgISEP0khNUqwvpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2dHGHRn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-543d8badc30so5270962e87.0
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 15:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738624042; x=1739228842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svwUaY/AgsImk8F87XWjzee+6GgygrVf3xyaZxTAuqE=;
        b=C2dHGHRnFqkUE7kbHLgpzRVxeH0Gnkqv2YyM/LmN58YBexXlxnVShEoC/6fKLGuVUK
         3FrziZVSjRMN/Y70qBAyA4I3pq9QLGCS+HYE3bL76GUI3sXGH9b3zPO800t/AlCrIA9j
         aVBmkcTQ1ApOlHYhIMqFhi2DhsfjzjJDeQQuaEzj3mIaBOaIBCUB1owJpcxrzY8vImV5
         o6ebHPswH1DQ4NV4sJl/HEp57DLOsY/uE0aVpYKEcbC9y8rl2jX39GY2tYRQ17Tyr06U
         /i/JPhy2T26Vm+wMJRcXCrVOUcVXi3pyeqcmq1tKLfVam/BwCbHlhAVeUtM1+c6y5Ir1
         jN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738624042; x=1739228842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svwUaY/AgsImk8F87XWjzee+6GgygrVf3xyaZxTAuqE=;
        b=M9IXcA2HdWs1z/S43J3nrP6hJ0v1EBu+hxlCJ1WeccwBd+egth//hHc8rvHvFb+ilM
         z0hgbz2IATzXLrgDZR7eRS2hDTERstVbpj/MXb+D6MgxPSw5YZdXdVEuATDlzZmouZ87
         /KaVWKrFMq3C+1v1AcRtLuoTptSdgYvqEXcr45ryhOG9X7+/W0429S41K1Eb1qzMgkXP
         TzYwqYL1eHU7tCdGZSmNG2lQxF1pWpEGq8fzPatTvrhd6fgzWj2skK9b5pxWIex48Ily
         GvWwHoiB8EAi3o88EHiyEnMgA+XVAPysIOHlslc2XCBc4B3hB9wMT43G5jao7rfT/ujf
         EjNw==
X-Forwarded-Encrypted: i=1; AJvYcCUdD4owe9B6kp/WxMLtMLAXdNOI+7Lxa23o+BZsS+MGNUXf9exiyllI2e13E55MAYfIoA5PXIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrUBwtqKgFfwUOJViQQsDuyrE9r8Hc/UoMt5nt+3KPIkvDuuZG
	ZDIW4f1siKvd0Jirk2XNTNfbLMc6ii+Z47BjajundUYvmiEZkeY9RktX4NlZkhMLAm1GMlHTFXF
	WXowQ02i0eHDfUKjO8zdowzVpbQxNi8+8/SiA
X-Gm-Gg: ASbGnctmMKW5uJsMqNqmlxklL1IdKDy4RWRY3JREL8kDSQhuw+mHi2Rt6NsoTxeEeQ+
	TAX8fe6Whg47GFc/0VdcKsp7zzsNn+cC2Q2hLM4aUP/PCZcB+QvoHkel+bLiINNP8T1eM8fELvi
	FVsqCLDbPzX7AAIfBBup7dpX8ukg==
X-Google-Smtp-Source: AGHT+IHTU25ruxLMbTA/rNlNPHkgunVRLhjwLYjYm77haSUFAnmqEMkV93UqqfMOyTez8ElyhJZjOUul3shM8Bzf2fY=
X-Received: by 2002:a05:6512:118b:b0:542:28b4:2732 with SMTP id
 2adb3069b0e04-543e4be947emr8761617e87.19.1738624042144; Mon, 03 Feb 2025
 15:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh> <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
In-Reply-To: <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
From: Daniel Rosenberg <drosen@google.com>
Date: Mon, 3 Feb 2025 15:07:10 -0800
X-Gm-Features: AWEUYZmsRqc6CfAaad0GqfvJKZlnCJwcK-6nF3wr3xkSVGNuChY132-7z7wPn7w
Message-ID: <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
Subject: Re: f2fs: Introduce linear search for dentries
To: Todd Kjos <tkjos@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>, 
	Android Kernel Team <kernel-team@android.com>, "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 12:29=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> As the original commit that this says it fixes was reverted, should that
> also be brought back everywhere also?  Or did that happen already and I
> missed that?
>
> thanks,
>
> greg k-h

The revert of the unicode patch is in all of the stable branches
already. That f2fs patch is technically a fix for the revert as well,
since the existence of either of those is a problem for the same
reason :/

On Sat, Feb 1, 2025 at 9:06=E2=80=AFAM Todd Kjos <tkjos@google.com> wrote:
>
> Before we can bring back the reverted patch, we need the same fix for
> ext4. Daniel, is there progress on that?
>
Last I knew, Ted had a prototype patch for that, not sure what the
current status of it is. I'm also not sure whether the unicode patch
is being relanded, or if there's a different fix in the works there.

-Daniel

