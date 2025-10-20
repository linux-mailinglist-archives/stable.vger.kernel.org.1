Return-Path: <stable+bounces-188133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28DBF205F
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67A4134D76D
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3946C24501B;
	Mon, 20 Oct 2025 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u7YATRdy"
X-Original-To: Stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82323E33D
	for <Stable@vger.kernel.org>; Mon, 20 Oct 2025 15:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760973161; cv=none; b=XwzRvKKu8FNy4XEn+tJvbT5gnfIBFrhTlRSpx/JWiZ3Vvf7uAXj4RICZgxbfdRoSsYkhGkbCdhYutZh50WOu2JKg1yc7OJW1mfYQlAg8vhALoK7w5LtxcM/vOSYWhG+uU21yd6TVuzAdDub21MYRZ1jXhSIZHjB2jR9B9Ywn1i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760973161; c=relaxed/simple;
	bh=xOuPESK8A8ZsLAMfQkDlhPH9utzkEu7vEwNlSg8sCvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=HmlCdtQAhxTc7Yb5fVhU1TkAw5tk8mB/aOh4oLECozag/0l1/aLJHk2r6HX5uc7eFL/LTw4s3HZvVOh2pKOHncviA9tSttOwB/iSM0MtbAW42lTtqkhTQsbu9dDpEYK6GlIkAjCBm08CiyqMSwIBH5Bgn+Lw3HGV0PbBwVe/4vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u7YATRdy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-471076f819bso35959275e9.3
        for <Stable@vger.kernel.org>; Mon, 20 Oct 2025 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760973157; x=1761577957; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOuPESK8A8ZsLAMfQkDlhPH9utzkEu7vEwNlSg8sCvA=;
        b=u7YATRdyfxGr5Ef3fOzbO8mHJTbllMykVxqzgsXIYu+uanfTZ3aOzKbvAMoLRUhlMN
         yEMwq+CD5W6iHPn27fpHLpnsNQdtPIUiodC7TkPJ3BHW5JLuxR9v6dszCjQaUMUfynFL
         Mv3ojBMuST2+CnPe6PWrQatrJoR6G3xBcGUKz1q6M6qmhbezZxVeNQsRsrrkOjVQXQLw
         dskg33Z5pk3s6hGCLCkvkRUSts1E7DXOV0FE+UxDcFeo/juNgPTEFjvR5teyadZlNOuc
         OCSiQiGZMsAfGVwn1rjaddR+R3FTT0t2x8q21Rvrz8eckHSUoPbCFHRuaQMvswRTUfbi
         +Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760973157; x=1761577957;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xOuPESK8A8ZsLAMfQkDlhPH9utzkEu7vEwNlSg8sCvA=;
        b=P/pYCwTAz2MfBvxTwrXJBcenZgRqGcgEFo8Mqw7tTx9/IzqqUhH7mo3EbPMd5VKvSk
         QCioMidO1EztauHVWCAGUbXhmg8l6CmJjCdz2CuqNpTWw+ffnL7zfFlWdoIKHuOcMpaJ
         ntKVJ3YLJOqnlReM4OgScCcqpjmBg6Hg0wE2815o9cCInof0yS4pHIPi+rhXM9jGhv/l
         6W3FygOHvCLe2x+tEz3VLtroOSPqnekkHV43jGPVPuPfEGkc4WOqywtsRanvyZxsjtyf
         YgwrZNoc9cn260383bOBjDFD/32IVxt6qeFBbZoYOfeWQn4lGnSBDlXUtjv03ZO4M0Tj
         EWwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf4lsabXPxa+atoiEs6qhpCvgd44SlTj+yMFCHMs1EwTu7nhM+fJyN1sjbbOdA891QlF5MIf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1EkXHOevMPjBZD3EIJtoMlz9fNfEarIs+nZWUbwPIZHObfTd7
	5CDK3fU4FDadBjy+pqHTRrLNvObZJlf+213MH1f5CaZx9IdRqlDvPBr22gZoByAoTV8=
X-Gm-Gg: ASbGnctEFR4S+wBmz3lrARM7t/sxuBXuuiGmucBU5RTJMBIfKYeqIuOf1IfP0IC+kSv
	WhxmXiz+zpkHmy38uK0/EWivZsiWhOnp+/AFvotljXoGm9hbWmVQOJaNUgV1diIEJO95JvJKwLh
	NqossSPhkByaWCfWDoKVATkPW3hb+BXQM7xKh6VYLEvS9on8hMsGHH1hoK1gO2yVyCmZAWcFpG5
	R7Vhc7ncV/KLdPpWV7WNhXXKzLKV0QyOprW7Tdu8yj13FTqjRvscQXYqFWgpfH+NijhKCWqKRxH
	SkoFj6DYkK3vIm6cmpeNzI2PHY/UU5IqAp2PliNeGws8XlJvDvatgiet+fuSlPFZhpG1FevTfrS
	n6DuKQRUYf0g+PYE4mHPuin/FskCmhCJdheIPs5vkAwxMlh4aDODIJBx1AEEjABa9ztilCCkEyp
	bX0Ic=
X-Google-Smtp-Source: AGHT+IECoZa3fLJQgVws7eIYsvFcF+35q6vBM+53448SH1/XsTn40cSP7eTVirwX0Mnmnf2V5Dy6mQ==
X-Received: by 2002:a05:600c:3581:b0:45d:d5df:ab2d with SMTP id 5b1f17b1804b1-4711790bf23mr94199515e9.26.1760973157411;
        Mon, 20 Oct 2025 08:12:37 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:9f99:cf6:2e6a:c11f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47152959b55sm154497755e9.6.2025.10.20.08.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 08:12:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 16:12:36 +0100
Message-Id: <DDN8VVZ4ZL38.13JN04FQV1254@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Srinivas Kandagatla" <srinivas.kandagatla@oss.qualcomm.com>,
 <broonie@kernel.org>
Cc: <perex@perex.cz>, <tiwai@suse.com>, <srini@kernel.org>,
 <linux-sound@vger.kernel.org>, <m.facchin@arduino.cc>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <Stable@vger.kernel.org>
Subject: Re: [PATCH 2/9] ASoC: qcom: q6adm: the the copp device only during
 last instance
X-Mailer: aerc 0.20.0
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
 <20251015131740.340258-3-srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20251015131740.340258-3-srinivas.kandagatla@oss.qualcomm.com>

On Wed Oct 15, 2025 at 2:17 PM BST, Srinivas Kandagatla wrote:
> A matching Common object post processing instance is normally resused
> across multiple streams. However currently we close this on DSP
> eventhough there is a refcount on this copp object, this can result in

even though?

> below error.

[..]

Best regards,
Alexey

