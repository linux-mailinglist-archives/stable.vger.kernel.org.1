Return-Path: <stable+bounces-54786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A75911818
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 03:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EF01F2255C
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275D8249A;
	Fri, 21 Jun 2024 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwUAdP6e"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7E823C3;
	Fri, 21 Jun 2024 01:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934025; cv=none; b=s2XQudOV55omwJq+PEddMPcYK5PJLNlkGe5OEJErFC7R5gtGBH2cneSRojG9A0dBJ7i2WF7JwdpYYb5TPf4ql9GCuW+B6ZkWahMRp437PUJTOvX84WIZ6qC5yiNblRgt2RMi153wcH7+3iPGnQwnNrfgNbyT1MWaCieE1TvfaBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934025; c=relaxed/simple;
	bh=1Z+1pSECJCcJNFpchITMfwuTw//Gxxq9YXpt6KsYM9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+2EnU6TO+9vVt6Y/iS6hsiawlNhagSSWoCZ3X7zXuTHB8oOCvK/2UlEw8JekYHb0nXEmtoVngTmZKB2102ze/2orTORDrV9yKWs4CK7IDHGabfUe4r0bsWW0OW6GFSgopUa+0SvekHkjyJXuE+jz57Gp3MI1fobcgfq4WNuzsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwUAdP6e; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6ef64b092cso167450966b.1;
        Thu, 20 Jun 2024 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718934022; x=1719538822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGQtzgqEz5YLBdkBn3WvUxx0bdndpPW+TjQwMlI5mWU=;
        b=hwUAdP6essCYtjUU/iW/jEjS+qXcWsMBcV6TJ1xDJijadzfZLHHiQJVjPAtmUXWxE8
         XvSI2qHhj/+Ny8o7XxFd5sew0yKr+v38aklhR8zVwXRp0ndJruHlnoy0ZSecVuCQ/1K9
         jO5hge9nxTyBLMaNT5R0lrck+EDcMHGBBjmLJbA4i4f43pbqaaYYfnkk+f08S4DHyEsv
         ldWC7ZW3hy310fuSLGTvh0igSFiawTXOaHznvbvS1R0W9TfT6VACas86U3fUKgdwXEg8
         NChcnvM3NJsr3TM2dt5rOEOCiyy9YUnwYC28+sF7+OCsy+wtt9/F6OV0anxrUBCqqBAn
         RBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718934022; x=1719538822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XGQtzgqEz5YLBdkBn3WvUxx0bdndpPW+TjQwMlI5mWU=;
        b=YNQ8Na8HcCnUMuqjfQDb4FcmPuxgWC4ZQorItgdMYNXpp521TUYEpcjM4Cx14woZE1
         6Z0tz7BntQ9/MgFX8wHZw1LuVp9DNR+v2Nqips5H11i8L51043I9zyeprt9HOt5A9miA
         UuUElGnrhJyjRrtrB74BZ34pkFDatA/HzsCqO0/W2w2wnM2/mBSOKcuO1gKozJ/tc/1h
         GeopUsHfTJIAVzTxg8Jq0DE+rgtBLarU26kp8IZ/HFjNzX+5fEV9mm3bnMtIZH9m0E2t
         8U76rG+8jIw9KRcCMY9xYGSb40o8DvNhd5UIW1j6WAZVtMDTceFZqtZAg4RCj/chUfpo
         SwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYj/e/wwzDHHWaRaZEbDo9yamHCtdIfvaY8/sastekJol5YNzWcIsCyKHgk2Bdgd1AZPZZ2Tn1VCo1pu7wraAu1S+q9oyWXGxzQyl3qhEwePFFxfNUMLhjTZB3maOOqBN1lcxA
X-Gm-Message-State: AOJu0YySqWfScicadYTa3IEKDISSjv1Mio80K3cl4HG8FYUoVsqIHoty
	kNqesSOn46ECLbkcNk85/nDvYDPvnZnVjU8o1UVGmleXOI+Qc5Y8dn1ZL2bWdZF8sfvpl88ZGk2
	i0t2+cQjuAdlSpNRkHvsi/wlWgwM=
X-Google-Smtp-Source: AGHT+IFaIC7bIusgiaQh44+XU4MNDVuFgkfJ2qcxkgIRa505tpICKdxUNzPrkgHC4ujUZEfh2+JsCIzv42UYpZ+bN/E=
X-Received: by 2002:a17:907:175e:b0:a6f:80ff:4050 with SMTP id
 a640c23a62f3a-a6fab62f501mr405848466b.25.1718934021813; Thu, 20 Jun 2024
 18:40:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619114529.3441-1-joswang1221@gmail.com> <2024062051-washtub-sufferer-d756@gregkh>
In-Reply-To: <2024062051-washtub-sufferer-d756@gregkh>
From: joswang <joswang1221@gmail.com>
Date: Fri, 21 Jun 2024 09:40:10 +0800
Message-ID: <CAMtoTm06MTJ_Gc4NvenycvWRxhLSaPptT1DLvBRs4RWVZO9Y_g@mail.gmail.com>
Subject: Re: [PATCH v7] usb: dwc3: core: Workaround for CSR read timeout
To: Greg KH <gregkh@linuxfoundation.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Jos Wang <joswang@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:16=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 19, 2024 at 07:45:29PM +0800, joswang wrote:
> > From: Jos Wang <joswang@lenovo.com>
> >
> > This is a workaround for STAR 4846132, which only affects
> > DWC_usb31 version2.00a operating in host mode.
> >
> > There is a problem in DWC_usb31 version 2.00a operating
> > in host mode that would cause a CSR read timeout When CSR
> > read coincides with RAM Clock Gating Entry. By disable
> > Clock Gating, sacrificing power consumption for normal
> > operation.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jos Wang <joswang@lenovo.com>
>
> What commit id does this fix?  How far back should it be backported in
> the stable releases?
>
> thanks,
>
> greg k-h

Hello Greg Thinh

It seems first begin from the commit 1e43c86d84fb ("usb: dwc3: core:
Add DWC31 version 2.00a controller")
in 6.8.0-rc6 branch ?

Thanks

Jos Wang

