Return-Path: <stable+bounces-195395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3016C75FAE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF434D366
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499C1F3BA4;
	Thu, 20 Nov 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLSCIeDm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D4229B38
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664697; cv=none; b=OpamwHf5JXZuKr+1xSuy9+K7Trlx24PzDzLYBRCpK/Yd9ACRoF6CeMxxiATBbKLNldrbsIOwa1USGTWrfrIWIhxFgv7iFK57CZf++NX/JAhS7rLfobso39qDFD2D2q0gkqD+ct5qFNw7uRzC9PHwTiDv+Hi/Wcgx1/ibAm0Gb6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664697; c=relaxed/simple;
	bh=L06JMK7n+oxsx9dHjUt3ALR0/CMNNsuE/8RunGlhWeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSZt/uHg0W/GBUBPLjwqGRkvZMLbK4ZrJ4Far61IqnhQvNXL+vKK3xP/qrxXRaZD2E4Mn++FI3Wu4UltQtjuRYWxZIPdLU07w63lJfHIG2KUgJXWr6+kpPYiAynR5ltFCNo1FAZZu+stITMmccqRRmEPbGUD4Xybe4FdFs1Yhew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLSCIeDm; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b25dd7ab33so75194785a.1
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 10:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763664692; x=1764269492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L06JMK7n+oxsx9dHjUt3ALR0/CMNNsuE/8RunGlhWeg=;
        b=YLSCIeDmI115RR8ymF3lo91sVyD6b4wsXh48xt9SBoYRYH1/JH7xcxS3zhdIGySqUu
         qQC2EyU3FbDNGa1uka4oPJFYHbLyXsO9fOwlQoxhIaWkQ2vOfipE3jeQgpx8xInPcPRW
         f+5b1NV3le8KWd0S5gijLtAgY4rPPkxAT27Vw2hiupldkxrlhPURbEvO4UDWLxL6L3Ie
         sxUx1nWqAPEYV4y22jKQbnWB5f/+QuoS2uqCRwjZBiQ/tteR1AdFeWrKYnPrLpIalz0e
         HhZw3nkh7BOXeCMo9dV20qfvwGxLipi+5LBSuIwIHn5E2m1F+HgMhPxxO2BVDUz1hehK
         EhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763664692; x=1764269492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L06JMK7n+oxsx9dHjUt3ALR0/CMNNsuE/8RunGlhWeg=;
        b=wDVXalYtsK84ZudG3QcDSPZCBP1t5KRbPL0dWoSZQyccVpZPp8aIN6+sfU5oAkgRqq
         ZFq/ZOmmUVU84N68OZSxVwwWiFPVedwtnG5jZhyJYukLrKGhzB5me8XrpELu1eRg5zus
         qaH7RPPRMOr1EYtEYko8vQOFk+Bp7/S/2oRPUIO/xONdKBPiRSjY66iw6r8gpc3nWJi7
         gNiMUct++fAIhVIiRD1O8fFeDZa+iVI/lUMFM+xTp4B3eWVIzKrs/gMWRDNZGnPHxNRF
         2E9W8RyKMR/z3vtyO1LmBMHLDLLKSjTlfffvuMwH+u1P7r+GRo4jTKUq6k9OVsHEAQ0S
         eVnA==
X-Gm-Message-State: AOJu0YwPWEZWKPLCH79U7gR1ClR5seH2ItlhM7hqO6+Z29xr43FEPLGk
	WLNPxp3hqk8lw9IwJ+sBnsg7lrpToTz3rHtm7TtNDww9nPDzEQojh5kXNfWVnQtZaG/m1SsJq0F
	1ucVoJR3gQv6ikJDba1hlWn7bLLLnWew=
X-Gm-Gg: ASbGncvXOFvm4W/qTU0AYYoMa6M1dD8d8vXAh4B5uKtvuo0a9EHWULW9ckMAsx4Cwod
	DqzXycBpaegPGAPwtaDxb95oodDlqQVA3OZVI7qSNYZOsng3/PGJ4epCHm1XCbknsRRfZvXg0Ej
	6beCKRa1ct1MdCet2fkT8XImSiLfySXRjzW0IUdthr1gpmyKitwNh0qc3FmMpYn5auoh3kafLNY
	EXReKnwHjTxws3OWyzv0+RjLdKGdazOU8ah88Qx+M/SU/XaYFo9J//6UaFjm7OvDL4nEA==
X-Google-Smtp-Source: AGHT+IFw8Dpv3tkO2+kXpx9Zh9KmZutH4pzz3luNAU10uHYeCPFN9BnBalwRCs8bfDQ0oh70PYu8nKEF29dPDnAfxmM=
X-Received: by 2002:a05:622a:1914:b0:4ee:275c:28eb with SMTP id
 d75a77b69052e-4ee496f999cmr51069791cf.62.1763664692398; Thu, 20 Nov 2025
 10:51:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120184211.2379439-3-joannelkoong@gmail.com> <aR9hiE7WB5ex9ED6@041890d37db4>
In-Reply-To: <aR9hiE7WB5ex9ED6@041890d37db4>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 20 Nov 2025 10:51:21 -0800
X-Gm-Features: AWmQ_bnM6WF9Ao6Azi1-LbqWgG5lKZvGrcYWd8-etWcCRdBPZXei57dbGBJiagI
Message-ID: <CAJnrk1aiZPrHeWf8WZEJopvGUC4hXZ8HN_BvyuK_vaeiuQE_PA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fs/writeback: skip inodes with potential writeback
 hang in wait_sb_inodes()
To: kernel test robot <lkp@intel.com>
Cc: stable@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:45=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi,
>
> Thanks for your patch.
>
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
>
> The check is based on https://www.kernel.org/doc/html/latest/process/stab=
le-kernel-rules.html#option-1
>
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to ha=
ve the patch automatically included in the stable tree.
> Subject: [PATCH v1 2/2] fs/writeback: skip inodes with potential writebac=
k hang in wait_sb_inodes()
> Link: https://lore.kernel.org/stable/20251120184211.2379439-3-joannelkoon=
g%40gmail.com

Sorry about that, I thought it was enough to cc it in the email. I'll
add the stable cc tag to the patch itself from now on.

Thanks,
Joanne
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
>
>

