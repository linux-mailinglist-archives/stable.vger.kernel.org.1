Return-Path: <stable+bounces-26744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8D087195E
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BC91C21D1C
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 09:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B35476B;
	Tue,  5 Mar 2024 09:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skilj3ol"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC3750A72
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630178; cv=none; b=os4HhgIfPvCqKfUBwaccmJ78qvnTBDCGiFN+RbVS811fnk72dPQTPebCTyVWXPJqifXgO04ovs1F5Vwr8xRSIzuy59sRuYRddYViuBtVaK2TAe+tvNLpAlvBvH0R3gPmI/3b2l2bYP+0X+q43nCVtCdFzgN3oDKRAHs4Aqp3yYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630178; c=relaxed/simple;
	bh=pUEkTUaEinq7lTGTudWbBzE6b8iQHi6XhoJnUFsMyNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1/C5ZNX5od/9gslXpprHXerbbCq3zROlx+3UfUCpaOWm1JOQne0B4c43JkdO+RfmQx7CNieXtiua0nKW0HFlSizD9N1krxiyxquTzTp+cOJypk0G4bxX5TqGJOUBAkCzzNG0IUgkFAoOtmKzt7NmaqjwDTfAfIQGD+noonTzNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skilj3ol; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513160a49c1so2839e87.0
        for <stable@vger.kernel.org>; Tue, 05 Mar 2024 01:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709630174; x=1710234974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUEkTUaEinq7lTGTudWbBzE6b8iQHi6XhoJnUFsMyNY=;
        b=skilj3olUBDEob/9lHWfOaAN7YyHitXQ42f0owOVhH+sA3a1ZroLBId0aph8tfI+Ek
         hgwrg0PBLfwYr4KO1G6ZDhrp2ojmSos1/jSqX5Ruebbk+DId7U9my4aWHYrEWsSduhxg
         Zf4b4U38jA94GHjvgzZyQIrTFr96fXIM2Mg+8J0FZ2aoueF+OAopfrfwPRnD5iL29YWz
         KhPY4bscBJ+Thj/0zISFZxL53KCbSWe9mcdnJZDWBw75btJk3wvliA7IkwrlBDN3qwdG
         F1/6OL6hojpGwg3VNZ0GYUEWq1gfSsLDYJZnwE9OoSlos2oq4ceg1KdMAIy2OdVmcz5y
         8PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709630174; x=1710234974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUEkTUaEinq7lTGTudWbBzE6b8iQHi6XhoJnUFsMyNY=;
        b=gm3ZVXcXIXeP/hPwGznI0lzHPX3ZLXudeodlGmCsdBzKrqT7e3kWnYHv0zQQjEMdLc
         CyFKPzKhY8bqEwoATCRspkfjrgtMvweFNApReKhrqUbTwjfHLfDUiaXWb67iW2Me2gtC
         Hc1AGAaiWhz9ALkmJRpiN9uS0TTciXmhgOfivrr07TkG/f1eGZ3oDHo7pTkD9yyL+rH3
         SxBbBmIq+4AIkHXoZBSH08LxNw+Pk4ARyc94xFLJsXbdQuBJdzVWPB4AOcHbtD3v59nk
         m8jzAb2nYC5uDAV2hI2kZG6IappMnveMnYhGwijgyZh2NIsRuAFDEd98rBQYhOHAtKp3
         lRcw==
X-Forwarded-Encrypted: i=1; AJvYcCWTqXMcy/BXStYkE0wnHfhWx6KyjhFbPWN3Ieq0n9DgmW5CK8nyoKfh/fjQviby4UXLp8x3Ss+W+keweRNFg0bQ8I7rb1Ul
X-Gm-Message-State: AOJu0YxVz5U7mMxZ6RzrH3YYHecZzqjYbOmoHLviIfNbV0AOse8lI0K1
	XhtCRqoP9IGskKndzgXI6ZndjEaKQYaH6cHoWhu4uphS6c9VNof8z8FB+AbYIMvaq2ooqhRjYlL
	ZDz8BVmHmw3syoyce0l+B26nF9GP1S+RVju9p
X-Google-Smtp-Source: AGHT+IGBTWDXRnEWgmFcgD/VIsmWhDVWePD6mfb41wRN4IYM0DkvXH5kA4vk5l9vJ/V7q4SYeVmBzdk3b7Lmu1q5dL8=
X-Received: by 2002:a19:385c:0:b0:513:1cf2:e14f with SMTP id
 d28-20020a19385c000000b005131cf2e14fmr59092lfj.4.1709630173911; Tue, 05 Mar
 2024 01:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228185116.1269-1-vamshigajjela@google.com> <ZeA7dVBmm1yuf6F9@hovoldconsulting.com>
In-Reply-To: <ZeA7dVBmm1yuf6F9@hovoldconsulting.com>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Tue, 5 Mar 2024 14:46:01 +0530
Message-ID: <CAMTSyjq6rOSeZND4iRdg_ooLf6P8rpx7oU5+tfCGjN1JVHhesg@mail.gmail.com>
Subject: Re: [PATCH] spmi: hisi-spmi-controller: Do not override device identifier
To: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:38=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Feb 29, 2024 at 12:21:16AM +0530, Vamshi Gajjela wrote:
> > 'nr' member of struct spmi_controller, which serves as an identifier
> > for the controller/bus. This value is a dynamic ID assigned in
> > spmi_controller_alloc, and overriding it from the driver results in an
> > ida_free error "ida_free called for id=3Dxx which is not allocated".
> >
> > Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> > Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driv=
er")
> > Cc: stable@vger.kernel.org
> > ---
>
> This is v2, which should be indicated in the patch subject and with a
> short changelog here (e.g. mentioning the split and rebase on 6.8-rc).
ack, Thanks
>
> Johan

