Return-Path: <stable+bounces-25362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C143886AFBD
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 14:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23001C23280
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 13:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C8149E0B;
	Wed, 28 Feb 2024 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCg28rL8"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B1148FFC
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125371; cv=none; b=ilDGCsgUy1nIjlPha91TBT+1BYXQ+CNPX4Uw5/RcH2CyiO6ZhL8YJCQuWmv58TVfPaXOpPGapIWZo0VPOvXEdNzIA4Az/Bljo/mweuAobKmmQeLiRSdwhJoFa6R0sWYIzFa0nwLPxAkpspYCB6fakIGMZRa66UOL65/L7K+QVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125371; c=relaxed/simple;
	bh=3cYG7GaJLaJHPFKTz6+fE0NqWzsbSwHco8JoDUKQEQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsFA9eCN8PMGTKqHtZG5PoncsHzaXVwcxPIYuwHwO8M9XduQFRv9rRaGEy4hpmcUxBh/MdxCJD2n//JxNn3K9aZ9Vv1htfOuz7r5PZ6+xWECIqGv9WRt8Dswx69uZzZ4V1h7PSmRiWgayhHp5lfvlsNgUwQqH7D4l90pSqJqYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hCg28rL8; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso4867629276.2
        for <stable@vger.kernel.org>; Wed, 28 Feb 2024 05:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125369; x=1709730169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x6lSKguAFNJlnGwYnPcXJDGp7aYh6GWsOXe6nAyiYVg=;
        b=hCg28rL8oQhsqzK4oYJZsSxvYvmljTITpK5k0wS+vfNH+vKG9z8H8l5pp4r41mYF+9
         p510o9l1WIA8Wm7T2r7h9/mLz4CKHFsNRJMgKj+qmuxzkae8EV6/HWFyRNPzuPZ9SmEV
         ZIRGSRmM2X1v7AVwcX0W432l6Y7VrBQ+JpLoXLVyFEhXIECUyUfUSsGZweEpmqQBbJnS
         npv0fQnT12bn58e6iJOQuzd/Lyyz8WvczN9nn8lQMSlDEZi7u/6/Z/FFB72Dh9XxQ2Jh
         ArmuL0uyavKLdZorcCRUuOASszDvpDEzvOjBs6U/pgfHnSXTdEo5tqmNGwpzdrmOBbie
         C27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125369; x=1709730169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x6lSKguAFNJlnGwYnPcXJDGp7aYh6GWsOXe6nAyiYVg=;
        b=FS3E1Sn/qX5qVDlMxY7iiSlIuxGL6Fzj8+uVeOHjmKNWVdJzjeMkS/9LCT/RR3kGIa
         E+ubwnftrPRDVyAWBXvqDdKQtAgJQWqUAfxHbK749tFAYJvnUQ4PlbbILFBo1ZuFGI9q
         KY4KBzKi8I4TSeeqYUHFjkA/5jBfr/sZCwCA48ohqzcep8vQGEgweJCXo7OE2J6Wr60j
         IMPbBdgCaaY7/FB2mZtZiufmOh6joAQbFRDqk78Q5kE8VIPRTCC7ECU9xw+iABUxmgtz
         pqgVztLKdTKA1Sza10NsxTVplCwXjhpz1CWuSjzN7iOWjBO4L4QdqxfelCARLXPkdmwR
         0kDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmV3Av6hAlzchVsd4dg2MXzl5GCycJwuavVyw8JvhcQ+eLKG4x/HFiqJIxuellfRXzaSGK2Stwm4YGzzinV+8sOJhI3ssm
X-Gm-Message-State: AOJu0YwShR49h9rcQENvBasLp/NlF6lq4EhT1MoBsFuXRmhYx88BEbmS
	L012VGhWbm82uny8XGdNQJ1cgt4rEVIeKlKfXCg9MsiP2Slds4Ufq08obtdH2N45t+uqTAMD0U5
	IvxhPn0VmGvBCRXDNaPntUe+Wx4aCGCL28OJm3w==
X-Google-Smtp-Source: AGHT+IHt515XwjEFX2Talx1MabYfeTXhLsH0vACvt9NK8SBc6/4ePgqNHrqmsK6WApAXc6SEFfgq73kQu0EE4nMTs0E=
X-Received: by 2002:a05:6902:1b09:b0:dcc:53c6:113a with SMTP id
 eh9-20020a0569021b0900b00dcc53c6113amr2580289ybb.59.1709125368961; Wed, 28
 Feb 2024 05:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218-msm8996-fix-ufs-v3-0-40aab49899a3@linaro.org> <yq1o7c24oyt.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1o7c24oyt.fsf@ca-mkp.ca.oracle.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 28 Feb 2024 15:02:37 +0200
Message-ID: <CAA8EJpqUrvzU_=EGcXdpLjVetSkCv0vfnc1hNhPQdyUQvY7UzQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] scsi: ufs: qcom: fix UFSDHCD support on MSM8996 platform
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, Nitin Rawat <quic_nitirawa@quicinc.com>, 
	Can Guo <quic_cang@quicinc.com>, 
	Naveen Kumar Goud Arepalli <quic_narepall@quicinc.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-scsi@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 04:33, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Dmitry,
>
> > First several patches target fixing the UFS support on the Qualcomm
> > MSM8996 / APQ8096 platforms, broken by the commit b4e13e1ae95e ("scsi:
> > ufs: qcom: Add multiple frequency support for
> > MAX_CORE_CLK_1US_CYCLES"). Last two patches clean up the UFS DT device
> > on that platform to follow the bindings on other MSM8969 platforms. If
> > such breaking change is unacceptable, they can be simply ignored,
> > merging fixes only.
>
> Does not apply to 6.9/scsi-staging. Please rebase if you want this
> series to go through the SCSI tree.

Please pick up just the UFS patch. DT patches should go through arm-soc tree.

-- 
With best wishes
Dmitry

