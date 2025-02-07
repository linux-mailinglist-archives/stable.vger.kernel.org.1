Return-Path: <stable+bounces-114267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BC1A2C725
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DAF7A6448
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82CD1EB19D;
	Fri,  7 Feb 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n65epe05"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE24238D58
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942164; cv=none; b=EhyryIobD4f16V6r6MdzSkmzJs2lJZSWfExtUdicBG6COFVoMa0Zd4aoNH9KR7HmKjil5TGU7u60mbYo5pI1Y8HN5FmOk+yEREAHG5ApFwHKBAT39yjgOnM9E3Kfjh+d4kSKydUXbNIAteMGPb1TxNcVyryVTDeLLiR28N/TpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942164; c=relaxed/simple;
	bh=OTFyLpxN6C5VuMjj49IaWGV1upiyLkZbFT2jAtsQFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fE3zrywEdd5KQkvQ5SVRy+0k4Bq3ITNckkuBuK8zDKXcmc/e3Y503LwzgEhpU1OhLWJIiy+kjvcSgHmKGI+p0n7h+4hAPJDG2kVVj33ptwzQ6GL/QASKLr64xT6YFbYvVi6S/nlTbj6nEP7m00MDSaFrB5WK+LbzBdVGMIeeXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n65epe05; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso13429125e9.1
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738942160; x=1739546960; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9uBaRTvniPQLL4y9k/ubMP7M1hOn1Tj5yYlr3MZgxQ=;
        b=n65epe05Z7msO7kfYF+G9HmvJ7pHqk/D6XsRWwh7hDmyhheayIZfA3LWu+/G/IDbMz
         +VDxZ397p8fhdt1kQxgPIg431hq1/3rH8bytPOwja0tutK2IACvHrTrdaJ7vJy4njCAG
         nAwNeMX/fRZ+Znui/1W+WKb8G3cXisbmYQU1N8RZ2Lqh036McCBgoJuuB7KV9j1wEZ4d
         iY4+U8EdvEqC+YTW8dbECJDgHz43RVY4hBYSnFF52/bJNDeSnNKGt3deXKALtLiWfVyq
         XnGb9tW6BpaWQQnwOBJZXF0iWBomA9s7ml/j3CtfZxHu7HK377HywDQRB30gfYj8eHie
         bbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942160; x=1739546960;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v9uBaRTvniPQLL4y9k/ubMP7M1hOn1Tj5yYlr3MZgxQ=;
        b=BFBgAhGRH0NEgRRrgsL51y2puDVjyNM2RYHX9iaxLB0/xYt9kCF6uXFHsFWb6UDRXr
         xWuedRybbEL0GR0m1ez8G/1X9PQOap9FNdtRFroqHlr07vbD6KKCbvYMpfRBg1NUrnBF
         QavUljgYYjaaseo56yo1uNsQFb1dgnBX/WCaq27kcOJ4kl1cyQ79G+MRbucmXZnO+5e9
         pZjsvDZPbK0jLuh0juat6TfC5lY5dmH9OM1b7FHTOuNRWXrU9fcQOumZlLRZNgNq//v4
         F7/tOCkkVUlaROvPy+vG5QPc5DzD6cr0ZkxjjIfc1Yk1PKWIwKMEpTxcLN8Im0RsU4de
         k+4A==
X-Gm-Message-State: AOJu0YzGggl9FHv0MrgCuE6n0EeXvcdaamm7CaQEGplkxHdGKOTGVU7B
	52e7ylVBl1xt9vVLHutoE6RMwuHtC3Ycp3w9+4b+MDm+AlKTWyBF9986faMRS8I=
X-Gm-Gg: ASbGncvKXRFcQSXBSj0oCwmYt3KcykQUrZmbzLqrpzaQCiNHpvNIMehmdzQ2VXTs7nN
	Syc5p70oPsyXfd2/gg9n178vOrfK88I4DQaaTBl23CG+jtVM9WP5YYSGgZXVs9GkXFziyc+E/si
	wgtr3p3LwXTCjq8m3jPvVZODl0oduhVCXJIVo8Ak6pvgnN40Qv9bBpBXYGetZXy236iEXu5sVty
	ti4jyZoHM6fd5C6cyEe5otx+b1+eLh/MzNkShxM6DXfNARjVJ2WKGmJCCfOD6J7QWuDdoRw5dGG
	YeQ3/cvVunAUXVNLdGOJ
X-Google-Smtp-Source: AGHT+IHw/7SkLNh3+GoLq4ArzhbTKTIC8ugTZ+xvY50S+PpRvFB2glfM4JxIKwBUi6SdVCWoBonkUw==
X-Received: by 2002:a05:600c:3b91:b0:434:e892:1033 with SMTP id 5b1f17b1804b1-43912d0f1e1mr56753875e9.2.1738942160302;
        Fri, 07 Feb 2025 07:29:20 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4390d94d802sm97702125e9.12.2025.02.07.07.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:29:20 -0800 (PST)
Date: Fri, 7 Feb 2025 18:29:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
	Sasha Levin <sashal@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: [stable] please apply media: cxd2841er: fix 64-bit division on gcc-9
Message-ID: <Z6YmzKDqPjwpTZI9@stanley.mountain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Greg and Sasha,

Could you please apply commit 8d46603eeeb4 ("media: cxd2841er: fix 64-bit
division on gcc-9") on v6.13.y?  It fixes the build with gcc-8 on arm32.
It applies cleanly to older kernels as well, but it's only required
for v6.13.y.

regards,
dan carpenter

