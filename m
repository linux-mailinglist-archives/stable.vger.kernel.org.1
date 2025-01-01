Return-Path: <stable+bounces-106628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0131D9FF414
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 14:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99E0161726
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F353A1E25E7;
	Wed,  1 Jan 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpBSpP2S"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2C51E22EF;
	Wed,  1 Jan 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735736417; cv=none; b=nvqqfSgngjAhMTHIlWWjzSWoNXgc7okbeUUWWu1rgE/IdIyExMuP28kzQfSWhoCUJebjT4akVDbBMBQxfbCZex8/8L2O9DpSU0wva7p5ffCYlh4386BkwESv9mdvs4RzO0WN/rngVYtB6YjFgVi4ePGbgFJSPAnKeH/WFa5575U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735736417; c=relaxed/simple;
	bh=0uAAxCpg43REf7bIKZ/E2f8ilVfL8vhTcdzJgfyhlBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIlrLINAnxgScA2k+bz0o8cRrvub7b2IfOo8cOEv5etz6zp+HpV9Q+9OcbH32+Ag56YL3MRSRLHaqRXrED2ZAkvBffKptf/Q9CRujcBEQx/U8BBL2E16PgnBc0+rUD/UQkCEmwm0Mrp8+gxbmVyk+HaPVdkG6wkasWuoftxWKbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpBSpP2S; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29fae583cc8so5556210fac.1;
        Wed, 01 Jan 2025 05:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735736414; x=1736341214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Us8i9XD6a6Xpl19PsypD5kc87khcrnEieosq8SfZKws=;
        b=YpBSpP2SIwLqNKLDejd1uArRfARmjXfue/CSeacCqzsWhgR9iBfMjKt0akkW41XYFT
         oVS7iOf9s3tj+vJNKTECjP3lVFjK6ns80AG4XY0Jl/T84nZO8Iayeg4O2FvaeZI8NvpM
         BPH7DHEpexCaJQqNK6+2ZRwhbjlAXWm7dbHZ29LhwgO3nZ+iXtvl66DTlv4Ij/Hs8CZv
         mflAVvihLl8Gc3cTOlndX3OuXHrxwPanjxXkTpxTiC3FV09jmTYuacteNUUACV8fBwS8
         82sUe59g19tdxtTYDNM4LNBvIvzCbxiskAkZRFxNXvsr3AE8hYJeqWpI9OZmoEV4Q5yX
         OI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735736414; x=1736341214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us8i9XD6a6Xpl19PsypD5kc87khcrnEieosq8SfZKws=;
        b=AVexQ6vf/9NJuHlgelfILePHKNTVi/g/ZI01F7sq1U1MuiKv0PuFDZt+l5+FKYRFj3
         iQXfHnT1RTQuGEqj2RfnlK+Zpk683x0imm2d11UeQwCKzm7/8uGmECtIJeTMqIF6AM7O
         m19AfVjIWM8GCiuBzGAL3pulmuci19aCL9QZvgqnDyR1Wc1VXOKOXp83a1zyaWpTyIX3
         kIbmV9cwf4cuCn8ZhCT7VO9ya/tYBQaVcovpD4uutlKsKRvtYhAzejY8H5gxSHX7Sjwu
         wMaS+txbkx1HK0Wc+ujdAoK9+v01ubsLRu0wgH6Hs7FSpLg//z8zty/Hhsz+X0GXu214
         CzTw==
X-Forwarded-Encrypted: i=1; AJvYcCVS6ICRX+1HHsLgvaYDnI9jSV8pJqf0EM2USfo0znRWdHqv/JT4RfmTQoRxG8aWdICKs1o9tcjtkv+u@vger.kernel.org, AJvYcCWMRVZyoRJCiq5xBf7r7Rs5n2djwqgjaL78OCnmdI0ouyELAxQ1OMNd7UZNM+Ts/pjTn5qqEneZ@vger.kernel.org, AJvYcCWUYedkPA1iZU4qsnrQkkR0Qq23wGb6aJX5LO61sRlS25f0riwyj7mjsDSWJsaQFezDhSMLdO8k6k4GZR9q@vger.kernel.org, AJvYcCWfS5BsmcspKz8OBesKeCUgt4b05AjTdZOrjEHOBJvlddAGryq9o45TSAjN8k2gZHZrp8aXiSXw1vyo@vger.kernel.org
X-Gm-Message-State: AOJu0YxHWU0yTlRkAQRz55alZ+qugvWitkjvLD7Wgcsws5+4C1DkJyO3
	xmPwK7+3682q7RiFvD2kHpOmJJHuu2tzmv7iv8mLgt3BxwglVO9TIuu9rmtDyaooJMYksjjuLuF
	bgetjx0FAdggYVOP+GedN9GoRabA=
X-Gm-Gg: ASbGncuXFNMjc02ASopPVhKhW0DqfXlVQihaeutzfRh8GY3mhoXRfDHfcT/vuYiSU2E
	G/amoKO834fSrYba9BjK60EYvXuyR6JYAnmd2
X-Google-Smtp-Source: AGHT+IHB2p9zwQITExAMkGuoasknjjtf0eq0ZjWNrICxm1bkeWJVYYMRvMR0UNZMYJa8ihH8tKafnye9YbzIrp+A8eI=
X-Received: by 2002:a05:6870:b48f:b0:2a0:1437:8d1b with SMTP id
 586e51a60fabf-2a7d12a49d5mr20209177fac.11.1735736413697; Wed, 01 Jan 2025
 05:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241222105239.2618-1-joswang1221@gmail.com> <20241222105239.2618-2-joswang1221@gmail.com>
 <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
In-Reply-To: <exu4kkmysquqfygz4gk26kfzediyqmq3wsxvu5ro454mi4fgyp@gr44ymyyxmng>
From: Jos Wang <joswang1221@gmail.com>
Date: Wed, 1 Jan 2025 21:00:01 +0800
Message-ID: <CAMtoTm0nCL7jL=Wno7Cv5upyPnF0wTOXbY+WNG+y1P94513Pgg@mail.gmail.com>
Subject: Re: [PATCH v2, 2/2] usb: typec: tcpm: fix the sender response time issue
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heikki.krogerus@linux.intel.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	rdbabiera@google.com, Jos Wang <joswang@lenovo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, thanks for your help in reviewing the code, and happy new year to
you and your family!

For the first commit you mentioned (modification time is 27ms), I
understand that just modify the include/linux/usb/pd.h file:
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index d50098fb16b5..cd2cc535d21d 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -457,7 +457,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_NO_RESPONSE       5000    /* 4.5 - 5.5 seconds */
 #define PD_T_DB_DETECT         10000   /* 10 - 15 seconds */
 #define PD_T_SEND_SOURCE_CAP   150     /* 100 - 200 ms */
-#define PD_T_SENDER_RESPONSE   60      /* 24 - 30 ms, relaxed */
+#define PD_T_SENDER_RESPONSE   27      /* 24 - 30 ms, relaxed */
 #define PD_T_RECEIVER_RESPONSE 15      /* 15ms max */
 #define PD_T_SOURCE_ACTIVITY   45
 #define PD_T_SINK_ACTIVITY     135

Is my understanding correct?


Thanks
Jos Wang

On Sun, Dec 22, 2024 at 9:14=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sun, Dec 22, 2024 at 06:52:39PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > According to the USB PD3 CTS specification
> > (https://usb.org/document-library/
> > usb-power-delivery-compliance-test-specification-0/
> > USB_PD3_CTS_Q4_2024_OR.zip), the requirements for
> > tSenderResponse are different in PD2 and PD3 modes, see
> > Table 19 Timing Table & Calculations. For PD2 mode, the
> > tSenderResponse min 24ms and max 30ms; for PD3 mode, the
> > tSenderResponse min 27ms and max 33ms.
> >
> > For the "TEST.PD.PROT.SRC.2 Get_Source_Cap No Request" test
> > item, after receiving the Source_Capabilities Message sent by
> > the UUT, the tester deliberately does not send a Request Message
> > in order to force the SenderResponse timer on the Source UUT to
> > timeout. The Tester checks that a Hard Reset is detected between
> > tSenderResponse min and max=EF=BC=8Cthe delay is between the last bit o=
f
> > the GoodCRC Message EOP has been sent and the first bit of Hard
> > Reset SOP has been received. The current code does not distinguish
> > between PD2 and PD3 modes, and tSenderResponse defaults to 60ms.
> > This will cause this test item and the following tests to fail:
> > TEST.PD.PROT.SRC3.2 SenderResponseTimer Timeout
> > TEST.PD.PROT.SNK.6 SenderResponseTimer Timeout
> >
> > Considering factors such as SOC performance, i2c rate, and the speed
> > of PD chip sending data, "pd2-sender-response-time-ms" and
> > "pd3-sender-response-time-ms" DT time properties are added to allow
> > users to define platform timing. For values that have not been
> > explicitly defined in DT using this property, a default value of 27ms
> > for PD2 tSenderResponse and 30ms for PD3 tSenderResponse is set.
>
> You have several different changes squashed into the same commit:
> - Change the timeout from 60 ms to 27-30 ms (I'd recommend using 27 ms
>   as it fits both 24-30 ms and 27-33 ms ranges,
> - Make timeout depend on the PD version,
> - Make timeouts configurable via DT.
>
> Only the first item is a fix per se and only that change should be
> considered for backporting. Please unsquash your changes into logical
> commits.  Theoretically the second change can be thought about as a part
> of the third change (making timeouts configurable) or of the fist change
> (fix the timeout to follow the standard), but I'd suggest having three
> separate commits.
>
> >
> > Fixes: 2eadc33f40d4 ("typec: tcpm: Add core support for sink side PPS")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
> > ---
> > v1 -> v2:
> > - modify the commit message
> > - patch 1/2 and patch 2/2 are placed in the same thread
>
> --
> With best wishes
> Dmitry

