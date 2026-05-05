Return-Path: <stable+bounces-244175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJJxKZMF+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:58:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0FE4CFD26
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DE93017263
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D12542317B;
	Tue,  5 May 2026 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5lXJaYD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B3534677D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 14:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777992919; cv=pass; b=J20aboHN70eTWihrRwhQa0qK8EYklbZBJ9Vf/yqAKPn+NG4al1DEiggVZ5WISJZbBlCWzcTJLbgP5nL+5YqBEzukBcCGfY98WEzM0kftEyPIg32ezBsYaXLFXvzWXo6E7RsilsA3hwm26olGMDn7P4d61bQ6LRcXgHi0YMgJoko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777992919; c=relaxed/simple;
	bh=veOyjPdO5oUFuy0DymgzCOLcYHy6fQVPHt5NSJsozBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qm4Dk2EglHZsY9nWYWKagpoHjNOS76YkSIjIEcPR6ATmt563WvwGeM7BvI7d3JH/h1fkqzKUroC4tKRVBKHeNOSkG7f9QRU80zJK37oMfzXsSY6TrM6hh/aGwbLE2Exityg8mayuPFpVTFo7URVOKnlMFiMSH+hCf/wPPhelbQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5lXJaYD; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c24be9e4bso4569862d50.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 07:55:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777992918; cv=none;
        d=google.com; s=arc-20240605;
        b=WBVhaaxW/BfoUaL//Z+HJ7u91bEwE4jOIhGMcAkfF8fTlwJkfI1CgT+/m96QdNXr1R
         QSFZNuU6n78RTiRWuvlpAiYZS8qtON4hta/MuB10+dLgtJ8wYP+CLc2pHcOd4f3J2qS/
         9fmjm++nmWhIqjl61dVnxkkPI4mwFsSaT57opRJ3mLios19IEqqxfVMFqJB6dP9KF5Fd
         aB0h4OpRYyoyVOLAKxrojL4DFPrIiGh5mdy9VBCBCh59BqcOTQwepHJHEZSIP00UDt+M
         15w5lOTmseHQtYIwalqEshGbXEiEsjIVkDwnBeRDUteGQKjkIYW+8x3QkcWKFcguxawz
         i8XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AnKXamoSsrvY3KYd/KYUeOyDTUDrk7xjkhda/0sSEmQ=;
        fh=IIiydIAELXeLP8pSNugn7AALmn+wK/wEB2B9+GzeixA=;
        b=lsh1A4uohIsSPM8X8wD8pF2eK3JnL8NZP1dZCacGytCZLszLXEVHGh1+r8ajzT7HWl
         VEM5pgUBQDc1Vyu9u4bemEBzN42fjHk+5nlvFgo/S0/qWxl3o489bCyNmBOsD0MyKhh4
         B9sF5PvcHjEyDbklWmuRNufhGzDFkkZnjbH6lni1B1ZArIWY3zDf0WYTAeRmzpQU3UhI
         dEhqt/NRHF7qyB110lTVmuDlXeBPiOj8ySGqr97DPYBzPVcslibxix4yhsM12W1+mkGN
         sDRNEKR3urMWYzto1nbXRCHSSpi/9cQaoaQBu8gRRRd2/CbDIkfxNFtSECib19oiKdZG
         SBIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777992918; x=1778597718; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnKXamoSsrvY3KYd/KYUeOyDTUDrk7xjkhda/0sSEmQ=;
        b=i5lXJaYDeAyRjVYcLjcmxh9HAINkZUzaifAcGKJJBIqQHoGxVzkFc0Iq8IzhKnkvfN
         +y87BB1i94vO4joAdHIKdgSJI4p6Rgv9lNKfNGu76+6mUDTZ3nhT2DSjFpKnVb9VhLTu
         lYu9nnEyG6XPqiOQndwdQUVIBxirBPyNmAzJZySUT904mK32k98U2HXoacYNkTc8vGqq
         7xJ6uZdeqdVq+YG0IGhoaV3Ln8nyCfx9MS5pB01c177xLWj9i46ebJW3y1rLBYLehQc1
         /NlDY++VaFZJroCVOMJralgjoUHL9eWKtx7nr4B/iRWQ+ixqpgCF7MJRJ0K/BnWRJR6q
         88Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777992918; x=1778597718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnKXamoSsrvY3KYd/KYUeOyDTUDrk7xjkhda/0sSEmQ=;
        b=MIedcz6xY1ToC68T4JgIA11IQrsP5iTL5BPLFanqPioRzOi8I4ZkjvezI2UgzC5/pm
         vKkY1drtzTMqyDgc196JK1Ul3h3WBx+doB51jWur9tnh46sTEMd5j7XQ9l+eF1ZLfPiV
         UFpZifp3Brhlm17Hx+4W5Ovx8r7mE9vtwiWv7dGbvyKfBYsRPzDNAWoWqJkkIUqux8F6
         zXATKSxAQXR35qrM78L3fSDdgSag7fHaoPF2AXMiTkIQsNBEUYszxQJ63AFsdWG08oQx
         GqxMZAV1Plz5hPErRTRso0iByit6W2S2TlkanjhcluSFypXFpXNojKBR1vbgLyzPRwhs
         TJbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8jgQd2RGRjTGSaKKAexD9H0280xPFHagZTJ81Be+uozx6ztdBH5F8TyFYRXhtDYIGl0idpjQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycI9Dr/03eOZ4qFowozjmCQ+LgFHkWtOkMufsBRMbiCTkMl5ST
	FMoE01gMqg1d9cWiops/ibE6oPOAGKb/Ltqf1kZunwD0lZ8p5NeeFh731uAYAEmEa0tYXGhXX+k
	gmIb59R1PL582EqUux26Z8uD+BlWcgzc=
X-Gm-Gg: AeBDiesbhANfi7bFC41cn2MLyL8ZmC/Q8daLyitPxYPe2YEcMt46jO4zgFbFy3K2N8F
	Hlb581Fda+EZYtLqFE587yi+INZgs6o/A72GBhJvC9ZCBQhe2dNr7q15mP1IsFbY8sWPv97sUCF
	Aw1GXvvhA8vP/gq68ACvL3XHnUO43xsqZHOD6ylMH5U9wMB10bFndqPmlZlQaLLpOlCBFL2a3ys
	sp1beqmpUI13paxRixFGpEmQVc55585UtEoT9AGwPLXd72Jn67ozq94mrnpyKYHfGwIN7JX5wYs
	mCqnm02duRhBgSNdtwg=
X-Received: by 2002:a05:690e:4812:b0:65c:4066:d177 with SMTP id
 956f58d0204a3-65c69c466a7mr2747030d50.9.1777992917582; Tue, 05 May 2026
 07:55:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226153250.18079-1-lgs201920130244@gmail.com> <2026040232-ungloved-bonnet-a407@gregkh>
In-Reply-To: <2026040232-ungloved-bonnet-a407@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 5 May 2026 22:55:08 +0800
X-Gm-Features: AVHnY4LW0K5qkKKaICN6pMky7MvIuguMQJ0BtIgKwRnmZeOiOtAkYvSDcll-dkg
Message-ID: <CANUHTR86gywBzYuoaM-drt2==KBPtJT2a38VGza7eK6bmVuPmg@mail.gmail.com>
Subject: Re: [PATCH v4] uio: uio_pci_generic_sva: fix double free of
 devm_kzalloc() memory
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0B0FE4CFD26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244175-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Greg,

Thanks for reviewing.

On Thu, 2 Apr 2026 at 21:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Breaks the build, how did you test this:
>   CC [M]  drivers/uio/uio_pci_generic_sva.o
> drivers/uio/uio_pci_generic_sva.c:147:26: error: unused variable 'udev' [-Werror,-Wunused-variable]
>   147 |         struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
>       |                                 ^~~~
> 1 error generated.
>
> {sigh}

Sorry, I missed the now-unused local variable in remove() after removing
the kfree() call.

I will send a v5 which also removes the pci_get_drvdata() assignment from
remove(), and I will make sure it builds before resending.

Thanks for catching this.

